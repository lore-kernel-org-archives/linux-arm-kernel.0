From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 11 Apr 2017 08:56:48 +0100
Subject: [PATCH] arm64: kaslr: fix ARM64_MODULE_PLTS dependency
In-Reply-To: <b0e872b9-f7ea-e3a4-84c4-fc9aa90cecbd@huawei.com>
References: <1491789132-18933-1-git-send-email-huawei.libin@huawei.com>
 <CAKv+Gu8x9sCq2b2OmjoARKJZ8V5e4MtJp962Z1gJxazvkfw-XA@mail.gmail.com>
 <b0e872b9-f7ea-e3a4-84c4-fc9aa90cecbd@huawei.com>
Message-ID: <CAKv+Gu_dTh5UMK7Gs=Tw1Tja+i1=dBQnc7H4vPybJ-8hNA2G1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 April 2017 at 07:28, Li Bin <huawei.libin@huawei.com> wrote:
>
> Hi,
> on 2017/4/10 17:12, Ard Biesheuvel wrote:
>> On 10 April 2017 at 02:52, Li Bin <huawei.libin@huawei.com> wrote:
>>> There is a bug that when RANDOMIZE_BASE enabled and
>>> RANDOMIZE_MODULE_REGION_FULL disabled, and assume that there are
>>> many modules, and module space is not enabled, module_alloc code
>>> now will alloc space in vmalloc space, and the patch
>>> "fe88a4 arm64: kaslr: keep modules close to the kernel when
>>> DYNAMIC_FTRACE=y" will be invalid.
>>>
>>
>> I guess you are alluding to the fact that this code [paraphrased]
>>
>> p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
>>             module_alloc_base + MODULES_VSIZE,
>>             GFP_KERNEL, PAGE_KERNEL_EXEC, 0,
>>             NUMA_NO_NODE, __builtin_return_address(0));
>>
>>     if (!p && IS_ENABLED(CONFIG_ARM64_MODULE_PLTS))
>>         p = __vmalloc_node_range(size, MODULE_ALIGN, VMALLOC_START,
>>                     VMALLOC_END, GFP_KERNEL, PAGE_KERNEL_EXEC, 0,
>>                     NUMA_NO_NODE, __builtin_return_address(0));
>>
>> will attempt to allocate from the vmalloc region when the module
>> region is exhausted.
>>
>> I think this is an ftrace problem, not a kaslr problem. The ftrace
>> code cannot deal with modules being far away from the kernel, which
>> means it is incompatible with module PLTs, and our Kconfig description
>> does not accurately describe that.
>>
>> So the correct way to fix this is to make CONFIG_ARM64_MODULE_PLTS and
>> DYNAMIC_FTRACE mutually exclusive in Kconfig. Given the existing KASLR
>> dependency on module PLTs, this would make DYNAMIC_FTRACE mutually
>> exclusive with KASLR, and I am not sure whether that is worth it. With
>> CONFIG_RANDOMIZE_MODULE_REGION_FULL disabled, it is highly unlikely
>> that modules end up too far away from the kernel, and even if an
>> ftrace splat should be avoided if we can, it doesn't really interfere
>> with anything except ftrace functionality itself.
>>
>>> In fact, we only need plt when RANDOMIZE_MODULE_REGION_FULL enabled,
>>> so fix the dependency, that only RANDOMIZE_MODULE_REGION_FULL select
>>> ARM64_MODULE_PLTS.
>>>
>>
>> This is incorrect. Without KASLR, the module space is allocated from a
>> dedicated region, which means we are guaranteed to have 128 MB of
>> space available. With KASLR, the module space is also 128 MB (minus
>> the size of the .text segment of vmlinux), but this region is *not*
>> reserved for modules. Given the vastness of the vmalloc space on
>> arm64, this is usually not a problem, but we have to be able to deal
>> with the situation where unrelated vmalloc/vmap calls have chewed up
>> our module space, and modules need to be allocated elsewhere.
>>
>> So given the choice between the rare occurrence of an otherwise
>> harmless ftrace splat, or the equally rare occurrence of a module that
>> fails to load, I think I prefer the former.
>
> If this is the case, then the description in Kconfig is not correct.
> ----------------------------------------------------------------------------
> config RANDOMIZE_MODULE_REGION_FULL
>         bool "Randomize the module region independently from the core kernel"
>           .......
>           .......
>
>           When this option is not set, the module region will be randomized over
>           a limited range that contains the [_stext, _etext] interval of the
>           core kernel, so branch relocations are always in range.
> ----------------------------------------------------------------------------
> This should be modified, right?
>

I guess 'always' could be changed here into something that reflects
the 0.001% likelihood that a module ends up elsewhere if a huge
vmap/vmalloc allocation just happens to end up right in the middle of
the module area, but I don't think it is very useful.

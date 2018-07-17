From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 17 Jul 2018 09:47:10 +0800
Subject: [PATCH v2] arm64/mm: unmap the linear alias of module allocations
In-Reply-To: <0a82ef4f-c0a0-ef49-1ebf-8903299042a0@redhat.com>
References: <20180711170426.11133-1-ard.biesheuvel@linaro.org>
 <0a82ef4f-c0a0-ef49-1ebf-8903299042a0@redhat.com>
Message-ID: <CAKv+Gu9WdjVRO_JfAY0MLB=S9_no=xEhq8R-q+FHqEEs2nd3=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 July 2018 at 07:56, Laura Abbott <labbott@redhat.com> wrote:
> On 07/11/2018 10:04 AM, Ard Biesheuvel wrote:
>>
>> When CONFIG_STRICT_KERNEL_RWX=y [which is the default on arm64], we
>> take great care to ensure that the mappings of modules in the vmalloc
>> space are locked down as much as possible, i.e., executable code is
>> mapped read-only, read-only data is mapped read-only and non-executable,
>> and read-write data is mapped non-executable as well.
>>
>> However, due to the way we map the linear region [aka the kernel direct
>> mapping], those module regions are aliased by read-write mappings, and
>> it is possible for an attacker to modify code or data that was assumed
>> to be immutable in this configuration.
>>
>> So let's ensure that the linear alias of module memory is remapped
>> read-only upon allocation and remapped read-write when it is freed. The
>> latter requires some special handling involving a workqueue due to the
>> fact that it may be called in softirq context at which time calling
>> find_vm_area() is unsafe.
>>
>> Note that this requires the entire linear region to be mapped down to
>> pages, which may result in a performance regression in some hardware
>> configurations.
>>
>
> I'm concerned any performance regression might just make people turn
> off rodata all together. It's not overly bad for the kernel mappings
> but modules are fully RWX so we might be trading a subtle threat for
> a more obvious one. Would putting this behind a Kconfig make sense
> for those who want the status quo (with a big caveat that this should
> have been present from the start)?
>

It would be good if we could quantify the performance hit before
deciding that it is a problem. I was actually expecting more
opposition and/or debate anyway in response to this patch, along the
lines of 'use case X is Y% slower now so your patch sucks!' but sadly,
none of that yet.

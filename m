From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 5 Mar 2018 12:22:42 +0000
Subject: [RFC PATCH v3 1/3] arm64/kernel: kaslr: reduce module
 randomization range to 4 GB
In-Reply-To: <CAKv+Gu9w2XUrYrz=kfcv_jZFxbVvCA7u9N4371R_1zy2cwXM0g@mail.gmail.com>
References: <20180214113645.16793-1-ard.biesheuvel@linaro.org>
 <20180214113645.16793-2-ard.biesheuvel@linaro.org>
 <20180223170019.uubttzhgtqhhxppt@lakrids.cambridge.arm.com>
 <CAKv+Gu9w2XUrYrz=kfcv_jZFxbVvCA7u9N4371R_1zy2cwXM0g@mail.gmail.com>
Message-ID: <CAKv+Gu9rq5Sr=Z1h8iOXrmJGJ_rvNe8WQpefYmBsziCobhByPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 February 2018 at 17:07, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 23 February 2018 at 17:00, Mark Rutland <mark.rutland@arm.com> wrote:
>> On Wed, Feb 14, 2018 at 11:36:43AM +0000, Ard Biesheuvel wrote:
>>> We currently have to rely on the GCC large code model for KASLR for
>>> two distinct but related reasons:
>>> - if we enable full randomization, modules will be loaded very far away
>>>   from the core kernel, where they are out of range for ADRP instructions,
>>> - even without full randomization, the fact that the 128 MB module region
>>>   is now no longer fully reserved for kernel modules means that there is
>>>   a very low likelihood that the normal bottom-up allocation of other
>>>   vmalloc regions may collide, and use up the range for other things.
>>>
>>> Large model code is suboptimal, given that each symbol reference involves
>>> a literal load that goes through the D-cache, reducing cache utilization.
>>> But more importantly, literals are not instructions but part of .text
>>> nonetheless, and hence mapped with executable permissions.
>>
>> I guess that means they pollute the I-caches, too?
>>
>
> Yes.
>
>> How big a difference does this series make to .text size?
>>
>
> I will add the numbers for a couple of sizable modules when I respin,
> although i don't expect that aspect to be the most convincing.
>

For the record, this is what I get before and after for a widely used
fairly large module:

   text    data     bss     dec     hex filename
 317907    7004      16 324927   4f53f net/mac80211/mac80211.ko

   text    data     bss     dec     hex filename
 315603    7004      19 322626   4ec42 net/mac80211/mac80211.ko

This is large model vs small model with the stack protector in strong mode.

So while the size does decrease slightly, I think the reduced cache
footprint is a more important metric here, and I am not sure how to
measure that.

>> I don't really have a strong opinion here. IIRC the idea for randomizing
>> modules across the whole vmalloc space was to make it harder for module
>> bugs to leak "real" kernel addresses, but I don't know how much that's
>> likely to help in practice, and the performance / cache footprint wins
>> are enticing.
>>
>
> Yes. I think the important thing is that they are randomized
> independently, and the additional entropy in the high order bits is
> unlikely to make a huge difference imo.
>
> When we added KASLR, the reason we enabled full module randomization
> by default was to get coverage for the new PLT code, not because it is
> deemed 'better' in some respect.
>
>> [...]
>>
>>> @@ -149,21 +151,23 @@ u64 __init kaslr_early_init(u64 dt_phys)
>>>                * vmalloc region, since shadow memory is allocated for each
>>>                * module at load time, whereas the vmalloc region is shadowed
>>>                * by KASAN zero pages. So keep modules out of the vmalloc
>>> -              * region if KASAN is enabled.
>>> +              * region if KASAN is enabled, and put the kernel well within
>>> +              * 4 GB of the module region.
>>>                */
>>> -             return offset;
>>> +             return offset % SZ_2G;
>>
>> I wonder if we can do more here, taking the kernel size into account.
>>
>> [...]
>>
>
> Not sure whether it matters tbh. To be honest, I think most KASAN
> users turn KASLR off unless they are debugging some aspect of KASLR
> itself (that's certainly how I use it)
>
>>> diff --git a/include/linux/sizes.h b/include/linux/sizes.h
>>> index ce3e8150c174..bc621db852d9 100644
>>> --- a/include/linux/sizes.h
>>> +++ b/include/linux/sizes.h
>>> @@ -44,4 +44,6 @@
>>>  #define SZ_1G                                0x40000000
>>>  #define SZ_2G                                0x80000000
>>>
>>> +#define SZ_4G                                0x100000000ULL
>>
>> Some asm includes <linux/sizes.h>, so it'd be nice for this to use
>> ULL().
>>
>> Masahiro Yamada had patches moving that to <linux/const.h>.
>>
>
> OK

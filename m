From: hejianet@gmail.com (Jia He)
Date: Mon, 9 Jul 2018 11:30:58 +0800
Subject: [RESEND PATCH v10 2/6] mm: page_alloc: remain
 memblock_next_valid_pfn() on arm/arm64
In-Reply-To: <20180706153709.6bcc76b0245f239f1d1dcc8a@linux-foundation.org>
References: <1530867675-9018-1-git-send-email-hejianet@gmail.com>
 <1530867675-9018-3-git-send-email-hejianet@gmail.com>
 <20180706153709.6bcc76b0245f239f1d1dcc8a@linux-foundation.org>
Message-ID: <4895a92f-f4c2-b200-3c7c-4fe8c4596f32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andew
Thanks for the comments

On 7/7/2018 6:37 AM, Andrew Morton Wrote:
> On Fri,  6 Jul 2018 17:01:11 +0800 Jia He <hejianet@gmail.com> wrote:
> 
>> From: Jia He <jia.he@hxt-semitech.com>
>>
>> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
>> where possible") optimized the loop in memmap_init_zone(). But it causes
>> possible panic bug. So Daniel Vacek reverted it later.
>>
>> But as suggested by Daniel Vacek, it is fine to using memblock to skip
>> gaps and finding next valid frame with CONFIG_HAVE_ARCH_PFN_VALID.
>> Daniel said:
>> "On arm and arm64, memblock is used by default. But generic version of
>> pfn_valid() is based on mem sections and memblock_next_valid_pfn() does
>> not always return the next valid one but skips more resulting in some
>> valid frames to be skipped (as if they were invalid). And that's why
>> kernel was eventually crashing on some !arm machines."
>>
>> About the performance consideration:
>> As said by James in b92df1de5,
>> "I have tested this patch on a virtual model of a Samurai CPU
>> with a sparse memory map.  The kernel boot time drops from 109 to
>> 62 seconds."
>>
>> Thus it would be better if we remain memblock_next_valid_pfn on arm/arm64.
>>
> 
> We're making a bit of a mess here.  mmzone.h:
> 
> ...
> #ifndef CONFIG_HAVE_ARCH_PFN_VALID
> ...
> #define next_valid_pfn(pfn)	(pfn + 1)

Yes, ^ this line can be removed.

> #endif
> ...
> #ifdef CONFIG_HAVE_MEMBLOCK_PFN_VALID
> #define next_valid_pfn(pfn)	memblock_next_valid_pfn(pfn)
> ...
> #else
> ...
> #ifndef next_valid_pfn
> #define next_valid_pfn(pfn)	(pfn + 1)
> #endif
> 
> I guess it works OK, since CONFIG_HAVE_MEMBLOCK_PFN_VALID depends on
> CONFIG_HAVE_ARCH_PFN_VALID.  But it could all do with some cleanup and
> modernization.
> 
> - Perhaps memblock_next_valid_pfn() should just be called
>   pfn_valid().  So the header file's responsibility is to provide
>   pfn_valid() and next_valid_pfn().
> 
> - CONFIG_HAVE_ARCH_PFN_VALID should go away.  The current way of
>   doing such thnigs is for the arch (or some Kconfig combination) to
>   define pfn_valid() and next_valid_pfn() in some fashion and to then
>   ensure that one of them is #defined to something, to indicate that
>   both of these have been set up.  Or something like that.

This is what I did in Patch v2, please see [1]. But Daniel opposed it [2]

As he said:
Now, if any other architecture defines CONFIG_HAVE_ARCH_PFN_VALID and
implements it's own version of pfn_valid(), there is no guarantee that
it will be based on memblock data or somehow equivalent to the arm
implementation, right?
I think it make sense, so I introduced the new config
CONFIG_HAVE_MEMBLOCK_PFN_VALID instead of using CONFIG_HAVE_ARCH_PFN_VALID
how about you ? :-)

[1] https://lkml.org/lkml/2018/3/24/71
[2] https://lkml.org/lkml/2018/3/28/231

> 
> 
> Secondly, in memmap_init_zone()
> 
>> -		if (!early_pfn_valid(pfn))
>> +		if (!early_pfn_valid(pfn)) {
>> +			pfn = next_valid_pfn(pfn) - 1;
>> 			continue;
>> +		}
>> +
> 
> This is weird-looking.  next_valid_pfn(pfn) is usually (pfn+1) so it's
> a no-op.  Sometimes we're calling memblock_next_valid_pfn() and then
> backing up one, presumably because the `for' loop ends in `pfn++'.  Or
> something.  Can this please be fully commented or cleaned up?
To clean it up, maybe below is not acceptable for you and other experts ?
		if (!early_pfn_valid(pfn)) {
#ifndef XXX
			continue;
		}
#else
		pfn = next_valid_pfn(pfn) - 1;
			continue;
		}
#endif

Another way which was suggested by Ard Biesheuvel
something like:
	for (pfn = start_pfn; pfn < end_pfn; pfn = next_valid_pfn(pfn))
	...
But it might have impact on memmap_init_zone loop.

E.g. context != MEMMAP_EARLY, pfn will not be checked by early_pfn_valid, thus
it will change the mem hotplug logic.

Sure, as you suggested, I can give more comments in all the cases of different
configs/arches for this line.

-- 
Cheers,
Jia

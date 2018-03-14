From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 14 Mar 2018 16:41:47 +0000
Subject: [PATCH] Revert "mm/page_alloc: fix memmap_init_zone pageblock
 alignment"
In-Reply-To: <CAKv+Gu8qguR0tFWZxecQDTPS3_Eyt_E6_YA1ivyAAqNuaaR9-g@mail.gmail.com>
References: <20180314134431.13241-1-ard.biesheuvel@linaro.org>
 <20180314141323.GD23100@dhcp22.suse.cz>
 <CAKv+Gu9hrZnX6pmiCaT=S30KQ11tY4kv=qvdSPPZ2nYDC7P7eQ@mail.gmail.com>
 <20180314145450.GI23100@dhcp22.suse.cz>
 <CAKv+Gu8qguR0tFWZxecQDTPS3_Eyt_E6_YA1ivyAAqNuaaR9-g@mail.gmail.com>
Message-ID: <CAKv+Gu8U9U1ThYxXWU6AuoF5s4uAGps_-T+2tksjc4nGNdX2_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 March 2018 at 15:54, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 14 March 2018 at 14:54, Michal Hocko <mhocko@kernel.org> wrote:
>> On Wed 14-03-18 14:35:12, Ard Biesheuvel wrote:
>>> On 14 March 2018 at 14:13, Michal Hocko <mhocko@kernel.org> wrote:
>>> > Does http://lkml.kernel.org/r/20180313224240.25295-1-neelx at redhat.com
>>> > fix your issue? From the debugging info you provided it should because
>>> > the patch prevents jumping backwards.
>>> >
>>>
>>> The patch does fix the boot hang.
>>>
>>> But I am concerned that we are papering over a fundamental flaw in
>>> memblock_next_valid_pfn().
>>
>> It seems that memblock_next_valid_pfn is doing the right thing here. It
>> is the alignment which moves the pfn back AFAICS. I am not really
>> impressed about the original patch either, to be completely honest.
>> It just looks awfully tricky. I still didn't manage to wrap my head
>> around the original issue though so I do not have much better ideas to
>> be honest.
>
> So first of all, memblock_next_valid_pfn() never refers to its max_pfn
> argument, which is odd nut easily fixed.
> Then, the whole idea of substracting one so that the pfn++ will
> produce the expected value is rather hacky,
>
> But the real problem is that rounding down pfn for the next iteration
> is dodgy, because early_pfn_valid() isn't guaranteed to return true
> for the rounded down value. I know it is probably fine in reality, but
> dodgy as hell. The same applies to the call to early_pfn_in_nid() btw
>
> So how about something like this (apologies on Gmail's behalf for the
> whitespace damage, I can resend it as a proper patch)
>
>
> ---------8<-----------
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3d974cb2a1a1..b89ca999ee3b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5352,28 +5352,29 @@
>                  * function.  They do not exist on hotplugged memory.
>                  */
>                 if (context != MEMMAP_EARLY)
>                         goto not_early;
>
> -               if (!early_pfn_valid(pfn)) {
> +               if (!early_pfn_valid(pfn) || !early_pfn_in_nid(pfn, nid)) {
>  #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
>                         /*
>                          * Skip to the pfn preceding the next valid one (or
>                          * end_pfn), such that we hit a valid pfn (or end_pfn)
>                          * on our next iteration of the loop. Note that it needs
>                          * to be pageblock aligned even when the region itself
>                          * is not. move_freepages_block() can shift ahead of
>                          * the valid region but still depends on correct page
>                          * metadata.
>                          */
> -                       pfn = (memblock_next_valid_pfn(pfn, end_pfn) &
> -                                       ~(pageblock_nr_pages-1)) - 1;
> -#endif
> +                       pfn = memblock_next_valid_pfn(pfn, end_pfn);
> +                       if (pfn >= end_pfn)
> +                               break;
> +                       pfn &= ~(pageblock_nr_pages - 1);
> +#else
>                         continue;
> +#endif
>                 }
> -               if (!early_pfn_in_nid(pfn, nid))
> -                       continue;
>                 if (!update_defer_init(pgdat, pfn, end_pfn, &nr_initialised))
>                         break;
>
>  #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
>                 /*
> ---------8<-----------
>
> This ensures that we enter the remainder of the loop with a properly
> aligned pfn, rather than tweaking the value of pfn so it assumes the
> expected value after 'pfn++'

Um, this does not actually solve the issue. I guess this is due to the
fact that a single pageblock size chunk could have both valid and
invalid PFNs, and so rounding down the first PFN of the second valid
chunk moves you back to the first chunk.

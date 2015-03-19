From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 19 Mar 2015 08:30:03 +0100
Subject: [PATCH v5 8/8] arm64: enforce x1|x2|x3 == 0 upon kernel entry as
 per boot protocol
In-Reply-To: <20150318202430.GA17417@leverpostej>
References: <1426690527-14258-1-git-send-email-ard.biesheuvel@linaro.org>
 <1426690527-14258-9-git-send-email-ard.biesheuvel@linaro.org>
 <20150318181315.GH19814@leverpostej>
 <CAKv+Gu_Psdg1PGbW8mydKGGUvyW=F1D125VSTdABLQEOHMaTwQ@mail.gmail.com>
 <CAKv+Gu_f=e4UG1GmtFh7j8fvq67v94VA=FwgaxHV5rECx0Wf=Q@mail.gmail.com>
 <20150318185737.GJ19814@leverpostej>
 <CAKv+Gu-PX4cPz=yuFeRUbB3COc7jRvGuCYR7h_xLVuUv7A9CfA@mail.gmail.com>
 <20150318202430.GA17417@leverpostej>
Message-ID: <CAKv+Gu-o4x1H1JnWfizTnr_+6MKEQbMXL3yEzT-LggvgM6V0QQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 March 2015 at 21:24, Mark Rutland <mark.rutland@arm.com> wrote:
>> >> >>>  ENTRY(stext)
>> >> >>> +     adr_l   x8, boot_regs                   // record the contents of
>> >> >>> +     stp     x0, x1, [x8]                    // x0 .. x3 at kernel entry
>> >> >>> +     stp     x2, x3, [x8, #16]
>> >> >>
>> >> >> I think we should have a dc ivac here as we do for
>> >> >> set_cpu_boot_mode_flag.
>> >> >>
>> >> >> That avoids a potential issue with boot_regs sharing a cacheline with
>> >> >> data we write with the MMU on -- using __flush_dcache_area will result
>> >> >> in a civac, so we could write back dirty data atop of the boot_regs if
>> >> >> there were clean entries in the cache when we did the non-cacheable
>> >> >> write.
>> >> >>
>> >> >
>> >> > Hmm, I wondered about that.
>> >> >
>> >> > Could we instead just make it u64 __initconst boot_regs[] in setup.c ?
>> >> >
>> >>
>> >> Never mind, it's easier just to do the invalidate right after, and I
>> >> can drop the flush before the access.
>> >
>> > Yup.
>> >
>> > Annoyingly the minimum cache line size seems to be a word (given the
>> > defnition of CTR.DminLine), which means you need a few dc ivac
>> > instructions to be architecturally correct.
>> >
>>
>> But that applies to cpu_boot_mode as well then?
>
> It writes a single word, so it happens to be safe.
>
>> I will add a call to __inval_cache_range() right after recording the
>> initial values, that should do the right thing regarding llinesize
>
> That works, with one caveat: you'll need a dmb sy between the writes and
> the call -- dc instructions by VA only hazard against normal cacheable
> accesses, and __inval_cache_range assumes the caches are on and so
> doesn't have a dmb prior to the dc instructions.
>

Does it matter at all that __inval_cache_range() will mostly end up
doing a civac for the whole array, since it uses civac not ivac for
both non-cachelined aligned ends of the region, and the typical
cacheline size is larger then the size of the array? Couldn't that
also clobber what we just wrote with a stale cacheline?

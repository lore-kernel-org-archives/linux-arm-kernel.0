From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 15 Aug 2014 15:28:33 +0200
Subject: [PATCH v2 1/3] arm64: spin-table: handle unmapped
 cpu-release-addrs
In-Reply-To: <20140815125324.GQ27466@arm.com>
References: <CAKv+Gu_UjRNhhiM0GPsKRdXRtmEnY6cbpY-JZ33RUMapbPYsbQ@mail.gmail.com>
 <20140813125844.GE32644@leverpostej>
 <20140814171323.GH9039@arm.com>
 <CAKv+Gu9ftjZby+5U5Vs0hXhyFdNLwx4MwvC-LL=y3a9eSz34iQ@mail.gmail.com>
 <20140815115714.GP27466@arm.com>
 <CAKv+Gu-2RyWY4V7zoOQEi3As96kmmAMae2s3YauJ4bL9-h+sdg@mail.gmail.com>
 <20140815125324.GQ27466@arm.com>
Message-ID: <CAKv+Gu9vj=b3pOJC3-x+QdjcErHShicEw-_6UHABG_j3qkGGOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 August 2014 14:53, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Aug 15, 2014 at 01:07:16PM +0100, Ard Biesheuvel wrote:
>> On 15 August 2014 13:57, Will Deacon <will.deacon@arm.com> wrote:
>> > On Thu, Aug 14, 2014 at 07:10:13PM +0100, Ard Biesheuvel wrote:
>> >> Patch 3/3 makes the EFI stub load Image at the lowest 2 meg boundary +
>> >> TEXT_OFFSET instead of erroring out when base of DRAM + TEXT_OFFSET is
>> >> occupied. This is necessary as the randomized TEXT_OFFSET could
>> >> potentially conflict with reserved areas at the base of DRAM if a low
>> >> value happens to be chosen.
>> >>
>> >> Patch 1/3 fixes the resulting breakage on APM Mustang in bringing up
>> >> the secondaries, as on that board in particular, the reserved area at
>> >> the base of DRAM contains the holding pen, and loading Image higher up
>> >> makes the mailbox inaccessible through the linear mapping hence the
>> >> need for ioremap_cache()
>> >>
>> >> Patch 2/3 is also a fix for a potential issue on UEFI boot, but it is
>> >> unrelated to 1/3 and 3/3
>> >
>> > I was planning to take all of these for 3.18 as there's no regression here
>> > (the fuzzing is a new debug feature and defaults to `n'). Do you think these
>> > qualify as -rc1 material?
>> >
>>
>> Considering that TEXT_OFFSET fuzzing is recommended to be turned on
>> for distro kernels, I would say this is definitely appropriate for
>> 3.17
>
> Whilst I see that in the commit log, the same recommendation doesn't appear
> in the Kconfig text and I'm not sure that it's such a wise thing to say
> either. From a distribution's point of view, I think I'd want any kernel
> issues to be as reproducible as possible, and fuzzing the text offset seems
> to go against that.
>

OK. There is one other real world issue that 3/3 addresses, which are
platforms that have memreserves at the base of DRAM containing bits of
UEFI itself (this is what got this whole discussion going in the first
place). Currently, we cannot boot via UEFI on these platforms, as the
EFI stub will only consider base of DRAM + TEXT_OFFSET as an option,
and fail the boot if it is not available.

If this is something that could wait until 3.18 as well (Mark S?),
then it's fine by me.

-- 
Ard

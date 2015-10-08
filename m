From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 8 Oct 2015 18:01:32 +0200
Subject: [PATCH v6 0/6] KASAN for arm64
In-Reply-To: <20151008151144.GM17192@e104818-lin.cambridge.arm.com>
References: <1442482692-6416-1-git-send-email-ryabinin.a.a@gmail.com>
 <20151007100411.GG3069@e104818-lin.cambridge.arm.com>
 <CAPAsAGxR-yqtmFeo65Xw_0RQyEy=mN1uG=GKtqoMLr_x_N0u5w@mail.gmail.com>
 <20151008111144.GC7275@leverpostej> <56165228.8060201@gmail.com>
 <CAKv+Gu_v7J1BA+xFcowBrW05bRFs=_WFf_HCeCmWgdZVRo0eQw@mail.gmail.com>
 <20151008151144.GM17192@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu-qn-1SLy6HopaVb1h2Lfp0pXC4sAm0yQum18tsEFw81w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(+ Matt)

On 8 October 2015 at 17:11, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Thu, Oct 08, 2015 at 02:09:26PM +0200, Ard Biesheuvel wrote:
>> On 8 October 2015 at 13:23, Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:
>> > On 10/08/2015 02:11 PM, Mark Rutland wrote:
>> >> On Thu, Oct 08, 2015 at 01:36:09PM +0300, Andrey Ryabinin wrote:
>> >>> 2015-10-07 13:04 GMT+03:00 Catalin Marinas <catalin.marinas@arm.com>:
>> >>>> On Thu, Sep 17, 2015 at 12:38:06PM +0300, Andrey Ryabinin wrote:
>> >>>>> As usual patches available in git
>> >>>>>       git://github.com/aryabinin/linux.git kasan/arm64v6
>> >>>>>
>> >>>>> Changes since v5:
>> >>>>>  - Rebase on top of 4.3-rc1
>> >>>>>  - Fixed EFI boot.
>> >>>>>  - Updated Doc/features/KASAN.
>> >>>>
>> >>>> I tried to merge these patches (apart from the x86 one which is already
>> >>>> merged) but it still doesn't boot on Juno as an EFI application.
>> >>>>
>> >>>
>> >>> 4.3-rc1 was ok and 4.3-rc4 is not. Break caused by 0ce3cc008ec04
>> >>> ("arm64/efi: Fix boot crash by not padding between EFI_MEMORY_RUNTIME
>> >>> regions")
>> >>> It introduced sort() call in efi_get_virtmap().
>> >>> sort() is generic kernel function and it's instrumented, so we crash
>> >>> when KASAN tries to access shadow in sort().
>> >>
>> >> I believe this is solved by Ard's stub isolation series [1,2], which
>> >> will build a stub-specific copy of sort() and various other functions
>> >> (see the arm-deps in [2]).
>> >>
>> >> So long as the stub is not built with ASAN, that should work.
>> >
>> > Thanks, this should help, as we already build the stub without ASAN instrumentation.
>>
>> Indeed. I did not mention instrumentation in the commit log for those
>> patches, but obviously, something like KASAN instrumentation cannot be
>> tolerated in the stub since it makes assumptions about the memory
>> layout
>
> I'll review your latest EFI stub isolation patches and try Kasan again
> on top (most likely tomorrow).
>

OK.

If you (and Matt) are ok with those, I'd like to spin a new version
that only adds strcmp(). We need that in a separate series that only
touches libstub, so with strcmp() added, we are completely independent
in terms of merging order.

Thanks,
Ard.

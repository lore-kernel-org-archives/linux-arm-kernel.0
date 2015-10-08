From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 8 Oct 2015 12:11:44 +0100
Subject: [PATCH v6 0/6] KASAN for arm64
In-Reply-To: <CAPAsAGxR-yqtmFeo65Xw_0RQyEy=mN1uG=GKtqoMLr_x_N0u5w@mail.gmail.com>
References: <1442482692-6416-1-git-send-email-ryabinin.a.a@gmail.com>
 <20151007100411.GG3069@e104818-lin.cambridge.arm.com>
 <CAPAsAGxR-yqtmFeo65Xw_0RQyEy=mN1uG=GKtqoMLr_x_N0u5w@mail.gmail.com>
Message-ID: <20151008111144.GC7275@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 08, 2015 at 01:36:09PM +0300, Andrey Ryabinin wrote:
> 2015-10-07 13:04 GMT+03:00 Catalin Marinas <catalin.marinas@arm.com>:
> > On Thu, Sep 17, 2015 at 12:38:06PM +0300, Andrey Ryabinin wrote:
> >> As usual patches available in git
> >>       git://github.com/aryabinin/linux.git kasan/arm64v6
> >>
> >> Changes since v5:
> >>  - Rebase on top of 4.3-rc1
> >>  - Fixed EFI boot.
> >>  - Updated Doc/features/KASAN.
> >
> > I tried to merge these patches (apart from the x86 one which is already
> > merged) but it still doesn't boot on Juno as an EFI application.
> >
> 
> 4.3-rc1 was ok and 4.3-rc4 is not. Break caused by 0ce3cc008ec04
> ("arm64/efi: Fix boot crash by not padding between EFI_MEMORY_RUNTIME
> regions")
> It introduced sort() call in efi_get_virtmap().
> sort() is generic kernel function and it's instrumented, so we crash
> when KASAN tries to access shadow in sort().

I believe this is solved by Ard's stub isolation series [1,2], which
will build a stub-specific copy of sort() and various other functions
(see the arm-deps in [2]).

So long as the stub is not built with ASAN, that should work.

Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/373807.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/373808.html

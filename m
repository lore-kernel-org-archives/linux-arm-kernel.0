From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 18 Mar 2015 18:57:37 +0000
Subject: [PATCH v5 8/8] arm64: enforce x1|x2|x3 == 0 upon kernel entry as
 per boot protocol
In-Reply-To: <CAKv+Gu_f=e4UG1GmtFh7j8fvq67v94VA=FwgaxHV5rECx0Wf=Q@mail.gmail.com>
References: <1426690527-14258-1-git-send-email-ard.biesheuvel@linaro.org>
 <1426690527-14258-9-git-send-email-ard.biesheuvel@linaro.org>
 <20150318181315.GH19814@leverpostej>
 <CAKv+Gu_Psdg1PGbW8mydKGGUvyW=F1D125VSTdABLQEOHMaTwQ@mail.gmail.com>
 <CAKv+Gu_f=e4UG1GmtFh7j8fvq67v94VA=FwgaxHV5rECx0Wf=Q@mail.gmail.com>
Message-ID: <20150318185737.GJ19814@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 06:46:11PM +0000, Ard Biesheuvel wrote:
> On 18 March 2015 at 19:16, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > On 18 March 2015 at 19:13, Mark Rutland <mark.rutland@arm.com> wrote:
> >> On Wed, Mar 18, 2015 at 02:55:27PM +0000, Ard Biesheuvel wrote:
> >>> According to the arm64 boot protocol, registers x1 to x3 should be
> >>> zero upon kernel entry, and non-zero values are reserved for future
> >>> use. This future use is going to be problematic if we never enforce
> >>> the current rules, so start enforcing them now, by emitting a warning
> >>> if non-zero values are detected.
> >>>
> >>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >>> ---
> >>>  arch/arm64/kernel/head.S  |  4 ++++
> >>>  arch/arm64/kernel/setup.c | 15 +++++++++++++++
> >>>  2 files changed, 19 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> >>> index a0fbd99efb89..8636c3cef006 100644
> >>> --- a/arch/arm64/kernel/head.S
> >>> +++ b/arch/arm64/kernel/head.S
> >>> @@ -233,6 +233,10 @@ section_table:
> >>>  #endif
> >>>
> >>>  ENTRY(stext)
> >>> +     adr_l   x8, boot_regs                   // record the contents of
> >>> +     stp     x0, x1, [x8]                    // x0 .. x3 at kernel entry
> >>> +     stp     x2, x3, [x8, #16]
> >>
> >> I think we should have a dc ivac here as we do for
> >> set_cpu_boot_mode_flag.
> >>
> >> That avoids a potential issue with boot_regs sharing a cacheline with
> >> data we write with the MMU on -- using __flush_dcache_area will result
> >> in a civac, so we could write back dirty data atop of the boot_regs if
> >> there were clean entries in the cache when we did the non-cacheable
> >> write.
> >>
> >
> > Hmm, I wondered about that.
> >
> > Could we instead just make it u64 __initconst boot_regs[] in setup.c ?
> >
> 
> Never mind, it's easier just to do the invalidate right after, and I
> can drop the flush before the access.

Yup.

Annoyingly the minimum cache line size seems to be a word (given the
defnition of CTR.DminLine), which means you need a few dc ivac
instructions to be architecturally correct.

Mark.

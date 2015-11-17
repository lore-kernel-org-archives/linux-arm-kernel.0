From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Nov 2015 17:07:01 +0000
Subject: [RFC PATCH] arm64: use non-global mappings for UEFI runtime
 regions
In-Reply-To: <CAKv+Gu8FPcTSmgfg48jep8WC0_7BhSHERMmtgbgUzk3T6Fbiwg@mail.gmail.com>
References: <1447750411-6424-1-git-send-email-ard.biesheuvel@linaro.org>
 <20151117152558.GK12586@leverpostej>
 <20151117163445.GE30101@arm.com>
 <CAKv+Gu8FPcTSmgfg48jep8WC0_7BhSHERMmtgbgUzk3T6Fbiwg@mail.gmail.com>
Message-ID: <20151117170701.GH30101@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 06:01:38PM +0100, Ard Biesheuvel wrote:
> On 17 November 2015 at 17:34, Will Deacon <will.deacon@arm.com> wrote:
> > On Tue, Nov 17, 2015 at 03:25:58PM +0000, Mark Rutland wrote:
> >> On Tue, Nov 17, 2015 at 09:53:31AM +0100, Ard Biesheuvel wrote:
> >> > As pointed out by Russell King in response to the proposed ARM version
> >> > of this code, the sequence to switch between the UEFI runtime mapping
> >> > and current's actual userland mapping (and vice versa) is potentially
> >> > unsafe, since it leaves a time window between the switch to the new
> >> > page tables and the TLB flush where speculative accesses may hit on
> >> > stale global TLB entries.
> >>
> >> Wow, annoying that we missed that.
> >>
> >> > So instead, use non-global mappings, and perform the switch via the
> >> > ordinary ASID-aware context switch routines.
> >> >
> >> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >>
> >> From digging into the way the ASID allocator works, I believe this is
> >> correct. FWIW:
> >>
> >> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> >>
> >> For backporting, I'm not sure that this is necessarily safe prior to
> >> Will's rework of the ASID allocator. I think we can IPI in this context,
> >> and it looks like the cpu_set_reserved_ttbr0() in flush_context() would
> >> save us from the problem described above, but I may have missed
> >> something.
> >>
> >> Will, are you aware of anything that could bite us here?
> >
> > Can we guarantee that efi_virtmap_{load,unload} are called with interrupts
> > enabled? Also, the old rollover code seems to rely on current->active_mm
> > being the thing to switch to, so an incoming rollover might break things
> > if we're running with the efi_mm.
> >
> 
> OK, but not the current rollover code, right? I.e., if we go with this
> approach (after fixing the interupts issue), it will carry over to ARM
> as well?

Sure, the current code (i.e. for anything after 4.3) looks fine. Let me
go back and ack that...

Will

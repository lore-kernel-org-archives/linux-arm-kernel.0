From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 17 Oct 2013 12:16:02 +0100
Subject: [RFC PATCH] arm64: KVM: honor cacheability attributes on S2
 page fault
In-Reply-To: <CAAhSdy3X1y6Lgni47NQu0ozUbTv3902RaMyBGyjD7OZ9p1=iJw@mail.gmail.com>
References: <20131011123839.GH12308@darko.cambridge.arm.com>
 <CAAhSdy1Sm2N68ZB5r9BmansGYnUgFO0ZFdUL=XB7RhJ258AAFA@mail.gmail.com>
 <20131011143721.GD15803@arm.com>
 <CAAhSdy1RS58HxDD2sKC5NP=vZ-fn=Zc4qEYZoFHR2usGqiQMFA@mail.gmail.com>
 <5258125E.4040709@arm.com>
 <CAAhSdy2nfnDuAZW6XWz0Xc4ehcU9YcHKLv7WVSCgk3+b8AD7Hw@mail.gmail.com>
 <20131011154401.GE15803@arm.com>
 <CAAhSdy3u2KUwdSWniDq=vCfXi6u44FhjKUA96RZPjCMiDaDA5A@mail.gmail.com>
 <20131015143848.GA1591@arm.com>
 <CAAhSdy3X1y6Lgni47NQu0ozUbTv3902RaMyBGyjD7OZ9p1=iJw@mail.gmail.com>
Message-ID: <20131017111601.GK23462@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 05:19:01AM +0100, Anup Patel wrote:
> On Tue, Oct 15, 2013 at 8:08 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > So, the proposal:
> >
> > 1. Clean+invalidate D-cache for pages mapped into the stage 2 for the
> >    first time (if the access is non-cacheable). Covered by this patch.
> > 2. Track guest's use of the MMU registers (SCTLR etc.) and detect when
> >    the stage 1 is enabled. When stage 1 is enabled, clean+invalidate the
> >    D-cache again for the all pages already mapped in stage 2 (in case we
> >    had speculative loads).
> 
> I agree on both point1 & poin2.
> 
> The point2 is for avoiding speculative cache loads for Host-side mappings
> of the Guest RAM. Right?

Yes.

> > The above allow the guest OS to run the boot code with MMU disabled and
> > then enable the MMU. If the guest needs to disable the MMU or caches
> > after boot, we either ask the guest for a Hyp call or we extend point 2
> > above to detect disabling (though that's not very efficient). Guest
> > power management via PSCI already implies Hyp calls, it's more for kexec
> > where you have a soft reset.
> 
> Yes, Guest disabling MMU after boot could be problematic.
> 
> The Hyp call (or PSCI call) approach can certainly be efficient but we need
> to change Guest OS for this. On the other hand, extending point2 (though
> inefficient) could save us the pain of changing Guest OS.
> 
> Can we come-up with a way of avoiding Hyp call (or PSCI call) here ?

It could probably be done more efficiently by decoding the MMU register
access fault at the EL2 level and emulating it there to avoid a switch
to host Linux. But that's not a trivial task and I can't tell about the
performance impact.

We still have an issue here since normally the guest disables the caches
and flushes them by set/way (usually on the last standing CPU, the
others being parked via PSCI). Such guest set/way operation isn't safe
when physical CPUs are up, even if you trap it in Hyp (unless you do it
via other complications like stop_machine() but even that may not be
entirely race-free and it opens the way for DoS attacks). The safest
here would be to do the cache maintenance by VA for all the guest
address space (probably fine if you do it in a preemptible way).

> > This only needs to be done for the primary CPU (or until the first CPU
> > enabled the MMU). Once a CPU enabled its MMU, the others will have
> > to cope with speculative loads into the cache anyway (if secondary VCPU
> > are started by a PSCI HVC call, we can probably ignore the trapping of
> > MMU register access anyway).
> 
> Also, this would be a nice way of reducing Clean-invalidate D-cache upon
> non-cacheable accesses for SMP Guest (i.e. An enhancement to this patch).

I think this should be fine, just do the clean&invalidate when the MMU
is off on all the VCPUs. Once one of them enabled the MMU, fall back to
the faster implementation. The same for the trapping above (unless we
later want to deal with MMU being turned off).

> > Note that we don't cover the I-cache. On ARMv8 you can get speculative
> > loads into the I-cache even if it is disabled, so it needs to be
> > invalidated explicitly before the MMU or the I-cache is enabled.
> 
> I think it should be responsibility of Guest OS to invalidate I-cache before
> enabling MMU or I-cache enable. Right?

Yes.

-- 
Catalin

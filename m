From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 16 May 2011 17:31:26 +0100
Subject: [PATCH 0/1] ARM: thumb: Fix thumb mode compilation problems.
In-Reply-To: <BANLkTi=k4UWY-K+gG8gBnvvEE3QOTZaaKQ@mail.gmail.com>
References: <20110513195845.2FFE540CD1@eskimo.mtv.corp.google.com>
	<20110516103835.GA6955@arm.com>
	<BANLkTi=k4UWY-K+gG8gBnvvEE3QOTZaaKQ@mail.gmail.com>
Message-ID: <20110516163126.GB22931@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2011 at 09:06:26AM -0700, Colin Cross wrote:
> On Mon, May 16, 2011 at 3:38 AM, Dave Martin <dave.martin@linaro.org> wrote:
> > On Fri, May 13, 2011 at 12:58:45PM -0700, Vadim Bendebury wrote:
> >>
> >> This patch won't necessarily apply as it has not been verified on
> >> a real hardware, so this is more of an RFC.
> >>
> >> Vadim Bendebury (1):
> >> ? ARM: thumb: Fix thumb mode compilation problems.
> >>
> >> ?arch/arm/kernel/fiq.c ? ? ? ? | ? 34 ++++++++++++++++++++++++++--------
> >> ?arch/arm/mach-tegra/headsmp.S | ? ?3 ++-
> >> ?2 files changed, 28 insertions(+), 9 deletions(-)
> >>
> >> --
> >> 1.7.3.1
> >>
> >>
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel at lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
> > A different patch for this has already been discussed:
> >
> > http://thread.gmane.org/gmane.linux.ports.arm.kernel/112864
> >
> > It's a bit stalled on my side because I don't have a suitable platform
> > to test it on. ?As some have suggested, in my case (imx51) the inclusion
> > of code was inherited from from an older subarch tree and is no longer
> > appropriate -- so my problem is actually solved just by not building
> > this code.
> >
> > If the code is really used in your kernel (not just built) it would
> > be really useful if you could test this patch.
> >
> > However you should definitely check whether the code is really used at
> > all on tegra.
> >
> > There's a fair chance that it's not used: FIQ is not much used by linux
> > on armv7 and above: unless you make use of cache+TLB lockdown / SRAM etc.,
> > FIQ is unlikely to be significantly faster than IRQ on recent CPUs. ?FIQ
> > may also get reserved for use by TrustZone on some platforms, complicating
> > the picture further.
> 
> Most Android kernels, including on Tegra, use the FIQ handler for a
> simple debugger on the serial console.   Sending a break will enter
> debugger mode, which can dump backtraces from FIQ context, even if the
> CPU is stuck in an IRQ, or with IRQs off.
> 
> We've never used a Thumb2 kernel though.

Fair enough -- in that case I guess it may be needed.

Sounds like entering the debugger will help in testing this; I don't have
the board myself though.

---Dave

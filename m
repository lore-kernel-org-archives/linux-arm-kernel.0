From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Sep 2016 17:58:11 +0200
Subject: [PATCH 1/2] armv8: aarch32: Execute 32-bit Linux for LayerScape
 platforms
In-Reply-To: <d63613a0-8153-cc7e-f1e2-7f324f624b0f@arm.com>
References: <1474597146-33312-1-git-send-email-b18965@freescale.com>
 <2017806.nj5EEu7nrO@wuerfel> <d63613a0-8153-cc7e-f1e2-7f324f624b0f@arm.com>
Message-ID: <2519047.ijr708V79a@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 23, 2016 4:13:30 PM CEST Robin Murphy wrote:
> On 23/09/16 15:44, Arnd Bergmann wrote:
> > On Friday, September 23, 2016 3:24:12 PM CEST Robin Murphy wrote:
> >> On 23/09/16 15:01, Stuart Yoder wrote:
> >> Otherwise you can
> >> always simply run your own shim at EL2 to drive an AArch32 EL1 (it'll
> >> need to trap and translate subsequent SMC calls for e.g. PSCI).
> >>
> >>> If there is such a requirement, it's something begging for standardization.
> >>> Doesn't make sense for multiple divergent approaches for switching from
> >>> aarch64/EL2 to aarch32/EL2.
> >>
> >> Perhaps - I did briefly look into how hard it would be to write a proper
> >> SMC service handler to do this (since ATF does have a framework for such
> >> things), but concluded it would be more than 10 minutes' work and just
> >> cheated instead. It's certainly something which could be raised with the
> >> firmware folks.
> > 
> > If we end up allowing all arm64 platforms to be enabled in arch/arm,
> > we could perhaps create a generic implementation that does both of
> > those things, i.e.
> > 
> > - Take the arm32 kernel Image or zImage file, wrap it inside of a binary
> >   that implements the arm64 boot protocol.
> > - When that starts up, try to use the new PSCI call to jump into
> >   the arm32 kernel
> > - If PSCI failed and we are running in EL2, implement the shim
> >   and start the arm32 kernel in EL1 mode
> 
> Really, though, the firmware call thing is an incredibly niche use-case.
> Beyond development, the only real benefit of starting an AArch32 kernel
> in Hyp is that you can run AArch32 KVM guests, which you can do equally
> well (if not better) under an AArch64 kernel.

This was my question earlier in the thread, apparently Alison has
another use case in mind, but I don't yet know what that is. If
that use case is important enough, we could do it this way.

The only use case I can think of at the moment is boot testing
on kernelci.org, which could be used to check whether all the drivers
work in 32-bit environments.

	Arnd

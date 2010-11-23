From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Nov 2010 20:06:30 +0000
Subject: [PATCH v2] arm: GIC: Do not try to register more then NR_IRQS
	interrupts
In-Reply-To: <F01D8B85CFF58440B2A13965FBA90CA45911B9845B@GEORGE.Emea.Arm.com>
References: <1290541542-12917-1-git-send-email-pawel.moll@arm.com>
	<20101123195026.GC26510@n2100.arm.linux.org.uk>
	<F01D8B85CFF58440B2A13965FBA90CA45911B9845B@GEORGE.Emea.Arm.com>
Message-ID: <20101123200630.GD26510@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 23, 2010 at 08:01:30PM +0000, Pawel Moll wrote:
> > > +   gic_irqs = readl(base + GIC_DIST_CTR) & 0x1f;
> > > +   gic_irqs = (gic_irqs + 1) * 32;
> >
> > I think this should still be limited to 1020 IRQs.  Note that 1020 is
> > not divisible by 32, so gic_irqs ends up being 1024 which is wrong.
> 
> You mean situation when ITLinesNumber=31, I suppose? Well, registers
> covering 1021-1023 would exist anyway, and I would hope that the
> relevant bits would be simply ignored, but we may safeguard ourselves
> anyway.

It wasn't so much the bits in the register I was concerned about, but
the situation where NR_IRQS > 1020, and we have a secondary controller
using numbers 1021 upwards.

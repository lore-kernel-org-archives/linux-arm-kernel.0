From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 14 Jul 2015 15:55:46 +0100
Subject: [PATCH v3 3/3] arm: kernel: implement cpuidle_ops with psci
 backend
In-Reply-To: <20150714122904.GV7557@n2100.arm.linux.org.uk>
References: <1436430685-2202-1-git-send-email-jszhang@marvell.com>
 <1436430685-2202-4-git-send-email-jszhang@marvell.com>
 <20150714103421.GU7557@n2100.arm.linux.org.uk>
 <20150714110302.GA334@red-moon>
 <20150714122904.GV7557@n2100.arm.linux.org.uk>
Message-ID: <20150714145546.GA14556@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 01:29:04PM +0100, Russell King - ARM Linux wrote:
> On Tue, Jul 14, 2015 at 12:03:02PM +0100, Lorenzo Pieralisi wrote:
> > On Tue, Jul 14, 2015 at 11:34:21AM +0100, Russell King - ARM Linux wrote:
> > > > +static struct cpuidle_ops psci_cpuidle_ops __initdata = {
> > > > +	.suspend = cpu_psci_cpu_suspend,
> > > > +	.init = cpu_psci_cpu_init_idle,
> > > > +};
> > > > +CPUIDLE_METHOD_OF_DECLARE(psci_cpuidle, "psci", &psci_cpuidle_ops);
> > 
> > I take this as an ACK to M.Rutland's PSCI code move to drivers/firmware,
> > right ?
> 
> No, that's not something I've particularly looked at.  PSCI doesn't really
> interest me because I have no systems which (afaik) support it.

PSCI implementation is currently part of arch/arm which means it is
used on arch/arm (and related platforms) and you should be interested in it
for that specific reason.

It is not about what you are interested on, it is about the code you
maintain, so please have a look at it, thank you.

> > > We don't do this for other stuff - we don't have IRQ_CHIP_OF_DECLARE
> > > stuff in arch/arm but have the IRQ chip drivers in drivers/irqchip.
> > > We keep it all togehter in drivers/irqchip, even when the IRQ chip
> > > driver is only useful on ARM.
> > 
> > CPUidle operations are ARM only, they are not used on ARM64, so
> > they belong in arch/arm (that's the same thing as SMP ops, on ARM64
> > SMP ops and CPUidle ops are unified through CPU operations).
> 
> I don't agree with that.  CPU idle isn't an "ARM thing" at all, it's
> generic kernel infrastructure.  OF is generic kernel infrastructure too.

I said "CPUidle operations", not CPUidle, we know CPUidle is not an
ARM thing.

> Yet, we're stuffing _all_ the PSCI CPU idle code into
> drivers/firmware/psci.c, but then stuffing the PSCI OF data structures
> into arch/arm.  This is utterly _insane_.

Ok, so we will copy the ARM64 PSCI idle related code to arch/arm
and we are done with this, or we will have to ifdef drivers/firmware
code, take your pick.

> There is nothing ARM specific about these CPU idle ops.  They don't
> belong on arch/arm.

See above.

> NAK on this series (and the move of the PSCI code to drivers/firmware)

I do not accept that. You may NAK this series but you can't object to
moving PSCI firmware code to drivers/firmware for that reason, so
please have a look at Mark's patches again and ACK/NAK them for
a valid reason, it has been a while since he asked.

> until people start seeing sense with stuff like this.  Having stuff split
> between arch/arm/ and drivers/ like this is totally crap.  It makes code
> unnecessary complex for no reason what so ever.

That's rather vague and just your opinion. If you have a solution better
than this one you tell us about it otherwise you keep your comments for
yourself, thank you.

> Find a solution which doesn't involve leaving _just_ data structures to
> connect stuff to OF in arch/arm.

I will copy the PSCI CPUidle related functions from arm64 to arch/arm so that
it is not _just_ OF data structures and I hope we are done with this.

Lorenzo

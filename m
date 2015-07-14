From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 14 Jul 2015 13:29:04 +0100
Subject: [PATCH v3 3/3] arm: kernel: implement cpuidle_ops with psci
 backend
In-Reply-To: <20150714110302.GA334@red-moon>
References: <1436430685-2202-1-git-send-email-jszhang@marvell.com>
 <1436430685-2202-4-git-send-email-jszhang@marvell.com>
 <20150714103421.GU7557@n2100.arm.linux.org.uk>
 <20150714110302.GA334@red-moon>
Message-ID: <20150714122904.GV7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 12:03:02PM +0100, Lorenzo Pieralisi wrote:
> On Tue, Jul 14, 2015 at 11:34:21AM +0100, Russell King - ARM Linux wrote:
> > > +static struct cpuidle_ops psci_cpuidle_ops __initdata = {
> > > +	.suspend = cpu_psci_cpu_suspend,
> > > +	.init = cpu_psci_cpu_init_idle,
> > > +};
> > > +CPUIDLE_METHOD_OF_DECLARE(psci_cpuidle, "psci", &psci_cpuidle_ops);
> 
> I take this as an ACK to M.Rutland's PSCI code move to drivers/firmware,
> right ?

No, that's not something I've particularly looked at.  PSCI doesn't really
interest me because I have no systems which (afaik) support it.

> > We don't do this for other stuff - we don't have IRQ_CHIP_OF_DECLARE
> > stuff in arch/arm but have the IRQ chip drivers in drivers/irqchip.
> > We keep it all togehter in drivers/irqchip, even when the IRQ chip
> > driver is only useful on ARM.
> 
> CPUidle operations are ARM only, they are not used on ARM64, so
> they belong in arch/arm (that's the same thing as SMP ops, on ARM64
> SMP ops and CPUidle ops are unified through CPU operations).

I don't agree with that.  CPU idle isn't an "ARM thing" at all, it's
generic kernel infrastructure.  OF is generic kernel infrastructure too.

Yet, we're stuffing _all_ the PSCI CPU idle code into
drivers/firmware/psci.c, but then stuffing the PSCI OF data structures
into arch/arm.  This is utterly _insane_.

There is nothing ARM specific about these CPU idle ops.  They don't
belong on arch/arm.

NAK on this series (and the move of the PSCI code to drivers/firmware)
until people start seeing sense with stuff like this.  Having stuff split
between arch/arm/ and drivers/ like this is totally crap.  It makes code
unnecessary complex for no reason what so ever.

Find a solution which doesn't involve leaving _just_ data structures to
connect stuff to OF in arch/arm.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

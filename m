From: tpiepho@impinj.com (Trent Piepho)
Date: Tue, 27 Nov 2018 18:53:25 +0000
Subject: iMX6 PCIe MSI issues
In-Reply-To: <4a582df8-f7dc-3ad5-42d7-33924eb57b0a@sedsystems.ca>
References: <aad42775-52b6-6086-60a8-e45a17d50960@sedsystems.ca>
 <CAOMZO5DuZ4ZWk03tnsTx=Vpd8AbnCADMgyyKRuL0F6N3ZmN6qw@mail.gmail.com>
 <1543252169.18519.49.camel@impinj.com>
 <4a582df8-f7dc-3ad5-42d7-33924eb57b0a@sedsystems.ca>
Message-ID: <1543344805.18519.71.camel@impinj.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-11-26 at 13:24 -0600, Robert Hancock wrote:
> 
> > Also, I think the new irq domain stuff in 4.17 breaks irq accounting to
> > the GIC chain interrupt (152) to the dwc msi domain.  It'll always show
> > as zero in /proc/interrupts.  But I've mostly been working in 4.16 so
> > I'm not sure about the precise interaction of irq domains and
> > /proc/interrupts yet.
> 
> I'm not actually seeing the MSI interrupt showing up in /proc/interrupts
> at all in 4.19. From adding some debug output into the dwc PCIe code, it
> appears it's using Linux IRQ 24 as the chaining interrupt, but there's
> no entry in /proc/interrupts for either Linux IRQ 24 or GIC vector 152.
> Not sure if there is supposed to be or not. It does appear that the
> vector isn't masked in the GIC in any case, however, and when I force
> the interrupt into the GIC pending register, things seem to happen
> properly after that.

In 4.16, the MSI chaining interrupt does show up in /proc/interrupts
and does increment.  Also shows up as trace events too.

In 4.17, it no longer appears in /proc/interrupts.  Finding the Linux
irq number is non-obvious, as you've seen.  It will show up in
/sys/kernel/irq and /sys/kernel/debug/irq/irqs, but the count is always
zero.  IMHO, not an improvement.

So if you're using that count in /sys to determine that the GIC irq
never fired, then it's not conclusive.  It always reads zero.

But the same problem 2014 would obviously predate the 4.17 kernel.

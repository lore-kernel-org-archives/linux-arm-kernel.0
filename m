From: bpringlemeir@nbsps.com (Bill Pringlemeir)
Date: Mon, 27 Jan 2014 16:17:17 -0500
Subject: [RFC] drivers: irq-chip: Enable SGI's for Secure-to-NonSecure
 communication use-cases
References: <79CD15C6BA57404B839C016229A409A83EDAD1B8@DBDE04.ent.ti.com>
 <20140106132536.GA27282@n2100.arm.linux.org.uk>
 <79CD15C6BA57404B839C016229A409A83EDAD85E@DBDE04.ent.ti.com>
Message-ID: <87wqhl15wi.fsf@nbsps.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]

>> So it seems that your intention is to use the existing infrastructure
>> for this by directing SGIs through the normal IRQ processing.
>> To that idea, I say no way.

On  6 Jan 2014, hvaibhav at ti.com wrote:

> You have any other alternative?

I think you need to put Bhupesh Sharma's comment with this.  The typical
sane mode for GIC with TZ is to have the monitor mode toggle the IRQ/FIQ
routing bits in the SCR (cp15) bits 1,2.  That is, the IRQ goes direct
to core and FIQ goes to monitor from the 'Normal' world.  In the
'Secure' world, the FIQ goes direct to core and IRQ traps to monitor.
The monitor mode vector table has a gateway from secure to normal for
IRQ and gateway from normal to secure for FIQ.

Now, consider the 'SMC' instruction and what is present in stuff like
this,

 http://lwn.net/Articles/513756/
 mach-omap2/{omap-smc.S,omap-secure.c,omap-secure.h}

Instead of messing around with the GIC, why not use something even more
generic like the 'SMC' instruction.  It has the same sort of 'end game'
which is a trap to monitor mode.  The monitor has to be a little smarter
to determine which world called but this should always be the case;
really you want to check this.

Btw, the situation is the same no matter which world Linux is in.  I
don't think Linux can be the recipient of an 'SMC' call.  But I think
most use cases would put it in the 'normal world' and the SMC is fine.

Fwiw,
Bill Pringlemeir.

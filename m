From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 12 Jan 2010 15:21:31 -0500 (EST)
Subject: [RFC 08/18] arm: msm: set L2CR1 to enable prefetch and burston
	Scorpion.
In-Reply-To: <20100112114441.GB27771@n2100.arm.linux.org.uk>
References: <20100111234540.GN7925@n2100.arm.linux.org.uk>
	<1263293501.29654.40.camel@pc1117.cambridge.arm.com>
	<20100112114441.GB27771@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1001121429360.10143@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Jan 2010, Russell King - ARM Linux wrote:

> On Tue, Jan 12, 2010 at 10:51:41AM +0000, Catalin Marinas wrote:
> > We discussed in the past but the thread died. There are various bits
> > that may need to be enabled before the CPU is initialised but it is
> > highly dependent on the hardware configuration and not only the CPU
> > type. For example, Cortex-A8/A9 may have some bits in the ACTLR register
> > which are fine to set on RealView but not on OMAP because the kernel
> > there is running in non-secure mode. Now Scorpion has other needs.
> > 
> > Since such initialisation would run before the MMU is enabled, should we
> > add an additional per-platform macro to be invoked before the CPU is set
> > up? A pointer in the machine_desc structure to an asm routine would also
> > work assuming that care is taken to calculate the phys address and the
> > code is position independent.
> 
> What you're asking for is bith platform and CPU dependent - which makes
> it much more difficult to generalize.  It also throws a spanner in the
> works for the DT people.

We have a similar issue with the latest Marvell SOCs.  Those are using a 
PJ4 core which is available in two variants: ARMv6 compatible and ARMv7 
compatible. The problem is that both variants have the same main CPU ID: 
0x560f5810.  Now that the architecture level field has been obsoleted by 
ARM Ltd (it contains 0xf) therefore the architecture has to be 
determined through other means.  There is unfortunately no other 
standard register with a simple architecture level value like this field 
used to hold.

Of course we want a single kernel image to be able to work with both 
variants.  That means that we need to find a way at runtime to select 
between service functions from proc-v6.S or proc-v7.S, but the current 
simple value/mask scheme doesn't work anymore.

So...  Maybe a new scheme could be used instead without impacting 
backward compatibility.  For example, what about replacing the mask 
field with a probe function address?  Whenever the recorded CPU ID value 
in the proc_info structure is 0xffffff then the CPU mask value is 
instead a probe function that should return success/failure, and 
therefore the CPU probing could be as elaborate as it needs to be.  And 
if special initializations have to be performed before the MMU is turned 
on then that could be the place to perform them before success is 
returned.

What do you think?


Nicolas

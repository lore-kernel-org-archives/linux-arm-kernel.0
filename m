From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 15 Jan 2011 12:01:17 +0000
Subject: [PATCH] ARM: make head.S less dependent on the compile time
	PHYS_OFFSET define
In-Reply-To: <alpine.LFD.2.00.1101142322580.938@xanadu.home>
References: <alpine.LFD.2.00.1101131659220.11803@xanadu.home>
	<20110113232327.GG24149@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101140050070.25804@xanadu.home>
	<20110115004449.GU15996@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101142322580.938@xanadu.home>
Message-ID: <20110115120117.GY15996@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 14, 2011 at 11:49:31PM -0500, Nicolas Pitre wrote:
> On Sat, 15 Jan 2011, Russell King - ARM Linux wrote:
> 
> > I've pushed it out under the branch p2v.  I think before this
> > goes upstream, "ARM: P2V: Use pv_fixup trick to get physical address"
> > needs merging with "ARM: P2V: make head.S use PLAT_PHYS_OFFSET" -
> > it doesn't really make sense to fix the same code twice for the same
> > underlying problem in the same patch set when it's possible to only
> > fix it once.
> 
> Indeed.  You probably should fold the following with it as well:

Ok, done.

One other item which has been missed: the p2v build state between kernel
and modules must match to prevent incompatible modules being loaded.

This also applies for the 16-bit p2v stuff as well - an 8-bit p2v module
can't be loaded into a 16-bit p2v kernel as it will be missing bits
16-23 of the offset.

These dependencies are actually one-way:

		------- module -------
kernel		fixed	p2v-8	p2v-16
fixed		y	n*	n*
p2v-8		n	y	y
p2v-16		n	n	y

The 'n*' could be 'y' if we always include the fixup code, but I'm not
sure the complexity required for expressing these dependencies (which
can't be done with the vermagic method) is worth it.

So I've added a marker to the module version string, which will require
the build configuration of P2V for the kernel and modules to match.

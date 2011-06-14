From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 14 Jun 2011 09:42:11 -0600
Subject: [RFC 1/2] ARM:Tegra: Device Tree Support: Initialize the audio
	card from the device tree.
In-Reply-To: <20110602213656.GB10532@n2100.arm.linux.org.uk>
References: <20110527205444.21000.90209.stgit@riker>
	<20110527205706.21000.34832.stgit@riker>
	<BANLkTi=NMjBjWVv_o3PocejhgGr8TdG+1Q@mail.gmail.com>
	<BANLkTi=PtEhxxmZo2DqvmySCmnEd3LbezQ@mail.gmail.com>
	<BANLkTikWpiY_o27OF-Jxvq7iPeWzrAYOsQ@mail.gmail.com>
	<20110602160445.GA8373@ponder.secretlab.ca>
	<20110602213656.GB10532@n2100.arm.linux.org.uk>
Message-ID: <20110614154211.GA1839@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2011 at 10:36:56PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jun 02, 2011 at 10:04:45AM -0600, Grant Likely wrote:
> > Right now we can't do dynamic registration for on-chip devices in a
> > lot of cases because we don't have the infrastructure to hook up the
> > associated struct clks.
> 
> I've been wondering about this, and I don't see it as a blocking problem
> as you seem to be.
> 
> I assume platform devices have stable names when they're created from
> the device tree?  If yes, there's no problem having the DT start to
> describe the SoC specific devices _today_ - all that the clk API using
> clkdev requires is a stable device name.

Yes, the name is stable, but the name isn't the same as what board
support code currently uses for statically registered
platform_devices, and when I started on this work my goal has been to
have as little impact on existing platform support code.  I certainly
didn't want two sets of clock registrations, one with the names that
statically allocated platform devices use and one with the DT
generated names.

One solution would have been to add a "linux,devname" property or
something similar to each device node, but one of the things I'm very
careful about is to strongly avoid encoding Linux specific
implementation details into the DT.  History has shown that internal
details are subject to change over time, so there is less chance of
breaking a DT platform if the description is focused on the HW.  The
name Linux needs to hook up {clocks,regulators,etc} to a device very
much falls into this category.

That said, I stepped back and took another look at the problem after
receiving your email, and I've been looking at it all wrong.  I did
actually had a solution that matched up static device registrations
to DT nodes (of_platform_prepare()), but it was complex and ugly so I
wasn't very excited about it.

However, I've got a patch now that solves the problem in a much nicer
way.  If Linux needs specific devices to have specific names, then it
can pass in a lookup table that matches DT nodes to device names,
which is considerably simpler and it leaves the platform setup code in
control over how devices get instantiated.  I'll post the patches today
or tomorrow.

So, basically, all my problems on obtaining clocks are now completely
gone.  :-)

Ultimately, this is a short-term solution that allows devices to get
described in the DT without having to implement clock mappings at the
same time.  When clock mappings also get moved to the device tree, the
need for the lookup table simply goes away.

g.

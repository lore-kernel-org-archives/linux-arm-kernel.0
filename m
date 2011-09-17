From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 17 Sep 2011 12:23:21 +0100
Subject: [PATCH] arm/dt: Add SoC detection macros
In-Reply-To: <20110917103457.GP28104@game.jcrosoft.org>
References: <1315555339-12685-1-git-send-email-amartin@nvidia.com>
	<20110917102811.GC16381@n2100.arm.linux.org.uk>
	<20110917103457.GP28104@game.jcrosoft.org>
Message-ID: <20110917112321.GE16381@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 17, 2011 at 12:34:57PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 11:28 Sat 17 Sep     , Russell King - ARM Linux wrote:
> > One last point to raise here is - and it's quite a fundamental one - do we
> > really want this?  If we're making decisions based on the SoC type, that
> > suggests to me that the hardware description in DT is incomplete, and
> > we're hiding stuff in the kernel behind the SoC type.  That doesn't sound
> > particularly appealing given the point of DT is to encode the hardware
> > specific information outside the kernel code.
>
> except if a machine can run on 2 soc so detect it will avoid to have 2 Device
> Tree

This code is structured to match the SoC based upon an entry in the DT,
so for tegra2 vs tegra3 it's already having to have two different DTs
to distinguish between them.

However, I still go back to my original point: the point of DT is to
provide a description of the hardware which the kernel is running on -
not only for current hardware but possibly future hardware as well.  Eg,
if Tegra4 comes along with more peripherals than Tegra3 but has basic
hardware which the kernel already supports, just wired up differently,
then Tegra4 should just work with a new DT file and no code changes.

What I'm saying is that in that scenario it should not be necessary to
edit the kernel to invent new SoC types, and then teach it that Tegra4
is mostly the same as Tegra3.  That information should all be encoded
into the DT rather than the C code in the kernel.

So, I think adding this SoC type stuff is the wrong approach to the
problem.

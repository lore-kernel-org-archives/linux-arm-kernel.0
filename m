From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 18 May 2010 07:57:43 -0400 (EDT)
Subject: Boot interface for device trees on ARM
In-Reply-To: <201005181324.45701.jeremy.kerr@canonical.com>
References: <201005181054.32325.jeremy.kerr@canonical.com>
	<alpine.LFD.2.00.1005172341200.12758@xanadu.home>
	<201005181324.45701.jeremy.kerr@canonical.com>
Message-ID: <alpine.LFD.2.00.1005180742500.12758@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 May 2010, Jeremy Kerr wrote:

> Hi Nicolas,
> 
> > I think that, for the moment, it is best if the bootloader on already 
> > existing subarchitectures where DT is introduced still preserve the 
> > already existing ability to boot using ATAGs.  This allows for the 
> > testing and validation of the DT concept against the legacy ATAG method 
> > more easily.
> 
> Just to clarify - by "still preserve the existing ability to use ATAGs" you 
> mean only for non-DT boot, right?

Exact.  Once a particular SOC family has no non-DT support anymore (due 
to being entirely new, or because people get really enthusiastic and 
fade out legacy machine specific init code completely) then and only 
then it might be logical to remove ATAG from the concerned bootloaders.


> This proposal still does not require ATAG_DEVTREE?

No.

> > Why one DT machine ID per subarchitecture?  Simply because a significant
> > part of the DT handling code will have to be subarchitecture specific
> > anyway.  The timer hardware, the GPIO configuration and muxing, SOC
> > specific platform data handling, power management config, and many other
> > things are simply too different from one SOC family to another and
> > trying to have a single global DT support code to rule them all is
> > insane.
> 
> The code for DT boot will be still subarch-specific, but I don't think we need 
> IDs for that. There is enough information in the device tree to select the 
> subarch-specific code to use for early init, without needing to parameterise 
> every element of the machine.

You can't do that without shifting the World Order on ARM.  And _that_ 
is going to create resistance for merging DT support.

> The machine-level "compatible" property allows 
> us to do this.
> 
> Therefore, I don't think we need the machine ID at all: once the DT is 
> available, we can use that for any machine-specific stuff. Even though we're 
> not *configuring* it from the device tree, we can *select* it from there 
> instead.

This is just added complexity, especially in the early boot code which 
for now simply has to compare r1 against well known constants.  We have 
that ID passed by the bootloader already.  I don't see the advantage of 
ignoring it and relying solely on DT for that.

Furthermore, if you're interested only in, say, OMAP5 (let's say you're 
doing U-Boot for it) then you need no bother about anything else than 
passing the ID number for OMAP5_DEVICE_TREE into r1 and manage 
*everything else* in the device tree.


Nicolas

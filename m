From: tony@atomide.com (Tony Lindgren)
Date: Tue, 6 Dec 2016 09:05:40 -0800
Subject: How do I define SRAM chip in GPMC device tree ?
In-Reply-To: <3f98534e-2176-e03e-ac53-b60b8d0ead7c@newflow.co.uk>
References: <3f98534e-2176-e03e-ac53-b60b8d0ead7c@newflow.co.uk>
Message-ID: <20161206170540.GA13181@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Mark Jackson <mpfj-list@newflow.co.uk> [161206 04:33]:
> Hi
> 
> We have an existing board supported in Linux v4.1 (see am335x-nano.dts)
> and I was looking to update to a more recent kernel but have hit a stumbling
> block.
> 
> Our unit has an SRAM device connected to CS1 and we currently rely on uboot
> to init the GPMC settings.
> 
> From v4.2+ I now see that the GPMC code has been changed to reset all the
> GPMC settings when the kernel starts, so our SRAM is now inaccessible.

Yes we've changed to use device tree to describe what's on the GPMC and
refuse to probe it unless configured properly. This is because of the
problems trying to use unknown bootloader configuration, such as kernel
hangs if GPMC was accessed in some cases.

If you enable CONFIG_OMAP_GPMC_DEBUG you should see the bootloader
configured timings in mostly suitable format for adding to dts.

> I've tried the following to add an extra device to the GPMC, but no go:-
> 
> 	sram at 1,0 {
> 		reg = <1 0x00000000 0x01000000>;
> 		/*compatible = "mmio-sram";*/
> 		bank-width = <2>;
> 
> 		gpmc,mux-add-data = <2>;
> 
> 		gpmc,sync-clk-ps = <0>;
> 		gpmc,cs-on-ns = <0>;
> 		gpmc,cs-rd-off-ns = <160>;
> 		gpmc,cs-wr-off-ns = <160>;
> 		gpmc,adv-on-ns = <10>;
> 		gpmc,adv-rd-off-ns = <30>;
> 		gpmc,adv-wr-off-ns = <30>;
> 		gpmc,oe-on-ns = <40>;
> 		gpmc,oe-off-ns = <160>;
> 		gpmc,we-on-ns = <40>;
> 		gpmc,we-off-ns = <160>;
> 		gpmc,rd-cycle-ns = <160>;
> 		gpmc,wr-cycle-ns = <160>;
> 		gpmc,access-ns = <150>;
> 		gpmc,page-burst-access-ns = <10>;
> 		gpmc,cycle2cycle-samecsen;
> 		gpmc,cycle2cycle-delay-ns = <20>;
> 		gpmc,wr-data-mux-bus-ns = <70>;
> 		gpmc,wr-access-ns = <80>;
> 	};
> 
> Looking at drivers/memory/omap-gpmc.c, I can see that when the GPMC
> children are scanned, only the following are matched:-
> 
> "nand","onenand","ethernet","nor","uart"

Those are to set up things for probing the device driver for the
connected device. Some have both sync and async accaess to configure,
so at least so far we have not been able to come up with a generic
init.

> So can anyone explain how to add a standard SRAM chip ?

Assuming you've verified that the dts configuration produces working
timings for you, pobably gpmc_probe_generic_child() is the way to
go for adding "sram" option. Note that we have similar interfaces
already for onenand and ethernet for their buffers so you may want
to take a look what the init does for those.

But yeah basically a little bit of new code is needed for that.

Regards,

Tony

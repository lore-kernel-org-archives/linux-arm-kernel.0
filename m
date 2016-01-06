From: tony@atomide.com (Tony Lindgren)
Date: Wed, 6 Jan 2016 08:44:00 -0800
Subject: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
In-Reply-To: <20160106090543.GC11364@pali>
References: <568662FC.9050206@gmail.com> <20160104170206.GC12777@atomide.com>
 <201601041834.56056@pali> <20160104174001.GD12777@atomide.com>
 <568AC0F9.2010304@gmail.com> <20160105041356.GE12777@atomide.com>
 <20160105084947.GG22661@pali> <20160105224929.GF12777@atomide.com>
 <568CD697.9060800@gmail.com> <20160106090543.GC11364@pali>
Message-ID: <20160106164400.GJ12777@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pali Roh?r <pali.rohar@gmail.com> [160106 01:06]:
> On Wednesday 06 January 2016 10:55:51 Ivaylo Dimitrov wrote:
> > On  6.01.2016 00:49, Tony Lindgren wrote:
> > >
> > >Suggested fix below, please test and reply with your Tested-by's if
> > >it solves the problem so we may still be able to get this into v4.4.
> > >
> > >8< ---------------
> > >From: Tony Lindgren <tony@atomide.com>
> > >Date: Tue, 5 Jan 2016 12:04:20 -0800
> > >Subject: [PATCH] ARM: OMAP2+: Fix onenand rate detection to avoid filesystem
> > >  corruption
> > >
> > >Commit 63aa945b1013 ("memory: omap-gpmc: Add Kconfig option for debug")
> > >unified the GPMC debug for the SoCs with GPMC. The commit also left
> > >out the option for HWMOD_INIT_NO_RESET as we now require proper timings
> > >for GPMC to be able to remap GPMC devices out of address 0.
> > >
> > >Unfortunately on 900, onenand now only partially works with the device
> > >tree provided timings. It works enough to get detected but the clock
> > >rate supported by the onenand chip gets misdetected. This in turn causes
> > >the GPMC timings to be miscalculated and this leads into file system
> > >corruption on n900.
> > >
> > >Looks like onenand needs CS_CONFIG1 bit 27 WRITETYPE set for for sync
> > >write. This is needed also for async timings when we write to onenand
> > >with omap2_onenand_set_async_mode(). Without sync write bit set, the
> > >async read for the onenand ONENAND_REG_VERSION_ID will return 0xfff.
> > >
> > >Let's exit with an error if onenand rate is not detected. And let's
> > >remove the extra call to omap2_onenand_set_async_mode() as we only
> > >need to do this once at the end of omap2_onenand_setup_async().
> > >
> > >Reported-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> > >Signed-off-by: Tony Lindgren <tony@atomide.com>
> > >
> > >--- a/arch/arm/mach-omap2/gpmc-onenand.c
> > >+++ b/arch/arm/mach-omap2/gpmc-onenand.c
> > 
> > Bellow is gpmc dmesg output with that fix. I also disabled
> > CONFIG_OMAP_GPMC_DEBUG and am still able to boot to maemo with no obvious
> > problems.
> > 
> > So, seems that fixes the problem, feel free to  add:
> > 
> > Tested-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> 
> Great! Thank you for fixing and testing this problem!

Good to hear it fixes the issue. I'll wait to hear from Aaro before
committing.

Regards,

Tony

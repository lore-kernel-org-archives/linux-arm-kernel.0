From: tony@atomide.com (Tony Lindgren)
Date: Tue, 5 Jan 2016 14:49:29 -0800
Subject: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
In-Reply-To: <20160105084947.GG22661@pali>
References: <1432156863-19695-1-git-send-email-tony@atomide.com>
 <568662FC.9050206@gmail.com> <20160104170206.GC12777@atomide.com>
 <201601041834.56056@pali> <20160104174001.GD12777@atomide.com>
 <568AC0F9.2010304@gmail.com> <20160105041356.GE12777@atomide.com>
 <20160105084947.GG22661@pali>
Message-ID: <20160105224929.GF12777@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pali Roh?r <pali.rohar@gmail.com> [160105 00:50]:
> On Monday 04 January 2016 20:13:56 Tony Lindgren wrote:
> > * Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [160104 10:59]:
> > > Hi,
> > > 
> > > On  4.01.2016 19:40, Tony Lindgren wrote:
> > > >>On Monday 04 January 2016 18:02:06 Tony Lindgren wrote:
> > > >>>> >Care to boot with CONFIG_OMAP_GPMC_DEBUG=y and post the gpmc related
> > > >>>> >dmesg output?
> > > 
> > > Here it is, including the pre-gpmc log, keep in mind this is with restored
> > > HWMOD_INIT_NO_RESET flag so rootfs is functional and I can get dmesg output
> > > from the syslog. Don't know if it is helpful :). Also, this device has
> > > Numonyx onenand (HW rev. 2204), unlike most of the others which have Samsung
> > > onenand (HW rev. 2101 etc), no idea if it is relevant.
> > 
> > Thanks. I got the problem reproduced here too.
> > 
> > [    1.915557] gpmc cs0 after gpmc_cs_set_timings:
> > [    1.920410] cs0 GPMC_CS_CONFIG1: 0xfb001201
> > 
> > Looks like in the failing case the clock rates are not properly
> > calculated in GPMC and GPMCFCLKDIVIDER is set wrong in
> > GPMC_CS_CONFIG1. Need to look at it more to figure out what's the
> > best way to fix this.
> > 
> > Regards,
> > 
> > Tony
> 
> Hm... Maybe this problem is in U-Boot too?

Yeah maybe. Looks like we need sync write bit set also for async
timings for omap2_onenand_set_async_mode() to work to detect the
onenand rate for sync mode :)

Suggested fix below, please test and reply with your Tested-by's if
it solves the problem so we may still be able to get this into v4.4.

Regards,

Tony

8< ---------------
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 5 Jan 2016 12:04:20 -0800
Subject: [PATCH] ARM: OMAP2+: Fix onenand rate detection to avoid filesystem
 corruption

Commit 63aa945b1013 ("memory: omap-gpmc: Add Kconfig option for debug")
unified the GPMC debug for the SoCs with GPMC. The commit also left
out the option for HWMOD_INIT_NO_RESET as we now require proper timings
for GPMC to be able to remap GPMC devices out of address 0.

Unfortunately on 900, onenand now only partially works with the device
tree provided timings. It works enough to get detected but the clock
rate supported by the onenand chip gets misdetected. This in turn causes
the GPMC timings to be miscalculated and this leads into file system
corruption on n900.

Looks like onenand needs CS_CONFIG1 bit 27 WRITETYPE set for for sync
write. This is needed also for async timings when we write to onenand
with omap2_onenand_set_async_mode(). Without sync write bit set, the
async read for the onenand ONENAND_REG_VERSION_ID will return 0xfff.

Let's exit with an error if onenand rate is not detected. And let's
remove the extra call to omap2_onenand_set_async_mode() as we only
need to do this once at the end of omap2_onenand_setup_async().

Reported-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -149,8 +149,8 @@ static int omap2_onenand_get_freq(struct omap_onenand_platform_data *cfg,
 		freq = 104;
 		break;
 	default:
-		freq = 54;
-		break;
+		pr_err("onenand rate not detected, bad GPMC async timings?\n");
+		freq = 0;
 	}
 
 	return freq;
@@ -271,6 +271,11 @@ static int omap2_onenand_setup_async(void __iomem *onenand_base)
 	struct gpmc_timings t;
 	int ret;
 
+	/*
+	 * Note that we need to keep sync_write set for the call to
+	 * omap2_onenand_set_async_mode() to work to detect the onenand
+	 * supported clock rate for the sync timings.
+	 */
 	if (gpmc_onenand_data->of_node) {
 		gpmc_read_settings_dt(gpmc_onenand_data->of_node,
 				      &onenand_async);
@@ -281,12 +286,9 @@ static int omap2_onenand_setup_async(void __iomem *onenand_base)
 			else
 				gpmc_onenand_data->flags |= ONENAND_SYNC_READ;
 			onenand_async.sync_read = false;
-			onenand_async.sync_write = false;
 		}
 	}
 
-	omap2_onenand_set_async_mode(onenand_base);
-
 	omap2_onenand_calc_async_timings(&t);
 
 	ret = gpmc_cs_program_settings(gpmc_onenand_data->cs, &onenand_async);
@@ -310,6 +312,8 @@ static int omap2_onenand_setup_sync(void __iomem *onenand_base, int *freq_ptr)
 	if (!freq) {
 		/* Very first call freq is not known */
 		freq = omap2_onenand_get_freq(gpmc_onenand_data, onenand_base);
+		if (!freq)
+			return -ENODEV;
 		set_onenand_cfg(onenand_base);
 	}
 

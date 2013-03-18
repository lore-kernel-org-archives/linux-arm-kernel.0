From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 18 Mar 2013 18:16:57 +0000
Subject: [PATCH v2 1/2] ARM: vexpress: Enable regulator framework when
 MMCI is in use
In-Reply-To: <20130318180328.GJ4977@n2100.arm.linux.org.uk>
References: <20130315181614.GY4977@n2100.arm.linux.org.uk>
 <1363629655-28917-1-git-send-email-pawel.moll@arm.com>
 <20130318180328.GJ4977@n2100.arm.linux.org.uk>
Message-ID: <1363630617.3054.19.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-03-18 at 18:03 +0000, Russell King - ARM Linux wrote:
> > Without the regulator framework present there are no valid operating
> > voltages reported and the device initialisation fails:
> > 
> > mmci-pl18x 1c050000.mmci: mmc0: PL180 manf 41 rev0 at 0x1c050000 irq 41,42 (pio)
> > mmc0: host doesn't support card's voltages
> > mmc0: error -22 whilst initialising MMC card
> 
> Okay, this isn't going to work, because this means it's broken on a whole
> load of platforms.  What it means is that this commit:
> 
> commit 599c1d5c750ddf528c7c6d3cdc466708f0502e66
> Author: Ulf Hansson <ulf.hansson@linaro.org>
> Date:   Mon Jan 7 16:22:50 2013 +0100
> 
>     ARM: 7620/1: mmc: mmci: Convert to use mmc_regulator_get_supply
>     
>     By using the mmc_regulator_get_supply API we are able to do some
>     cleanups of the regulator code. Additionally let the regulator
>     API handle the error printing.
>     
>     Cc: Chris Ball <cjb@laptop.org>
>     Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>     Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> is actually wrong and probably needs reverting.

Reverting it will not change anything as the driver had the same
dependency before, just using :

@@ -1391,29 +1379,13 @@ static int mmci_probe(struct amba_device *dev,
 	} else
 		dev_warn(&dev->dev, "could not get default pinstate\n");
 
-#ifdef CONFIG_REGULATOR
-	/* If we're using the regulator framework, try to fetch a regulator */
-	host->vcc = regulator_get(&dev->dev, "vmmc");
-	if (IS_ERR(host->vcc))
-		host->vcc = NULL;
-	else {
-		int mask = mmc_regulator_get_ocrmask(host->vcc);
-
-		if (mask < 0)
-			dev_err(&dev->dev, "error getting OCR mask (%d)\n",
-				mask);
-		else {
-			host->mmc->ocr_avail = (u32) mask;
-			if (plat->ocr_mask)
-				dev_warn(&dev->dev,
-				 "Provided ocr_mask/setpower will not be used "
-				 "(using regulator instead)\n");
-		}
-	}
-#endif
-	/* Fall back to platform data if no regulator is found */
-	if (host->vcc == NULL)
+	/* Get regulators and the supported OCR mask */
+	mmc_regulator_get_supply(mmc);
+	if (!mmc->ocr_avail)
 		mmc->ocr_avail = plat->ocr_mask;
+	else if (plat->ocr_mask)
+		dev_warn(mmc_dev(mmc), "Platform OCR mask is ignored\n");
+
 	mmc->caps = plat->capabilities;
 	mmc->caps2 = plat->capabilities2;

It was using the other MMC/regulator core helper, introduced by:

commit 5c13941acc513669c7d07b28789c3f9ba66ddddf
Author: David Brownell <dbrownell@users.sourceforge.net>
Date:   Wed Mar 11 03:30:43 2009 -0800

    MMC: regulator utilities
    
    Glue between MMC and regulator stacks ... verified with
    some OMAP3 boards using adjustable and configured-as-fixed
    regulators on several MMC controllers.
    
    These calls are intended to be used by MMC host adapters
    using at least one regulator per host.  Examples include
    slots with regulators supporting multiple voltages and
    ones using multiple voltage rails (e.g. DAT4..DAT7 using a
    separate supply, or a split rail chip like certain SDIO
    WLAN or eMMC solutions).
    
    Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
    Acked-by: Pierre Ossman <drzeus@drzeus.cx>
    Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>

Pawel

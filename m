From: rabin.vincent@stericsson.com (Rabin VINCENT)
Date: Thu, 24 Jun 2010 13:57:47 +0530
Subject: [PATCH 07/12] mmci: pass power_mode to the translate_vdd callback
In-Reply-To: <AANLkTil2Cb4alVFkfEjXApMgIdkmNvEEarWkT9AhXIdU@mail.gmail.com>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
	<1277198267-10860-7-git-send-email-rabin.vincent@stericsson.com>
	<AANLkTil2Cb4alVFkfEjXApMgIdkmNvEEarWkT9AhXIdU@mail.gmail.com>
Message-ID: <20100624082746.GA12453@bnru01.bnr.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 23, 2010 at 00:03:47 +0200, Linus Walleij wrote:
> 2010/6/22 Rabin Vincent <rabin.vincent@stericsson.com>:
> > @@ -17,7 +17,8 @@
> > ?* mmc/host.h
> > ?* @translate_vdd: a callback function to translate a MMC_VDD_*
> > ?* mask into a value to be binary or:ed and written into the
> > - * MMCIPWR register of the block
> > + * MMCIPWR register of the block. ?May also control external power
> > + * based on the power_mode.
> 
> Actually this callback is named like that for a reason: it is to be used
> to translate the MMC_VDD_* into a u8:4 bitmask for the MMCIPWR
> register, 4 bits possibly routed out of the PL180 block on some
> designs (never seen in practice, but could be used in theory).
> 
> So it translates a voltage into a 4-bit bitmask, hence the name.
> 
> Now the semantics are altered to have other side-effects in
> the platform, so the function should be renamed, something like
> platform_vdd_handler() would be more appropriate.
> 

This is already inside platform data, so how about just ->vdd_handler()?
Or ->set_power(), like some other drivers?

Note that we'd also like to use this to do the board-specific settings
for the *DIREN and FBCLK bits, which replace the Voltage bits on some ST
variants, like so:

+static u32 mop500_sdi0_translate_vdd(struct device *dev, unsigned int vdd,
+				     unsigned char power_mode)
+{
+	if (power_mode == MMC_POWER_UP)
+		gpio_set_value(gpio_sdmmc_en, 1);
+	else if (power_mode == MMC_POWER_OFF)
+		gpio_set_value(gpio_sdmmc_en, 0);
+
+	return MCI_FBCLKEN | MCI_CMDDIREN | MCI_DATA0DIREN |
+	       MCI_DATA2DIREN | MCI_DATA31DIREN;
+}

Rabin

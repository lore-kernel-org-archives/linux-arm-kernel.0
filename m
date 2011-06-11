From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 12 Jun 2011 01:21:14 +0800
Subject: [PATCH 2/2] ARM:mach-mx5/board-mx53_loco: Add CD and WP GPIOs
In-Reply-To: <2952C0A749B3034EA13D670115D4FEC8F1A0C4@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1307722520-12952-1-git-send-email-andre.silva@freescale.com>
	<20110611165856.GD29093@S2100-06.ap.freescale.net>
	<2952C0A749B3034EA13D670115D4FEC8F1A0C4@039-SN1MPN1-005.039d.mgd.msft.net>
Message-ID: <20110611172113.GE29093@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 12, 2011 at 12:59:39AM +0800, Silva Andre-B22958 wrote:
> Hi Shawn,
> 
> The tests was done simpling inserting and removing the SD card, 

That said you saw CD working, and what about WP?

> since before no parameters were passed to the  imx53_add_sdhci_esdhc_imx and the controller was able to detect the card via software. When setting up the iomux (CD) pin and passing it to the  imx53_add_sdhci_esdhc_imx function, it should be able to start detecting the card using the pin instead.
> 
No, your CD gpio setup does not make any change.  The CD is working
in the exactly same way before you patch.  If you check function
esdhc_pltfm_init of sdhci-esdhc-imx driver, you will find the
following.

                /* i.MX5x has issues to be researched */
                if (!cpu_is_mx25() && !cpu_is_mx35())
                        goto not_supported;

CD gpio interrupt only gets supported on mx25 and mx35 currently,
and mx5 CD works with flag SDHCI_QUIRK_BROKEN_CARD_DETECTION set,
in which case a very expensive method is being used to poll card
present by sdhci driver.

-- 
Regards,
Shawn

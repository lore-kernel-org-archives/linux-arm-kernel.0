From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Fri, 13 May 2011 14:32:55 +0400
Subject: [PATCH] pxa/hx4700: Fix basic suspend/resume
In-Reply-To: <E1QKFPN-0003xV-Sf@outmx07.plus.net>
References: <E1QKFPN-0003xV-Sf@outmx07.plus.net>
Message-ID: <20110513103255.GB18716@rainbow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19:49 Wed 11 May     , Paul Parsons wrote:
> 
> Driver-specific bugs still remain. In particular the mmc driver does not resume properly after returning from sleep mode, thus preventing sleep mode from being entered a second time.

Sorry, no comments about your patch, just wanted to say about mmc
driver. Some time ago when I tried to look at suspend on hx4700,
this patch helped me to survive suspend-wakeup cycle with root on MMC:

diff --git a/drivers/mfd/asic3.c b/drivers/mfd/asic3.c
index 4896a3c..4c686d9 100644
--- a/drivers/mfd/asic3.c
+++ b/drivers/mfd/asic3.c
@@ -895,6 +895,8 @@ static struct mfd_cell asic3_cell_mmc = {
 	.name          = "tmio-mmc",
 	.enable        = asic3_mmc_enable,
 	.disable       = asic3_mmc_disable,
+	.suspend	= asic3_mmc_disable,
+	.resume		= asic3_mmc_enable,
 	.driver_data   = &asic3_mmc_data,
 	.num_resources = ARRAY_SIZE(asic3_mmc_resources),
 	.resources     = asic3_mmc_resources,

That was around 2.6.37. Not sure if it still helps and I have no possibility
to check - tmio_mmc on ASIC3 seems to be totally borken in 2.6.39-rcX - it
doesn't even detect card on my hx4700 :( And that's pity, as I mainly use
SD for rootfs.

-- 
Best regards,
Dmitry "MAD" Artamonow

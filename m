From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 11 Feb 2014 11:37:11 +0000
Subject: [PATCH 6/7] mmc: arm-mmci: attempt to get mclk by name
In-Reply-To: <1392118632-11312-1-git-send-email-mark.rutland@arm.com>
References: <1392118632-11312-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1392118632-11312-7-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The primecell device tree binding (from which the pl18x binding is
derived from) states that the apb_pclk clock input should be listed
first for all primecell devices. The arm-mmci driver requires the mclk
clock input, but the way it currently grabs the clock means that it
always gets the first clock (which should be apb_pclk).

As the AMBA bus code grabs apb_pclk by name, some existing dts provide
apb_pclk as the second clock in the clocks list to work around this, in
violation of both the primecell binding. The pl18x binding does not
mention clocks at all, so the first clock (MCLK) is given an arbitrary
name.

This patch attempts to fix the mess my having the arm-mmci driver first
attempt to get mclk by name. If this fails, it falls back to the old
behaviour of simply acquiring the first clock. This is compatible with
any old dtb, whether it lists mclk by name or not, and allows the driver
to support dtbs which do not violate the bindings. Hopefully this will
lead to future uniformity across dtbs.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Chris Ball <cjb@laptop.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
---
 drivers/mmc/host/mmci.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index b931226..4af962c 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1470,7 +1470,14 @@ static int mmci_probe(struct amba_device *dev,
 	dev_dbg(mmc_dev(mmc), "designer ID = 0x%02x\n", host->hw_designer);
 	dev_dbg(mmc_dev(mmc), "revision = 0x%01x\n", host->hw_revision);
 
-	host->clk = devm_clk_get(&dev->dev, NULL);
+	/*
+	 * For compatibility with old DTBs and platform data, fall back to the
+	 * first clock if there's not an explicitly named "mclk" entry.
+	 */
+	host->clk = devm_clk_get(&dev->dev, "mclk");
+	if (IS_ERR(host->clk))
+		host->clk = devm_clk_get(&dev->dev, NULL);
+
 	if (IS_ERR(host->clk)) {
 		ret = PTR_ERR(host->clk);
 		goto host_free;
-- 
1.8.1.1

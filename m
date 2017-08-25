From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 25 Aug 2017 11:49:53 +0200
Subject: [PATCH 2/2] mmc: sunxi: Reset the device at probe time
In-Reply-To: <20170825094953.3247-1-maxime.ripard@free-electrons.com>
References: <20170825094953.3247-1-maxime.ripard@free-electrons.com>
Message-ID: <20170825094953.3247-2-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We might be into some troubles if the bootloader misconfigured the MMC
controller.

We currently only de-assert the reset line at probe time, which means that
if the device was already out of reset, we're going to keep whatever state
was set already.

Switch to a reset instead of the deassert to have a device in a pristine
state when we start operating.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/mmc/host/sunxi-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index da5f46a14497..53c970fe0873 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1242,7 +1242,7 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
 	}
 
 	if (!IS_ERR(host->reset)) {
-		ret = reset_control_deassert(host->reset);
+		ret = reset_control_reset(host->reset);
 		if (ret) {
 			dev_err(&pdev->dev, "reset err %d\n", ret);
 			goto error_disable_clk_sample;
-- 
2.13.5

From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 16 Jul 2016 12:46:01 +0200
Subject: [PATCH 1/4] mmc: sunxi: Disable sample clks on remove
In-Reply-To: <1468665964-27142-1-git-send-email-hdegoede@redhat.com>
References: <1468665964-27142-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1468665964-27142-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When support for the sample clks was added calls to prepare_enable
were added to the probe path, but matching calls to disable_unprepare
were forgotten in the remove path, this fixes this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mmc/host/sunxi-mmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index a4d2b63..71a480b 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1160,6 +1160,8 @@ static int sunxi_mmc_remove(struct platform_device *pdev)
 	if (!IS_ERR(host->reset))
 		reset_control_assert(host->reset);
 
+	clk_disable_unprepare(host->clk_sample);
+	clk_disable_unprepare(host->clk_output);
 	clk_disable_unprepare(host->clk_mmc);
 	clk_disable_unprepare(host->clk_ahb);
 
-- 
2.7.4

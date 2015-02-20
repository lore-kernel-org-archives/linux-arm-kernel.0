From: addy.ke@rock-chips.com (Addy Ke)
Date: Fri, 20 Feb 2015 10:37:40 +0800
Subject: [PATCH v2] mmc: dw_mmc: rockchip: add support MMC_CAP_RUNTIME_RESUME
 capability
In-Reply-To: <1423812140-24196-1-git-send-email-addy.ke@rock-chips.com>
References: <1423812140-24196-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <1424399860-3394-1-git-send-email-addy.ke@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To support HS200 and UHS mode, mmc core will call init_card() to
execute tuning:
- sdio: init_card can be executed at runtime resume.
- sd and mmc: init_card can be executed at resume or runtime resume,
  which depends on MMC_CAP_RUNTIME_RESUME capability.

On rk3288 SoC, host will get DRTO interrupt when host send command
to read tuning data. This will spend more than 111ms:
drto_ms = drto_clks * 1000 / bus_hz = 111ms.

And the total tuning time will be more than 400ms.

So we should add MMC_CAP_RUNTIME_RESUME capability to execute tuning
at runtime resume. Only if we do so, can we pass resume test.

Reviewed-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
---
Changes in v2:
- add this capability for all 4 slots, suggested by Doug Anderson.

 drivers/mmc/host/dw_mmc-rockchip.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index e2a726a..dbf166f 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -76,12 +76,20 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
 	return 0;
 }
 
+/* Common capabilities of RK3288 SoC */
+static unsigned long dw_mci_rk3288_dwmmc_caps[4] = {
+	MMC_CAP_RUNTIME_RESUME, /* emmc */
+	MMC_CAP_RUNTIME_RESUME, /* sdmmc */
+	MMC_CAP_RUNTIME_RESUME, /* sdio0 */
+	MMC_CAP_RUNTIME_RESUME, /* sdio1 */
+};
 static const struct dw_mci_drv_data rk2928_drv_data = {
 	.prepare_command        = dw_mci_rockchip_prepare_command,
 	.init			= dw_mci_rockchip_init,
 };
 
 static const struct dw_mci_drv_data rk3288_drv_data = {
+	.caps			= dw_mci_rk3288_dwmmc_caps,
 	.prepare_command        = dw_mci_rockchip_prepare_command,
 	.set_ios		= dw_mci_rk3288_set_ios,
 	.setup_clock    = dw_mci_rk3288_setup_clock,
-- 
1.8.3.2

From: romain.perier@collabora.com (Romain Perier)
Date: Mon, 28 Aug 2017 14:16:03 +0200
Subject: [PATCH 3/4] nvmem: rockchip: add support for RK3368
In-Reply-To: <20170828121604.15968-1-romain.perier@collabora.com>
References: <20170828121604.15968-1-romain.perier@collabora.com>
Message-ID: <20170828121604.15968-4-romain.perier@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the necessary functions and data for handling support on RK3368
SoCs.

Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 .../devicetree/bindings/nvmem/rockchip-efuse.txt   |  1 +
 drivers/nvmem/rockchip-efuse.c                     | 80 ++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt b/Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt
index 1ff02afdc55a..60bec4782806 100644
--- a/Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt
+++ b/Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt
@@ -6,6 +6,7 @@ Required properties:
   - "rockchip,rk3188-efuse" - for RK3188 SoCs.
   - "rockchip,rk3228-efuse" - for RK3228 SoCs.
   - "rockchip,rk3288-efuse" - for RK3288 SoCs.
+  - "rockchip,rk3368-efuse" - for RK3368 SoCs.
   - "rockchip,rk3399-efuse" - for RK3399 SoCs.
 - reg: Should contain the registers location and exact eFuse size
 - clocks: Should be the clock id of eFuse
diff --git a/drivers/nvmem/rockchip-efuse.c b/drivers/nvmem/rockchip-efuse.c
index 63e3eb55f3ac..4e11f251035f 100644
--- a/drivers/nvmem/rockchip-efuse.c
+++ b/drivers/nvmem/rockchip-efuse.c
@@ -14,6 +14,7 @@
  * more details.
  */
 
+#include <linux/arm-smccc.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -46,9 +47,17 @@
 #define REG_EFUSE_CTRL		0x0000
 #define REG_EFUSE_DOUT		0x0004
 
+/* SMC function IDs for SiP Service queries */
+#define ROCKCHIP_SIP_ACCESS_REG	0x82000002
+
+/* SIP access registers: read or write */
+#define ROCKCHIP_SIP_SECURE_REG_RD	0x0
+#define ROCKCHIP_SIP_SECURE_REG_WR	0x1
+
 struct rockchip_efuse_chip {
 	struct device *dev;
 	void __iomem *base;
+	phys_addr_t phys;
 	struct clk *clk;
 };
 
@@ -92,6 +101,72 @@ static int rockchip_rk3288_efuse_read(void *context, unsigned int offset,
 	return 0;
 }
 
+static u32 smc_reg_read(u32 addr_phy)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(ROCKCHIP_SIP_ACCESS_REG, 0, addr_phy,
+		      ROCKCHIP_SIP_SECURE_REG_RD, 0, 0, 0, 0, &res);
+	if (res.a0)
+		pr_err("%s error: %d, addr phy: 0x%x\n", __func__, (int)res.a0,
+		       addr_phy);
+	return res.a1;
+}
+
+static u32 smc_reg_write(u32 addr_phy, u32 val)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(ROCKCHIP_SIP_ACCESS_REG, val, addr_phy,
+		      ROCKCHIP_SIP_SECURE_REG_WR, 0, 0, 0, 0, &res);
+	if (res.a0)
+		pr_err("%s error: %d, addr phy: 0x%x\n", __func__, (int)res.a0,
+                       addr_phy);
+	return res.a0;
+}
+
+static int rockchip_rk3368_efuse_read(void *context, unsigned int offset,
+				      void *val, size_t bytes)
+{
+	struct rockchip_efuse_chip *efuse = context;
+	u8 *buf = val;
+	int ret;
+
+	ret = clk_prepare_enable(efuse->clk);
+	if (ret < 0) {
+		dev_err(efuse->dev, "failed to prepare/enable efuse clk\n");
+		return ret;
+	}
+
+	smc_reg_write(efuse->phys + REG_EFUSE_CTRL, RK3288_LOAD | RK3288_PGENB);
+	udelay(1);
+	while (bytes--) {
+		smc_reg_write(efuse->phys + REG_EFUSE_CTRL,
+			      smc_reg_read(efuse->phys + REG_EFUSE_CTRL) &
+			      (~(RK3288_A_MASK << RK3288_A_SHIFT)));
+		smc_reg_write(efuse->phys + REG_EFUSE_CTRL,
+			      smc_reg_read(efuse->phys + REG_EFUSE_CTRL) |
+			      ((offset++ & RK3288_A_MASK) << RK3288_A_SHIFT));
+
+		udelay(1);
+		smc_reg_write(efuse->phys + REG_EFUSE_CTRL,
+			      smc_reg_read(efuse->phys + REG_EFUSE_CTRL) |
+			      RK3288_STROBE);
+		udelay(1);
+		*buf++ = smc_reg_read(efuse->phys + REG_EFUSE_DOUT);
+		smc_reg_write(efuse->phys + REG_EFUSE_CTRL,
+			      smc_reg_read(efuse->phys + REG_EFUSE_CTRL) &
+			      (~RK3288_STROBE));
+		udelay(1);
+	}
+
+	/* Switch to standby mode */
+	smc_reg_write(efuse->phys + REG_EFUSE_CTRL, RK3288_PGENB | RK3288_CSB);
+
+	clk_disable_unprepare(efuse->clk);
+	return 0;
+}
+
 static int rockchip_rk3399_efuse_read(void *context, unsigned int offset,
 				      void *val, size_t bytes)
 {
@@ -178,6 +253,10 @@ static const struct of_device_id rockchip_efuse_match[] = {
 		.data = (void *)&rockchip_rk3288_efuse_read,
 	},
 	{
+		.compatible = "rockchip,rk3368-efuse",
+		.data = (void *)&rockchip_rk3368_efuse_read,
+	},
+	{
 		.compatible = "rockchip,rk3399-efuse",
 		.data = (void *)&rockchip_rk3399_efuse_read,
 	},
@@ -205,6 +284,7 @@ static int rockchip_efuse_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	efuse->phys = res->start;
 	efuse->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(efuse->base))
 		return PTR_ERR(efuse->base);
-- 
2.11.0

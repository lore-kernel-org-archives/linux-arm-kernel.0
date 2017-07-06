From: finley.xiao@rock-chips.com (Finley Xiao)
Date: Thu,  6 Jul 2017 15:36:37 +0800
Subject: [PATCH 2/2] nvmem: rockchip-efuse: add support for rk3328-efuse
In-Reply-To: <1499326597-10821-1-git-send-email-finley.xiao@rock-chips.com>
References: <1499326597-10821-1-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <1499326597-10821-3-git-send-email-finley.xiao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the necessary data for handling eFuse on the rk3328.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
---
 .../devicetree/bindings/nvmem/rockchip-efuse.txt   |  1 +
 drivers/nvmem/rockchip-efuse.c                     | 66 ++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt b/Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt
index d206aa1..7a817c5 100644
--- a/Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt
+++ b/Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt
@@ -6,6 +6,7 @@ Required properties:
   - "rockchip,rk3188-efuse" - for RK3188 SoCs.
   - "rockchip,rk322x-efuse" - for RK322x SoCs.
   - "rockchip,rk3288-efuse" - for RK3288 SoCs.
+  - "rockchip,rk3328-efuse" - for RK3328 SoCs.
   - "rockchip,rk3399-efuse" - for RK3399 SoCs.
 - reg: Should contain the registers location and exact eFuse size
 - clocks: Should be the clock id of eFuse
diff --git a/drivers/nvmem/rockchip-efuse.c b/drivers/nvmem/rockchip-efuse.c
index 8e3e5d0..70c2d64 100644
--- a/drivers/nvmem/rockchip-efuse.c
+++ b/drivers/nvmem/rockchip-efuse.c
@@ -32,6 +32,14 @@
 #define RK3288_STROBE		BIT(1)
 #define RK3288_CSB		BIT(0)
 
+#define RK3328_SECURE_SIZES	96
+#define RK3328_INT_STATUS	0x0018
+#define RK3328_DOUT		0x0020
+#define RK3328_AUTO_CTRL	0x0024
+#define RK3328_INT_FINISH	BIT(0)
+#define RK3328_AUTO_ENB		BIT(0)
+#define RK3328_AUTO_RD		BIT(1)
+
 #define RK3399_A_SHIFT		16
 #define RK3399_A_MASK		0x3ff
 #define RK3399_NBYTES		4
@@ -92,6 +100,60 @@ static int rockchip_rk3288_efuse_read(void *context, unsigned int offset,
 	return 0;
 }
 
+static int rockchip_rk3328_efuse_read(void *context, unsigned int offset,
+				      void *val, size_t bytes)
+{
+	struct rockchip_efuse_chip *efuse = context;
+	unsigned int addr_start, addr_end, addr_offset, addr_len;
+	u32 out_value, status;
+	u8 *buf;
+	int ret, i = 0;
+
+	ret = clk_prepare_enable(efuse->clk);
+	if (ret < 0) {
+		dev_err(efuse->dev, "failed to prepare/enable efuse clk\n");
+		return ret;
+	}
+
+	/* 128 Byte efuse, 96 Byte for secure, 32 Byte for non-secure */
+	offset += RK3328_SECURE_SIZES;
+	addr_start = rounddown(offset, RK3399_NBYTES) / RK3399_NBYTES;
+	addr_end = roundup(offset + bytes, RK3399_NBYTES) / RK3399_NBYTES;
+	addr_offset = offset % RK3399_NBYTES;
+	addr_len = addr_end - addr_start;
+
+	buf = kzalloc(sizeof(*buf) * addr_len * RK3399_NBYTES, GFP_KERNEL);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto nomem;
+	}
+
+	while (addr_len--) {
+		writel(RK3328_AUTO_RD | RK3328_AUTO_ENB |
+		       ((addr_start++ & RK3399_A_MASK) << RK3399_A_SHIFT),
+		       efuse->base + RK3328_AUTO_CTRL);
+		udelay(2);
+		status = readl(efuse->base + RK3328_INT_STATUS);
+		if (!(status & RK3328_INT_FINISH)) {
+			ret = -EIO;
+			goto err;
+		}
+		out_value = readl(efuse->base + RK3328_DOUT);
+		writel(RK3328_INT_FINISH, efuse->base + RK3328_INT_STATUS);
+
+		memcpy(&buf[i], &out_value, RK3399_NBYTES);
+		i += RK3399_NBYTES;
+	}
+
+	memcpy(val, buf + addr_offset, bytes);
+err:
+	kfree(buf);
+nomem:
+	clk_disable_unprepare(efuse->clk);
+
+	return ret;
+}
+
 static int rockchip_rk3399_efuse_read(void *context, unsigned int offset,
 				      void *val, size_t bytes)
 {
@@ -178,6 +240,10 @@ static const struct of_device_id rockchip_efuse_match[] = {
 		.data = (void *)&rockchip_rk3288_efuse_read,
 	},
 	{
+		.compatible = "rockchip,rk3328-efuse",
+		.data = (void *)&rockchip_rk3328_efuse_read,
+	},
+	{
 		.compatible = "rockchip,rk3399-efuse",
 		.data = (void *)&rockchip_rk3399_efuse_read,
 	},
-- 
2.7.4

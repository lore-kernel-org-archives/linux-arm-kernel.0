From: finley.xiao@rock-chips.com (Finley Xiao)
Date: Thu,  6 Jul 2017 15:36:36 +0800
Subject: [PATCH 1/2] nvmem: rockchip-efuse: parse 'rockchip,efuse-size'
In-Reply-To: <1499326597-10821-1-git-send-email-finley.xiao@rock-chips.com>
References: <1499326597-10821-1-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <1499326597-10821-2-git-send-email-finley.xiao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The eFuse size is defined in property <reg> before, but the length
of registers is not equal to the size on some platforms, so we
add a new property to redefine it.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
---
 Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt | 4 ++++
 drivers/nvmem/rockchip-efuse.c                             | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt b/Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt
index 194926f..d206aa1 100644
--- a/Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt
+++ b/Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt
@@ -11,6 +11,10 @@ Required properties:
 - clocks: Should be the clock id of eFuse
 - clock-names: Should be "pclk_efuse"
 
+Optional properties:
+- rockchip,efuse-size: Should be exact eFuse size in byte, the eFuse
+  size in property <reg> will be invalid if define this property.
+
 Deprecated properties:
 - compatible: "rockchip,rockchip-efuse"
   Old efuse compatible value compatible to rk3066a, rk3188 and rk3288
diff --git a/drivers/nvmem/rockchip-efuse.c b/drivers/nvmem/rockchip-efuse.c
index a0d4ede..8e3e5d0 100644
--- a/drivers/nvmem/rockchip-efuse.c
+++ b/drivers/nvmem/rockchip-efuse.c
@@ -214,7 +214,9 @@ static int rockchip_efuse_probe(struct platform_device *pdev)
 		return PTR_ERR(efuse->clk);
 
 	efuse->dev = &pdev->dev;
-	econfig.size = resource_size(res);
+	if (of_property_read_u32(dev->of_node, "rockchip,efuse-size",
+				 &econfig.size))
+		econfig.size = resource_size(res);
 	econfig.reg_read = match->data;
 	econfig.priv = efuse;
 	econfig.dev = efuse->dev;
-- 
2.7.4

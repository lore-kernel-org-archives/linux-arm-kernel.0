From: jay.xu@rock-chips.com (Jianqun)
Date: Sat, 13 Sep 2014 08:42:12 +0800
Subject: [PATCH 4/5] ASoC: rockchip-i2s: fix registers' property of rockchip
 i2s controller
In-Reply-To: <1410568723-21559-1-git-send-email-jay.xu@rock-chips.com>
References: <1410568723-21559-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <1410568932-21823-1-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reference rockchip I2S controller TRM, modify some registers' property
I2S_FIFOLR: read / write, but not volatile, not precious
I2S_INTSR: read / write
I2S_CLR: volatile, register value will be cleared by read

Test on RK3288 with max98090.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 sound/soc/rockchip/rockchip_i2s.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 1b9b404..6595383 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -365,6 +365,8 @@ static bool rockchip_i2s_rd_reg(struct device *dev, unsigned int reg)
 	case I2S_XFER:
 	case I2S_CLR:
 	case I2S_RXDR:
+	case I2S_FIFOLR:
+	case I2S_INTSR:
 		return true;
 	default:
 		return false;
@@ -374,8 +376,8 @@ static bool rockchip_i2s_rd_reg(struct device *dev, unsigned int reg)
 static bool rockchip_i2s_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case I2S_FIFOLR:
 	case I2S_INTSR:
+	case I2S_CLR:
 		return true;
 	default:
 		return false;
@@ -385,8 +387,6 @@ static bool rockchip_i2s_volatile_reg(struct device *dev, unsigned int reg)
 static bool rockchip_i2s_precious_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case I2S_FIFOLR:
-		return true;
 	default:
 		return false;
 	}
-- 
1.9.1

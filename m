From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Thu,  2 Mar 2017 02:01:07 +0800
Subject: [PATCH v2 1/5] pinctrl: sunxi: refactor pinctrl choice selecting for
 ARM64
In-Reply-To: <20170301180111.12365-1-icenowy@aosc.xyz>
References: <20170301180111.12365-1-icenowy@aosc.xyz>
Message-ID: <20170301180111.12365-2-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM64 Allwinner SoCs used to have every pinctrl driver selected in
ARCH_SUNXI. Change this to make their default value to (ARM64 &&
ARCH_SUNXI).

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
Changes in v2:
- Drop PINCTRL_SUN8I_H3_R's dependency on RESET_CONTROLLER, as there's really
  no reset line for H3 R_PIO pin controller. (By experiment and investigation
  on A83T/A80 user manual)

 drivers/pinctrl/sunxi/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index 816015cf7053..a84bfa7f3c05 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -48,8 +48,8 @@ config PINCTRL_SUN8I_H3
 	select PINCTRL_SUNXI
 
 config PINCTRL_SUN8I_H3_R
-	def_bool MACH_SUN8I
-	select PINCTRL_SUNXI_COMMON
+	def_bool MACH_SUN8I || (ARM64 && ARCH_SUNXI)
+	select PINCTRL_SUNXI
 
 config PINCTRL_SUN8I_V3S
 	def_bool MACH_SUN8I
@@ -65,11 +65,11 @@ config PINCTRL_SUN9I_A80_R
 	select PINCTRL_SUNXI
 
 config PINCTRL_SUN50I_A64
-	bool
+	def_bool ARM64 && ARCH_SUNXI
 	select PINCTRL_SUNXI
 
 config PINCTRL_SUN50I_H5
-	bool
+	def_bool ARM64 && ARCH_SUNXI
 	select PINCTRL_SUNXI
 
 endif
-- 
2.11.1

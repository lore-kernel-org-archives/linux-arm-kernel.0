From: aalonso@freescale.com (Adrian Alonso)
Date: Fri, 25 Sep 2015 16:05:59 -0500
Subject: [PATCH v6 3/6] pinctrl: freescale: imx: allow mux_reg offset zero
In-Reply-To: <1443215162-13716-1-git-send-email-aalonso@freescale.com>
References: <1443215162-13716-1-git-send-email-aalonso@freescale.com>
Message-ID: <1443215162-13716-3-git-send-email-aalonso@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow mux_reg offset zero to be a valid pin_id, on imx7d
mux_conf reg offset is zero for iomuxc-lspr controller

Signed-off-by: Adrian Alonso <aalonso@freescale.com>
---
Changes for V2: Resend
Changes for V3: Resend
Changes for V4: Simplify pin_id assigment when ZERO_OFFSET_VALID is set
Changes for V5:
- Drop patch pinctrl: freescale: imx: add ZERO_OFFSET_VALID flag
- Allow mux_reg ZERO OFFSET as pin_id
Changes for V6: Restore ZERO_OFFSET_VALID flag

 drivers/pinctrl/freescale/pinctrl-imx.c | 5 ++++-
 drivers/pinctrl/freescale/pinctrl-imx.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index b9c6deb..151d50d 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -542,6 +542,9 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
 		struct imx_pin_reg *pin_reg;
 		struct imx_pin *pin = &grp->pins[i];
 
+		if (!(info->flags & ZERO_OFFSET_VALID) && !mux_reg)
+			mux_reg = -1;
+
 		if (info->flags & SHARE_MUX_CONF_REG) {
 			conf_reg = mux_reg;
 		} else {
@@ -550,7 +553,7 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
 				conf_reg = -1;
 		}
 
-		pin_id = mux_reg ? mux_reg / 4 : conf_reg / 4;
+		pin_id = (mux_reg != -1) ? mux_reg / 4 : conf_reg / 4;
 		pin_reg = &info->pin_regs[pin_id];
 		pin->pin = pin_id;
 		grp->pin_ids[i] = pin_id;
diff --git a/drivers/pinctrl/freescale/pinctrl-imx.h b/drivers/pinctrl/freescale/pinctrl-imx.h
index 2a5fe72..2a592f6 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.h
+++ b/drivers/pinctrl/freescale/pinctrl-imx.h
@@ -85,6 +85,7 @@ struct imx_pinctrl_soc_info {
 };
 
 #define SHARE_MUX_CONF_REG	0x1
+#define ZERO_OFFSET_VALID	0x2
 
 #define NO_MUX		0x0
 #define NO_PAD		0x0
-- 
2.1.4

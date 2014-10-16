From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Thu, 16 Oct 2014 10:11:32 -0700
Subject: [PATCH RFC v2 5/8] pinctrl: zynq: Support low power mode property
In-Reply-To: <1413479495-14206-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1413479495-14206-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1413479495-14206-6-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 - for HSTL type pins, allow setting the low power mode property

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/pinctrl/pinctrl-zynq.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-zynq.c b/drivers/pinctrl/pinctrl-zynq.c
index f3fce76c8390..0136bddbb4be 100644
--- a/drivers/pinctrl/pinctrl-zynq.c
+++ b/drivers/pinctrl/pinctrl-zynq.c
@@ -879,9 +879,10 @@ static const struct pinmux_ops zynq_pinmux_ops = {
 };
 
 /* pinconfig */
-#define ZYNQ_PINCONF_TRISTATE	BIT(0)
-#define ZYNQ_PINCONF_SPEED	BIT(8)
-#define ZYNQ_PINCONF_PULLUP	BIT(12)
+#define ZYNQ_PINCONF_TRISTATE		BIT(0)
+#define ZYNQ_PINCONF_SPEED		BIT(8)
+#define ZYNQ_PINCONF_PULLUP		BIT(12)
+#define ZYNQ_PINCONF_DISABLE_RECVR	BIT(13)
 
 #define ZYNQ_PINCONF_IOTYPE_SHIFT	9
 #define ZYNQ_PINCONF_IOTYPE_MASK	(7 << ZYNQ_PINCONF_IOTYPE_SHIFT)
@@ -895,6 +896,11 @@ enum zynq_io_standards {
 	zynq_iostd_max
 };
 
+static unsigned int zynq_pinconf_iostd_get(u32 reg)
+{
+	return (reg & ZYNQ_PINCONF_IOTYPE_MASK) >> ZYNQ_PINCONF_IOTYPE_SHIFT;
+}
+
 static int zynq_pinconf_cfg_get(struct pinctrl_dev *pctldev,
 				unsigned pin,
 				unsigned long *config)
@@ -930,9 +936,19 @@ static int zynq_pinconf_cfg_get(struct pinctrl_dev *pctldev,
 	case PIN_CONFIG_SLEW_RATE:
 		arg = !!(reg & ZYNQ_PINCONF_SPEED);
 		break;
+	case PIN_CONFIG_LOW_POWER_MODE:
+	{
+		enum zynq_io_standards iostd = zynq_pinconf_iostd_get(reg);
+
+		if (iostd != zynq_iostd_hstl)
+			return -EINVAL;
+		if (!(reg & ZYNQ_PINCONF_DISABLE_RECVR))
+			return -EINVAL;
+		arg = !!(reg & ZYNQ_PINCONF_DISABLE_RECVR);
+		break;
+	}
 	case PIN_CONFIG_IOSTANDARD:
-		arg = reg & ZYNQ_PINCONF_IOTYPE_MASK;
-		arg >>= ZYNQ_PINCONF_IOTYPE_SHIFT;
+		arg = zynq_pinconf_iostd_get(reg);
 		break;
 	default:
 		return -ENOTSUPP;
@@ -994,6 +1010,13 @@ static int zynq_pinconf_cfg_set(struct pinctrl_dev *pctldev,
 			}
 			reg |= arg << ZYNQ_PINCONF_IOTYPE_SHIFT;
 			break;
+		case PIN_CONFIG_LOW_POWER_MODE:
+			if (arg)
+				reg |= ZYNQ_PINCONF_DISABLE_RECVR;
+			else
+				reg &= ~ZYNQ_PINCONF_DISABLE_RECVR;
+
+			break;
 		default:
 			dev_warn(pctldev->dev,
 				 "unsupported configuration parameter '%u'\n",
-- 
2.1.2.1.g5e69ed6

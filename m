From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 3 Aug 2015 12:47:14 +0800
Subject: [PATCH v2 06/10] usb: chipidea: add ahb burst configuration interface
In-Reply-To: <1438577238-10153-1-git-send-email-peter.chen@freescale.com>
References: <1438577238-10153-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1438577238-10153-7-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The users can change it through dts or platform data if they
want to change the default value.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/bits.h  |  3 +++
 drivers/usb/chipidea/core.c  | 14 ++++++++++++++
 include/linux/usb/chipidea.h |  2 ++
 3 files changed, 19 insertions(+)

diff --git a/drivers/usb/chipidea/bits.h b/drivers/usb/chipidea/bits.h
index 831a8f6..462ad02 100644
--- a/drivers/usb/chipidea/bits.h
+++ b/drivers/usb/chipidea/bits.h
@@ -25,6 +25,9 @@
 #define VERSION		      (0xF << 25)
 #define CIVERSION	      (0x7 << 29)
 
+/* SBUSCFG */
+#define AHBBRST_MASK		0x7
+
 /* HCCPARAMS */
 #define HCCPARAMS_LEN         BIT(17)
 
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 38bd036..f60cbf6 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -439,6 +439,9 @@ void ci_platform_configure(struct ci_hdrc *ci)
 
 	hw_write(ci, OP_USBCMD, 0xff0000, ci->platdata->itc_setting << 16);
 
+	if (ci->platdata->flags & CI_HDRC_OVERRIDE_AHB_BURST)
+		hw_write_id_reg(ci, ID_SBUSCFG, AHBBRST_MASK,
+			ci->platdata->ahb_burst_config);
 }
 
 /**
@@ -647,6 +650,17 @@ static int ci_get_platdata(struct device *dev,
 		}
 	}
 
+	if (of_find_property(dev->of_node, "ahb-burst-config", NULL)) {
+		ret = of_property_read_u32(dev->of_node, "ahb-burst-config",
+			&platdata->ahb_burst_config);
+		if (ret) {
+			dev_err(dev,
+				"failed to get ahb-burst-config\n");
+			return ret;
+		}
+		platdata->flags |= CI_HDRC_OVERRIDE_AHB_BURST;
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index 034f7e1..fe3c8eb 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -33,6 +33,7 @@ struct ci_hdrc_platform_data {
 #define CI_HDRC_FORCE_FULLSPEED		BIT(6)
 #define CI_HDRC_TURN_VBUS_EARLY_ON	BIT(7)
 #define CI_HDRC_SET_NON_ZERO_TTHA	BIT(8)
+#define CI_HDRC_OVERRIDE_AHB_BURST	BIT(9)
 	enum usb_dr_mode	dr_mode;
 #define CI_HDRC_CONTROLLER_RESET_EVENT		0
 #define CI_HDRC_CONTROLLER_STOPPED_EVENT	1
@@ -42,6 +43,7 @@ struct ci_hdrc_platform_data {
 	bool			tpl_support;
 	/* interrupt threshold setting */
 	u32			itc_setting;
+	u32			ahb_burst_config;
 };
 
 /* Default offset of capability registers */
-- 
1.9.1

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  5 Jun 2014 15:26:01 +0200
Subject: [PATCH v3 2/5] pinctrl: sunxi: Add macro definition for pinctrl with
 more than one interrupt
In-Reply-To: <1401974765-14417-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1401974765-14417-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1401974765-14417-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 and A23, unlike the other Allwinner SoCs, have several interrupts banks
and parent interrupts, while the other only have up to 32 interrupts in a
single bank and a single parent interrupt.

Start supporting it by introducing a function macro to declare irq functions
and their banks.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
index 8169ba598876..cb87e15b1b3c 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
@@ -77,6 +77,7 @@
 struct sunxi_desc_function {
 	const char	*name;
 	u8		muxval;
+	u8		irqbank;
 	u8		irqnum;
 };
 
@@ -139,6 +140,14 @@ struct sunxi_pinctrl {
 		.irqnum = _irq,					\
 	}
 
+#define SUNXI_FUNCTION_IRQ_BANK(_val, _bank, _irq)		\
+	{							\
+		.name = "irq",					\
+		.muxval = _val,					\
+		.irqbank = _bank,				\
+		.irqnum = _irq,					\
+	}
+
 /*
  * The sunXi PIO registers are organized as is:
  * 0x00 - 0x0c	Muxing values.
-- 
2.0.0

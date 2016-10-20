From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Thu, 20 Oct 2016 15:26:51 +0200
Subject: [PATCH 1/2] pinctrl: stm32: remove dependency with interrupt
 controller
In-Reply-To: <1476970012-7838-1-git-send-email-alexandre.torgue@st.com>
References: <1476970012-7838-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1476970012-7838-2-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allows to probe stm32 pinctrl driver even if no interrupt
controller is defined to manage gpio irqs.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 200667f..efc4371 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -1092,9 +1092,11 @@ int stm32_pctl_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ret = stm32_pctrl_dt_setup_irq(pdev, pctl);
-	if (ret)
-		return ret;
+	if (of_find_property(np, "interrupt-parent", NULL)) {
+		ret = stm32_pctrl_dt_setup_irq(pdev, pctl);
+		if (ret)
+			return ret;
+	}
 
 	for_each_child_of_node(np, child)
 		if (of_property_read_bool(child, "gpio-controller"))
-- 
1.9.1

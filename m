From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 20 Oct 2015 17:25:09 +0900
Subject: [PATCH] pinctrl: uniphier: set input-enable before pin-muxing
Message-ID: <1445329509-6252-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While IECTRL is disabled, input signals are pulled-down internally.
If pin-muxing is set up first, glitch signals (Low to High transition)
might be input to hardware blocks.

Bad case scenario:
[1] The hardware block is already running before pinctrl is handled.
   (the reset is de-asserted by default or by a firmware, for example)
[2] The pin-muxing is set up.  The input signals to hardware block
    are pulled-down by the chip-internal biasing.
[3] The pins are input-enabled.  The signals from the board reach the
    hardware block.

Actually, one invalid character is input to the UART blocks for such
SoCs as PH1-LD4, PH1-sLD8, where UART devices start to run at the
power on reset.

To avoid such problems, pins should be input-enabled before muxing.

Fixes: 6e9088920258 ("pinctrl: UniPhier: add UniPhier pinctrl core support")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reported-by: Dai Okamura <okamura.dai@socionext.com>
---

Hi Linus,

If it is not too late, please apply this fix for Linux 4.3.

Thanks,
Masahiro


 drivers/pinctrl/uniphier/pinctrl-uniphier-core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
index 918f3b6..589872c 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
@@ -539,6 +539,12 @@ static int uniphier_pmx_set_one_mux(struct pinctrl_dev *pctldev, unsigned pin,
 	unsigned reg, reg_end, shift, mask;
 	int ret;
 
+	/* some pins need input-enabling */
+	ret = uniphier_conf_pin_input_enable(pctldev,
+					     &pctldev->desc->pins[pin], 1);
+	if (ret)
+		return ret;
+
 	reg = UNIPHIER_PINCTRL_PINMUX_BASE + pin * mux_bits / 32 * reg_stride;
 	reg_end = reg + reg_stride;
 	shift = pin * mux_bits % 32;
@@ -563,9 +569,7 @@ static int uniphier_pmx_set_one_mux(struct pinctrl_dev *pctldev, unsigned pin,
 			return ret;
 	}
 
-	/* some pins need input-enabling */
-	return uniphier_conf_pin_input_enable(pctldev,
-					      &pctldev->desc->pins[pin], 1);
+	return 0;
 }
 
 static int uniphier_pmx_set_mux(struct pinctrl_dev *pctldev,
-- 
1.9.1

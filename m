From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Mar 2015 10:51:38 +0000
Subject: [PATCH 5/6] pinctrl: st: Show correct pin direction -- even when in
 GPIO mode
In-Reply-To: <1426675899-19882-1-git-send-email-lee.jones@linaro.org>
References: <1426675899-19882-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1426675899-19882-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Until now ST's pinconf_dbg_show() call-back has displayed the PIO
alternate function direction, which is only relevant if a pin is
operating in an alternate function mode i.e not GPIO mode.  If a
pin is in GPIO mode its direction is both set and status is
obtained by a completely different/unrelated bunch of registers.

This change ensures that the correct pin direction is shown, even
if a pin is operating in GPIO mode.

Reported-by: Olivier Clergeaud <olivier.clergeaud@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pinctrl/pinctrl-st.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index 52a4377..1cda40e 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -206,6 +206,9 @@
 #define gpio_chip_to_bank(chip) \
 		container_of(chip, struct st_gpio_bank, gpio_chip)
 
+#define pc_to_bank(pc) \
+		container_of(pc, struct st_gpio_bank, pc)
+
 enum st_retime_style {
 	st_retime_style_none,
 	st_retime_style_packed,
@@ -1053,15 +1056,18 @@ static int st_pinconf_get(struct pinctrl_dev *pctldev,
 static void st_pinconf_dbg_show(struct pinctrl_dev *pctldev,
 				   struct seq_file *s, unsigned pin_id)
 {
+	struct st_pio_control *pc;
 	unsigned long config;
+	int offset = st_gpio_pin(pin_id);
 
 	mutex_unlock(&pctldev->mutex);
+	pc = st_get_pio_control(pctldev, pin_id);
 	st_pinconf_get(pctldev, pin_id, &config);
 	mutex_lock(&pctldev->mutex);
 	seq_printf(s, "[OE:%ld,PU:%ld,OD:%ld]\n"
 		"\t\t[retime:%ld,invclk:%ld,clknotdat:%ld,"
 		"de:%ld,rt-clk:%ld,rt-delay:%ld]",
-		ST_PINCONF_UNPACK_OE(config),
+		!st_gpio_get_direction(&pc_to_bank(pc)->gpio_chip, offset),
 		ST_PINCONF_UNPACK_PU(config),
 		ST_PINCONF_UNPACK_OD(config),
 		ST_PINCONF_UNPACK_RT(config),
-- 
1.9.1

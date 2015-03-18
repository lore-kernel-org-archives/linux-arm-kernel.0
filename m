From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Mar 2015 10:51:35 +0000
Subject: [PATCH 2/6] pinctrl: st: Introduce a 'get pin function' call
In-Reply-To: <1426675899-19882-1-git-send-email-lee.jones@linaro.org>
References: <1426675899-19882-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1426675899-19882-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This call fetches the numerical function value a specified pin is
currently operating in.  Function zero is more often than not the
GPIO function.  Greater than zero values represent an alternative
function.  You'd need to either look those up in the Device Tree
sources or the Programmer's Manual.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pinctrl/pinctrl-st.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index 9e5ec00..5362e45 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -460,6 +460,20 @@ static void st_pctl_set_function(struct st_pio_control *pc,
 	regmap_field_write(alt, val);
 }
 
+static unsigned int st_pctl_get_pin_function(struct st_pio_control *pc, int pin)
+{
+	struct regmap_field *alt = pc->alt;
+	unsigned int val;
+	int offset = pin * 4;
+
+	if (!alt)
+		return 0;
+
+	regmap_field_read(alt, &val);
+
+	return (val >> offset) & 0xf;
+}
+
 static unsigned long st_pinconf_delay_to_bit(unsigned int delay,
 	const struct st_pctl_data *data, unsigned long config)
 {
-- 
1.9.1

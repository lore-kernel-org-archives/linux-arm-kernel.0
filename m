From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 14:09:20 +0900
Subject: [PATCH 12/28] sh-pfc: Configure pins as GPIOs at request time when
 handled externally
In-Reply-To: <1364879376-10020-1-git-send-email-horms+renesas@verge.net.au>
References: <1364879376-10020-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364879376-10020-13-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

When a GPIO is handled by a separate driver the pinmux
gpio_set_direction() handler won't be called. The pin mux type then need
to be configured to GPIO at request time.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/core.c    |   37 ++++++++++++++++---------------------
 drivers/pinctrl/sh-pfc/pinctrl.c |   11 +++++++++++
 2 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 97e6ea3..ced9a95 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -268,7 +268,7 @@ int sh_pfc_config_mux(struct sh_pfc *pfc, unsigned mark, int pinmux_type)
 	int ret;
 
 	switch (pinmux_type) {
-
+	case PINMUX_TYPE_GPIO:
 	case PINMUX_TYPE_FUNCTION:
 		range = NULL;
 		break;
@@ -297,6 +297,8 @@ int sh_pfc_config_mux(struct sh_pfc *pfc, unsigned mark, int pinmux_type)
 	enum_id = 0;
 	field = 0;
 	value = 0;
+
+	/* Iterate over all the configuration fields we need to update. */
 	while (1) {
 		pos = sh_pfc_mark_to_enum(pfc, mark, pos, &enum_id);
 		if (pos < 0)
@@ -305,18 +307,20 @@ int sh_pfc_config_mux(struct sh_pfc *pfc, unsigned mark, int pinmux_type)
 		if (!enum_id)
 			break;
 
-		/* first check if this is a function enum */
+		/* Check if the configuration field selects a function. If it
+		 * doesn't, skip the field if it's not applicable to the
+		 * requested pinmux type.
+		 */
 		in_range = sh_pfc_enum_in_range(enum_id, &pfc->info->function);
 		if (!in_range) {
-			/* not a function enum */
-			if (range) {
-				/*
-				 * other range exists, so this pin is
-				 * a regular GPIO pin that now is being
-				 * bound to a specific direction.
-				 *
-				 * for this case we only allow function enums
-				 * and the enums that match the other range.
+			if (pinmux_type == PINMUX_TYPE_FUNCTION) {
+				/* Functions are allowed to modify all
+				 * fields.
+				 */
+				in_range = 1;
+			} else if (pinmux_type != PINMUX_TYPE_GPIO) {
+				/* Input/output types can only modify fields
+				 * that correspond to their respective ranges.
 				 */
 				in_range = sh_pfc_enum_in_range(enum_id, range);
 
@@ -327,17 +331,8 @@ int sh_pfc_config_mux(struct sh_pfc *pfc, unsigned mark, int pinmux_type)
 				 */
 				if (in_range && enum_id == range->force)
 					continue;
-			} else {
-				/*
-				 * no other range exists, so this pin
-				 * must then be of the function type.
-				 *
-				 * allow function type pins to select
-				 * any combination of function/in/out
-				 * in their MARK lists.
-				 */
-				in_range = 1;
 			}
+			/* GPIOs are only allowed to modify function fields. */
 		}
 
 		if (!in_range)
diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
index aef268b..3492ec9 100644
--- a/drivers/pinctrl/sh-pfc/pinctrl.c
+++ b/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -182,6 +182,17 @@ static int sh_pfc_gpio_request_enable(struct pinctrl_dev *pctldev,
 		goto done;
 	}
 
+	if (!pfc->gpio) {
+		/* If GPIOs are handled externally the pin mux type need to be
+		 * set to GPIO here.
+		 */
+		const struct sh_pfc_pin *pin = &pfc->info->pins[idx];
+
+		ret = sh_pfc_config_mux(pfc, pin->enum_id, PINMUX_TYPE_GPIO);
+		if (ret < 0)
+			goto done;
+	}
+
 	cfg->type = PINMUX_TYPE_GPIO;
 
 	ret = 0;
-- 
1.7.10.4

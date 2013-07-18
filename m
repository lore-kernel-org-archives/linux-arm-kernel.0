From: tony@atomide.com (Tony Lindgren)
Date: Thu, 18 Jul 2013 08:15:14 -0700
Subject: [PATCH 4/4] drivers: Add pinctrl handling for dynamic pin states
In-Reply-To: <20130718151213.30990.45828.stgit@localhost>
References: <20130718151213.30990.45828.stgit@localhost>
Message-ID: <20130718151514.30990.99907.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We want to have static pin states handled separately from
dynamic pin states, so let's add optional state_active.

Then if state_active is defined, let's check and make sure
state_idle and state_sleep match state_active for the
pin groups to avoid checking them during runtime as the
active and idle pins may need to be toggled for many
devices every time we enter and exit idle.

See also Documentation/pinctrl.txt regarding runtime
muxing of pins.

Cc: Felipe Balbi <balbi@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/base/pinctrl.c |   39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/base/pinctrl.c b/drivers/base/pinctrl.c
index 5fb74b4..49644ed 100644
--- a/drivers/base/pinctrl.c
+++ b/drivers/base/pinctrl.c
@@ -34,6 +34,7 @@ int pinctrl_bind_pins(struct device *dev)
 		goto cleanup_alloc;
 	}
 
+	/* Default static pins that don't need to change */
 	dev->pins->default_state = pinctrl_lookup_state(dev->pins->p,
 					PINCTRL_STATE_DEFAULT);
 	if (IS_ERR(dev->pins->default_state)) {
@@ -48,23 +49,57 @@ int pinctrl_bind_pins(struct device *dev)
 		goto cleanup_get;
 	}
 
+	/* Optional runtime dynamic pins in addition to the static pins */
+	dev->pins->active_state = pinctrl_lookup_state(dev->pins->p,
+					PINCTRL_STATE_ACTIVE);
+	if (IS_ERR(dev->pins->active_state)) {
+		/* Not supplying this state is perfectly legal */
+		dev_dbg(dev, "no active pinctrl state\n");
+	} else {
+		ret = pinctrl_select_dynamic(dev->pins->p,
+				dev->pins->active_state);
+		if (ret) {
+			dev_dbg(dev, "failed to select active pinctrl state\n");
+			goto cleanup_get;
+		}
+	}
+
 #ifdef CONFIG_PM
 	/*
 	 * If power management is enabled, we also look for the optional
 	 * sleep and idle pin states, with semantics as defined in
 	 * <linux/pinctrl/pinctrl-state.h>
+	 *
+	 * Note that if active state is defined, sleep and idle states must
+	 * cover the same pin groups as active state.
 	 */
 	dev->pins->sleep_state = pinctrl_lookup_state(dev->pins->p,
 					PINCTRL_STATE_SLEEP);
-	if (IS_ERR(dev->pins->sleep_state))
+	if (IS_ERR(dev->pins->sleep_state)) {
 		/* Not supplying this state is perfectly legal */
 		dev_dbg(dev, "no sleep pinctrl state\n");
+	} else if (!IS_ERR(dev->pins->active_state)) {
+		ret = pinctrl_check_dynamic(dev, dev->pins->active_state,
+					    dev->pins->sleep_state);
+		if (ret) {
+			dev_err(dev, "sleep state groups do not match active state\n");
+			dev->pins->sleep_state = ERR_PTR(-EINVAL);
+		}
+	}
 
 	dev->pins->idle_state = pinctrl_lookup_state(dev->pins->p,
 					PINCTRL_STATE_IDLE);
-	if (IS_ERR(dev->pins->idle_state))
+	if (IS_ERR(dev->pins->idle_state)) {
 		/* Not supplying this state is perfectly legal */
 		dev_dbg(dev, "no idle pinctrl state\n");
+	} else if (!IS_ERR(dev->pins->active_state)) {
+		ret = pinctrl_check_dynamic(dev, dev->pins->active_state,
+					    dev->pins->idle_state);
+		if (ret) {
+			dev_err(dev, "idle state groups do not match active state\n");
+			dev->pins->idle_state = ERR_PTR(-EINVAL);
+		}
+	}
 #endif
 
 	return 0;

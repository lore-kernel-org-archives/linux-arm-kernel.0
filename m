From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 28 Sep 2012 09:18:08 +0200
Subject: [PATCH v2] pinctrl: clarify idle vs sleep states
Message-ID: <1348816688-27531-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This pure documentation fix tries to align the "idle" and
"sleep" pin states to the idle and suspend states from
runtime PM.

Cc: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- I changed my mind slightly after experimentation in practice
  (empirical stuff is the best). So now I think "idle" is for
  runtime_suspend(), and "sleep" is for suspend() proper. This
  works best in practice for us. I'm trying to set some model
  here that will be easy to understand and usable for typical
  cases.
---
 include/linux/pinctrl/pinctrl-state.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/pinctrl/pinctrl-state.h b/include/linux/pinctrl/pinctrl-state.h
index 634608dc..b5919f8 100644
--- a/include/linux/pinctrl/pinctrl-state.h
+++ b/include/linux/pinctrl/pinctrl-state.h
@@ -6,13 +6,18 @@
  * @PINCTRL_STATE_DEFAULT: the state the pinctrl handle shall be put
  *	into as default, usually this means the pins are up and ready to
  *	be used by the device driver. This state is commonly used by
- *	hogs to configure muxing and pins at boot.
+ *	hogs to configure muxing and pins at boot, and also as a state
+ *	to go into when returning from sleep and idle in
+ *	.pm_runtime_resume() or ordinary .resume() for example.
  * @PINCTRL_STATE_IDLE: the state the pinctrl handle shall be put into
- *	when the pins are idle. Could typically be set from a
- *	pm_runtime_suspend() operation.
+ *	when the pins are idle. This is a state where the system is relaxed
+ *	but not fully sleeping - some power may be on but clocks gated for
+ *	example. Could typically be set from a pm_runtime_suspend() or
+ *	pm_runtime_idle() operation.
  * @PINCTRL_STATE_SLEEP: the state the pinctrl handle shall be put into
- *	when the pins are sleeping. Could typically be set from a
- *	common suspend() function.
+ *	when the pins are sleeping. This is a state where the system is in
+ *	its lowest sleep state. Could typically be set from an
+ *	ordinary .suspend() function.
  */
 #define PINCTRL_STATE_DEFAULT "default"
 #define PINCTRL_STATE_IDLE "idle"
-- 
1.7.11.3

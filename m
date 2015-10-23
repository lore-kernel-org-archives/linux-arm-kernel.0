From: wxt@rock-chips.com (Caesar Wang)
Date: Fri, 23 Oct 2015 19:25:27 +0800
Subject: [PATCH v4 2/3] thermal: rockchip: support the sleep pinctrl state to
 avoid glitches in s2r
In-Reply-To: <1445599528-18825-1-git-send-email-wxt@rock-chips.com>
References: <1445599528-18825-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1445599528-18825-3-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we come out of system suspend state (S3) the tsadc will have been
reset and back at its default state.  While reprogramming the tsadc
it's possible that we'll glitch the output and unintentionally cause
the "over temperature" GPIO to be asserted.  Since the over
temperature GPIO is often hooked up to something that will cause a
reboot or shutdown in hardware, this glitch can be catastrophic on
some boards.

We'll add support for selecting the "sleep" pinctrl state at suspend
time.  Boards can use this to effectively disable the tsadc at suspend
time and avoid glitches when the system is resumed.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v4:
  - take the Doug's commit as correct decription.

Changes in v3:
  - Add the pinctrl state for in the suspend/resume.

Changes in v2: None
Changes in v1: None

 drivers/thermal/rockchip_thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index c89ffb2..3b8fbda 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -642,6 +642,8 @@ static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
 	clk_disable(thermal->pclk);
 	clk_disable(thermal->clk);
 
+	pinctrl_pm_select_sleep_state(dev);
+
 	return 0;
 }
 
@@ -678,6 +680,8 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
 	for (i = 0; i < ARRAY_SIZE(thermal->sensors); i++)
 		rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
 
+	pinctrl_pm_select_default_state(dev);
+
 	return 0;
 }
 
-- 
1.9.1

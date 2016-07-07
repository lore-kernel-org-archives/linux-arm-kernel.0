From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Thu,  7 Jul 2016 15:21:00 -0700
Subject: [PATCH v2 09/22] usb: chipidea: Kick OTG state machine for AVVIS with
 vbus extcon
In-Reply-To: <20160707222114.1673-1-stephen.boyd@linaro.org>
References: <20160707222114.1673-1-stephen.boyd@linaro.org>
Message-ID: <20160707222114.1673-10-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Force the OTG state machine to go forward when we're using an
extcon for vbus detection. In this case, the controller may never
raise an interrupt for AVVIS, so we need to simulate the event by
toggling the appropriate OTG fsm bits and kicking the state
machine again.

Cc: Peter Chen <peter.chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

I think this was rejected last time around but I've kept it in the
series to continue discussion on how we're supposed to be emulating
vbus an id pin interrupts and the otgsc register.

 drivers/usb/chipidea/otg_fsm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/usb/chipidea/otg_fsm.c b/drivers/usb/chipidea/otg_fsm.c
index de8e22ec3902..aab076fc4d82 100644
--- a/drivers/usb/chipidea/otg_fsm.c
+++ b/drivers/usb/chipidea/otg_fsm.c
@@ -475,6 +475,14 @@ static void ci_otg_drv_vbus(struct otg_fsm *fsm, int on)
 				return;
 			}
 		}
+		/*
+		 * Force state machine forward if we use extcon
+		 * to detect vbus state (i.e. simulate AVVIS event)
+		 */
+		if (!IS_ERR(ci->platdata->vbus_extcon.edev)) {
+			fsm->a_vbus_vld = 1;
+			ci_otg_queue_work(ci);
+		}
 		/* Disable data pulse irq */
 		hw_write_otgsc(ci, OTGSC_DPIE, 0);
 
@@ -486,6 +494,15 @@ static void ci_otg_drv_vbus(struct otg_fsm *fsm, int on)
 
 		fsm->a_bus_drop = 1;
 		fsm->a_bus_req = 0;
+		/*
+		 * Force state machine forward if we use extcon
+		 * to detect vbus state (i.e. simulate AVVIS event)
+		 */
+		if (!IS_ERR(ci->platdata->vbus_extcon.edev)) {
+			fsm->a_vbus_vld = 0;
+			fsm->b_conn = 0;
+			ci_otg_queue_work(ci);
+		}
 	}
 }
 
-- 
2.9.0.rc2.8.ga28705d

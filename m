From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Mon, 27 Jun 2016 18:18:27 -0700
Subject: [PATCH] usb: otg-fsm: Cancel HNP polling work when not used
Message-ID: <20160628011827.1688-1-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We setup the HNP polling worker, but we never stop it. The OTG
state machine can go round and round and keep reinitializing the
worker even while it's actively running. That's bad, and debug
objects catches it. Fix this by canceling the work when we leave
the A_HOST or B_HOST states.

[otg_set_state]  Set state: a_wait_bcon
usb 2-1: USB disconnect, device number 2
[otg_statemachine]  quit statemachine, changed = 1
[otg_set_state]  Set state: a_host
<HNP Polling started>
[otg_statemachine]  quit statemachine, changed = 1
usb 2-1: new low-speed USB device number 3 using ci_hdrc
usb 2-1: New USB device found, idVendor=03f0, idProduct=134a
usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 2-1: Product: HP USB Optical Mouse
usb 2-1: Manufacturer: PixArt
input: PixArt HP USB Optical Mouse as /devices/platform/soc/f9a55000.usb/ci_hdrc.0/usb2/2-1/2-1:1.0/0003:03F0:134A.0002/input/input1
hid-generic 0003:03F0:134A.0002: input: USB HID v1.11 Mouse [PixArt HP USB Optical Mouse] on usb-ci_hdrc.0-1/input0
[otg_set_state]  Set state: a_wait_bcon
usb 2-1: USB disconnect, device number 3
[otg_statemachine]  quit statemachine, changed = 1
[otg_set_state]  Set state: a_host
<HNP Polling started>
------------[ cut here ]------------
WARNING: CPU: 2 PID: 95 at lib/debugobjects.c:263 debug_print_object+0x98/0xc0
ODEBUG: init active (active state 0) object type: timer_list hint: delayed_work_timer_fn+0x0/0x2c
Modules linked in: phy_qcom_usb_hsic phy_qcom_usb_hs ci_hdrc_msm ci_hdrc
CPU: 2 PID: 95 Comm: kworker/u8:1 Not tainted 4.7.0-rc1-00043-g1f22f3b65c44-dirty #442
Hardware name: Qualcomm (Flattened Device Tree)
Workqueue: ci_otg ci_otg_work [ci_hdrc]
[<c031067c>] (unwind_backtrace) from [<c030cbf0>] (show_stack+0x20/0x24)
[<c030cbf0>] (show_stack) from [<c060cec8>] (dump_stack+0x7c/0x9c)
[<c060cec8>] (dump_stack) from [<c031f8a4>] (__warn+0xe4/0x110)
[<c031f8a4>] (__warn) from [<c031f9a0>] (warn_slowpath_fmt+0x48/0x50)
[<c031f9a0>] (warn_slowpath_fmt) from [<c06289c0>] (debug_print_object+0x98/0xc0)
[<c06289c0>] (debug_print_object) from [<c0628bbc>] (__debug_object_init+0xcc/0x3bc)
[<c0628bbc>] (__debug_object_init) from [<c0628ed0>] (debug_object_init+0x24/0x2c)
[<c0628ed0>] (debug_object_init) from [<c037ceb0>] (init_timer_key+0x24/0x120)
[<c037ceb0>] (init_timer_key) from [<c07b3f1c>] (otg_start_hnp_polling+0x7c/0xbc)
[<c07b3f1c>] (otg_start_hnp_polling) from [<c074543c>] (otg_set_state+0x740/0xc20)
[<c074543c>] (otg_set_state) from [<c0745d98>] (otg_statemachine+0x47c/0x4ac)
[<c0745d98>] (otg_statemachine) from [<bf00c808>] (ci_otg_fsm_work+0x48/0x1a0 [ci_hdrc])
[<bf00c808>] (ci_otg_fsm_work [ci_hdrc]) from [<bf007428>] (ci_otg_work+0xd4/0x218 [ci_hdrc])
[<bf007428>] (ci_otg_work [ci_hdrc]) from [<c0338cac>] (process_one_work+0x154/0x4b4)
[<c0338cac>] (process_one_work) from [<c033908c>] (worker_thread+0x38/0x4d0)
[<c033908c>] (worker_thread) from [<c033f0a0>] (kthread+0xe8/0x104)
[<c033f0a0>] (kthread) from [<c0308ed8>] (ret_from_fork+0x14/0x3c)

Cc: Li Jun <jun.li@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Fixes: ae57e97a9521 ("usb: common: otg-fsm: add HNP polling support")
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/usb/common/usb-otg-fsm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/usb/common/usb-otg-fsm.c b/drivers/usb/common/usb-otg-fsm.c
index 9059b7dc185e..73eec8c12235 100644
--- a/drivers/usb/common/usb-otg-fsm.c
+++ b/drivers/usb/common/usb-otg-fsm.c
@@ -61,6 +61,18 @@ static int otg_set_protocol(struct otg_fsm *fsm, int protocol)
 	return 0;
 }
 
+static void otg_stop_hnp_polling(struct otg_fsm *fsm)
+{
+	/*
+	 * The memory of host_req_flag should be allocated by
+	 * controller driver, otherwise, hnp polling is not started.
+	 */
+	if (!fsm->host_req_flag)
+		return;
+
+	cancel_delayed_work_sync(&fsm->hnp_polling_work);
+}
+
 /* Called when leaving a state.  Do state clean up jobs here */
 static void otg_leave_state(struct otg_fsm *fsm, enum usb_otg_state old_state)
 {
@@ -84,6 +96,7 @@ static void otg_leave_state(struct otg_fsm *fsm, enum usb_otg_state old_state)
 		fsm->b_ase0_brst_tmout = 0;
 		break;
 	case OTG_STATE_B_HOST:
+		otg_stop_hnp_polling(fsm);
 		break;
 	case OTG_STATE_A_IDLE:
 		fsm->adp_prb = 0;
@@ -97,6 +110,7 @@ static void otg_leave_state(struct otg_fsm *fsm, enum usb_otg_state old_state)
 		fsm->a_wait_bcon_tmout = 0;
 		break;
 	case OTG_STATE_A_HOST:
+		otg_stop_hnp_polling(fsm);
 		otg_del_timer(fsm, A_WAIT_ENUM);
 		break;
 	case OTG_STATE_A_SUSPEND:
-- 
2.9.0.rc2.8.ga28705d

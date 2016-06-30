From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed, 29 Jun 2016 19:02:32 -0700
Subject: [PATCH] usb: otg-fsm: Cancel HNP polling work when not used
In-Reply-To: <20160629094347.GL25236@shlinux2>
References: <20160628011827.1688-1-stephen.boyd@linaro.org>
 <20160629094347.GL25236@shlinux2>
Message-ID: <146725215291.32568.16495744198971136361@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter Chen (2016-06-29 02:43:47)
> On Mon, Jun 27, 2016 at 06:18:27PM -0700, Stephen Boyd wrote:
> It introduces circular locking after applying it, otg_statemachine calls
> otg_leave_state, and otg_leave_state calls otg_statemachine again due
> to flush work, see below dump:
> 
> I suggest moving initialization/flush hnp polling work to chipidea driver.
> 
> [  183.086987] ======================================================
> [  183.093183] [ INFO: possible circular locking dependency detected ]
> [  183.099471] 4.7.0-rc4-00012-gf1f333f-dirty #856 Not tainted
> [  183.105059] -------------------------------------------------------
> [  183.111341] kworker/0:2/114 is trying to acquire lock:
> [  183.116492]  (&ci->fsm.lock){+.+.+.}, at: [<806118dc>]
> otg_statemachine+0x20/0x470
> [  183.124199] 
> [  183.124199] but task is already holding lock:
> [  183.130052]  ((&(&fsm->hnp_polling_work)->work)){+.+...}, at:
> [<80140368>] process_one_work+0x128/0x418
> [  183.139568] 
> [  183.139568] which lock already depends on the new lock.
> [  183.139568] 
> [  183.147765] 
> [  183.147765] the existing dependency chain (in reverse order) is:
> [  183.155265] 
> -> #1 ((&(&fsm->hnp_polling_work)->work)){+.+...}:
> [  183.161371]        [<8013e97c>] flush_work+0x44/0x234
> [  183.166469]        [<801411a8>] __cancel_work_timer+0x98/0x1c8
> [  183.172347]        [<80141304>] cancel_delayed_work_sync+0x14/0x18
> [  183.178570]        [<80610ef8>] otg_set_state+0x290/0xc54
> [  183.184011]        [<806119d0>] otg_statemachine+0x114/0x470
> [  183.189712]        [<8060a590>] ci_otg_fsm_work+0x40/0x190
> [  183.195239]        [<806054d0>] ci_otg_work+0xcc/0x1e4
> [  183.200430]        [<801403d4>] process_one_work+0x194/0x418
> [  183.206136]        [<8014068c>] worker_thread+0x34/0x4fc
> [  183.211489]        [<80146d08>] kthread+0xdc/0xf8
> [  183.216238]        [<80108ab0>] ret_from_fork+0x14/0x24
> [  183.221514] 
> -> #0 (&ci->fsm.lock){+.+.+.}:
> [  183.225880]        [<8016ff94>] lock_acquire+0x78/0x98
> [  183.231062]        [<80947c18>] mutex_lock_nested+0x54/0x3ec
> [  183.236773]        [<806118dc>] otg_statemachine+0x20/0x470
> [  183.242388]        [<80611df4>] otg_hnp_polling_work+0xc8/0x1a4
> [  183.248352]        [<801403d4>] process_one_work+0x194/0x418
> [  183.254055]        [<8014068c>] worker_thread+0x34/0x4fc
> [  183.259409]        [<80146d08>] kthread+0xdc/0xf8
> [  183.264154]        [<80108ab0>] ret_from_fork+0x14/0x24
> [  183.269424] 
> [  183.269424] other info that might help us debug this:
> [  183.269424] 
> [  183.277451]  Possible unsafe locking scenario:
> [  183.277451] 
> [  183.283389]        CPU0                    CPU1
> [  183.287931]        ----                    ----
> [  183.292473]   lock((&(&fsm->hnp_polling_work)->work));
> [  183.297665]                                lock(&ci->fsm.lock);
> [  183.303639]
>         lock((&(&fsm->hnp_polling_work)->work));
> [  183.311347]   lock(&ci->fsm.lock);
> [  183.314801] 

Hm.. perhaps we should do cancel_delayed_work() then and not require any
sync? That would require some locking in the polling worker, but that
looks racy anyway as it runs in parallel to the state machine so it
probably needs to lock with the FSM. Completely untested patch as I'm
going home from work now.

----8<----
diff --git a/drivers/usb/common/usb-otg-fsm.c b/drivers/usb/common/usb-otg-fsm.c
index 73eec8c12235..6f4b7f0c81ff 100644
--- a/drivers/usb/common/usb-otg-fsm.c
+++ b/drivers/usb/common/usb-otg-fsm.c
@@ -70,7 +70,11 @@ static void otg_stop_hnp_polling(struct otg_fsm *fsm)
 	if (!fsm->host_req_flag)
 		return;
 
-	cancel_delayed_work_sync(&fsm->hnp_polling_work);
+	/*
+	 * We don't call cancel_delayed_work_sync() here because the
+	 * worker is synchronized to this function via the fsm lock.
+	 */
+	cancel_delayed_work(&fsm->hnp_polling_work);
 }
 
 /* Called when leaving a state.  Do state clean up jobs here */
@@ -136,23 +140,27 @@ static void otg_leave_state(struct otg_fsm *fsm, enum usb_otg_state old_state)
 	}
 }
 
+static int __otg_statemachine(struct otg_fsm *fsm);
+
 static void otg_hnp_polling_work(struct work_struct *work)
 {
 	struct otg_fsm *fsm = container_of(to_delayed_work(work),
 				struct otg_fsm, hnp_polling_work);
 	struct usb_device *udev;
-	enum usb_otg_state state = fsm->otg->state;
+	enum usb_otg_state state;
 	u8 flag;
 	int retval;
 
+	mutex_lock(&fsm->lock);
+	state = fsm->otg->state;
 	if (state != OTG_STATE_A_HOST && state != OTG_STATE_B_HOST)
-		return;
+		goto unlock;
 
 	udev = usb_hub_find_child(fsm->otg->host->root_hub, 1);
 	if (!udev) {
 		dev_err(fsm->otg->host->controller,
 			"no usb dev connected, can't start HNP polling\n");
-		return;
+		goto unlock;
 	}
 
 	*fsm->host_req_flag = 0;
@@ -168,7 +176,7 @@ static void otg_hnp_polling_work(struct work_struct *work)
 				USB_CTRL_GET_TIMEOUT);
 	if (retval != 1) {
 		dev_err(&udev->dev, "Get one byte OTG status failed\n");
-		return;
+		goto unlock;
 	}
 
 	flag = *fsm->host_req_flag;
@@ -176,10 +184,10 @@ static void otg_hnp_polling_work(struct work_struct *work)
 		/* Continue HNP polling */
 		schedule_delayed_work(&fsm->hnp_polling_work,
 					msecs_to_jiffies(T_HOST_REQ_POLL));
-		return;
+		goto unlock;
 	} else if (flag != HOST_REQUEST_FLAG) {
 		dev_err(&udev->dev, "host request flag %d is invalid\n", flag);
-		return;
+		goto unlock;
 	}
 
 	/* Host request flag is set */
@@ -200,7 +208,9 @@ static void otg_hnp_polling_work(struct work_struct *work)
 		fsm->b_bus_req = 0;
 	}
 
-	otg_statemachine(fsm);
+	__otg_statemachine(fsm);
+unlock:
+	mutex_unlock(&fsm->lock);
 }
 
 static void otg_start_hnp_polling(struct otg_fsm *fsm)
@@ -340,12 +350,10 @@ static int otg_set_state(struct otg_fsm *fsm, enum usb_otg_state new_state)
 }
 
 /* State change judgement */
-int otg_statemachine(struct otg_fsm *fsm)
+static int __otg_statemachine(struct otg_fsm *fsm)
 {
 	enum usb_otg_state state;
 
-	mutex_lock(&fsm->lock);
-
 	state = fsm->otg->state;
 	fsm->state_changed = 0;
 	/* State machine state change judgement */
@@ -458,9 +466,16 @@ int otg_statemachine(struct otg_fsm *fsm)
 	default:
 		break;
 	}
-	mutex_unlock(&fsm->lock);
 
 	VDBG("quit statemachine, changed = %d\n", fsm->state_changed);
 	return fsm->state_changed;
 }
+
+int otg_statemachine(struct otg_fsm *fsm)
+{
+	int ret;
+	mutex_lock(&fsm->lock);
+	ret = __otg_statemachine(fsm);
+	mutex_unlock(&fsm->lock);
+}
 EXPORT_SYMBOL_GPL(otg_statemachine);

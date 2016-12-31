From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 31 Dec 2016 23:04:59 +0100
Subject: [PATCH 5/6] staging: vchiq_arm: Combine substrings for 24 messages
In-Reply-To: <5acd65e7-0b5d-0972-5e1a-6e87d71dc1a4@users.sourceforge.net>
References: <5acd65e7-0b5d-0972-5e1a-6e87d71dc1a4@users.sourceforge.net>
Message-ID: <ed807b91-4a5f-4b0e-a048-7b8c090771d8@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 31 Dec 2016 22:00:28 +0100

The script "checkpatch.pl" pointed information out like the following.

WARNING: quoted string split across lines

* Thus fix the affected source code places.

* Improve indentation for passed parameters.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  | 164 +++++++++++----------
 1 file changed, 90 insertions(+), 74 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 3b7a0c87954d..05a00914dba0 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -292,12 +292,14 @@ service_callback(VCHIQ_REASON_T reason, VCHIQ_HEADER_T *header,
 		return VCHIQ_SUCCESS;
 
 	vchiq_log_trace(vchiq_arm_log_level,
-		"service_callback - service %lx(%d,%p), reason %d, header %lx, "
-		"instance %lx, bulk_userdata %lx",
-		(unsigned long)user_service,
-		service->localport, user_service->userdata,
-		reason, (unsigned long)header,
-		(unsigned long)instance, (unsigned long)bulk_userdata);
+			"service_callback - service %lx(%d,%p), reason %d, header %lx, instance %lx, bulk_userdata %lx",
+			(unsigned long)user_service,
+			service->localport,
+			user_service->userdata,
+			reason,
+			(unsigned long)header,
+			(unsigned long)instance,
+			(unsigned long)bulk_userdata);
 
 	if (header && user_service->is_vchi) {
 		spin_lock(&msg_queue_spinlock);
@@ -557,9 +559,8 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		rc = mutex_lock_killable(&instance->state->mutex);
 		if (rc != 0) {
 			vchiq_log_error(vchiq_arm_log_level,
-				"vchiq: connect: could not lock mutex for "
-				"state %d: %d",
-				instance->state->id, rc);
+					"vchiq: connect: could not lock mutex for state %d: %d",
+					instance->state->id, rc);
 			ret = -EINTR;
 			break;
 		}
@@ -720,16 +721,14 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 				vchiq_release_service_internal(service);
 			if (status != VCHIQ_SUCCESS) {
 				vchiq_log_error(vchiq_susp_log_level,
-					"%s: cmd %s returned error %d for "
-					"service %c%c%c%c:%03d",
-					__func__,
-					(cmd == VCHIQ_IOC_USE_SERVICE) ?
-						"VCHIQ_IOC_USE_SERVICE" :
-						"VCHIQ_IOC_RELEASE_SERVICE",
-					status,
-					VCHIQ_FOURCC_AS_4CHARS(
-						service->base.fourcc),
-					service->client_id);
+						"%s: cmd %s returned error %d for service %c%c%c%c:%03d",
+						__func__,
+						(cmd == VCHIQ_IOC_USE_SERVICE)
+						? "VCHIQ_IOC_USE_SERVICE"
+						: "VCHIQ_IOC_RELEASE_SERVICE",
+						status,
+						VCHIQ_FOURCC_AS_4CHARS(service->base.fourcc),
+						service->client_id);
 				ret = -EINVAL;
 			}
 		} else
@@ -930,8 +929,8 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 							"header %pK: msgbufsize %x < msglen %x",
 							header, args.msgbufsize,
 							msglen);
-						WARN(1, "invalid message "
-							"size\n");
+						WARN(1,
+						     "invalid message size\n");
 						if (ret == 0)
 							ret = -EMSGSIZE;
 						break;
@@ -1982,19 +1981,22 @@ block_resume(VCHIQ_ARM_STATE_T *arm_state)
 	if (arm_state->blocked_count) {
 		reinit_completion(&arm_state->blocked_blocker);
 		write_unlock_bh(&arm_state->susp_res_lock);
-		vchiq_log_info(vchiq_susp_log_level, "%s wait for previously "
-			"blocked clients", __func__);
+		vchiq_log_info(vchiq_susp_log_level,
+			       "%s wait for previously blocked clients",
+			       __func__);
 		if (wait_for_completion_interruptible_timeout(
 				&arm_state->blocked_blocker, timeout_val)
 					<= 0) {
-			vchiq_log_error(vchiq_susp_log_level, "%s wait for "
-				"previously blocked clients failed" , __func__);
+			vchiq_log_error(vchiq_susp_log_level,
+					"%s wait for previously blocked clients failed",
+					__func__);
 			status = VCHIQ_ERROR;
 			write_lock_bh(&arm_state->susp_res_lock);
 			goto out;
 		}
-		vchiq_log_info(vchiq_susp_log_level, "%s previously blocked "
-			"clients resumed", __func__);
+		vchiq_log_info(vchiq_susp_log_level,
+			       "%s previously blocked clients resumed",
+			       __func__);
 		write_lock_bh(&arm_state->susp_res_lock);
 	}
 
@@ -2003,8 +2005,9 @@ block_resume(VCHIQ_ARM_STATE_T *arm_state)
 			arm_state->vc_resume_state > VC_RESUME_IDLE) {
 		if (resume_count > 1) {
 			status = VCHIQ_ERROR;
-			vchiq_log_error(vchiq_susp_log_level, "%s waited too "
-				"many times for resume" , __func__);
+			vchiq_log_error(vchiq_susp_log_level,
+					"%s waited too many times for resume",
+					__func__);
 			goto out;
 		}
 		write_unlock_bh(&arm_state->susp_res_lock);
@@ -2013,10 +2016,11 @@ block_resume(VCHIQ_ARM_STATE_T *arm_state)
 		if (wait_for_completion_interruptible_timeout(
 				&arm_state->vc_resume_complete, timeout_val)
 					<= 0) {
-			vchiq_log_error(vchiq_susp_log_level, "%s wait for "
-				"resume failed (%s)", __func__,
-				resume_state_names[arm_state->vc_resume_state +
-							VC_RESUME_NUM_OFFSET]);
+			vchiq_log_error(vchiq_susp_log_level,
+					"%s wait for resume failed (%s)",
+					__func__,
+					resume_state_names[arm_state->vc_resume_state
+							   + VC_RESUME_NUM_OFFSET]);
 			status = VCHIQ_ERROR;
 			write_lock_bh(&arm_state->susp_res_lock);
 			goto out;
@@ -2056,12 +2060,14 @@ vchiq_arm_vcsuspend(VCHIQ_STATE_T *state)
 
 	switch (arm_state->vc_suspend_state) {
 	case VC_SUSPEND_REQUESTED:
-		vchiq_log_info(vchiq_susp_log_level, "%s: suspend already "
-			"requested", __func__);
+		vchiq_log_info(vchiq_susp_log_level,
+			       "%s: suspend already requested",
+			       __func__);
 		break;
 	case VC_SUSPEND_IN_PROGRESS:
-		vchiq_log_info(vchiq_susp_log_level, "%s: suspend already in "
-			"progress", __func__);
+		vchiq_log_info(vchiq_susp_log_level,
+			       "%s: suspend already in progress",
+			       __func__);
 		break;
 
 	default:
@@ -2136,13 +2142,14 @@ output_timeout_error(VCHIQ_STATE_T *state)
 		VCHIQ_SERVICE_T *service_ptr = state->services[i];
 		if (service_ptr && service_ptr->service_use_count &&
 			(service_ptr->srvstate != VCHIQ_SRVSTATE_FREE)) {
-			snprintf(err, sizeof(err), " %c%c%c%c(%d) service has "
-				"use count %d%s", VCHIQ_FOURCC_AS_4CHARS(
-					service_ptr->base.fourcc),
+			snprintf(err, sizeof(err),
+				 " %c%c%c%c(%d) service has use count %d%s",
+				 VCHIQ_FOURCC_AS_4CHARS(service_ptr->base.fourcc),
 				 service_ptr->client_id,
 				 service_ptr->service_use_count,
-				 service_ptr->service_use_count ==
-					 vc_use_count ? "" : " (+ more)");
+				 (service_ptr->service_use_count == vc_use_count)
+				 ? ""
+				 : " (+ more)");
 			break;
 		}
 	}
@@ -2192,22 +2199,26 @@ vchiq_arm_force_suspend(VCHIQ_STATE_T *state)
 		 * for the timeout */
 		stop_suspend_timer(arm_state);
 		if (!vchiq_videocore_wanted(state)) {
-			vchiq_log_info(vchiq_susp_log_level, "%s videocore "
-				"idle, initiating suspend", __func__);
+			vchiq_log_info(vchiq_susp_log_level,
+				       "%s videocore idle, initiating suspend",
+				       __func__);
 			status = vchiq_arm_vcsuspend(state);
 		} else if (arm_state->autosuspend_override <
 						FORCE_SUSPEND_FAIL_MAX) {
-			vchiq_log_info(vchiq_susp_log_level, "%s letting "
-				"videocore go idle", __func__);
+			vchiq_log_info(vchiq_susp_log_level,
+				       "%s letting videocore go idle",
+				       __func__);
 			status = VCHIQ_SUCCESS;
 		} else {
-			vchiq_log_warning(vchiq_susp_log_level, "%s failed too "
-				"many times - attempting suspend", __func__);
+			vchiq_log_warning(vchiq_susp_log_level,
+					  "%s failed too many times - attempting suspend",
+					  __func__);
 			status = vchiq_arm_vcsuspend(state);
 		}
 	} else {
-		vchiq_log_info(vchiq_susp_log_level, "%s videocore suspend "
-			"in progress - wait for completion", __func__);
+		vchiq_log_info(vchiq_susp_log_level,
+			       "%s videocore suspend in progress - wait for completion",
+			       __func__);
 		status = VCHIQ_SUCCESS;
 	}
 
@@ -2224,8 +2235,9 @@ vchiq_arm_force_suspend(VCHIQ_STATE_T *state)
 
 		write_lock_bh(&arm_state->susp_res_lock);
 		if (rc < 0) {
-			vchiq_log_warning(vchiq_susp_log_level, "%s "
-				"interrupted waiting for suspend", __func__);
+			vchiq_log_warning(vchiq_susp_log_level,
+					  "%s interrupted waiting for suspend",
+					  __func__);
 			status = VCHIQ_ERROR;
 			goto unblock_resume;
 		} else if (rc == 0) {
@@ -2434,8 +2446,9 @@ vchiq_use_internal(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service,
 			service->client_id);
 		entity_uc = &service->service_use_count;
 	} else {
-		vchiq_log_error(vchiq_susp_log_level, "%s null service "
-				"ptr", __func__);
+		vchiq_log_error(vchiq_susp_log_level,
+				"%s null service ptr",
+				__func__);
 		ret = VCHIQ_ERROR;
 		goto out;
 	}
@@ -2461,21 +2474,23 @@ vchiq_use_internal(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service,
 			 * continue */
 			arm_state->blocked_count++;
 			write_unlock_bh(&arm_state->susp_res_lock);
-			vchiq_log_info(vchiq_susp_log_level, "%s %s resume "
-				"blocked - waiting...", __func__, entity);
+			vchiq_log_info(vchiq_susp_log_level,
+				       "%s %s resume blocked - waiting...",
+				       __func__, entity);
 			if (wait_for_completion_killable(
 					&arm_state->resume_blocker) != 0) {
-				vchiq_log_error(vchiq_susp_log_level, "%s %s "
-					"wait for resume blocker interrupted",
-					__func__, entity);
+				vchiq_log_error(vchiq_susp_log_level,
+						"%s %s wait for resume blocker interrupted",
+						__func__, entity);
 				ret = VCHIQ_ERROR;
 				write_lock_bh(&arm_state->susp_res_lock);
 				arm_state->blocked_count--;
 				write_unlock_bh(&arm_state->susp_res_lock);
 				goto out;
 			}
-			vchiq_log_info(vchiq_susp_log_level, "%s %s resume "
-				"unblocked", __func__, entity);
+			vchiq_log_info(vchiq_susp_log_level,
+				       "%s %s resume unblocked",
+				       __func__, entity);
 			write_lock_bh(&arm_state->susp_res_lock);
 			if (--arm_state->blocked_count == 0)
 				complete_all(&arm_state->blocked_blocker);
@@ -2515,8 +2530,9 @@ vchiq_use_internal(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service,
 			__func__, entity);
 		if (wait_for_completion_killable(
 				&arm_state->vc_resume_complete) != 0) {
-			vchiq_log_error(vchiq_susp_log_level, "%s %s wait for "
-				"resume interrupted", __func__, entity);
+			vchiq_log_error(vchiq_susp_log_level,
+					"%s %s wait for resume interrupted",
+					__func__, entity);
 			ret = VCHIQ_ERROR;
 			goto out;
 		}
@@ -2793,10 +2809,9 @@ vchiq_dump_service_use_state(VCHIQ_STATE_T *state)
 		resume_state_names[vc_resume_state + VC_RESUME_NUM_OFFSET]);
 
 	if (only_nonzero)
-		vchiq_log_warning(vchiq_susp_log_level, "Too many active "
-			"services (%d).  Only dumping up to first %d services "
-			"with non-zero use-count", active_services,
-			local_max_services);
+		vchiq_log_warning(vchiq_susp_log_level,
+				  "Too many active services (%d). Only dumping up to first %d services with non-zero use-count",
+				  active_services, local_max_services);
 
 	for (i = 0; i < j; i++) {
 		vchiq_log_warning(vchiq_susp_log_level,
@@ -2834,13 +2849,14 @@ vchiq_check_service(VCHIQ_SERVICE_T *service)
 
 	if (ret == VCHIQ_ERROR) {
 		vchiq_log_error(vchiq_susp_log_level,
-			"%s ERROR - %c%c%c%c:%d service count %d, "
-			"state count %d, videocore suspend state %s", __func__,
-			VCHIQ_FOURCC_AS_4CHARS(service->base.fourcc),
-			service->client_id, service->service_use_count,
-			arm_state->videocore_use_count,
-			suspend_state_names[arm_state->vc_suspend_state +
-						VC_SUSPEND_NUM_OFFSET]);
+				"%s ERROR - %c%c%c%c:%d service count %d, state count %d, videocore suspend state %s",
+				__func__,
+				VCHIQ_FOURCC_AS_4CHARS(service->base.fourcc),
+				service->client_id,
+				service->service_use_count,
+				arm_state->videocore_use_count,
+				suspend_state_names[arm_state->vc_suspend_state
+						    + VC_SUSPEND_NUM_OFFSET]);
 		vchiq_dump_service_use_state(service->state);
 	}
 out:
-- 
2.11.0

From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Fri, 15 May 2015 08:34:27 +0200
Subject: [PATCH V3 2/2] tee: add OP-TEE driver
In-Reply-To: <1431671667-11219-1-git-send-email-jens.wiklander@linaro.org>
References: <1431671667-11219-1-git-send-email-jens.wiklander@linaro.org>
Message-ID: <1431671667-11219-3-git-send-email-jens.wiklander@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds a OP-TEE driver which also can be compiled as a loadable module.

* Targets ARM and ARM64
* Supports using reserved memory from OP-TEE as shared memory
* CMA as shared memory is optional and only tried if OP-TEE doesn't
  supply a reserved shared memory region
* Probes OP-TEE version using SMCs
* Accepts requests on privileged and unprivileged device
* Uses OPTEE message protocol version 2

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 Documentation/devicetree/bindings/optee/optee.txt  |  17 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |   6 +
 drivers/tee/Kconfig                                |  10 +
 drivers/tee/Makefile                               |   1 +
 drivers/tee/optee/Kconfig                          |  19 +
 drivers/tee/optee/Makefile                         |  13 +
 drivers/tee/optee/call.c                           | 294 ++++++++++++
 drivers/tee/optee/core.c                           | 509 ++++++++++++++++++++
 drivers/tee/optee/optee_private.h                  | 138 ++++++
 drivers/tee/optee/optee_smc.h                      | 510 +++++++++++++++++++++
 drivers/tee/optee/rpc.c                            | 282 ++++++++++++
 drivers/tee/optee/smc_a32.S                        |  30 ++
 drivers/tee/optee/smc_a64.S                        |  37 ++
 drivers/tee/optee/supp.c                           | 327 +++++++++++++
 include/uapi/linux/optee_msg.h                     | 368 +++++++++++++++
 16 files changed, 2562 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/optee/optee.txt
 create mode 100644 drivers/tee/optee/Kconfig
 create mode 100644 drivers/tee/optee/Makefile
 create mode 100644 drivers/tee/optee/call.c
 create mode 100644 drivers/tee/optee/core.c
 create mode 100644 drivers/tee/optee/optee_private.h
 create mode 100644 drivers/tee/optee/optee_smc.h
 create mode 100644 drivers/tee/optee/rpc.c
 create mode 100644 drivers/tee/optee/smc_a32.S
 create mode 100644 drivers/tee/optee/smc_a64.S
 create mode 100644 drivers/tee/optee/supp.c
 create mode 100644 include/uapi/linux/optee_msg.h

diff --git a/Documentation/devicetree/bindings/optee/optee.txt b/Documentation/devicetree/bindings/optee/optee.txt
new file mode 100644
index 0000000..8cea829
--- /dev/null
+++ b/Documentation/devicetree/bindings/optee/optee.txt
@@ -0,0 +1,17 @@
+OP-TEE Device Tree Bindings
+
+OP-TEE is a piece of software using hardware features to provide a Trusted
+Execution Environment. The security can be provided with ARM TrustZone, but
+also by virtualization or a separate chip. As there's no single OP-TEE
+vendor we're using "optee" as the first part of compatible propterty,
+indicating the OP-TEE protocol is used when communicating with the secure
+world.
+
+* OP-TEE based on ARM TrustZone required properties:
+
+- compatible="optee,optee-tz"
+
+Example:
+	optee {
+		compatible="optee,optee-tz";
+	};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 8033919..17c2a7e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -141,6 +141,7 @@ nvidia	NVIDIA
 nxp	NXP Semiconductors
 onnn	ON Semiconductor Corp.
 opencores	OpenCores.org
+optee	OP-TEE, Open Portable Trusted Execution Environment
 ortustech	Ortus Technology Co., Ltd.
 ovti	OmniVision Technologies
 panasonic	Panasonic Corporation
diff --git a/MAINTAINERS b/MAINTAINERS
index dfcc9cc..1234695 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7295,6 +7295,12 @@ F:	arch/*/oprofile/
 F:	drivers/oprofile/
 F:	include/linux/oprofile.h
 
+OP-TEE DRIVER
+M:	Jens Wiklander <jens.wiklander@linaro.org>
+S:	Maintained
+F:	include/uapi/linux/optee_msg.h
+F:	drivers/tee/optee/
+
 ORACLE CLUSTER FILESYSTEM 2 (OCFS2)
 M:	Mark Fasheh <mfasheh@suse.com>
 M:	Joel Becker <jlbec@evilplan.org>
diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
index 64a8cd7..b269276 100644
--- a/drivers/tee/Kconfig
+++ b/drivers/tee/Kconfig
@@ -6,3 +6,13 @@ config TEE
 	help
 	  This implements a generic interface towards a Trusted Execution
 	  Environment (TEE).
+
+if TEE
+
+menu "TEE drivers"
+
+source "drivers/tee/optee/Kconfig"
+
+endmenu
+
+endif
diff --git a/drivers/tee/Makefile b/drivers/tee/Makefile
index 60d2dab..53f3c76 100644
--- a/drivers/tee/Makefile
+++ b/drivers/tee/Makefile
@@ -1,3 +1,4 @@
 obj-y += tee.o
 obj-y += tee_shm.o
 obj-y += tee_shm_pool.o
+obj-$(CONFIG_OPTEE) += optee/
diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
new file mode 100644
index 0000000..3faa855
--- /dev/null
+++ b/drivers/tee/optee/Kconfig
@@ -0,0 +1,19 @@
+# OP-TEE Trusted Execution Environment Configuration
+config OPTEE
+	tristate "OP-TEE"
+	default n
+	depends on ARM || ARM64
+	help
+	  This implements the OP-TEE Trusted Execution Environment (TEE)
+	  driver.
+
+if OPTEE
+menu "OP-TEE options"
+config OPTEE_USE_CMA
+	bool "Use CMA"
+	default n
+	select DMA_CMA
+	help
+	  Configures OP-TEE driver to use CMA for shared memory allocations.
+endmenu
+endif
diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
new file mode 100644
index 0000000..096651d
--- /dev/null
+++ b/drivers/tee/optee/Makefile
@@ -0,0 +1,13 @@
+obj-$(CONFIG_OPTEE) += optee.o
+optee-objs += core.o
+optee-objs += call.o
+ifdef CONFIG_ARM
+plus_sec := $(call as-instr,.arch_extension sec,+sec)
+AFLAGS_smc_a32.o := -Wa,-march=armv7-a$(plus_sec)
+optee-objs += smc_a32.o
+endif
+ifdef CONFIG_ARM64
+optee-objs += smc_a64.o
+endif
+optee-objs += rpc.o
+optee-objs += supp.o
diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
new file mode 100644
index 0000000..b4c583b
--- /dev/null
+++ b/drivers/tee/optee/call.c
@@ -0,0 +1,294 @@
+/*
+ * Copyright (c) 2015, Linaro Limited
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <linux/types.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/device.h>
+#include <linux/tee_drv.h>
+#include "optee_private.h"
+#include "optee_smc.h"
+
+static void optee_call_lock(struct optee_call_sync *callsync)
+{
+	mutex_lock(&callsync->mutex);
+}
+
+static void optee_call_lock_wait_completion(struct optee_call_sync *callsync)
+{
+	/*
+	 * Release the lock until "something happens" and then reacquire it
+	 * again.
+	 *
+	 * This is needed when TEE returns "busy" and we need to try again
+	 * later.
+	 */
+	callsync->c_waiters++;
+	mutex_unlock(&callsync->mutex);
+	/*
+	 * Wait at most one second. Secure world is normally never busy
+	 * more than that so we should normally never timeout.
+	 */
+	wait_for_completion_timeout(&callsync->c, HZ);
+	mutex_lock(&callsync->mutex);
+	callsync->c_waiters--;
+}
+
+static void optee_call_unlock(struct optee_call_sync *callsync)
+{
+	/*
+	 * If at least one thread is waiting for "something to happen" let
+	 * one thread know that "something has happened".
+	 */
+	if (callsync->c_waiters)
+		complete(&callsync->c);
+	mutex_unlock(&callsync->mutex);
+}
+
+static int optee_arg_from_user(struct opteem_arg *arg, size_t size,
+			struct tee_shm **put_shm)
+{
+	struct opteem_param *param;
+	size_t n;
+
+	if (!arg->num_params || !put_shm)
+		return -EINVAL;
+
+	param = OPTEEM_GET_PARAMS(arg);
+
+	for (n = 0; n < arg->num_params; n++) {
+		struct tee_shm *shm;
+		u32 shm_offs;
+		phys_addr_t pa;
+		int ret;
+
+		if (param[n].attr & ~(OPTEEM_ATTR_TYPE_MASK | OPTEEM_ATTR_META))
+			return -EINVAL;
+
+		if (optee_param_is(param + n, PARAM_MEMREF | PARAM_INOUT)) {
+			shm_offs = param[n].u.memref.buf_ptr;
+			shm = tee_shm_get_from_fd(
+					(int)param[n].u.memref.shm_ref);
+			if (IS_ERR(shm))
+				return PTR_ERR(shm);
+			put_shm[n] = shm;
+			ret = tee_shm_get_pa(shm, shm_offs, &pa);
+			if (ret)
+				return ret;
+			param[n].u.memref.buf_ptr = pa;
+		}
+	}
+
+	return 0;
+}
+
+static int optee_arg_to_user(struct opteem_arg *arg,
+			struct opteem_arg __user *uarg)
+{
+	struct opteem_param *param = OPTEEM_GET_PARAMS(arg);
+	struct opteem_param __user *uparam = (void __user *)(uarg + 1);
+	size_t n;
+
+	if (arg->cmd == OPTEEM_CMD_OPEN_SESSION &&
+	    put_user(arg->session, &uarg->session))
+		return -EINVAL;
+	if (put_user(arg->ret, &uarg->ret) ||
+	    put_user(arg->ret_origin, &uarg->ret_origin))
+		return -EINVAL;
+
+	for (n = 0; n < arg->num_params; n++) {
+		struct opteem_param *p = param + n;
+		struct opteem_param __user *up = uparam + n;
+
+		if (optee_param_is(p, PARAM_VALUE | PARAM_OUT)) {
+			if (put_user(p->u.value.a, &up->u.value.a) ||
+			    put_user(p->u.value.b, &up->u.value.b))
+				return -EINVAL;
+		} else if (optee_param_is(p, PARAM_MEMREF | PARAM_OUT)) {
+			if (put_user(p->u.memref.size, &up->u.memref.size))
+				return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+/* Requires the filpstate mutex to be held */
+static struct optee_session *find_session(struct optee_context_data *ctxdata,
+			u32 session_id)
+{
+	struct optee_session *sess;
+
+	list_for_each_entry(sess, &ctxdata->sess_list, list_node)
+		if (sess->session_id == session_id)
+			return sess;
+	return NULL;
+}
+
+u32 optee_do_call_with_arg(struct tee_context *ctx, phys_addr_t parg)
+{
+	struct optee *optee = tee_get_drvdata(ctx->teedev);
+	struct optee_smc_param param = { };
+	u32 ret;
+	u32 cmdid = OPTEE_SMC_CALL_WITH_ARG;
+
+	reg_pair_from_64(&param.a1, &param.a2, parg);
+	optee_call_lock(&optee->callsync);
+	while (true) {
+		param.a0 = cmdid;
+
+		optee_smc(&param);
+		ret = param.a0;
+
+		if (ret == OPTEE_SMC_RETURN_EBUSY) {
+			/*
+			 * Since secure world returned busy, release the
+			 * lock we had when entering this function and wait
+			 * for "something to happen" (something else to
+			 * exit from secure world and needed resources may
+			 * have become available).
+			 */
+			optee_call_lock_wait_completion(&optee->callsync);
+		} else if (OPTEE_SMC_RETURN_IS_RPC(ret)) {
+			/*
+			 * Process the RPC. We're unlocking the path to
+			 * secure world to allow another request while
+			 * processing the RPC.
+			 */
+			optee_call_unlock(&optee->callsync);
+			cmdid = optee_handle_rpc(ctx, &param);
+			optee_call_lock(&optee->callsync);
+		} else {
+			break;
+		}
+	}
+	optee_call_unlock(&optee->callsync);
+	return ret;
+}
+
+int optee_cmd_call_with_arg(struct tee_context *ctx, struct tee_shm *shm,
+			struct opteem_cmd_prefix *arg,
+			struct opteem_cmd_prefix __user *uarg, size_t len)
+{
+	struct optee_context_data *ctxdata = ctx->data;
+	struct tee_shm **put_shm = NULL;
+	struct opteem_arg *opteem_arg;
+	struct opteem_arg __user *opteem_uarg;
+	struct optee_session *sess = NULL;
+	phys_addr_t opteem_parg;
+	size_t opteem_arg_size;
+	int rc;
+	size_t n;
+
+	opteem_arg = (struct opteem_arg *)(arg + 1);
+	opteem_uarg = (struct opteem_arg __user *)(uarg + 1);
+
+	opteem_arg_size = len - sizeof(*arg);
+
+	/* Check that the header is complete */
+	if (opteem_arg_size < sizeof(struct opteem_arg))
+		return -EINVAL;
+	/* Check that there's room for the specified number of params */
+	if (opteem_arg_size != OPTEEM_GET_ARG_SIZE(opteem_arg->num_params))
+		return -EINVAL;
+
+	if (opteem_arg->num_params) {
+		put_shm = kcalloc(opteem_arg->num_params,
+				  sizeof(struct tee_shm *), GFP_KERNEL);
+		if (!put_shm)
+			return -ENOMEM;
+		/*
+		 * The params are updated with physical addresses and the ref
+		 * counters on the shared memory is increased. The shms to
+		 * decreased ref counts on when the call is over are stored in
+		 * put_shm.
+		 */
+		rc = optee_arg_from_user(opteem_arg, opteem_arg_size, put_shm);
+		if (rc)
+			goto out;
+	}
+
+	rc = tee_shm_va2pa(shm, opteem_arg, &opteem_parg);
+	if (rc)
+		goto out;
+
+	switch (opteem_arg->cmd) {
+	case OPTEEM_CMD_OPEN_SESSION:
+		/*
+		 * Allocate memory now to be able to store the new session
+		 * below.
+		 */
+		sess = kzalloc(sizeof(struct optee_session), GFP_KERNEL);
+		if (!sess) {
+			rc = -ENOMEM;
+			goto out;
+		}
+		break;
+	case OPTEEM_CMD_CLOSE_SESSION:
+		/* A session is about to be closed, remove it from the list */
+		mutex_lock(&ctxdata->mutex);
+		sess = find_session(ctxdata, opteem_arg->session);
+		if (sess)
+			list_del(&sess->list_node);
+		mutex_unlock(&ctxdata->mutex);
+		if (!sess) {
+			rc = -EINVAL;
+			goto out;
+		}
+		kfree(sess);
+		sess = NULL;
+		break;
+
+	case OPTEEM_CMD_INVOKE_COMMAND:
+	case OPTEEM_CMD_CANCEL:
+		mutex_lock(&ctxdata->mutex);
+		sess = find_session(ctxdata, opteem_arg->session);
+		mutex_unlock(&ctxdata->mutex);
+		if (!sess) {
+			rc = -EINVAL;
+			goto out;
+		}
+		sess = NULL;
+		break;
+
+	default:
+		rc = -EINVAL;
+		goto out;
+	}
+
+	if (optee_do_call_with_arg(ctx, opteem_parg)) {
+		opteem_arg->ret = TEEC_ERROR_COMMUNICATION;
+		opteem_arg->ret_origin = TEEC_ORIGIN_COMMS;
+	}
+
+	rc = optee_arg_to_user(opteem_arg, opteem_uarg);
+
+	if (sess && opteem_arg->ret == TEEC_SUCCESS) {
+		/* A new session has been created, add it to the list. */
+		sess->session_id = opteem_arg->session;
+		mutex_lock(&ctxdata->mutex);
+		list_add(&sess->list_node, &ctxdata->sess_list);
+		mutex_unlock(&ctxdata->mutex);
+		sess = NULL;
+	}
+out:
+	kfree(sess);
+	if (put_shm) {
+		for (n = 0; n < opteem_arg->num_params; n++)
+			if (put_shm[n])
+				tee_shm_put(put_shm[n]);
+		kfree(put_shm);
+	}
+	return rc;
+}
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
new file mode 100644
index 0000000..b3f8b92d
--- /dev/null
+++ b/drivers/tee/optee/core.c
@@ -0,0 +1,509 @@
+/*
+ * Copyright (c) 2015, Linaro Limited
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/dma-contiguous.h>
+#ifdef CONFIG_OPTEE_USE_CMA
+#include <linux/cma.h>
+#endif
+#include <linux/io.h>
+#include <linux/tee_drv.h>
+#include "optee_private.h"
+#include "optee_smc.h"
+
+#define DRIVER_NAME "optee"
+
+bool optee_param_is(struct opteem_param *param, uint32_t flags)
+{
+	static const u8 attr_flags[] = {
+		[OPTEEM_ATTR_TYPE_NONE]		 = 0,
+		[OPTEEM_ATTR_TYPE_VALUE_INPUT]	 = PARAM_VALUE | PARAM_IN,
+		[OPTEEM_ATTR_TYPE_VALUE_OUTPUT]	 = PARAM_VALUE | PARAM_OUT,
+		[OPTEEM_ATTR_TYPE_VALUE_INOUT]	 = PARAM_VALUE | PARAM_IN |
+						   PARAM_OUT,
+		[OPTEEM_ATTR_TYPE_MEMREF_INPUT]	 = PARAM_MEMREF | PARAM_IN,
+		[OPTEEM_ATTR_TYPE_MEMREF_OUTPUT] = PARAM_MEMREF | PARAM_OUT,
+		[OPTEEM_ATTR_TYPE_MEMREF_INOUT]	 = PARAM_MEMREF | PARAM_IN |
+						   PARAM_OUT,
+	};
+	int idx = param->attr & OPTEEM_ATTR_TYPE_MASK;
+	u32 masked;
+
+	if (idx >= sizeof(attr_flags))
+		return false;
+
+	masked = attr_flags[idx] & flags;
+	return (masked & PARAM_ANY) && (masked & PARAM_INOUT);
+}
+
+static void optee_get_smc_version(struct optee_smc_param *param)
+{
+	param->a0 = OPTEE_SMC_CALLS_UID;
+	optee_smc(param);
+}
+
+static int optee_get_version(struct tee_context *ctx,
+			struct tee_ioctl_version_data __user *vers)
+{
+	struct optee_smc_param param;
+
+	optee_get_smc_version(&param);
+	/* The first 4 words in param are the UUID of protocol */
+	return copy_to_user(vers, &param, sizeof(*vers));
+}
+
+static int optee_open(struct tee_context *ctx)
+{
+	struct optee_context_data *ctxdata;
+
+	ctxdata = kzalloc(sizeof(*ctxdata), GFP_KERNEL);
+	if (!ctxdata)
+		return -ENOMEM;
+
+	mutex_init(&ctxdata->mutex);
+	INIT_LIST_HEAD(&ctxdata->sess_list);
+
+	ctx->data = ctxdata;
+	return 0;
+}
+
+static void optee_release(struct tee_context *ctx)
+{
+	struct optee_context_data *ctxdata = ctx->data;
+	struct tee_shm *shm;
+	struct opteem_arg *arg = NULL;
+	phys_addr_t parg;
+
+	if (!ctxdata)
+		return;
+
+	shm = tee_shm_alloc(ctx->teedev, sizeof(struct opteem_arg),
+			    TEE_SHM_MAPPED);
+	if (!IS_ERR(shm)) {
+		arg = tee_shm_get_va(shm, 0);
+		/*
+		 * If va2pa fails for some reason, we can't call
+		 * optee_close_session(), only free the memory. Secure OS
+		 * will leak sessions and finally refuse more session, but
+		 * we will at least let normal world reclaim its memory.
+		 */
+		if (!IS_ERR(arg))
+			tee_shm_va2pa(shm, arg, &parg);
+	}
+
+	while (true) {
+		struct optee_session *sess;
+
+		sess = list_first_entry_or_null(&ctxdata->sess_list,
+						struct optee_session,
+						list_node);
+		if (!sess)
+			break;
+		list_del(&sess->list_node);
+		if (!IS_ERR_OR_NULL(arg)) {
+			memset(arg, 0, sizeof(*arg));
+			arg->cmd = OPTEEM_CMD_CLOSE_SESSION;
+			arg->session = sess->session_id;
+			optee_do_call_with_arg(ctx, parg);
+		}
+		kfree(sess);
+	}
+	kfree(ctxdata);
+
+	if (!IS_ERR(shm))
+		tee_shm_free(shm);
+
+	ctx->data = NULL;
+}
+
+static int optee_cmd_raw_fastcall(u32 smc_id, struct opteem_cmd_prefix *arg,
+		size_t len)
+{
+	struct optee_smc_param param = { .a0 = smc_id };
+	u32 *data = (u32 *)(arg + 1);
+	size_t data_len = len - sizeof(*arg);
+
+	if (data_len < 4 * sizeof(u32))
+		return -EINVAL;
+
+	/* This is a fast-call no need to take a mutex */
+
+	optee_smc(&param);
+	data[0] = param.a0;
+	data[1] = param.a1;
+	data[2] = param.a2;
+	data[3] = param.a3;
+	return 0;
+}
+
+static int optee_cmd(struct tee_context *ctx, void __user *buf, size_t len)
+{
+	struct opteem_cmd_prefix *arg;
+	struct tee_shm *shm;
+	int ret;
+
+	if (len > OPTEE_MAX_ARG_SIZE || len < sizeof(*arg))
+		return -EINVAL;
+
+	shm = tee_shm_alloc(ctx->teedev, len, TEE_SHM_MAPPED);
+	if (IS_ERR(shm))
+		return PTR_ERR(shm);
+
+	arg = tee_shm_get_va(shm, 0);
+	if (IS_ERR(arg) || copy_from_user(arg, buf, len)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	switch (arg->func_id) {
+	case OPTEEM_FUNCID_CALLS_UID:
+		ret = optee_cmd_raw_fastcall(OPTEE_SMC_CALLS_UID, arg, len);
+		break;
+	case OPTEEM_FUNCID_GET_OS_UUID:
+		ret = optee_cmd_raw_fastcall(OPTEE_SMC_CALL_GET_OS_UUID,
+					     arg, len);
+		break;
+	case OPTEEM_FUNCID_CALLS_REVISION:
+		ret = optee_cmd_raw_fastcall(OPTEE_SMC_CALLS_REVISION,
+					     arg, len);
+		break;
+	case OPTEEM_FUNCID_GET_OS_REVISION:
+		ret = optee_cmd_raw_fastcall(OPTEE_SMC_CALL_GET_OS_REVISION,
+					     arg, len);
+		break;
+	case OPTEEM_FUNCID_CALL_WITH_ARG:
+		ret = optee_cmd_call_with_arg(ctx, shm, arg, buf, len);
+		goto out_from_call;
+	default:
+		ret = -EINVAL;
+		goto out;
+	}
+
+out:
+	if (!ret) {
+		if (copy_to_user(buf, arg, len))
+			ret = -EINVAL;
+	}
+out_from_call:
+	tee_shm_free(shm);
+	return ret;
+}
+
+static struct tee_driver_ops optee_ops = {
+	.get_version = optee_get_version,
+	.open = optee_open,
+	.release = optee_release,
+	.cmd = optee_cmd,
+};
+
+static struct tee_desc optee_desc = {
+	.name = DRIVER_NAME "-clnt",
+	.ops = &optee_ops,
+	.owner = THIS_MODULE,
+};
+
+static int optee_supp_req(struct tee_context *ctx, void __user *buf,
+			size_t len)
+{
+	struct opteem_cmd_prefix *arg;
+	struct tee_shm *shm;
+	int ret;
+
+	if (len > OPTEE_MAX_ARG_SIZE || len < sizeof(*arg))
+		return -EINVAL;
+
+	shm = tee_shm_alloc(ctx->teedev, len, TEE_SHM_MAPPED);
+	if (IS_ERR(shm)) {
+		ret = PTR_ERR(shm);
+		goto out;
+	}
+
+	arg = tee_shm_get_va(shm, 0);
+	if (IS_ERR(arg) || copy_from_user(arg, buf, len)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	switch (arg->func_id) {
+	case OPTEEM_FUNCID_CALLS_UID:
+		ret = optee_cmd_raw_fastcall(OPTEE_SMC_CALLS_UID, arg, len);
+		break;
+	case OPTEEM_FUNCID_GET_OS_UUID:
+		ret = optee_cmd_raw_fastcall(OPTEE_SMC_CALL_GET_OS_UUID,
+					     arg, len);
+		break;
+	case OPTEEM_FUNCID_CALLS_REVISION:
+		ret = optee_cmd_raw_fastcall(OPTEE_SMC_CALLS_REVISION,
+					     arg, len);
+		break;
+	case OPTEEM_FUNCID_GET_OS_REVISION:
+		ret = optee_cmd_raw_fastcall(OPTEE_SMC_CALL_GET_OS_REVISION,
+					     arg, len);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	if (ret)
+		goto out;
+
+	if (copy_to_user(buf, arg, len))
+		ret = -EINVAL;
+out:
+	if (!IS_ERR(shm))
+		tee_shm_free(shm);
+	return ret;
+}
+
+static int optee_supp_cmd(struct tee_context *ctx, void __user *buf,
+			size_t len)
+{
+	struct opteem_cmd_prefix arg;
+
+	if (len < sizeof(arg) || copy_from_user(&arg, buf, sizeof(arg)))
+		return -EINVAL;
+
+	switch (arg.func_id) {
+	case OPTEEM_FUNCID_SUPP_CMD_WRITE:
+		return optee_supp_write(ctx, buf + sizeof(arg),
+					len - sizeof(arg));
+	case OPTEEM_FUNCID_SUPP_CMD_READ:
+		return optee_supp_read(ctx, buf + sizeof(arg),
+				       len - sizeof(arg));
+	default:
+		return optee_supp_req(ctx, buf, len);
+	}
+}
+
+static struct tee_driver_ops optee_supp_ops = {
+	.get_version = optee_get_version,
+	.open = optee_open,
+	.release = optee_release,
+	.cmd = optee_supp_cmd,
+};
+
+static struct tee_desc optee_supp_desc = {
+	.name = DRIVER_NAME "-supp",
+	.ops = &optee_supp_ops,
+	.owner = THIS_MODULE,
+	.flags = TEE_DESC_PRIVILEGED,
+};
+
+static bool opteem_api_uid_is_optee_api(void)
+{
+	struct optee_smc_param param;
+
+	optee_get_smc_version(&param);
+
+	if (param.a0 == OPTEEM_UID_0 && param.a1 == OPTEEM_UID_1 &&
+	    param.a2 == OPTEEM_UID_2 && param.a3 == OPTEEM_UID_3)
+		return true;
+	return false;
+}
+
+static bool opteem_api_revision_is_compatible(void)
+{
+	struct optee_smc_param param = { .a0 = OPTEE_SMC_CALLS_REVISION };
+
+	optee_smc(&param);
+
+	if (param.a0 == OPTEEM_REVISION_MAJOR &&
+	    (int)param.a1 >= OPTEEM_REVISION_MINOR)
+		return true;
+	return false;
+}
+
+static struct tee_shm_pool *optee_config_shm_ioremap(struct device *dev,
+			void __iomem **ioremaped_shm)
+{
+	struct optee_smc_param param = { .a0 = OPTEE_SMC_GET_SHM_CONFIG };
+	struct tee_shm_pool *pool;
+	u_long vaddr;
+	phys_addr_t paddr;
+	size_t size;
+	phys_addr_t begin;
+	phys_addr_t end;
+	void __iomem *va;
+
+	optee_smc(&param);
+	if (param.a0 != OPTEE_SMC_RETURN_OK) {
+		dev_info(dev, "shm service not available\n");
+		return ERR_PTR(-ENOENT);
+	}
+
+	if (param.a3 != OPTEE_SMC_SHM_CACHED) {
+		dev_err(dev, "only normal cached shared memory supported\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	begin = roundup(param.a1, PAGE_SIZE);
+	end = rounddown(param.a1 + param.a2, PAGE_SIZE);
+	paddr = begin;
+	size = end - begin;
+
+	va = ioremap_cache(paddr, size);
+	if (!va) {
+		dev_err(dev, "shared memory ioremap failed\n");
+		return ERR_PTR(-EINVAL);
+	}
+	vaddr = (u_long)va;
+
+	pool = tee_shm_pool_alloc_res_mem(dev, vaddr, paddr, size);
+	if (IS_ERR(pool))
+		iounmap(va);
+	else
+		*ioremaped_shm = va;
+	return pool;
+}
+
+#ifdef CONFIG_OPTEE_USE_CMA
+static struct tee_shm_pool *optee_config_shm_cma(struct device *dev)
+{
+	struct optee_smc_param param = { .a0 = OPTEE_SMC_REGISTER_SHM };
+	u_long vaddr;
+	phys_addr_t paddr;
+	size_t size;
+	struct tee_shm_pool *pool;
+
+	pool = tee_shm_pool_alloc(dev, &vaddr, &paddr, &size);
+	if (IS_ERR(pool))
+		return pool;
+
+	reg_pair_from_64(&param.a1, &param.a2, paddr);
+	param.a3 = size;
+	param.a4 = OPTEE_SMC_SHM_CACHED;
+	optee_smc(&param);
+	if (param.a0 != OPTEE_SMC_RETURN_OK) {
+		dev_err(dev, "can't register shared memory\n");
+		tee_shm_pool_free(pool);
+		return ERR_PTR(-EINVAL);
+	}
+	return pool;
+}
+#else
+static struct tee_shm_pool *optee_config_shm_cma(struct device *dev)
+{
+	return ERR_PTR(-ENOENT);
+}
+#endif
+
+static int optee_probe(struct platform_device *pdev)
+{
+	struct tee_shm_pool *pool;
+	struct optee *optee = NULL;
+	void __iomem *ioremaped_shm = NULL;
+	int rc;
+
+	if (!opteem_api_uid_is_optee_api() ||
+	    !opteem_api_revision_is_compatible())
+		return -EINVAL;
+
+	pool = optee_config_shm_ioremap(&pdev->dev, &ioremaped_shm);
+	if (IS_ERR(pool))
+		pool = optee_config_shm_cma(&pdev->dev);
+	if (IS_ERR(pool))
+		return PTR_ERR(pool);
+
+	optee = devm_kzalloc(&pdev->dev, sizeof(*optee), GFP_KERNEL);
+	if (!optee) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	optee->dev = &pdev->dev;
+
+	optee->teedev = tee_device_alloc(&optee_desc, &pdev->dev, pool, optee);
+	if (IS_ERR(optee->teedev)) {
+		rc = PTR_ERR(optee->teedev);
+		goto err;
+	}
+
+	optee->supp_teedev = tee_device_alloc(&optee_supp_desc, &pdev->dev,
+					      pool, optee);
+	if (IS_ERR(optee->supp_teedev)) {
+		rc = PTR_ERR(optee->supp_teedev);
+		goto err;
+	}
+
+	rc = tee_device_register(optee->teedev);
+	if (rc)
+		goto err;
+
+	rc = tee_device_register(optee->supp_teedev);
+	if (rc)
+		goto err;
+
+	mutex_init(&optee->callsync.mutex);
+	init_completion(&optee->callsync.c);
+	optee->callsync.c_waiters = 0;
+	optee_mutex_wait_init(&optee->mutex_wait);
+	optee_supp_init(&optee->supp);
+	optee->ioremaped_shm = ioremaped_shm;
+	optee->pool = pool;
+
+	platform_set_drvdata(pdev, optee);
+
+	dev_info(&pdev->dev, "initialized driver\n");
+	return 0;
+err:
+	tee_device_unregister(optee->teedev);
+	tee_device_unregister(optee->supp_teedev);
+	if (pool)
+		tee_shm_pool_free(pool);
+	if (ioremaped_shm)
+		iounmap(optee->ioremaped_shm);
+	return rc;
+}
+
+static int optee_remove(struct platform_device *pdev)
+{
+	struct optee *optee = platform_get_drvdata(pdev);
+
+	tee_device_unregister(optee->teedev);
+	tee_device_unregister(optee->supp_teedev);
+	tee_shm_pool_free(optee->pool);
+	if (optee->ioremaped_shm)
+		iounmap(optee->ioremaped_shm);
+	optee_mutex_wait_uninit(&optee->mutex_wait);
+	optee_supp_uninit(&optee->supp);
+	mutex_destroy(&optee->callsync.mutex);
+	return 0;
+}
+
+static const struct of_device_id optee_match[] = {
+	{ .compatible = "optee,optee-tz" },
+	{},
+};
+
+static struct platform_driver optee_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.of_match_table = optee_match,
+	},
+	.probe = optee_probe,
+	.remove = optee_remove,
+};
+
+module_platform_driver(optee_driver);
+
+MODULE_AUTHOR("Linaro");
+MODULE_DESCRIPTION("OP-TEE driver");
+MODULE_SUPPORTED_DEVICE("");
+MODULE_VERSION("1.0");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
new file mode 100644
index 0000000..86505ca
--- /dev/null
+++ b/drivers/tee/optee/optee_private.h
@@ -0,0 +1,138 @@
+/*
+ * Copyright (c) 2015, Linaro Limited
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef OPTEE_PRIVATE_H
+#define OPTEE_PRIVATE_H
+
+#include <linux/types.h>
+#include <linux/semaphore.h>
+#include <linux/tee_drv.h>
+#include <linux/optee_msg.h>
+
+#define OPTEE_MAX_ARG_SIZE	1024
+
+/* Some Global Platform error codes used in this driver */
+#define TEEC_SUCCESS			0x00000000
+#define TEEC_ERROR_BAD_PARAMETERS	0xFFFF0006
+#define TEEC_ERROR_COMMUNICATION	0xFFFF000E
+#define TEEC_ERROR_OUT_OF_MEMORY	0xFFFF000C
+
+#define TEEC_ORIGIN_COMMS		0x00000002
+
+struct optee_call_sync {
+	struct mutex mutex;
+	struct completion c;
+	int c_waiters;
+};
+
+struct optee_mutex_wait {
+	struct mutex mu;
+	struct list_head db;
+};
+
+struct optee_supp {
+	bool supp_next_write;
+	size_t data_size;
+	const struct opteem_arg *data_to_supp;
+	struct opteem_arg *data_from_supp;
+	struct mutex thrd_mutex;
+	struct mutex supp_mutex;
+	struct semaphore data_to_supp_sem;
+	struct semaphore data_from_supp_sem;
+};
+
+struct optee {
+	struct tee_device *supp_teedev;
+	struct tee_device *teedev;
+	struct device *dev;
+	struct optee_call_sync callsync;
+	struct optee_mutex_wait mutex_wait;
+	struct optee_supp supp;
+	struct tee_shm_pool *pool;
+	void __iomem *ioremaped_shm;
+};
+
+struct optee_session {
+	struct list_head list_node;
+	u32 session_id;
+};
+
+struct optee_context_data {
+	struct mutex mutex;
+	struct list_head sess_list;
+};
+
+/* Note that 32bit arguments are passed also when running in 64bit */
+struct optee_smc_param {
+	u32 a0;
+	u32 a1;
+	u32 a2;
+	u32 a3;
+	u32 a4;
+	u32 a5;
+	u32 a6;
+	u32 a7;
+};
+
+void optee_smc(struct optee_smc_param *param);
+
+u32 optee_handle_rpc(struct tee_context *ctx, struct optee_smc_param *param);
+
+void optee_mutex_wait_init(struct optee_mutex_wait *muw);
+void optee_mutex_wait_uninit(struct optee_mutex_wait *muw);
+
+void optee_supp_thrd_req(struct tee_context *ctx, struct opteem_arg *arg);
+int optee_supp_read(struct tee_context *ctx, void __user *buf, size_t len);
+int optee_supp_write(struct tee_context *ctx, void __user *buf, size_t len);
+void optee_supp_init(struct optee_supp *supp);
+void optee_supp_uninit(struct optee_supp *supp);
+
+
+u32 optee_do_call_with_arg(struct tee_context *ctx, phys_addr_t parg);
+int optee_cmd_call_with_arg(struct tee_context *ctx, struct tee_shm *shm,
+			struct opteem_cmd_prefix *arg,
+			struct opteem_cmd_prefix __user *uarg, size_t len);
+
+/*
+ * Small helpers
+ */
+#define PARAM_VALUE	0x1
+#define PARAM_MEMREF	0x2
+#define PARAM_ANY	(PARAM_VALUE | PARAM_MEMREF)
+#define PARAM_IN	0x4
+#define PARAM_OUT	0x8
+#define PARAM_INOUT	(PARAM_IN | PARAM_OUT)
+
+/**
+ * optee_param_is() - report kind of opteem parameter
+ * @param:	the opteem parameter
+ * @flags:	which properties of the parameter to check
+ * @returns true if any of PARAM_VALUE PARAM_MEMREF is satified _and_
+ *	any of the PARAM_IN PARAM_OUT is satisfied
+ */
+bool optee_param_is(struct opteem_param *param, uint32_t flags);
+
+static inline void *reg_pair_to_ptr(u32 reg0, u32 reg1)
+{
+	return (void *)(u_long)(((u64)reg0 << 32) | reg1);
+}
+
+static inline void reg_pair_from_64(u32 *reg0, u32 *reg1, u64 val)
+{
+	*reg0 = val >> 32;
+	*reg1 = val;
+}
+
+
+#endif /*OPTEE_PRIVATE_H*/
diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
new file mode 100644
index 0000000..6254bcf
--- /dev/null
+++ b/drivers/tee/optee/optee_smc.h
@@ -0,0 +1,510 @@
+/*
+ * Copyright (c) 2015, Linaro Limited
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *
+ * 1. Redistributions of source code must retain the above copyright notice,
+ * this list of conditions and the following disclaimer.
+ *
+ * 2. Redistributions in binary form must reproduce the above copyright notice,
+ * this list of conditions and the following disclaimer in the documentation
+ * and/or other materials provided with the distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ */
+#ifndef OPTEE_SMC_H
+#define OPTEE_SMC_H
+
+/*
+ * This file is exported by OP-TEE and is in kept in sync between secure
+ * world and normal world kernel driver. We're following ARM SMC Calling
+ * Convention as specified in
+ * http://infocenter.arm.com/help/topic/com.arm.doc.den0028a/index.html
+ *
+ * This file depends on optee_msg.h being included to expand the SMC id
+ * macros below.
+ */
+
+#define OPTEE_SMC_32			0
+#define OPTEE_SMC_64			0x40000000
+#define OPTEE_SMC_FAST_CALL		0x80000000
+#define OPTEE_SMC_STD_CALL		0
+
+#define OPTEE_SMC_OWNER_MASK		0x3F
+#define OPTEE_SMC_OWNER_SHIFT		24
+
+#define OPTEE_SMC_FUNC_MASK		0xFFFF
+
+#define OPTEE_SMC_IS_FAST_CALL(smc_val)	((smc_val) & OPTEE_SMC_FAST_CALL)
+#define OPTEE_SMC_IS_64(smc_val)	((smc_val) & OPTEE_SMC_64)
+#define OPTEE_SMC_FUNC_NUM(smc_val)	((smc_val) & OPTEE_SMC_FUNC_MASK)
+#define OPTEE_SMC_OWNER_NUM(smc_val) \
+	(((smc_val) >> OPTEE_SMC_OWNER_SHIFT) & OPTEE_SMC_OWNER_MASK)
+
+#define OPTEE_SMC_CALL_VAL(type, calling_convention, owner, func_num) \
+			((type) | (calling_convention) | \
+			(((owner) & OPTEE_SMC_OWNER_MASK) << \
+				OPTEE_SMC_OWNER_SHIFT) |\
+			((func_num) & OPTEE_SMC_FUNC_MASK))
+
+#define OPTEE_SMC_STD_CALL_VAL(func_num) \
+	OPTEE_SMC_CALL_VAL(OPTEE_SMC_32, OPTEE_SMC_STD_CALL, \
+			   OPTEE_SMC_OWNER_TRUSTED_OS, (func_num))
+#define OPTEE_SMC_FAST_CALL_VAL(func_num) \
+	OPTEE_SMC_CALL_VAL(OPTEE_SMC_32, OPTEE_SMC_FAST_CALL, \
+			   OPTEE_SMC_OWNER_TRUSTED_OS, (func_num))
+
+#define OPTEE_SMC_OWNER_ARCH		0
+#define OPTEE_SMC_OWNER_CPU		1
+#define OPTEE_SMC_OWNER_SIP		2
+#define OPTEE_SMC_OWNER_OEM		3
+#define OPTEE_SMC_OWNER_STANDARD	4
+#define OPTEE_SMC_OWNER_TRUSTED_APP	48
+#define OPTEE_SMC_OWNER_TRUSTED_OS	50
+
+#define OPTEE_SMC_OWNER_TRUSTED_OS_OPTEED 62
+#define OPTEE_SMC_OWNER_TRUSTED_OS_API	63
+
+/*
+ * Function specified by SMC Calling convention.
+ */
+#define OPTEE_SMC_FUNCID_CALLS_COUNT	0xFF00
+#define OPTEE_SMC_CALLS_COUNT \
+	OPTEE_SMC_CALL_VAL(OPTEE_SMC_32, OPTEE_SMC_FAST_CALL, \
+			   OPTEE_SMC_OWNER_TRUSTED_OS_API, \
+			   OPTEE_SMC_FUNCID_CALLS_COUNT)
+
+
+/*
+ * Cache settings for shared memory
+ */
+#define OPTEE_SMC_SHM_NONCACHED		0ULL
+#define OPTEE_SMC_SHM_CACHED		1ULL
+
+/*
+ * a0..a7 is used as register names in the descriptions below, on arm32
+ * that translates to r0..r7 and on arm64 to w0..w7. In both cases it's
+ * 32-bit registers.
+ */
+
+/*
+ * Function specified by SMC Calling convention
+ *
+ * Return one of the following UIDs if using API specified in this file
+ * without further extentions:
+ * 65cb6b93-af0c-4617-8ed6-644a8d1140f8
+ * see also OPTEE_SMC_UID_* in optee_msg.h
+ */
+#define OPTEE_SMC_FUNCID_CALLS_UID OPTEEM_FUNCID_CALLS_UID
+#define OPTEE_SMC_CALLS_UID \
+	OPTEE_SMC_CALL_VAL(OPTEE_SMC_32, OPTEE_SMC_FAST_CALL, \
+			   OPTEE_SMC_OWNER_TRUSTED_OS_API, \
+			   OPTEE_SMC_FUNCID_CALLS_UID)
+
+/*
+ * Function specified by SMC Calling convention
+ *
+ * Returns 2.0 if using API specified in this file without further extentions.
+ * see also OPTEEM_REVISION_* in optee_msg.h
+ */
+#define OPTEE_SMC_FUNCID_CALLS_REVISION OPTEEM_FUNCID_CALLS_REVISION
+#define OPTEE_SMC_CALLS_REVISION \
+	OPTEE_SMC_CALL_VAL(OPTEE_SMC_32, OPTEE_SMC_FAST_CALL, \
+			   OPTEE_SMC_OWNER_TRUSTED_OS_API, \
+			   OPTEE_SMC_FUNCID_CALLS_REVISION)
+
+/*
+ * Get UUID of Trusted OS.
+ *
+ * Used by non-secure world to figure out which Trusted OS is installed.
+ * Note that returned UUID is the UUID of the Trusted OS, not of the API.
+ *
+ * Returns UUID in a0-4 in the same way as OPTEE_SMC_CALLS_UID
+ * described above.
+ */
+#define OPTEE_SMC_FUNCID_GET_OS_UUID OPTEEM_FUNCID_GET_OS_UUID
+#define OPTEE_SMC_CALL_GET_OS_UUID \
+	OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_GET_OS_UUID)
+
+/*
+ * Get revision of Trusted OS.
+ *
+ * Used by non-secure world to figure out which version of the Trusted OS
+ * is installed. Note that the returned revision is the revision of the
+ * Trusted OS, not of the API.
+ *
+ * Returns revision in a0-1 in the same way as OPTEE_SMC_CALLS_REVISION
+ * described above.
+ */
+#define OPTEE_SMC_FUNCID_GET_OS_REVISION OPTEEM_FUNCID_GET_OS_REVISION
+#define OPTEE_SMC_CALL_GET_OS_REVISION \
+	OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_GET_OS_REVISION)
+
+/*
+ * Call with struct opteem_arg as argument
+ *
+ * Call register usage:
+ * a0	SMC Function ID, OPTEE_SMC*CALL_WITH_ARG
+ * a1	Upper 32bit of a 64bit physical pointer to a struct opteem_arg
+ * a2	Lower 32bit of a 64bit physical pointer to a struct opteem_arg
+ * a3-6	Not used
+ * a7	Hypervisor Client ID register
+ *
+ * Normal return register usage:
+ * a0	Return value, OPTEE_SMC_RETURN_*
+ * a1-3	Not used
+ * a4-7	Preserved
+ *
+ * Ebusy return register usage:
+ * a0	Return value, OPTEE_SMC_RETURN_EBUSY
+ * a1-3	Preserved
+ * a4-7	Preserved
+ *
+ * RPC return register usage:
+ * a0	Return value, OPTEE_SMC_RETURN_IS_RPC(val)
+ * a1-2	RPC parameters
+ * a3-7	Resume information, must be preserved
+ *
+ * Possible return values:
+ * OPTEE_SMC_RETURN_UNKNOWN_FUNCTION	Trusted OS does not recognize this
+ *					function.
+ * OPTEE_SMC_RETURN_OK			Call completed, result updated in
+ *					the previously supplied struct
+ *					opteem_arg.
+ * OPTEE_SMC_RETURN_EBUSY		Trusted OS busy, try again later.
+ * OPTEE_SMC_RETURN_EBADADDR		Bad physcial pointer to struct
+ *					opteem_arg.
+ * OPTEE_SMC_RETURN_EBADCMD		Bad/unknown cmd in struct opteem_arg
+ * OPTEE_SMC_RETURN_IS_RPC()		Call suspended by RPC call to normal
+ *					world.
+ */
+#define OPTEE_SMC_FUNCID_CALL_WITH_ARG OPTEEM_FUNCID_CALL_WITH_ARG
+#define OPTEE_SMC_CALL_WITH_ARG \
+	OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_WITH_ARG)
+/* Same as OPTEE_SMC_CALL_WITH_ARG but a "fast call". */
+#define OPTEE_SMC_FASTCALL_WITH_ARG \
+	OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_CALL_WITH_ARG)
+
+/*
+ * Register a secure/non-secure shared memory region
+ *
+ * Call register usage:
+ * a0	SMC Function ID, OPTEE_SMC*_REGISTER_SHM
+ * a1	Upper 32bits of 64bit physical address of start of SHM
+ * a2	Lower 32bits of 64bit physical address of start of SHM
+ * a3	Size of SHM
+ * a4	Cache settings of memory, as defined by the
+ *	OPTEE_SMC_SHM_* values above
+ * a5-6	Not used
+ * a7	Hypervisor Client ID register
+ *
+ * Normal return register usage:
+ * a0	OPTEE_SMC_RETURN_OK if OK
+ *	OPTEE_SMC_RETURN_EBUSY can't obtain access to register SHM
+ *	OPTEE_SMC_RETURN_ENOMEM not enough memory to register SHM
+ *	OPTEE_SMC_RETURN_EBADADDR bad parameters
+ *	OPTEE_SMC_RETURN_EBADCMD call not available
+ * a1-2	Not used
+ * a3-7	Preserved
+ */
+#define OPTEE_SMC_FUNCID_REGISTER_SHM	5
+#define OPTEE_SMC_REGISTER_SHM \
+	OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_REGISTER_SHM)
+
+/*
+ * Unregister a secure/non-secure shared memory region
+ *
+ * Call register usage:
+ * a0	SMC Function ID, OPTEE_SMC*_*UNREGISTER_SHM
+ * a1	Upper 32bits of 64bit physical address of start of SHM
+ * a2	Lower 32bits of 64bit physical address of start of SHM
+ * a3	Size of SHM
+ * a3-6	Not used
+ * a7	Hypervisor Client ID register
+ *
+ * Normal return register usage:
+ * a00	OPTEE_SMC_RETURN_OK if OK
+ *	OPTEE_SMC_RETURN_EBUSY can't obtain access to register SHM
+ *	OPTEE_SMC_RETURN_ENOMEM not enough memory to register SHM
+ *	OPTEE_SMC_RETURN_EBADCMD call not available
+ * a1-3	Not used
+ * a4-7	Preserved
+ */
+#define OPTEE_SMC_FUNCID_UNREGISTER_SHM	6
+#define OPTEE_SMC_UNREGISTER_SHM \
+	OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_UNREGISTER_SHM)
+
+/*
+ * Get Shared Memory Config
+ *
+ * Returns the Secure/Non-secure shared memory config.
+ *
+ * Call register usage:
+ * a0	SMC Function ID, OPTEE_SMC_GET_SHM_CONFIG
+ * a1-6	Not used
+ * a7	Hypervisor Client ID register
+ *
+ * Have config return register usage:
+ * a0	OPTEE_SMC_RETURN_OK
+ * a1	Physical address of start of SHM
+ * a2	Size of of SHM
+ * a3	Cache settings of memory, as defined by the
+ *	OPTEE_SMC_SHM_* values above
+ * a4-7	Preserved
+ *
+ * Not available register usage:
+ * a0	OPTEE_SMC_RETURN_NOTAVAIL
+ * a1-3 Not used
+ * a4-7	Preserved
+ */
+#define OPTEE_SMC_FUNCID_GET_SHM_CONFIG	7
+#define OPTEE_SMC_GET_SHM_CONFIG \
+	OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_GET_SHM_CONFIG)
+
+/*
+ * Configures L2CC mutex
+ *
+ * Disables, enables usage of L2CC mutex. Returns or sets physical address
+ * of L2CC mutex.
+ *
+ * Call register usage:
+ * a0	SMC Function ID, OPTEE_SMC_L2CC_MUTEX
+ * a1	OPTEE_SMC_L2CC_MUTEX_GET_ADDR	Get physical address of mutex
+ *	OPTEE_SMC_L2CC_MUTEX_SET_ADDR	Set physical address of mutex
+ *	OPTEE_SMC_L2CC_MUTEX_ENABLE	Enable usage of mutex
+ *	OPTEE_SMC_L2CC_MUTEX_DISABLE	Disable usage of mutex
+ * a2	if a1 == OPTEE_SMC_L2CC_MUTEX_SET_ADDR, physical address of mutex
+ * a3-6	Not used
+ * a7	Hypervisor Client ID register
+ *
+ * Have config return register usage:
+ * a0	OPTEE_SMC_RETURN_OK
+ * a1	Preserved
+ * a2	if a1 == OPTEE_SMC_L2CC_MUTEX_GET_ADDR, physical address of L2CC mutex
+ * a3-7	Preserved
+ *
+ * Error return register usage:
+ * a0	OPTEE_SMC_RETURN_NOTAVAIL	Physical address not available
+ *	OPTEE_SMC_RETURN_EBADADDR	Bad supplied physical address
+ *	OPTEE_SMC_RETURN_EBADCMD	Unsupported value in a1
+ * a1-7	Preserved
+ */
+#define OPTEE_SMC_L2CC_MUTEX_GET_ADDR	0
+#define OPTEE_SMC_L2CC_MUTEX_SET_ADDR	1
+#define OPTEE_SMC_L2CC_MUTEX_ENABLE	2
+#define OPTEE_SMC_L2CC_MUTEX_DISABLE	3
+#define OPTEE_SMC_FUNCID_L2CC_MUTEX	8
+#define OPTEE_SMC_L2CC_MUTEX \
+	OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_L2CC_MUTEX)
+
+/*
+ * Resume from RPC (for example after processing an IRQ)
+ *
+ * Call register usage:
+ * a0	SMC Function ID, OPTEE_SMC_CALL_RETURN_FROM_RPC
+ * a1-3	Value of a1-3 when OPTEE_SMC_CALL_WITH_ARG returned
+ *	OPTEE_SMC_RETURN_RPC in a0
+ *
+ * Return register usage is the same as for OPTEE_SMC_*CALL_WITH_ARG above.
+ *
+ * Possible return values
+ * OPTEE_SMC_RETURN_UNKNOWN_FUNCTION	Trusted OS does not recognize this
+ *					function.
+ * OPTEE_SMC_RETURN_OK			Original call completed, result
+ *					updated in the previously supplied.
+ *					struct opteem_arg
+ * OPTEE_SMC_RETURN_RPC			Call suspended by RPC call to normal
+ *					world.
+ * OPTEE_SMC_RETURN_EBUSY		Trusted OS busy, try again later.
+ * OPTEE_SMC_RETURN_ERESUME		Resume failed, the opaque resume
+ *					information was corrupt.
+ */
+#define OPTEE_SMC_FUNCID_RETURN_FROM_RPC	3
+#define OPTEE_SMC_CALL_RETURN_FROM_RPC \
+	OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_RETURN_FROM_RPC)
+
+#define OPTEE_SMC_RETURN_RPC_PREFIX_MASK	0xFFFF0000
+#define OPTEE_SMC_RETURN_RPC_PREFIX		0xFFFF0000
+#define OPTEE_SMC_RETURN_RPC_FUNC_MASK		0x0000FFFF
+
+#define OPTEE_SMC_RETURN_GET_RPC_FUNC(ret) \
+	((ret) & OPTEE_SMC_RETURN_RPC_FUNC_MASK)
+
+#define OPTEE_SMC_RPC_VAL(func)		((func) | OPTEE_SMC_RETURN_RPC_PREFIX)
+
+/*
+ * Allocate argument memory for RPC parameter passing.
+ * Argument memory is used to hold a struct opteem_arg.
+ *
+ * "Call" register usage:
+ * a0	This value, OPTEE_SMC_RETURN_RPC_ALLOC_ARG
+ * a1	Size in bytes of required argument memory
+ * a2	Not used
+ * a3	Resume information, must be preserved
+ * a4-5	Not used
+ * a6-7	Resume information, must be preserved
+ *
+ * "Return" register usage:
+ * a0	SMC Function ID, OPTEE_SMC_CALL_RETURN_FROM_RPC.
+ * a1	Upper 32bits of 64bit physical pointer to allocated argument
+ *	memory, (a1 == 0 && a2 == 0) if size was 0 or if memory can't
+ *	be allocated.
+ * a2	Lower 32bits of 64bit physical pointer to allocated argument
+ *	memory, (a1 == 0 && a2 == 0) if size was 0 or if memory can't
+ *	be allocated
+ * a3	Preserved
+ * a4	Upper 32bits of 64bit Shared memory cookie used when freeing
+ *	the memory or doing an RPC
+ * a5	Lower 32bits of 64bit Shared memory cookie used when freeing
+ *	the memory or doing an RPC
+ * a6-7	Preserved
+ */
+#define OPTEE_SMC_RPC_FUNC_ALLOC_ARG	0
+#define OPTEE_SMC_RETURN_RPC_ALLOC_ARG \
+	OPTEE_SMC_RPC_VAL(OPTEE_SMC_RPC_FUNC_ALLOC_ARG)
+
+/*
+ * Allocate payload memory for RPC parameter passing.
+ * Payload memory is used to hold the memory referred to by struct
+ * opteem_param_memref.
+ *
+ * "Call" register usage:
+ * a0	This value, OPTEE_SMC_RETURN_RPC_ALLOC_PAYLOAD
+ * a1	Size in bytes of required argument memory
+ * a2	Not used
+ * a3	Resume information, must be preserved
+ * a4-5	Not used
+ * a6-7	Resume information, must be preserved
+ *
+ * "Return" register usage:
+ * a0	SMC Function ID, OPTEE_SMC_CALL_RETURN_FROM_RPC.
+ * a1	Upper 32bits of 64bit physical pointer to allocated argument
+ *	memory, (a1 == 0 && a2 == 0) if size was 0 or if memory can't
+ *	be allocated
+ * a2	Lower 32bits of 64bit physical pointer to allocated argument
+ *	memory, (a1 == 0 && a2 == 0) if size was 0 or if memory can't
+ *	be allocated
+ * a3	Preserved
+ * a4	Upper 32bits of 64bit Shared memory cookie used when freeing
+ *	the memory
+ * a5	Lower 32bits of 64bit Shared memory cookie used when freeing
+ *	the memory
+ * a6-7	Preserved
+ */
+#define OPTEE_SMC_RPC_FUNC_ALLOC_PAYLOAD	1
+#define OPTEE_SMC_RETURN_RPC_ALLOC_PAYLOAD \
+	OPTEE_SMC_RPC_VAL(OPTEE_SMC_RPC_FUNC_ALLOC_PAYLOAD)
+
+/*
+ * Free memory previously allocated by OPTEE_SMC_RETURN_RPC_ALLOC_ARG.
+ *
+ * "Call" register usage:
+ * a0	This value, OPTEE_SMC_RETURN_RPC_FREE_ARG
+ * a1	Upper 32bits of 64bit shared memory cookie belonging to this
+ *	argument memory
+ * a2	Lower 32bits of 64bit shared memory cookie belonging to this
+ *	argument memory
+ * a3-7	Resume information, must be preserved
+ *
+ * "Return" register usage:
+ * a0	SMC Function ID, OPTEE_SMC_CALL_RETURN_FROM_RPC.
+ * a1-2	Not used
+ * a3-7	Preserved
+ */
+#define OPTEE_SMC_RPC_FUNC_FREE_ARG	2
+#define OPTEE_SMC_RETURN_RPC_FREE_ARG \
+	OPTEE_SMC_RPC_VAL(OPTEE_SMC_RPC_FUNC_FREE_ARG)
+
+/*
+ * Free memory previously allocated by OPTEE_SMC_RETURN_RPC_ALLOC_PAYLOAD.
+ *
+ * "Call" register usage:
+ * a0	This value, OPTEE_SMC_RETURN_RPC_FREE_PAYLOAD
+ * a1	Upper 32bit of 64bit shared memory cookie belonging to this
+ *	payload memory
+ * a2	Lower 32bit of 64bit shared memory cookie belonging to this
+ *	payload memory
+ * a3-7	Resume information, must be preserved
+ *
+ * "Return" register usage:
+ * a0	SMC Function ID, OPTEE_SMC_CALL_RETURN_FROM_RPC.
+ * a1-2	Not used
+ * a3-7	Preserved
+ */
+#define OPTEE_SMC_RPC_FUNC_FREE_PAYLOAD	3
+#define OPTEE_SMC_RETURN_RPC_FREE_PAYLOAD \
+	OPTEE_SMC_RPC_VAL(OPTEE_SMC_RPC_FUNC_FREE_PAYLOAD)
+
+/*
+ * Deliver an IRQ in normal world.
+ *
+ * "Call" register usage:
+ * a0	OPTEE_SMC_RETURN_RPC_IRQ
+ * a1-7	Resume information, must be preserved
+ *
+ * "Return" register usage:
+ * a0	SMC Function ID, OPTEE_SMC_CALL_RETURN_FROM_RPC.
+ * a1-7	Preserved
+ */
+#define OPTEE_SMC_RPC_FUNC_IRQ		4
+#define OPTEE_SMC_RETURN_RPC_IRQ \
+	OPTEE_SMC_RPC_VAL(OPTEE_SMC_RPC_FUNC_IRQ)
+
+/*
+ * Do an RPC request. The supplied struct opteem_arg tells which
+ * request to do and the parameters for the request. The following fields
+ * are used (the rest are unused):
+ * - cmd		the Request ID
+ * - ret		return value of the request, filled in by normal world
+ * - num_params		number of parameters for the request
+ * - params		the parameters
+ * - param_attrs	attributes of the parameters
+ *
+ * "Call" register usage:
+ * a0	OPTEE_SMC_RETURN_RPC_CMD
+ * a1	Upper 32bit of a 64bit Shared memory cookie holding a
+ *	struct opteem_arg, must be preserved, only the data should
+ *	be updated
+ * a2	Lower 32bit of a 64bit Shared memory cookie holding a
+ *	struct opteem_arg, must be preserved, only the data should
+ *	be updated
+ * a3-7	Resume information, must be preserved
+ *
+ * "Return" register usage:
+ * a0	SMC Function ID, OPTEE_SMC_CALL_RETURN_FROM_RPC.
+ * a1-2	Not used
+ * a3-7	Preserved
+ */
+#define OPTEE_SMC_RPC_FUNC_CMD		5
+#define OPTEE_SMC_RETURN_RPC_CMD \
+	OPTEE_SMC_RPC_VAL(OPTEE_SMC_RPC_FUNC_CMD)
+
+/* Returned in a0 */
+#define OPTEE_SMC_RETURN_UNKNOWN_FUNCTION 0xFFFFFFFF
+
+/* Returned in a0 only from Trusted OS functions */
+#define OPTEE_SMC_RETURN_OK		0x0
+#define OPTEE_SMC_RETURN_EBUSY		0x1
+#define OPTEE_SMC_RETURN_ERESUME	0x2
+#define OPTEE_SMC_RETURN_EBADADDR	0x3
+#define OPTEE_SMC_RETURN_EBADCMD	0x4
+#define OPTEE_SMC_RETURN_ENOMEM		0x5
+#define OPTEE_SMC_RETURN_NOTAVAIL	0x6
+#define OPTEE_SMC_RETURN_IS_RPC(ret) \
+	(((ret) != OPTEE_SMC_RETURN_UNKNOWN_FUNCTION) && \
+	((((ret) & OPTEE_SMC_RETURN_RPC_PREFIX_MASK) == \
+		OPTEE_SMC_RETURN_RPC_PREFIX)))
+
+#endif /* OPTEE_SMC_H */
diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
new file mode 100644
index 0000000..640af3d
--- /dev/null
+++ b/drivers/tee/optee/rpc.c
@@ -0,0 +1,282 @@
+/*
+ * Copyright (c) 2015, Linaro Limited
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/tee_drv.h>
+#include "optee_private.h"
+#include "optee_smc.h"
+
+struct optee_mutex_wait_entry {
+	struct list_head link;
+	struct completion comp;
+	struct mutex mu;
+	u32 wait_after;
+	u32 key;
+};
+
+/*
+ * Compares two serial numbers using Serial Number Arithmetic
+ * (https://www.ietf.org/rfc/rfc1982.txt).
+ */
+#define TICK_GT(t1, t2) \
+	(((t1) < (t2) && (t2) - (t1) > 0xFFFFFFFFu) || \
+	((t1) > (t2) && (t1) - (t2) < 0xFFFFFFFFu))
+
+static struct optee_mutex_wait_entry *muw_find_entry(
+			struct optee_mutex_wait *muw, u32 key)
+{
+	struct optee_mutex_wait_entry *w;
+
+	mutex_lock(&muw->mu);
+
+	list_for_each_entry(w, &muw->db, link)
+		if (w->key == key)
+			goto out;
+
+	w = kmalloc(sizeof(struct optee_mutex_wait), GFP_KERNEL);
+	if (!w)
+		goto out;
+
+	init_completion(&w->comp);
+	mutex_init(&w->mu);
+	w->wait_after = 0;
+	w->key = key;
+	list_add_tail(&w->link, &muw->db);
+out:
+	mutex_unlock(&muw->mu);
+	return w;
+}
+
+static void muw_delete_entry(struct optee_mutex_wait_entry *w)
+{
+	list_del(&w->link);
+	mutex_destroy(&w->mu);
+	kfree(w);
+}
+
+static void muw_delete(struct optee_mutex_wait *muw, u32 key)
+{
+	struct optee_mutex_wait_entry *w;
+
+	mutex_lock(&muw->mu);
+
+	list_for_each_entry(w, &muw->db, link) {
+		if (w->key == key) {
+			muw_delete_entry(w);
+			break;
+		}
+	}
+
+	mutex_unlock(&muw->mu);
+}
+
+static void muw_wakeup(struct optee_mutex_wait *muw, u32 key,
+			u32 wait_after)
+{
+	struct optee_mutex_wait_entry *w = muw_find_entry(muw, key);
+
+	if (!w)
+		return;
+
+	mutex_lock(&w->mu);
+	w->wait_after = wait_after;
+	mutex_unlock(&w->mu);
+	complete(&w->comp);
+}
+
+static void muw_sleep(struct optee_mutex_wait *muw, u32 key, u32 wait_tick)
+{
+	struct optee_mutex_wait_entry *w = muw_find_entry(muw, key);
+	u32 wait_after;
+
+	if (!w)
+		return;
+
+	mutex_lock(&w->mu);
+	wait_after = w->wait_after;
+	mutex_unlock(&w->mu);
+
+	/*
+	 * Only wait if the wait_tick is larger than wait_after, that is
+	 * the mutex_wait hasn't been updated while this function was about
+	 * to be called.
+	 */
+	if (TICK_GT(wait_tick, wait_after))
+		wait_for_completion_timeout(&w->comp, HZ);
+}
+
+void optee_mutex_wait_init(struct optee_mutex_wait *muw)
+{
+	mutex_init(&muw->mu);
+	INIT_LIST_HEAD(&muw->db);
+}
+
+void optee_mutex_wait_uninit(struct optee_mutex_wait *muw)
+{
+	/*
+	 * It's the callers responsibility to ensure that no one is using
+	 * anything inside muw.
+	 */
+
+	mutex_destroy(&muw->mu);
+	while (!list_empty(&muw->db)) {
+		struct optee_mutex_wait_entry *w;
+
+		w = list_first_entry(&muw->db, struct optee_mutex_wait_entry,
+				     link);
+		muw_delete_entry(w);
+	}
+}
+
+static void handle_rpc_func_cmd_mutex_wait(struct optee *optee,
+			struct opteem_arg *arg)
+{
+	struct opteem_param *params;
+
+	if (arg->num_params != OPTEEM_RPC_NUM_PARAMS)
+		goto bad;
+
+	params = OPTEEM_GET_PARAMS(arg);
+
+	if ((params[0].attr & OPTEEM_ATTR_TYPE_MASK) !=
+			OPTEEM_ATTR_TYPE_VALUE_INPUT)
+		goto bad;
+	if (params[1].attr != OPTEEM_ATTR_TYPE_NONE)
+		goto bad;
+
+	switch (arg->func) {
+	case OPTEEM_RPC_SLEEP_MUTEX_WAIT:
+		muw_sleep(&optee->mutex_wait, params[0].u.value.a,
+			  params[0].u.value.b);
+		break;
+	case OPTEEM_RPC_SLEEP_MUTEX_WAKEUP:
+		muw_wakeup(&optee->mutex_wait, params[0].u.value.a,
+			   params[0].u.value.b);
+		break;
+	case OPTEEM_RPC_SLEEP_MUTEX_DELETE:
+		muw_delete(&optee->mutex_wait, params[0].u.value.a);
+		break;
+	default:
+		goto bad;
+	}
+
+	arg->ret = TEEC_SUCCESS;
+	return;
+bad:
+	arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+}
+
+static void handle_rpc_func_cmd_wait(struct opteem_arg *arg)
+{
+	struct opteem_param *params;
+	u32 msec_to_wait;
+
+	if (arg->num_params != OPTEEM_RPC_NUM_PARAMS)
+		goto bad;
+
+	params = OPTEEM_GET_PARAMS(arg);
+	if (params[0].attr != OPTEEM_ATTR_TYPE_VALUE_INPUT)
+		goto bad;
+
+	msec_to_wait = params[0].u.value.a;
+
+	/* set task's state to interruptible sleep */
+	set_current_state(TASK_INTERRUPTIBLE);
+
+	/* take a nap */
+	schedule_timeout(msecs_to_jiffies(msec_to_wait));
+
+	arg->ret = TEEC_SUCCESS;
+	return;
+bad:
+	arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+}
+
+static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
+			struct tee_shm *shm)
+{
+	struct opteem_arg *arg;
+
+	arg = tee_shm_get_va(shm, 0);
+	if (IS_ERR(arg)) {
+		dev_err(optee->dev, "%s: tee_shm_get_va %p failed\n",
+			__func__, shm);
+		return;
+	}
+
+	switch (arg->cmd) {
+	case OPTEEM_RPC_CMD_SLEEP_MUTEX:
+		handle_rpc_func_cmd_mutex_wait(optee, arg);
+		break;
+	case OPTEEM_RPC_CMD_SUSPEND:
+		handle_rpc_func_cmd_wait(arg);
+		break;
+	default:
+		optee_supp_thrd_req(ctx, arg);
+	}
+}
+
+u32 optee_handle_rpc(struct tee_context *ctx, struct optee_smc_param *param)
+{
+	struct tee_device *teedev = ctx->teedev;
+	struct optee *optee = tee_get_drvdata(teedev);
+	struct tee_shm *shm;
+	phys_addr_t pa;
+
+	switch (OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0)) {
+	case OPTEE_SMC_RPC_FUNC_ALLOC_ARG:
+		shm = tee_shm_alloc(teedev, param->a1, TEE_SHM_MAPPED);
+		if (!IS_ERR(shm) && !tee_shm_get_pa(shm, 0, &pa)) {
+			reg_pair_from_64(&param->a1, &param->a2, pa);
+			reg_pair_from_64(&param->a4, &param->a5, (u_long)shm);
+		} else {
+			param->a1 = 0;
+			param->a2 = 0;
+			param->a4 = 0;
+			param->a5 = 0;
+		}
+		break;
+	case OPTEE_SMC_RPC_FUNC_ALLOC_PAYLOAD:
+		shm = tee_shm_alloc(teedev, param->a1,
+				    TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+		if (!IS_ERR(shm) && !tee_shm_get_pa(shm, 0, &pa)) {
+			reg_pair_from_64(&param->a1, &param->a2, pa);
+			reg_pair_from_64(&param->a4, &param->a5, (u_long)shm);
+		} else {
+			param->a1 = 0;
+			param->a2 = 0;
+			param->a4 = 0;
+			param->a5 = 0;
+		}
+		break;
+	case OPTEE_SMC_RPC_FUNC_FREE_ARG:
+	case OPTEE_SMC_RPC_FUNC_FREE_PAYLOAD:
+		shm = reg_pair_to_ptr(param->a1, param->a2);
+		tee_shm_free(shm);
+		break;
+	case OPTEE_SMC_RPC_FUNC_IRQ:
+		break;
+	case OPTEE_SMC_RPC_FUNC_CMD:
+		shm = reg_pair_to_ptr(param->a1, param->a2);
+		handle_rpc_func_cmd(ctx, optee, shm);
+		break;
+	default:
+		dev_warn(optee->dev, "Unknown RPC func 0x%x\n",
+			 (u32)OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0));
+		break;
+	}
+
+	return OPTEE_SMC_CALL_RETURN_FROM_RPC;
+}
diff --git a/drivers/tee/optee/smc_a32.S b/drivers/tee/optee/smc_a32.S
new file mode 100644
index 0000000..30fe0e5
--- /dev/null
+++ b/drivers/tee/optee/smc_a32.S
@@ -0,0 +1,30 @@
+/*
+ * Copyright (c) 2015, Linaro Limited
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <linux/linkage.h>
+
+	.text
+	.balign 4
+	.code 32
+
+	/* void optee_smc(struct optee_smc_param *param); */
+	.globl	optee_smc
+ENTRY(optee_smc)
+	push	{r4-r8, lr}
+	mov	r8, r0
+	ldm	r8, {r0-r7}
+.arch_extension sec
+	smc	#0
+	stm	r8, {r0-r7}
+	pop	{r4-r8, pc}
+ENDPROC(optee_smc)
diff --git a/drivers/tee/optee/smc_a64.S b/drivers/tee/optee/smc_a64.S
new file mode 100644
index 0000000..458a138
--- /dev/null
+++ b/drivers/tee/optee/smc_a64.S
@@ -0,0 +1,37 @@
+/*
+ * Copyright (c) 2015, Linaro Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License Version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <linux/linkage.h>
+
+	.text
+
+#define SMC_PARAM_W0_OFFS	0
+#define SMC_PARAM_W2_OFFS	8
+#define SMC_PARAM_W4_OFFS	16
+#define SMC_PARAM_W6_OFFS	24
+
+	/* void optee_smc(struct smc_param *param); */
+	.globl	optee_smc
+ENTRY(optee_smc)
+	stp	x28, x30, [sp, #-16]!
+	mov	x28, x0
+	ldp	w0, w1, [x28, #SMC_PARAM_W0_OFFS]
+	ldp	w2, w3, [x28, #SMC_PARAM_W2_OFFS]
+	ldp	w4, w5, [x28, #SMC_PARAM_W4_OFFS]
+	ldp	w6, w7, [x28, #SMC_PARAM_W6_OFFS]
+	smc	#0
+	stp	w0, w1, [x28, #SMC_PARAM_W0_OFFS]
+	stp	w2, w3, [x28, #SMC_PARAM_W2_OFFS]
+	ldp	x28, x30, [sp], #16
+	ret
+ENDPROC(optee_smc)
diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
new file mode 100644
index 0000000..97c0a9a
--- /dev/null
+++ b/drivers/tee/optee/supp.c
@@ -0,0 +1,327 @@
+/*
+ * Copyright (c) 2015, Linaro Limited
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include "optee_private.h"
+
+void optee_supp_init(struct optee_supp *supp)
+{
+	memset(supp, 0, sizeof(*supp));
+	mutex_init(&supp->thrd_mutex);
+	mutex_init(&supp->supp_mutex);
+	sema_init(&supp->data_to_supp_sem, 0);
+	sema_init(&supp->data_from_supp_sem, 0);
+}
+
+void optee_supp_uninit(struct optee_supp *supp)
+{
+	mutex_destroy(&supp->thrd_mutex);
+	mutex_destroy(&supp->supp_mutex);
+}
+
+static void optee_supp_send(struct optee *optee,
+			const struct opteem_arg *arg,
+			struct opteem_arg *resp)
+{
+	struct optee_supp *supp = &optee->supp;
+
+	/*
+	 * Other threads blocks here until we've copied our answer from
+	 * supplicant.
+	 */
+	mutex_lock(&supp->thrd_mutex);
+
+	/*
+	 * We have exclusive access to data_to_supp and data_from_supp
+	 * since the supplicant is at this point either trying to down()
+	 * data_to_supp_sem or still in userspace about to do the ioctl()
+	 * to enter optee_supp_read() below.
+	 */
+
+	supp->data_to_supp = arg;
+	supp->data_from_supp = resp;
+
+	/* Let supplicant get the data */
+	up(&supp->data_to_supp_sem);
+
+	/*
+	 * Wait for supplicant to process and return result, once we've
+	 * down()'ed data_from_supp_sem we have exclusive access again.
+	 */
+	down(&supp->data_from_supp_sem);
+
+	/* We're done, let someone else talk to the supplicant now. */
+	mutex_unlock(&supp->thrd_mutex);
+}
+
+static void copy_back_outdata(struct opteem_arg *arg,
+			const struct opteem_arg *resp)
+{
+	struct opteem_param *arg_params = OPTEEM_GET_PARAMS(arg);
+	struct opteem_param *resp_params = OPTEEM_GET_PARAMS(resp);
+	size_t n;
+
+	/* Copy back out and inout parameters */
+	for (n = 0; n < arg->num_params; n++) {
+		struct opteem_param *ap = arg_params + n;
+
+		if (optee_param_is(ap, PARAM_VALUE | PARAM_OUT))
+			ap->u.value = resp_params[n].u.value;
+		else if (optee_param_is(ap, PARAM_MEMREF | PARAM_OUT))
+			ap->u.memref.size = resp_params[n].u.memref.size;
+	}
+	arg->ret = resp->ret;
+
+}
+
+void optee_supp_thrd_req(struct tee_context *ctx, struct opteem_arg *arg)
+{
+	struct optee *optee = tee_get_drvdata(ctx->teedev);
+	const size_t s = OPTEEM_GET_ARG_SIZE(OPTEEM_RPC_NUM_PARAMS);
+	struct opteem_arg *resp;
+
+	if (arg->num_params != OPTEEM_RPC_NUM_PARAMS) {
+		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+		return;
+	}
+
+	resp = kzalloc(s, GFP_KERNEL);
+	if (!resp) {
+		arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
+		return;
+	}
+
+	optee_supp_send(optee, arg, resp);
+	copy_back_outdata(arg, resp);
+
+	kfree(resp);
+}
+
+static u32 memref_to_user(struct tee_shm *shm,
+			struct opteem_param_memref *ph_mem,
+			struct opteem_param_memref *user_mem, int *fd)
+{
+	int res;
+	phys_addr_t pa;
+
+	if (!shm) {
+		*fd = -1;
+		return TEEC_SUCCESS;
+	}
+
+	res = tee_shm_get_pa(shm, 0, &pa);
+	if (res)
+		return TEEC_ERROR_BAD_PARAMETERS;
+
+	if (pa > ph_mem->buf_ptr)
+		return TEEC_ERROR_BAD_PARAMETERS;
+
+	user_mem->buf_ptr = ph_mem->buf_ptr - pa;
+	res = tee_shm_get_fd(shm);
+	if (res < 0)
+		return TEEC_ERROR_OUT_OF_MEMORY;
+
+	*fd = res;
+	return TEEC_SUCCESS;
+}
+
+static int optee_supp_copy_to_user(void __user *buf,
+			const struct opteem_arg *arg, struct opteem_arg *tmp)
+{
+	size_t s = OPTEEM_GET_ARG_SIZE(OPTEEM_RPC_NUM_PARAMS);
+	struct opteem_param *arg_params;
+	struct opteem_param *tmp_params;
+	size_t n;
+	int ret;
+
+	memcpy(tmp, arg, s);
+	arg_params = OPTEEM_GET_PARAMS(arg);
+	tmp_params = OPTEEM_GET_PARAMS(tmp);
+
+	for (n = 0; n < arg->num_params; n++) {
+		if (optee_param_is(arg_params + n, PARAM_MEMREF | PARAM_INOUT))
+			tmp_params[n].u.memref.shm_ref = -1;
+	}
+
+	for (n = 0; n < arg->num_params; n++) {
+		if (optee_param_is(arg_params + n,
+				   PARAM_MEMREF | PARAM_INOUT)) {
+			int fd = -1;
+			struct tee_shm *shm;
+			uint32_t res;
+			struct opteem_param_memref *memref;
+
+			memref = &arg_params[n].u.memref;
+			shm = (struct tee_shm *)(uintptr_t)memref->shm_ref;
+			res = memref_to_user(shm, memref,
+					     &tmp_params[n].u.memref, &fd);
+			/* Propagate kind of error to requesting thread. */
+			if (res != TEEC_SUCCESS) {
+				tmp->ret = res;
+				if (res == TEEC_ERROR_OUT_OF_MEMORY) {
+					/*
+					 * For out of memory it could help
+					 * if tee-supplicant was restarted,
+					 * maybe it leaks something.
+					 */
+					ret = -ENOMEM;
+					goto err;
+				}
+				/* Let supplicant grab next request. */
+				ret = -EAGAIN;
+			}
+			tmp_params[n].u.memref.shm_ref = fd;
+		}
+	}
+
+	if (copy_to_user(buf, tmp, s)) {
+		/* Something is wrong, let supplicant restart and try again */
+		ret = -EINVAL;
+		goto err;
+	}
+	return 0;
+err:
+	for (n = 0; n < arg->num_params; n++) {
+		int fd;
+
+		if (!optee_param_is(arg_params + n, PARAM_MEMREF | PARAM_INOUT))
+			continue;
+		fd = tmp_params[n].u.memref.shm_ref;
+		if (fd >= 0)
+			tee_shm_put_fd(fd);
+	}
+	return ret;
+}
+
+int optee_supp_read(struct tee_context *ctx, void __user *buf, size_t len)
+{
+	struct tee_device *teedev = ctx->teedev;
+	struct optee *optee = tee_get_drvdata(teedev);
+	struct optee_supp *supp = &optee->supp;
+	const size_t s = OPTEEM_GET_ARG_SIZE(OPTEEM_RPC_NUM_PARAMS);
+	int ret;
+
+	if (len != s)
+		return -EINVAL;
+
+	/*
+	 * In case two supplicants or two threads in one supplicant is
+	 * calling this function simultaneously we need to protect the
+	 * data with a mutex which we'll release before returning.
+	 */
+	mutex_lock(&supp->supp_mutex);
+	while (true) {
+		if (supp->supp_next_write) {
+			/*
+			 * optee_supp_read() has been called again without
+			 * a optee_supp_write() in between. Supplicant has
+			 * probably been restarted before it was able to
+			 * write back last result. Abort last request and
+			 * wait for a new.
+			 */
+			if (supp->data_to_supp) {
+				memcpy(supp->data_from_supp,
+				       supp->data_to_supp, s);
+				supp->data_from_supp->ret =
+					TEEC_ERROR_COMMUNICATION;
+				supp->data_to_supp = NULL;
+				supp->supp_next_write = false;
+				up(&supp->data_from_supp_sem);
+			}
+		}
+
+		/*
+		 * This is where supplicant will be hanging most of the
+		 * time, let's make this interruptable so we can easily
+		 * restart supplicant if needed.
+		 */
+		if (down_interruptible(&supp->data_to_supp_sem)) {
+			ret = -ERESTARTSYS;
+			goto out;
+		}
+
+		/* We have exlusive access to the data */
+		ret = optee_supp_copy_to_user(buf, supp->data_to_supp,
+					      supp->data_from_supp);
+		if (!ret)
+			break;
+		supp->data_to_supp = NULL;
+		up(&supp->data_from_supp_sem);
+		if (ret != -EAGAIN)
+			goto out;
+	}
+
+	/* We've consumed the data, set it to NULL */
+	supp->data_to_supp = NULL;
+
+	/* Allow optee_supp_write() below to do its work */
+	supp->supp_next_write = true;
+
+	ret = 0;
+out:
+	mutex_unlock(&supp->supp_mutex);
+	return ret;
+}
+
+int optee_supp_write(struct tee_context *ctx, void __user *buf, size_t len)
+{
+	struct tee_device *teedev = ctx->teedev;
+	struct optee *optee = tee_get_drvdata(teedev);
+	struct optee_supp *supp = &optee->supp;
+	const size_t s = OPTEEM_GET_ARG_SIZE(OPTEEM_RPC_NUM_PARAMS);
+	int ret = 0;
+
+	if (len != s)
+		return -EINVAL;
+
+	/*
+	 * We still have exclusive access to the data since that's how we
+	 * left it when returning from optee_supp_read().
+	 */
+
+	/* See comment on mutex in optee_supp_read() above */
+	mutex_lock(&supp->supp_mutex);
+
+	if (!supp->supp_next_write) {
+		/*
+		 * Something strange is going on, supplicant shouldn't
+		 * enter optee_supp_write() in this state
+		 */
+		ret = -ENOENT;
+		goto out;
+	}
+
+	if (copy_from_user(supp->data_from_supp, buf, s)) {
+		/*
+		 * Something is wrong, let supplicant restart. Next call to
+		 * optee_supp_read() will give an error to the requesting
+		 * thread and release it.
+		 */
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Data has been populated, set the pointer to NULL */
+	supp->data_from_supp = NULL;
+
+	/* Allow optee_supp_read() above to do its work */
+	supp->supp_next_write = false;
+
+	/* Let the requesting thread continue */
+	up(&supp->data_from_supp_sem);
+out:
+	mutex_unlock(&supp->supp_mutex);
+	return ret;
+}
diff --git a/include/uapi/linux/optee_msg.h b/include/uapi/linux/optee_msg.h
new file mode 100644
index 0000000..338d862
--- /dev/null
+++ b/include/uapi/linux/optee_msg.h
@@ -0,0 +1,368 @@
+/*
+ * Copyright (c) 2015, Linaro Limited
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *
+ * 1. Redistributions of source code must retain the above copyright notice,
+ * this list of conditions and the following disclaimer.
+ *
+ * 2. Redistributions in binary form must reproduce the above copyright notice,
+ * this list of conditions and the following disclaimer in the documentation
+ * and/or other materials provided with the distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ */
+#ifndef OPTEE_MSG_H
+#define OPTEE_MSG_H
+
+#include <linux/types.h>
+
+/*
+ * This file is exported by OP-TEE and is kept in sync between secure
+ * world, normal world kernel driver, and user space client lib.
+ *
+ * This file is divided into three sections.
+ * 1. Formatting of messages.
+ * 2. Requests from normal world
+ * 3. Requests from secure world, Remote Procedure Call (RPC)
+ */
+
+/*****************************************************************************
+ * Part 1 - formatting of messages
+ *****************************************************************************/
+
+/*
+ * Same values as TEE_PARAM_* from TEE Internal API
+ */
+#define OPTEEM_ATTR_TYPE_NONE		0
+#define OPTEEM_ATTR_TYPE_VALUE_INPUT	1
+#define OPTEEM_ATTR_TYPE_VALUE_OUTPUT	2
+#define OPTEEM_ATTR_TYPE_VALUE_INOUT	3
+#define OPTEEM_ATTR_TYPE_MEMREF_INPUT	5
+#define OPTEEM_ATTR_TYPE_MEMREF_OUTPUT	6
+#define OPTEEM_ATTR_TYPE_MEMREF_INOUT	7
+
+#define OPTEEM_ATTR_TYPE_MASK		0x7
+
+/*
+ * Meta parameter to be absorbed by the Secure OS and not passed
+ * to the Trusted Application.
+ *
+ * Currently only used for struct opteem_meta_open_session which
+ * is added to OPTEEM_CMD_OPEN_SESSION.
+ */
+#define OPTEEM_ATTR_META		0x8
+
+
+/**
+ * struct opteem_param_memref - memory reference
+ * @buf_ptr:	Address of the buffer
+ * @size:	Size of the buffer
+ * @shm_ref:	Shared memory reference only used by normal world
+ *
+ * Secure and normal world communicates pointers as physical address
+ * instead of the virtual address. This is because secure and normal world
+ * have completely independent memory mapping. Normal world can even have a
+ * hypervisor which need to translate the guest physical address (AKA IPA
+ * in ARM documentation) to a real physical address before passing the
+ * structure to secure world.
+ */
+struct opteem_param_memref {
+	__u64 buf_ptr;
+	__u64 size;
+	__u64 shm_ref;
+};
+
+/**
+ * struct opteem_param_value - values
+ * @a: first value
+ * @b: second value
+ * @c: third value
+ */
+struct opteem_param_value {
+	__u64 a;
+	__u64 b;
+	__u64 c;
+};
+
+/**
+ * struct opteem_param - parameter
+ * @attr: attributes
+ * @memref: a memory reference
+ * @value: a value
+ *
+ * @attr & OPTEEM_ATTR_TYPE_MASK indicates if memref or value is used in
+ * the union. OPTEEM_ATTR_TYPE_VALUE_* indicates value and
+ * OPTEEM_ATTR_TYPE_MEMREF_* indicates memref. OPTEEM_ATTR_TYPE_NONE
+ * indicates that none of the members are used.
+ */
+struct opteem_param {
+	__u64 attr;
+	union {
+		struct opteem_param_memref memref;
+		struct opteem_param_value value;
+	} u;
+};
+
+/**
+ * struct opteem_arg - call argument
+ * @cmd: Command, one of OPTEEM_CMD_* or OPTEEM_RPC_CMD_*
+ * @func: Trusted Application function, specific to the Trusted Application,
+ *	     used if cmd == OPTEEM_CMD_INVOKE_COMMAND
+ * @session: In parameter for all OPTEEM_CMD_* except
+ *	     OPTEEM_CMD_OPEN_SESSION where it's an output parameter instead
+ * @ret: return value
+ * @ret_origin: origin of the return value
+ * @num_params: number of parameters supplied to the OS Command
+ * @params: the parameters supplied to the OS Command
+ *
+ * All normal calls to Trusted OS uses this struct. If cmd requires further
+ * information than what these field holds it can be passed as a parameter
+ * tagged as meta (setting the OPTEEM_ATTR_META bit in corresponding
+ * param_attrs). All parameters tagged as meta has to come first.
+ */
+struct opteem_arg {
+	__u32 cmd;
+	__u32 func;
+	__u32 session;
+	__u32 ret;
+	__u32 ret_origin;
+	__u32 num_params __aligned(8);
+
+	/*
+	 * num_params is 8 byte aligned since the 'struct opteem_param'
+	 * which follows requires 8 byte alignment.
+	 *
+	 * Commented out element used to visualize the layout dynamic part
+	 * of the struct. This field is not available at all if
+	 * num_params == 0.
+	 *
+	 * params is accessed through the macro OPTEEM_GET_PARAMS
+	 *
+	 * struct opteem_param params[num_params];
+	 */
+};
+
+/**
+ * OPTEEM_GET_PARAMS - return pointer to struct opteem_param *
+ *
+ * @x: Pointer to a struct opteem_arg
+ *
+ * Returns a pointer to the params[] inside a struct opteem_arg.
+ */
+#define OPTEEM_GET_PARAMS(x) \
+	(struct opteem_param *)(((struct opteem_arg *)(x)) + 1)
+
+/**
+ * OPTEEM_GET_ARG_SIZE - return size of struct opteem_arg
+ *
+ * @num_params: Number of parameters embedded in the struct opteem_arg
+ *
+ * Returns the size of the struct opteem_arg together with the number
+ * of embedded parameters.
+ */
+#define OPTEEM_GET_ARG_SIZE(num_params) \
+	(sizeof(struct opteem_arg) + \
+	 sizeof(struct opteem_param) * (num_params))
+
+/* Length in bytes of a UUID */
+#define OPTEEM_UUID_LEN	16
+
+/**
+ * struct opteem_meta_open_session - additional parameters for
+ *				     OPTEEM_CMD_OPEN_SESSION
+ * @uuid: UUID of the Trusted Application
+ * @clnt_uuid: UUID of client
+ * @clnt_login: Login class of client, TEE_LOGIN_* if being Global Platform
+ *		compliant
+ *
+ * This struct is passed in the first parameter as an input memref tagged
+ * as meta on an OPTEEM_CMD_OPEN_SESSION cmd.
+ */
+struct opteem_meta_open_session {
+	__u8 uuid[OPTEEM_UUID_LEN];
+	__u8 clnt_uuid[OPTEEM_UUID_LEN];
+	__u32 clnt_login;
+};
+
+/**
+ * struct optee_cmd_prefix - initial header for all user space buffers
+ * @func_id:	Function Id OPTEEM_FUNCID_* below
+ * @pad:	padding to make the struct size a multiple of 8 bytes
+ *
+ * This struct is 8 byte aligned since it's always followed by a struct
+ * opteem_arg which requires 8 byte alignment.
+ */
+struct opteem_cmd_prefix {
+	__u32 func_id;
+	__u32 pad __aligned(8);
+};
+
+/*****************************************************************************
+ * Part 2 - requests from normal world
+ *****************************************************************************/
+
+/*
+ * Return the following UID if using API specified in this file without
+ * further extentions:
+ * 384fb3e0-e7f8-11e3-af63-0002a5d5c51b.
+ * Represented in 4 32-bit words in OPTEEM_UID_0, OPTEEM_UID_1,
+ * OPTEEM_UID_2, OPTEEM_UID_3.
+ */
+#define OPTEEM_UID_0		0x384fb3e0
+#define OPTEEM_UID_1		0xe7f811e3
+#define OPTEEM_UID_2		0xaf630002
+#define OPTEEM_UID_3		0xa5d5c51b
+#define OPTEEM_FUNCID_CALLS_UID	0xFF01
+
+/*
+ * Returns 2.0 if using API specified in this file without further extentions.
+ * Represented in 2 32-bit words in OPTEEM_REVISION_MAJOR and
+ * OPTEEM_REVISION_MINOR
+ */
+#define OPTEEM_REVISION_MAJOR	2
+#define OPTEEM_REVISION_MINOR	0
+#define OPTEEM_FUNCID_CALLS_REVISION	0xFF03
+
+/*
+ * Get UUID of Trusted OS.
+ *
+ * Used by non-secure world to figure out which Trusted OS is installed.
+ * Note that returned UUID is the UUID of the Trusted OS, not of the API.
+ *
+ * Returns UUID in 4 32-bit words in the same way as OPTEEM_FUNCID_CALLS_UID
+ * described above.
+ */
+#define OPTEEM_OS_OPTEE_UUID_0		0x486178e0
+#define OPTEEM_OS_OPTEE_UUID_1		0xe7f811e3
+#define OPTEEM_OS_OPTEE_UUID_2		0xbc5e0002
+#define OPTEEM_OS_OPTEE_UUID_3		0xa5d5c51b
+#define OPTEEM_FUNCID_GET_OS_UUID	0x0000
+
+/*
+ * Get revision of Trusted OS.
+ *
+ * Used by non-secure world to figure out which version of the Trusted OS
+ * is installed. Note that the returned revision is the revision of the
+ * Trusted OS, not of the API.
+ *
+ * Returns revision in 2 32-bit words in the same way as OPTEEM_CALLS_REVISION
+ * described above.
+ */
+#define OPTEEM_OS_OPTEE_REVISION_MAJOR	1
+#define OPTEEM_OS_OPTEE_REVISION_MINOR	0
+#define OPTEEM_FUNCID_GET_OS_REVISION	0x0001
+
+/*
+ * Do a secure call with struct opteem_arg as argument
+ * The OPTEEM_CMD_* below defines what goes in struct opteem_arg::cmd
+ *
+ * For OPTEEM_CMD_OPEN_SESSION the first parameter is tagged as meta, holding
+ * a memref with a struct opteem_meta_open_session which is needed find the
+ * Trusted Application and to indicate the credentials of the client.
+ *
+ * For OPTEEM_CMD_INVOKE_COMMAND struct opteem_arg::func is Trusted
+ * Application function, specific to the Trusted Application.
+ */
+#define OPTEEM_CMD_OPEN_SESSION		0
+#define OPTEEM_CMD_INVOKE_COMMAND	1
+#define OPTEEM_CMD_CLOSE_SESSION	2
+#define OPTEEM_CMD_CANCEL		3
+#define OPTEEM_FUNCID_CALL_WITH_ARG	0x0004
+
+/*
+ * Do a write response from tee-supplicant with struct opteem_arg as argument
+ */
+#define OPTEEM_FUNCID_SUPP_CMD_WRITE	0x1000
+
+/*
+ * Do a read request from tee-supplicant with struct opteem_arg as argument
+ */
+#define OPTEEM_FUNCID_SUPP_CMD_READ	0x1001
+
+/*****************************************************************************
+ * Part 3 - Requests from secure world, RPC
+ *****************************************************************************/
+
+/*
+ * All RPC is done with a struct opteem_arg as bearer of information,
+ * struct opteem_arg::arg holds values defined by OPTEEM_RPC_CMD_* below
+ */
+
+/*
+ * Number of parameters used in RPC communication, always this number but
+ * for some commands a parameter may be set to unused.
+ */
+#define OPTEEM_RPC_NUM_PARAMS 2
+
+/*
+ * Load a TA into memory
+ * [in] param[0]	memref holding a uuid (OPTEEM_UUID_LEN bytes) of the
+ *			TA to load
+ * [out] param[1]	memref allocated to hold the TA content. memref.buf
+ *			may be == NULL to query the size of the TA content.
+ *			memref.size is always updated with the actual size
+ *			of the TA content. If returned memref.size is larger
+ *			than the supplied memref.size, not content is loaded.
+ * [out] arg.ret	return value of request, 0 on success.
+ */
+#define OPTEEM_RPC_CMD_LOAD_TA		0
+
+/*
+ * Reserved
+ */
+#define OPTEEM_RPC_CMD_RPMB		1
+
+/*
+ * File system access, defined in tee-supplicant
+ */
+#define OPTEEM_RPC_CMD_FS		2
+
+/*
+ * Get time, defined in tee-supplicant
+ */
+#define OPTEEM_RPC_CMD_GET_TIME		3
+
+/*
+ * Sleep mutex, helper for secure world to implement a sleeping mutex.
+ * struct opteem_arg::func	one of OPTEEM_RPC_SLEEP_MUTEX_* below
+ *
+ * OPTEEM_RPC_SLEEP_MUTEX_WAIT
+ * [in] param[0].value	.a sleep mutex key
+ *			.b wait tick
+ * [not used] param[1]
+ *
+ * OPTEEM_RPC_SLEEP_MUTEX_WAKEUP
+ * [in] param[0].value	.a sleep mutex key
+ *			.b wait after
+ * [not used] param[1]
+ *
+ * OPTEEM_RPC_SLEEP_MUTEX_DELETE
+ * [in] param[0].value	.a sleep mutex key
+ * [not used] param[1]
+ */
+#define OPTEEM_RPC_SLEEP_MUTEX_WAIT	0
+#define OPTEEM_RPC_SLEEP_MUTEX_WAKEUP	1
+#define OPTEEM_RPC_SLEEP_MUTEX_DELETE	2
+#define OPTEEM_RPC_CMD_SLEEP_MUTEX	4
+
+/*
+ * Suspend execution
+ *
+ * [in] param[0].value	.a number of milliseconds to suspend
+ */
+#define OPTEEM_RPC_CMD_SUSPEND		5
+
+#endif /* OPTEE_MSG_H */
-- 
1.9.1

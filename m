From: volodymyr_babchuk@epam.com (Volodymyr Babchuk)
Date: Thu, 28 Sep 2017 21:04:06 +0300
Subject: [PATCH v1 09/14] tee: optee: add registered buffers handling into RPC
 calls
In-Reply-To: <1506621851-6929-1-git-send-email-volodymyr_babchuk@epam.com>
References: <1506621851-6929-1-git-send-email-volodymyr_babchuk@epam.com>
Message-ID: <1506621851-6929-10-git-send-email-volodymyr_babchuk@epam.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Volodymyr Babchuk <vlad.babchuk@gmail.com>

With latest changes to OP-TEE we can use any buffers as a shared memory.
Thus, it is possible for supplicant to provide part of own memory
when OP-TEE asks to allocate a shared buffer.

This patch adds support for such feature into RPC handling code.
Now when OP-TEE asks supplicant to allocate shared buffer, supplicant
can use TEE_IOC_SHM_REGISTER to provide such buffer. RPC handler is
aware of this, so it will pass list of allocated pages to OP-TEE.

Signed-off-by: Volodymyr Babchuk <vlad.babchuk@gmail.com>
---
 drivers/tee/optee/call.c          | 19 ++++++++++-
 drivers/tee/optee/core.c          |  2 ++
 drivers/tee/optee/optee_private.h | 15 +++++++-
 drivers/tee/optee/rpc.c           | 72 ++++++++++++++++++++++++++++++++++-----
 4 files changed, 97 insertions(+), 11 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index ec53dca..7702991 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -136,6 +136,7 @@ u32 optee_do_call_with_arg(struct tee_context *ctx, phys_addr_t parg)
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
 	struct optee_call_waiter w;
 	struct optee_rpc_param param = { };
+	struct optee_call_ctx call_ctx = { };
 	u32 ret;
 
 	param.a0 = OPTEE_SMC_CALL_WITH_ARG;
@@ -160,13 +161,14 @@ u32 optee_do_call_with_arg(struct tee_context *ctx, phys_addr_t parg)
 			param.a1 = res.a1;
 			param.a2 = res.a2;
 			param.a3 = res.a3;
-			optee_handle_rpc(ctx, &param);
+			optee_handle_rpc(ctx, &param, &call_ctx);
 		} else {
 			ret = res.a0;
 			break;
 		}
 	}
 
+	optee_rpc_finalize_call(&call_ctx);
 	/*
 	 * We're done with our thread in secure world, if there's any
 	 * thread waiters wake up one.
@@ -554,3 +556,18 @@ int optee_shm_unregister(struct tee_context *ctx, struct tee_shm *shm)
 	tee_shm_free(shm_arg);
 	return rc;
 }
+
+int optee_shm_register_supp(struct tee_context *ctx, struct tee_shm *shm,
+			    struct page **pages, size_t num_pages)
+{
+	/*
+	 * We don't want to register supplicant memory in OP-TEE.
+	 * Instead information about it will be passed in RPC code.
+	 */
+	return 0;
+}
+
+int optee_shm_unregister_supp(struct tee_context *ctx, struct tee_shm *shm)
+{
+	return 0;
+}
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index a962f60..9883592 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -339,6 +339,8 @@ static const struct tee_driver_ops optee_supp_ops = {
 	.release = optee_release,
 	.supp_recv = optee_supp_recv,
 	.supp_send = optee_supp_send,
+	.shm_register = optee_shm_register_supp,
+	.shm_unregister = optee_shm_unregister_supp,
 };
 
 static const struct tee_desc optee_supp_desc = {
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 3ea7f7a..dfe1158 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -130,7 +130,16 @@ struct optee_rpc_param {
 	u32	a7;
 };
 
-void optee_handle_rpc(struct tee_context *ctx, struct optee_rpc_param *param);
+/* Holds context that is preserved during one STD call */
+struct optee_call_ctx {
+	/* information about page array used in last allocation */
+	void *pages_array;
+	size_t num_entries;
+};
+
+void optee_handle_rpc(struct tee_context *ctx, struct optee_rpc_param *param,
+		      struct optee_call_ctx *call_ctx);
+void optee_rpc_finalize_call(struct optee_call_ctx *call_ctx);
 
 void optee_wait_queue_init(struct optee_wait_queue *wq);
 void optee_wait_queue_exit(struct optee_wait_queue *wq);
@@ -164,6 +173,10 @@ int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
 		       struct page **pages, size_t num_pages);
 int optee_shm_unregister(struct tee_context *ctx, struct tee_shm *shm);
 
+int optee_shm_register_supp(struct tee_context *ctx, struct tee_shm *shm,
+			    struct page **pages, size_t num_pages);
+int optee_shm_unregister_supp(struct tee_context *ctx, struct tee_shm *shm);
+
 int optee_from_msg_param(struct tee_param *params, size_t num_params,
 			 const struct optee_msg_param *msg_params);
 int optee_to_msg_param(struct optee_msg_param *msg_params, size_t num_params,
diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
index cef417f..1ff86bd 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -200,7 +200,8 @@ static struct tee_shm *cmd_alloc_suppl(struct tee_context *ctx, size_t sz)
 }
 
 static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
-					  struct optee_msg_arg *arg)
+					  struct optee_msg_arg *arg,
+					  struct optee_call_ctx *call_ctx)
 {
 	phys_addr_t pa;
 	struct tee_shm *shm;
@@ -245,10 +246,44 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
 		goto bad;
 	}
 
-	arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT;
-	arg->params[0].u.tmem.buf_ptr = pa;
-	arg->params[0].u.tmem.size = sz;
-	arg->params[0].u.tmem.shm_ref = (unsigned long)shm;
+	sz = tee_shm_get_size(shm);
+
+	if (tee_shm_is_registered(shm)) {
+		struct page **pages;
+		u64 *pages_array;
+		size_t page_num;
+
+		pages = tee_shm_get_pages(shm, &page_num);
+		if (!pages || !page_num) {
+			arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
+			goto bad;
+		}
+
+		pages_array = optee_allocate_pages_array(page_num);
+		if (!pages_array) {
+			arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
+			goto bad;
+		}
+
+		call_ctx->pages_array = pages_array;
+		call_ctx->num_entries = page_num;
+
+		arg->params[0].attr =  OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT |
+				       OPTEE_MSG_ATTR_NONCONTIG;
+		arg->params[0].u.tmem.buf_ptr = virt_to_phys(pages_array) +
+						tee_shm_get_page_offset(shm);
+
+		arg->params[0].u.tmem.size = tee_shm_get_size(shm);
+		arg->params[0].u.tmem.shm_ref = (unsigned long)shm;
+
+		optee_fill_pages_list(pages_array, pages, page_num);
+	} else {
+		arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT;
+		arg->params[0].u.tmem.buf_ptr = pa;
+		arg->params[0].u.tmem.size = sz;
+		arg->params[0].u.tmem.shm_ref = (unsigned long)shm;
+	}
+
 	arg->ret = TEEC_SUCCESS;
 	return;
 bad:
@@ -307,8 +342,24 @@ static void handle_rpc_func_cmd_shm_free(struct tee_context *ctx,
 	arg->ret = TEEC_SUCCESS;
 }
 
+static void free_page_array(struct optee_call_ctx *call_ctx)
+{
+	if (call_ctx->pages_array) {
+		optee_free_pages_array(call_ctx->pages_array,
+				       call_ctx->num_entries);
+		call_ctx->pages_array = NULL;
+		call_ctx->num_entries = 0;
+	}
+}
+
+void optee_rpc_finalize_call(struct optee_call_ctx *call_ctx)
+{
+	free_page_array(call_ctx);
+}
+
 static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
-				struct tee_shm *shm)
+				struct tee_shm *shm,
+				struct optee_call_ctx *call_ctx)
 {
 	struct optee_msg_arg *arg;
 
@@ -329,7 +380,8 @@ static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
 		handle_rpc_func_cmd_wait(arg);
 		break;
 	case OPTEE_MSG_RPC_CMD_SHM_ALLOC:
-		handle_rpc_func_cmd_shm_alloc(ctx, arg);
+		free_page_array(call_ctx);
+		handle_rpc_func_cmd_shm_alloc(ctx, arg, call_ctx);
 		break;
 	case OPTEE_MSG_RPC_CMD_SHM_FREE:
 		handle_rpc_func_cmd_shm_free(ctx, arg);
@@ -343,10 +395,12 @@ static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
  * optee_handle_rpc() - handle RPC from secure world
  * @ctx:	context doing the RPC
  * @param:	value of registers for the RPC
+ * @call_ctx:	call context. Preserved during one OP-TEE invocation
  *
  * Result of RPC is written back into @param.
  */
-void optee_handle_rpc(struct tee_context *ctx, struct optee_rpc_param *param)
+void optee_handle_rpc(struct tee_context *ctx, struct optee_rpc_param *param,
+		      struct optee_call_ctx *call_ctx)
 {
 	struct tee_device *teedev = ctx->teedev;
 	struct optee *optee = tee_get_drvdata(teedev);
@@ -381,7 +435,7 @@ void optee_handle_rpc(struct tee_context *ctx, struct optee_rpc_param *param)
 		break;
 	case OPTEE_SMC_RPC_FUNC_CMD:
 		shm = reg_pair_to_ptr(param->a1, param->a2);
-		handle_rpc_func_cmd(ctx, optee, shm);
+		handle_rpc_func_cmd(ctx, optee, shm, call_ctx);
 		break;
 	default:
 		pr_warn("Unknown RPC func 0x%x\n",
-- 
2.7.4

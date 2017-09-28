From: volodymyr_babchuk@epam.com (Volodymyr Babchuk)
Date: Thu, 28 Sep 2017 21:04:04 +0300
Subject: [PATCH v1 07/14] tee: optee: add shared buffer registration functions
In-Reply-To: <1506621851-6929-1-git-send-email-volodymyr_babchuk@epam.com>
References: <1506621851-6929-1-git-send-email-volodymyr_babchuk@epam.com>
Message-ID: <1506621851-6929-8-git-send-email-volodymyr_babchuk@epam.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Volodymyr Babchuk <vlad.babchuk@gmail.com>

This change adds ops for shm_(un)register functions in tee interface.
Client application can use these functions to (un)register an own shared
buffer in OP-TEE address space. This allows zero copy data sharing between
Normal and Secure Worlds.

Please note that while those functions were added to optee code,
it does not report to userspace that those functions are available.
OP-TEE code does not set TEE_GEN_CAP_REG_MEM flag. This flag will be
enabled only after all other features of dynamic shared memory will be
implemented in subsequent patches.

Signed-off-by: Volodymyr Babchuk <vlad.babchuk@gmail.com>
---
 drivers/tee/optee/call.c          | 64 +++++++++++++++++++++++++++++++++++++++
 drivers/tee/optee/core.c          |  2 ++
 drivers/tee/optee/optee_private.h |  4 +++
 3 files changed, 70 insertions(+)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index f8e044d..ec53dca 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -490,3 +490,67 @@ void optee_free_pages_array(void *array, size_t num_entries)
 	free_pages_exact(array, get_pages_array_size(num_entries));
 }
 
+int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
+		       struct page **pages, size_t num_pages)
+{
+	struct tee_shm *shm_arg = NULL;
+	struct optee_msg_arg *msg_arg;
+	u64 *pages_array;
+	phys_addr_t msg_parg;
+	int rc = 0;
+
+	if (!num_pages)
+		return -EINVAL;
+
+	pages_array = optee_allocate_pages_array(num_pages);
+	if (!pages_array)
+		return -ENOMEM;
+
+	shm_arg = get_msg_arg(ctx, 1, &msg_arg, &msg_parg);
+	if (IS_ERR(shm_arg)) {
+		rc = PTR_ERR(shm_arg);
+		goto out;
+	}
+
+	optee_fill_pages_list(pages_array, pages, num_pages);
+
+	msg_arg->cmd = OPTEE_MSG_CMD_REGISTER_SHM;
+	msg_arg->params->attr = OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT |
+				OPTEE_MSG_ATTR_NONCONTIG;
+	msg_arg->params->u.tmem.shm_ref = (unsigned long)shm;
+	msg_arg->params->u.tmem.size = tee_shm_get_size(shm);
+	msg_arg->params->u.tmem.buf_ptr = virt_to_phys(pages_array) |
+					  tee_shm_get_page_offset(shm);
+
+	if (optee_do_call_with_arg(ctx, msg_parg) ||
+	    msg_arg->ret != TEEC_SUCCESS)
+		rc = -EINVAL;
+
+	tee_shm_free(shm_arg);
+out:
+	optee_free_pages_array(pages_array, num_pages);
+	return rc;
+}
+
+int optee_shm_unregister(struct tee_context *ctx, struct tee_shm *shm)
+{
+	struct tee_shm *shm_arg;
+	struct optee_msg_arg *msg_arg;
+	phys_addr_t msg_parg;
+	int rc = 0;
+
+	shm_arg = get_msg_arg(ctx, 1, &msg_arg, &msg_parg);
+	if (IS_ERR(shm_arg))
+		return PTR_ERR(shm_arg);
+
+	msg_arg->cmd = OPTEE_MSG_CMD_UNREGISTER_SHM;
+
+	msg_arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
+	msg_arg->params[0].u.rmem.shm_ref = (unsigned long)shm;
+
+	if (optee_do_call_with_arg(ctx, msg_parg) ||
+	    msg_arg->ret != TEEC_SUCCESS)
+		rc = -EINVAL;
+	tee_shm_free(shm_arg);
+	return rc;
+}
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 7952357..4d448bf 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -267,6 +267,8 @@ static const struct tee_driver_ops optee_ops = {
 	.close_session = optee_close_session,
 	.invoke_func = optee_invoke_func,
 	.cancel_req = optee_cancel_req,
+	.shm_register = optee_shm_register,
+	.shm_unregister = optee_shm_unregister,
 };
 
 static const struct tee_desc optee_desc = {
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index caa3c04..3ea7f7a 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -160,6 +160,10 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session);
 void optee_enable_shm_cache(struct optee *optee);
 void optee_disable_shm_cache(struct optee *optee);
 
+int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
+		       struct page **pages, size_t num_pages);
+int optee_shm_unregister(struct tee_context *ctx, struct tee_shm *shm);
+
 int optee_from_msg_param(struct tee_param *params, size_t num_params,
 			 const struct optee_msg_param *msg_params);
 int optee_to_msg_param(struct optee_msg_param *msg_params, size_t num_params,
-- 
2.7.4

From: volodymyr_babchuk@epam.com (Volodymyr Babchuk)
Date: Thu, 28 Sep 2017 21:04:05 +0300
Subject: [PATCH v1 08/14] tee: optee: add registered shared parameters handling
In-Reply-To: <1506621851-6929-1-git-send-email-volodymyr_babchuk@epam.com>
References: <1506621851-6929-1-git-send-email-volodymyr_babchuk@epam.com>
Message-ID: <1506621851-6929-9-git-send-email-volodymyr_babchuk@epam.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Volodymyr Babchuk <vlad.babchuk@gmail.com>

Now, when client applications can register own shared buffers in OP-TEE,
we need to extend ABI for parameter passing to/from OP-TEE.

So, if OP-TEE core detects that parameter belongs to registered shared
memory, it will use corresponding parameter attribute.

Signed-off-by: Volodymyr Babchuk <vlad.babchuk@gmail.com>
---
 drivers/tee/optee/core.c | 86 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 71 insertions(+), 15 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 4d448bf..a962f60 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -97,6 +97,33 @@ int optee_from_msg_param(struct tee_param *params, size_t num_params,
 					return rc;
 			}
 			break;
+		case OPTEE_MSG_ATTR_TYPE_RMEM_INPUT:
+		case OPTEE_MSG_ATTR_TYPE_RMEM_OUTPUT:
+		case OPTEE_MSG_ATTR_TYPE_RMEM_INOUT:
+			p->attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT +
+				  attr - OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
+			p->u.memref.size = mp->u.rmem.size;
+			shm = (struct tee_shm *)(unsigned long)
+				mp->u.rmem.shm_ref;
+
+			if (!shm) {
+				p->u.memref.shm_offs = 0;
+				p->u.memref.shm = NULL;
+				break;
+			}
+			p->u.memref.shm_offs = mp->u.rmem.offs;
+			p->u.memref.shm = shm;
+
+			/* Check that the memref is covered by the shm object */
+			if (p->u.memref.size) {
+				size_t o = p->u.memref.shm_offs +
+					   p->u.memref.size;
+
+				if (o > tee_shm_get_size(shm))
+					return -EINVAL;
+			}
+			break;
+
 		default:
 			return -EINVAL;
 		}
@@ -104,6 +131,46 @@ int optee_from_msg_param(struct tee_param *params, size_t num_params,
 	return 0;
 }
 
+static int to_msg_param_tmp_mem(struct optee_msg_param *mp,
+				const struct tee_param *p)
+{
+	int rc;
+	phys_addr_t pa;
+
+	mp->attr = OPTEE_MSG_ATTR_TYPE_TMEM_INPUT + p->attr -
+		   TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
+
+	mp->u.tmem.shm_ref = (unsigned long)p->u.memref.shm;
+	mp->u.tmem.size = p->u.memref.size;
+
+	if (!p->u.memref.shm) {
+		mp->u.tmem.buf_ptr = 0;
+		return 0;
+	}
+
+	rc = tee_shm_get_pa(p->u.memref.shm, p->u.memref.shm_offs, &pa);
+	if (rc)
+		return rc;
+
+	mp->u.tmem.buf_ptr = pa;
+	mp->attr |= OPTEE_MSG_ATTR_CACHE_PREDEFINED <<
+		    OPTEE_MSG_ATTR_CACHE_SHIFT;
+
+	return 0;
+}
+
+static int to_msg_param_reg_mem(struct optee_msg_param *mp,
+				const struct tee_param *p)
+{
+	mp->attr = OPTEE_MSG_ATTR_TYPE_RMEM_INPUT + p->attr -
+		   TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
+
+	mp->u.rmem.shm_ref = (unsigned long)p->u.memref.shm;
+	mp->u.rmem.size = p->u.memref.size;
+	mp->u.rmem.offs = p->u.memref.shm_offs;
+	return 0;
+}
+
 /**
  * optee_to_msg_param() - convert from struct tee_params to OPTEE_MSG parameters
  * @msg_params:	OPTEE_MSG parameters
@@ -116,7 +183,6 @@ int optee_to_msg_param(struct optee_msg_param *msg_params, size_t num_params,
 {
 	int rc;
 	size_t n;
-	phys_addr_t pa;
 
 	for (n = 0; n < num_params; n++) {
 		const struct tee_param *p = params + n;
@@ -139,22 +205,12 @@ int optee_to_msg_param(struct optee_msg_param *msg_params, size_t num_params,
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
-			mp->attr = OPTEE_MSG_ATTR_TYPE_TMEM_INPUT +
-				   p->attr -
-				   TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
-			mp->u.tmem.shm_ref = (unsigned long)p->u.memref.shm;
-			mp->u.tmem.size = p->u.memref.size;
-			if (!p->u.memref.shm) {
-				mp->u.tmem.buf_ptr = 0;
-				break;
-			}
-			rc = tee_shm_get_pa(p->u.memref.shm,
-					    p->u.memref.shm_offs, &pa);
+			if (tee_shm_is_registered(p->u.memref.shm))
+				rc = to_msg_param_reg_mem(mp, p);
+			else
+				rc = to_msg_param_tmp_mem(mp, p);
 			if (rc)
 				return rc;
-			mp->u.tmem.buf_ptr = pa;
-			mp->attr |= OPTEE_MSG_ATTR_CACHE_PREDEFINED <<
-					OPTEE_MSG_ATTR_CACHE_SHIFT;
 			break;
 		default:
 			return -EINVAL;
-- 
2.7.4

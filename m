From: carlo@caione.org (Carlo Caione)
Date: Fri,  3 Mar 2017 16:17:58 +0100
Subject: [PATCH 1/2] firmware: meson-sm: Check for buffer output size
In-Reply-To: <20170303151759.8330-1-carlo@caione.org>
References: <20170303151759.8330-1-carlo@caione.org>
Message-ID: <20170303151759.8330-2-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

After the data is read by the secure monitor driver it is being copied
in the output buffer checking only the size of the bounce buffer but not
the size of the output buffer.

Fix this in the secure monitor driver slightly changing the API. Fix
also the efuse driver that it is the only driver using this API to not
break bisectability.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 drivers/firmware/meson/meson_sm.c       | 10 +++++++---
 drivers/nvmem/meson-efuse.c             |  2 +-
 include/linux/firmware/meson/meson_sm.h |  4 ++--
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
index b0d254930ed3..5f30a5774e57 100644
--- a/drivers/firmware/meson/meson_sm.c
+++ b/drivers/firmware/meson/meson_sm.c
@@ -127,6 +127,7 @@ EXPORT_SYMBOL(meson_sm_call);
  * meson_sm_call_read - retrieve data from secure-monitor
  *
  * @buffer:	Buffer to store the retrieved data
+ * @bsize:	Size of the buffer
  * @cmd_index:	Index of the SMC32 function ID
  * @arg0:	SMC32 Argument 0
  * @arg1:	SMC32 Argument 1
@@ -136,8 +137,8 @@ EXPORT_SYMBOL(meson_sm_call);
  *
  * Return:	size of read data on success, a negative value on error
  */
-int meson_sm_call_read(void *buffer, unsigned int cmd_index, u32 arg0,
-		       u32 arg1, u32 arg2, u32 arg3, u32 arg4)
+int meson_sm_call_read(void *buffer, unsigned int bsize, unsigned int cmd_index,
+		       u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4)
 {
 	u32 size;
 
@@ -147,10 +148,13 @@ int meson_sm_call_read(void *buffer, unsigned int cmd_index, u32 arg0,
 	if (!fw.chip->cmd_shmem_out_base)
 		return -EINVAL;
 
+	if (bsize > fw.chip->shmem_size)
+		return -EINVAL;
+
 	if (meson_sm_call(cmd_index, &size, arg0, arg1, arg2, arg3, arg4) < 0)
 		return -EINVAL;
 
-	if (!size || size > fw.chip->shmem_size)
+	if (!size || size > bsize)
 		return -EINVAL;
 
 	if (buffer)
diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index f207c3b10482..70bfc9839bb2 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -27,7 +27,7 @@ static int meson_efuse_read(void *context, unsigned int offset,
 	u8 *buf = val;
 	int ret;
 
-	ret = meson_sm_call_read(buf, SM_EFUSE_READ, offset,
+	ret = meson_sm_call_read(buf, bytes, SM_EFUSE_READ, offset,
 				 bytes, 0, 0, 0);
 	if (ret < 0)
 		return ret;
diff --git a/include/linux/firmware/meson/meson_sm.h b/include/linux/firmware/meson/meson_sm.h
index 8e953c6f394a..37a5eaea69dd 100644
--- a/include/linux/firmware/meson/meson_sm.h
+++ b/include/linux/firmware/meson/meson_sm.h
@@ -25,7 +25,7 @@ int meson_sm_call(unsigned int cmd_index, u32 *ret, u32 arg0, u32 arg1,
 		  u32 arg2, u32 arg3, u32 arg4);
 int meson_sm_call_write(void *buffer, unsigned int b_size, unsigned int cmd_index,
 			u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4);
-int meson_sm_call_read(void *buffer, unsigned int cmd_index, u32 arg0, u32 arg1,
-		       u32 arg2, u32 arg3, u32 arg4);
+int meson_sm_call_read(void *buffer, unsigned int bsize, unsigned int cmd_index,
+		       u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4);
 
 #endif /* _MESON_SM_FW_H_ */
-- 
2.12.0

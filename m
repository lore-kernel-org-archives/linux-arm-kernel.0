From: carlo@caione.org (Carlo Caione)
Date: Fri,  3 Mar 2017 16:17:59 +0100
Subject: [PATCH 2/2] firmware: meson-sm: Allow 0 as valid return value
In-Reply-To: <20170303151759.8330-1-carlo@caione.org>
References: <20170303151759.8330-1-carlo@caione.org>
Message-ID: <20170303151759.8330-3-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Some special SMC calls (i.e. the function used to retrieve the serial
number of the Amlogic SoCs) returns 0 in the register 0 also when the
data was successfully read instead of using the register to hold the
number of bytes returned in the bounce buffer as expected.

With the current implementation of the driver this is seen as an error
and meson_sm_call_read() returns an error even though the data was
correctly read.

To deal with this when we have no information about the amount of read
data (that is 0 is returned by the SMC call) we return to the caller
the requested amount of data and 0 as return value.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 drivers/firmware/meson/meson_sm.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
index 5f30a5774e57..ff204421117b 100644
--- a/drivers/firmware/meson/meson_sm.c
+++ b/drivers/firmware/meson/meson_sm.c
@@ -136,11 +136,14 @@ EXPORT_SYMBOL(meson_sm_call);
  * @arg4:	SMC32 Argument 4
  *
  * Return:	size of read data on success, a negative value on error
+ *		When 0 is returned there is no guarantee about the amount of
+ *		data read and bsize bytes are copied in buffer.
  */
 int meson_sm_call_read(void *buffer, unsigned int bsize, unsigned int cmd_index,
 		       u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4)
 {
 	u32 size;
+	int ret;
 
 	if (!fw.chip)
 		return -ENOENT;
@@ -154,13 +157,18 @@ int meson_sm_call_read(void *buffer, unsigned int bsize, unsigned int cmd_index,
 	if (meson_sm_call(cmd_index, &size, arg0, arg1, arg2, arg3, arg4) < 0)
 		return -EINVAL;
 
-	if (!size || size > bsize)
+	if (size > bsize)
 		return -EINVAL;
 
+	ret = size;
+
+	if (!size)
+		size = bsize;
+
 	if (buffer)
 		memcpy(buffer, fw.sm_shmem_out_base, size);
 
-	return size;
+	return ret;
 }
 EXPORT_SYMBOL(meson_sm_call_read);
 
-- 
2.12.0

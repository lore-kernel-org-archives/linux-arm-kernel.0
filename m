From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Oct 2015 22:37:11 +0200
Subject: [PATCH] nvme: fix 32-bit build warning
Message-ID: <5851501.PBMrs03XFb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Compiling the nvme driver on 32-bit warns about a cast from a __u64
variable to a pointer:

drivers/block/nvme-core.c: In function 'nvme_submit_io':
drivers/block/nvme-core.c:1847:4: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    (void __user *)io.addr, length, NULL, 0);

The cast here is intentional and safe, so we can shut up the
gcc warning by adding an intermediate cast to 'unsigned long'.

I had previously submitted a patch to fix this problem in the
nvme driver, but it was accepted on the same day that two new
warnings got added.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: d29ec8241c10e ("nvme: submit internal commands through the block layer")

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index e917cf304ad0..f9faf276ce74 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1844,7 +1844,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	c.rw.metadata = cpu_to_le64(meta_dma);
 
 	status = __nvme_submit_sync_cmd(ns->queue, &c, NULL,
-			(void __user *)io.addr, length, NULL, 0);
+			(void __user *)(unsigned long)io.addr, length, NULL, 0);
  unmap:
 	if (meta) {
 		if (status == NVME_SC_SUCCESS && !write) {
@@ -1886,7 +1886,7 @@ static int nvme_user_cmd(struct nvme_dev *dev, struct nvme_ns *ns,
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
 
 	status = __nvme_submit_sync_cmd(ns ? ns->queue : dev->admin_q, &c,
-			NULL, (void __user *)cmd.addr, cmd.data_len,
+			NULL, (void __user *)(unsigned long)cmd.addr, cmd.data_len,
 			&cmd.result, timeout);
 	if (status >= 0) {
 		if (put_user(cmd.result, &ucmd->result))

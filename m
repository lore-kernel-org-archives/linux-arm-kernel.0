From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 09 Oct 2015 20:58:46 +0200
Subject: [PATCH v2] nvme: fix 32-bit build warning
In-Reply-To: <20151009144221.GA12760@infradead.org>
References: <5851501.PBMrs03XFb@wuerfel> <20151009144221.GA12760@infradead.org>
Message-ID: <6199457.Ih8H4dRbvg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From 877a323df080bda54a71e26ecf20b4244b31a180 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 6 Oct 2015 22:29:48 +0200
Subject: [PATCH] nvme: fix 32-bit build warning

Compiling the nvme driver on 32-bit warns about a cast from a __u64
variable to a pointer:

drivers/block/nvme-core.c: In function 'nvme_submit_io':
drivers/block/nvme-core.c:1847:4: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    (void __user *)io.addr, length, NULL, 0);

The cast here is intentional and safe, so we can shut up the
gcc warning by adding an intermediate cast to 'uintptr_t'.

I had previously submitted a patch to fix this problem in the
nvme driver, but it was accepted on the same day that two new
warnings got added.

For clarification, I also change the third instance of this cast
to use uintptr_t instead of unsigned long now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: d29ec8241c10e ("nvme: submit internal commands through the block layer")
---
v2: use uintptr_t for intermediate cast

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index e917cf304ad0..e8ff16c63977 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1804,7 +1804,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 
 	length = (io.nblocks + 1) << ns->lba_shift;
 	meta_len = (io.nblocks + 1) * ns->ms;
-	metadata = (void __user *)(unsigned long)io.metadata;
+	metadata = (void __user *)(uintptr_t)io.metadata;
 	write = io.opcode & 1;
 
 	if (ns->ext) {
@@ -1844,7 +1844,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	c.rw.metadata = cpu_to_le64(meta_dma);
 
 	status = __nvme_submit_sync_cmd(ns->queue, &c, NULL,
-			(void __user *)io.addr, length, NULL, 0);
+			(void __user *)(uintptr_t)io.addr, length, NULL, 0);
  unmap:
 	if (meta) {
 		if (status == NVME_SC_SUCCESS && !write) {
@@ -1886,7 +1886,7 @@ static int nvme_user_cmd(struct nvme_dev *dev, struct nvme_ns *ns,
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
 
 	status = __nvme_submit_sync_cmd(ns ? ns->queue : dev->admin_q, &c,
-			NULL, (void __user *)cmd.addr, cmd.data_len,
+			NULL, (void __user *)(uintptr_t)cmd.addr, cmd.data_len,
 			&cmd.result, timeout);
 	if (status >= 0) {
 		if (put_user(cmd.result, &ucmd->result))

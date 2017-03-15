From: dwmw2@infradead.org (David Woodhouse)
Date: Wed, 15 Mar 2017 20:42:39 +0000
Subject: [PATCH v2 4/4] arm64: Do not expose PCI mmap through procfs
Message-ID: <1489610559.86622.22.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
We shouldn't do this bit. But you did ask...

 drivers/pci/proc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 5cd960c..233d549 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -17,6 +17,11 @@
 
 static int proc_initialized;	/* = 0 */
 
+#ifdef __aarch64__
+/* ARM64 wants to be special and not expose this through /proc like everyone else */
+#undef HAVE_PCI_MMAP
+#endif
+
 static loff_t proc_bus_pci_lseek(struct file *file, loff_t off, int whence)
 {
 	struct pci_dev *dev = PDE_DATA(file_inode(file));
-- 
dwmw2
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 4938 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170315/8b71ad76/attachment.bin>

From: hch@lst.de (Christoph Hellwig)
Date: Wed, 16 May 2018 07:43:35 +0200
Subject: [PATCH 01/14] orangefs: don't return errno values from ->fault
In-Reply-To: <20180516054348.15950-1-hch@lst.de>
References: <20180516054348.15950-1-hch@lst.de>
Message-ID: <20180516054348.15950-2-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/orangefs/file.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index 26358efbf794..b4a25cd4f3fa 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -528,18 +528,16 @@ static long orangefs_ioctl(struct file *file, unsigned int cmd, unsigned long ar
 	return ret;
 }
 
-static int orangefs_fault(struct vm_fault *vmf)
+static vm_fault_t orangefs_fault(struct vm_fault *vmf)
 {
 	struct file *file = vmf->vma->vm_file;
 	int rc;
-	rc = orangefs_inode_getattr(file->f_mapping->host, 0, 1,
-	    STATX_SIZE);
-	if (rc == -ESTALE)
-		rc = -EIO;
+
+	rc = orangefs_inode_getattr(file->f_mapping->host, 0, 1, STATX_SIZE);
 	if (rc) {
 		gossip_err("%s: orangefs_inode_getattr failed, "
 		    "rc:%d:.\n", __func__, rc);
-		return rc;
+		return VM_FAULT_SIGBUS;
 	}
 	return filemap_fault(vmf);
 }
-- 
2.17.0

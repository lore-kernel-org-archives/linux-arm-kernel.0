From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Nov 2015 23:32:11 +0100
Subject: [PATCH, RESEND] orangefs: use %zu format string for size_t
Message-ID: <4529098.FXCydd13Bl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 32-bit architectures, 'size_t' and 'unsigned long' are not necessarily
the same, so we get a compiler warning about it:

fs/orangefs/pvfs2-bufmap.c: In function 'pvfs_bufmap_copy_from_iovec':
fs/orangefs/pvfs2-bufmap.c:521:8: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t {aka unsigned int}' [-Wformat=]

This changes the code to use %zu instead of %lu, which always
matches size_t.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 4d1c44043b26e ("Orangefs: use iov_iter interface")
---
Sent originally on October 7, but not yet applied, and we still get the
same warnings. Please apply.

diff --git a/fs/orangefs/pvfs2-bufmap.c b/fs/orangefs/pvfs2-bufmap.c
index 9d0392a3e824..06fb797dedda 100644
--- a/fs/orangefs/pvfs2-bufmap.c
+++ b/fs/orangefs/pvfs2-bufmap.c
@@ -518,7 +518,7 @@ int pvfs_bufmap_copy_from_iovec(struct pvfs2_bufmap *bufmap,
 	int i;
 
 	gossip_debug(GOSSIP_BUFMAP_DEBUG,
-		     "%s: buffer_index:%d: size:%lu:\n",
+		     "%s: buffer_index:%d: size:%zu:\n",
 		     __func__, buffer_index, size);
 
 	to = &bufmap->desc_array[buffer_index];
@@ -550,7 +550,7 @@ int pvfs_bufmap_copy_to_iovec(struct pvfs2_bufmap *bufmap,
 	size_t written;
 
 	gossip_debug(GOSSIP_BUFMAP_DEBUG,
-		     "%s: buffer_index:%d: iov_iter_count(iter):%lu:\n",
+		     "%s: buffer_index:%d: iov_iter_count(iter):%zu:\n",
 		     __func__, buffer_index, iov_iter_count(iter));
 
 	from = &bufmap->desc_array[buffer_index];

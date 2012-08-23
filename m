From: artem.bityutskiy@linux.intel.com (Artem Bityutskiy)
Date: Thu, 23 Aug 2012 10:41:29 +0300
Subject: JFFS2 issue with v3.5.x and later on Atmel chips at least (was:
 Kernel oops since v3.5.x on Atmel chips)
In-Reply-To: <5034F3F8.9080802@atmel.com>
References: <5034B45A.5060107@atmel.com> <5034F3F8.9080802@atmel.com>
Message-ID: <1345707689.2848.203.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Date: Thu, 23 Aug 2012 10:10:07 +0300
Subject: [PATCH] JFFS2: fix unmount regression

This patch fixes regression introduced by
"8bdc81c jffs2: get rid of jffs2_sync_super". We submit a delayed work in order
to make sure the write-buffer is synchronized at some point. But we do not
flush it when we unmount, which causes an oops when we unmount the file-system
and then the delayed work is executed.

This patch fixes the issue by adding a "cancel_delayed_work_sync()" infocation
in the '->sync_fs()' handler. This will make sure the delayed work is canceled
on sync, unmount and re-mount. And because VFS always callse 'sync_fs()' before
unmounting or remounting, this fixes the issue.

Reported-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: stable at vger.kernel.org [3.5+]
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---

Ludovic, would you please give this patch a test? Also attached.

 fs/jffs2/super.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 61ea413..e385fa3 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -100,6 +100,9 @@ static int jffs2_sync_fs(struct super_block *sb, int wait)
 {
 	struct jffs2_sb_info *c = JFFS2_SB_INFO(sb);
 
+	if (IS_ENABLED(CONFIG_JFFS2_FS_WRITEBUFFER))
+		cancel_delayed_work_sync(&c->wbuf_dwork);
+
 	mutex_lock(&c->alloc_sem);
 	jffs2_flush_wbuf_pad(c);
 	mutex_unlock(&c->alloc_sem);
-- 
1.7.10.4
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-JFFS2-fix-unmount-regression.patch
Type: text/x-patch
Size: 1538 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120823/238e9a92/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120823/238e9a92/attachment.sig>

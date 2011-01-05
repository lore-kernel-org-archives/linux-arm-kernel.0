From: rees@umich.edu (Jim Rees)
Date: Wed, 5 Jan 2011 10:38:29 -0500
Subject: still nfs problems [Was: Linux 2.6.37-rc8]
In-Reply-To: <4D248343.2000407@pengutronix.de>
References: <1293731992.4919.5.camel@heimdal.trondhjem.org>
	<20101230191846.GB14221@pengutronix.de>
	<20110103213850.GC25121@pengutronix.de>
	<1294100558.25100.8.camel@heimdal.trondhjem.org>
	<20110105084014.GN25121@pengutronix.de>
	<20110105110517.GQ25121@pengutronix.de>
	<20110105112701.GA8638@n2100.arm.linux.org.uk>
	<20110105134045.GS25121@pengutronix.de>
	<20110105142902.GA9278@merit.edu> <4D248343.2000407@pengutronix.de>
Message-ID: <20110105153829.GB11608@merit.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Kleine-Budde wrote:

  > Trond sent a fix to the nfs list on 27 Nov for "fileid changed" but I don't
  > know if this is the same bug you're seeing.  The patch was to
  > nfs_same_file() and I can send it if you want.  As far as I know the patch
  > made it upstream.
  
  Are you sure it's in .37?

...

  Would you please be so kind and send the patch to this thread?

This is the commit I'm thinking of:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=37a09f07459753e7c98d4e21f1c61e8756923f81

NFS: Fix a readdirplus bug

When comparing filehandles in the helper nfs_same_file(), we should not be
using 'strncmp()': filehandles are not null terminated strings.

Instead, we should just use the existing helper nfs_compare_fh().

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 8ea4a41..f0a384e 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -395,13 +395,9 @@ int xdr_decode(nfs_readdir_descriptor_t *desc, struct nfs_entry *entry, struct x
 static
 int nfs_same_file(struct dentry *dentry, struct nfs_entry *entry)
 {
-	struct nfs_inode *node;
 	if (dentry->d_inode == NULL)
 		goto different;
-	node = NFS_I(dentry->d_inode);
-	if (node->fh.size != entry->fh->size)
-		goto different;
-	if (strncmp(node->fh.data, entry->fh->data, node->fh.size) != 0)
+	if (nfs_compare_fh(entry->fh, NFS_FH(dentry->d_inode)) != 0)
 		goto different;
 	return 1;
 different:

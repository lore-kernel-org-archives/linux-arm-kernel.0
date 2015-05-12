From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 May 2015 23:31:29 +0200
Subject: [PATCH] nfsd: work around a gcc-5.1 warning
Message-ID: <2121336.tAfQfAWQ2u@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gcc-5.0 warns about a potential uninitialized variable use in nfsd:

fs/nfsd/nfs4state.c: In function 'nfsd4_process_open2':
fs/nfsd/nfs4state.c:3781:3: warning: 'old_deny_bmap' may be used uninitialized in this function [-Wmaybe-uninitialized]
   reset_union_bmap_deny(old_deny_bmap, stp);
   ^
fs/nfsd/nfs4state.c:3760:16: note: 'old_deny_bmap' was declared here
  unsigned char old_deny_bmap;
                ^

This is a false positive, the code path that is warned about cannot
actually be reached.

This adds an initialization for the variable to make the warning go
away.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This warning shows up in some ARM defconfig builds, which we try to
build with no warnings to detect regressions.

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 38f2d7abe3a7..997eda362a75 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3770,6 +3770,8 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp, struct svc_fh *c
 		set_deny(open->op_share_deny, stp);
 		fp->fi_share_deny |=
 				(open->op_share_deny & NFS4_SHARE_DENY_BOTH);
+	} else {
+		old_deny_bmap = 0;
 	}
 	spin_unlock(&fp->fi_lock);
 

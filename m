From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Jan 2016 16:32:44 +0100
Subject: [PATCH] ncpfs: avoid unused variable warning
Message-ID: <1453735996-1958733-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_NCPFS_NLS is not set, we get a harmless warning
about an unused local variable, because that is only passed
into a macro that does not evaluate its argument:

fs/ncpfs/dir.c:136:23: warning: unused variable 'sb' [-Wunused-variable]

This replaces the trivial macro with an equally trivial
inline function, which avoids the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 621e155a3591 ("fs: change d_compare for rcu-walk")
---
 fs/ncpfs/ncplib_kernel.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ncpfs/ncplib_kernel.h b/fs/ncpfs/ncplib_kernel.h
index 5233fbc1747a..2bbd70f26d0a 100644
--- a/fs/ncpfs/ncplib_kernel.h
+++ b/fs/ncpfs/ncplib_kernel.h
@@ -148,7 +148,10 @@ int ncp__io2vol(unsigned char *, unsigned int *,
 int ncp__vol2io(unsigned char *, unsigned int *,
 				const unsigned char *, unsigned int, int);
 
-#define NCP_IO_TABLE(sb)	NULL
+static inline struct nls_table *NCP_IO_TABLE(struct super_block *sb)
+{
+	return NULL;
+}
 #define ncp_tolower(t, c)	tolower(c)
 #define ncp_toupper(t, c)	toupper(c)
 #define ncp_io2vol(S,m,i,n,k,U)	ncp__io2vol(m,i,n,k,U)
-- 
2.7.0

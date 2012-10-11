From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Oct 2012 13:20:00 +0000
Subject: [PATCH v2] vfs: bogus warnings in fs/namei.c
In-Reply-To: <20121011043734.GE2616@ZenIV.linux.org.uk>
References: <1349448930-23976-1-git-send-email-arnd@arndb.de>
 <201210091307.19225.arnd@arndb.de> <20121011043734.GE2616@ZenIV.linux.org.uk>
Message-ID: <201210111320.01047.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The follow_link() function always initializes its *p argument,
or returns an error, but when building with 'gcc -s', the compiler
gets confused by the __always_inline attribute to the function
and can no longer detect where the cookie was initialized.

The solution is to always initialize the pointer from follow_link,
even in the error path. When building with -O2, this has zero impact
on generated code and adds a single instruction in the error path
for a -Os build on ARM.

Without this patch, building with gcc-4.6 through gcc-4.8 and
CONFIG_CC_OPTIMIZE_FOR_SIZE results in:

fs/namei.c: In function 'link_path_walk':
fs/namei.c:649:24: warning: 'cookie' may be used uninitialized in this function [-Wuninitialized]
fs/namei.c:1544:9: note: 'cookie' was declared here
fs/namei.c: In function 'path_lookupat':
fs/namei.c:649:24: warning: 'cookie' may be used uninitialized in this function [-Wuninitialized]
fs/namei.c:1934:10: note: 'cookie' was declared here
fs/namei.c: In function 'path_openat':
fs/namei.c:649:24: warning: 'cookie' may be used uninitialized in this function [-Wuninitialized]
fs/namei.c:2899:9: note: 'cookie' was declared here

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/fs/namei.c b/fs/namei.c
index 6d47fac..c1f18e4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -810,6 +810,7 @@ follow_link(struct path *link, struct nameidata *nd, void **p)
 	return error;
 
 out_put_nd_path:
+	*p = NULL;
 	path_put(&nd->path);
 	path_put(link);
 	return error;

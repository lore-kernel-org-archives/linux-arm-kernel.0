From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Jan 2013 22:44:07 +0000
Subject: [PATCH 08/19] lockdep: avoid warning about unused variables
In-Reply-To: <1359153858-31992-1-git-send-email-arnd@arndb.de>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <1359153858-31992-1-git-send-email-arnd@arndb.de>
Message-ID: <1359153858-31992-9-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When lockdep is disabled, a call to lockdep_assert_held
does not use its argument, which results in a compiler
warning if nothing else in the same function uses
that variable. An instance of this was introduced
by c9a49628819 "nfsd: make client_lock per net".

Without this patch, building ARM cerfcube_defconfig results in:

fs/nfsd/nfs4state.c: In function 'free_client':
fs/nfsd/nfs4state.c:1047:19: error: unused variable 'nn' [-Wunused-variable]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Stanislav Kinsbursky <skinsbursky@parallels.com>
---
 include/linux/lockdep.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 2bca44b..f05631e 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -410,7 +410,7 @@ struct lock_class_key { };
 
 #define lockdep_depth(tsk)	(0)
 
-#define lockdep_assert_held(l)			do { } while (0)
+#define lockdep_assert_held(l)			do { (void)(l); } while (0)
 
 #define lockdep_recursing(tsk)			(0)
 
-- 
1.8.0

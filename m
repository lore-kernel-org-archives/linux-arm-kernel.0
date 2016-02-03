From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  3 Feb 2016 23:05:50 +0100
Subject: [PATCH] kernel/locking/lockdep.c: mark chainhashentry as
 __maybe_unused
Message-ID: <1454537158-3759624-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added chainhashentry() function is only use when
CONFIG_PROVE_LOCKING is enabled, otherwise we get a warning about it.

kernel/locking/lockdep.c:318:26: error: 'chainhashentry' defined but not used [-Werror=unused-function]

We could add another #ifdef or add __maybe_unused to avoid the warning,
this patch picks the second option.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: a33a23c7def8 ("kernel/locking/lockdep.c: make lockdep initialize itself on demand")
---
 kernel/locking/lockdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 9269b1a74260..0d3c08d23946 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -315,7 +315,7 @@ static inline struct list_head *classhashentry(struct lockdep_subclass_key *key)
 
 static struct list_head __chainhash_table[CHAINHASH_SIZE];
 
-static struct list_head *chainhashentry(unsigned long chain)
+static __maybe_unused struct list_head * chainhashentry(unsigned long chain)
 {
 	if (unlikely(!lockdep_initialized))
 		lockdep_init();
-- 
2.7.0

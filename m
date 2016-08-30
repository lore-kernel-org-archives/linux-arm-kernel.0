From: liguozhu@hisilicon.com (Kenneth Lee)
Date: Tue, 30 Aug 2016 14:35:31 +0800
Subject: [PATCH] [bugfix] replace unnessary ldax with common ldr 
Message-ID: <1472538931-145463-1-git-send-email-liguozhu@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(add comment for the previous mail, sorry for the duplication)

There is no store_ex pairing with this load_ex. It is not necessary and
gave wrong hint to the cache system.

Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
---
 arch/arm64/include/asm/spinlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index c85e96d..3334c4f 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -63,7 +63,7 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 	 */
 "	sevl\n"
 "2:	wfe\n"
-"	ldaxrh	%w2, %4\n"
+"	ldrh	%w2, %4\n"
 "	eor	%w1, %w2, %w0, lsr #16\n"
 "	cbnz	%w1, 2b\n"
 	/* We got the lock. Critical section starts here. */
-- 
1.9.1

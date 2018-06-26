From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Jun 2018 12:00:12 +0100
Subject: [PATCH 3/3] arm64: kconfig: Ensure spinlock fastpaths are inlined if
 !PREEMPT
In-Reply-To: <1530010812-17161-1-git-send-email-will.deacon@arm.com>
References: <1530010812-17161-1-git-send-email-will.deacon@arm.com>
Message-ID: <1530010812-17161-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When running with CONFIG_PREEMPT=n, the spinlock fastpaths fit inside
64 bytes, which typically coincides with the L1 I-cache line size.

Inline the spinlock fastpaths, like we do already for rwlocks.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index facd19625563..476de9b1d239 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -42,6 +42,16 @@ config ARM64
 	select ARCH_INLINE_WRITE_UNLOCK_BH if !PREEMPT
 	select ARCH_INLINE_WRITE_UNLOCK_IRQ if !PREEMPT
 	select ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE if !PREEMPT
+	select ARCH_INLINE_SPIN_TRYLOCK if !PREEMPT
+	select ARCH_INLINE_SPIN_TRYLOCK_BH if !PREEMPT
+	select ARCH_INLINE_SPIN_LOCK if !PREEMPT
+	select ARCH_INLINE_SPIN_LOCK_BH if !PREEMPT
+	select ARCH_INLINE_SPIN_LOCK_IRQ if !PREEMPT
+	select ARCH_INLINE_SPIN_LOCK_IRQSAVE if !PREEMPT
+	select ARCH_INLINE_SPIN_UNLOCK if !PREEMPT
+	select ARCH_INLINE_SPIN_UNLOCK_BH if !PREEMPT
+	select ARCH_INLINE_SPIN_UNLOCK_IRQ if !PREEMPT
+	select ARCH_INLINE_SPIN_UNLOCK_IRQRESTORE if !PREEMPT
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
-- 
2.1.4

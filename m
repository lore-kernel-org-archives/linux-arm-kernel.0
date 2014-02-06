From: will.deacon@arm.com (Will Deacon)
Date: Thu,  6 Feb 2014 11:30:48 +0000
Subject: [PATCH 1/6] arm64: barriers: allow dsb macro to take option parameter
Message-ID: <1391686253-13436-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dsb instruction takes an option specifying both the target access
types and shareability domain.

This patch allows such an option to be passed to the dsb macro,
resulting in potentially more efficient code. Currently the option is
ignored until all callers are updated (unlike ARM, the option is
mandated by the assembler).

Signed-off-by: Will Deacon <will.deacon@arm.com>
---

Catalin -- I'd like to get this simple change in for 3.14, since it's a
           blocker for actually implementing the barrier options (we
	   need to move all of the callers over before making the switch).

 arch/arm64/include/asm/barrier.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 78e20ba8806b..409ca370cfe2 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -25,7 +25,7 @@
 #define wfi()		asm volatile("wfi" : : : "memory")
 
 #define isb()		asm volatile("isb" : : : "memory")
-#define dsb()		asm volatile("dsb sy" : : : "memory")
+#define dsb(opt)	asm volatile("dsb sy" : : : "memory")
 
 #define mb()		dsb()
 #define rmb()		asm volatile("dsb ld" : : : "memory")
-- 
1.8.2.2

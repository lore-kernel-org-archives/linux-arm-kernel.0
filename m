From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 23 Oct 2015 13:01:49 -0700
Subject: [PATCH v3 1/4] frv: io: Accept const void pointers for read{b,w,l}()
In-Reply-To: <1445630512-10888-1-git-send-email-sboyd@codeaurora.org>
References: <1445630512-10888-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1445630512-10888-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The frv port uses compiler builtins, __builtin_read*(), for the
I/O read routines. Unfortunately, these don't accept const void
pointers although the generic ASM implementations do, so generic
code passing const pointers to these APIs cause compilers to emit
warnings. Add wrapper functions that cast away the const to avoid
the warnings.

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/frv/include/asm/io.h | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/frv/include/asm/io.h b/arch/frv/include/asm/io.h
index 70dfbea8c8d7..8062fc73fad0 100644
--- a/arch/frv/include/asm/io.h
+++ b/arch/frv/include/asm/io.h
@@ -43,9 +43,20 @@ static inline unsigned long _swapl(unsigned long v)
 //#define __iormb() asm volatile("membar")
 //#define __iowmb() asm volatile("membar")
 
-#define __raw_readb __builtin_read8
-#define __raw_readw __builtin_read16
-#define __raw_readl __builtin_read32
+static inline u8 __raw_readb(const volatile void __iomem *addr)
+{
+	return __builtin_read8((volatile void __iomem *)addr);
+}
+
+static inline u16 __raw_readw(const volatile void __iomem *addr)
+{
+	return __builtin_read16((volatile void __iomem *)addr);
+}
+
+static inline u32 __raw_readl(const volatile void __iomem *addr)
+{
+	return __builtin_read32((volatile void __iomem *)addr);
+}
 
 #define __raw_writeb(datum, addr) __builtin_write8(addr, datum)
 #define __raw_writew(datum, addr) __builtin_write16(addr, datum)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

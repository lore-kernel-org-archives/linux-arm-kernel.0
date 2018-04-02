From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon,  2 Apr 2018 14:13:39 -0400
Subject: [PATCH v2] MIPS: io: add a barrier after register read in readX()
Message-ID: <1522692821-27706-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While a barrier is present in writeX() function before the register write,
a similar barrier is missing in the readX() function after the register
read. This could allow memory accesses following readX() to observe
stale data.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Reported-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/include/asm/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 0cbf3af..7f9068d 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -377,6 +377,7 @@ static inline type pfx##read##bwlq(const volatile void __iomem *mem)	\
 		BUG();							\
 	}								\
 									\
+	war_io_reorder_wmb();						\
 	return pfx##ioswab##bwlq(__mem, __val);				\
 }
 
-- 
2.7.4

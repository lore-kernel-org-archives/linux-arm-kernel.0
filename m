From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue,  3 Apr 2018 08:55:04 -0400
Subject: [PATCH v3 2/2] MIPS: io: add a barrier after register read in readX()
In-Reply-To: <1522760109-16497-1-git-send-email-okaya@codeaurora.org>
References: <1522760109-16497-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1522760109-16497-2-git-send-email-okaya@codeaurora.org>
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
index fd00ddaf..6ac502f 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -377,6 +377,7 @@ static inline type pfx##read##bwlq(const volatile void __iomem *mem)	\
 		BUG();							\
 	}								\
 									\
+	rmb();								\
 	return pfx##ioswab##bwlq(__mem, __val);				\
 }
 
-- 
2.7.4

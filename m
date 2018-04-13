From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 12 Apr 2018 22:30:44 -0400
Subject: [PATCH v4 2/2] MIPS: io: add a barrier after register read in readX()
In-Reply-To: <1523586646-19630-1-git-send-email-okaya@codeaurora.org>
References: <1523586646-19630-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1523586646-19630-2-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While a barrier is present in writeX() function before the register write,
a similar barrier is missing in the readX() function after the register
read. This could allow memory accesses following readX() to observe
stale data.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Reported-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/include/asm/io.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index fd00ddaf..d96af41 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -377,6 +377,8 @@ static inline type pfx##read##bwlq(const volatile void __iomem *mem)	\
 		BUG();							\
 	}								\
 									\
+	/* prevent prefetching of coherent DMA dma prematurely */	\
+	rmb();								\
 	return pfx##ioswab##bwlq(__mem, __val);				\
 }
 
-- 
2.7.4

From: shannon.zhao@linaro.org (shannon.zhao at linaro.org)
Date: Tue, 17 Nov 2015 17:40:03 +0800
Subject: [PATCH v3 04/62] arm/acpi: Emulate io ports for arm
In-Reply-To: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
Message-ID: <1447753261-7552-5-git-send-email-shannon.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Parth Dixit <parth.dixit@linaro.org>

Add macros to emulate x86 style ports for arm. This avoids modification in
common code for acpi.

Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 xen/include/asm-arm/arm64/io.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/xen/include/asm-arm/arm64/io.h b/xen/include/asm-arm/arm64/io.h
index 37abc47..7ad9b65 100644
--- a/xen/include/asm-arm/arm64/io.h
+++ b/xen/include/asm-arm/arm64/io.h
@@ -20,6 +20,7 @@
 #ifndef _ARM_ARM64_IO_H
 #define _ARM_ARM64_IO_H
 
+#include <asm/system.h>
 #include <asm/byteorder.h>
 
 /*
@@ -109,4 +110,17 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 #define writel(v,c)             ({ __iowmb(); writel_relaxed((v),(c)); })
 #define writeq(v,c)             ({ __iowmb(); writeq_relaxed((v),(c)); })
 
+/*
+ * Emulate x86 io ports for arm.
+ */
+#define __armio(addr) ( (void __iomem *)addr )
+
+#define inb(c) ( readb( __armio(c) ) )
+#define inw(c) ( readw( __armio(c) ) )
+#define inl(c) ( readl( __armio(c) ) )
+
+#define outb(v, c) ( writeb(v, __armio(c) ) )
+#define outw(v, c) ( writew(v, __armio(c) ) )
+#define outl(v, c) ( writel(v, __armio(c) ) )
+
 #endif /* _ARM_ARM64_IO_H */
-- 
2.1.0

From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  7 Nov 2018 18:10:38 +0100
Subject: [PATCH] arm64: mm: define NET_IP_ALIGN to 0
Message-ID: <20181107171038.25281-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On arm64, there is no need to add 2 bytes of padding to the start of
each network buffer just to make the IP header appear 32-bit aligned.

Since this might actually adversely affect DMA performance some
platforms, let's override NET_IP_ALIGN to 0 to get rid of this
padding.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/processor.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 3e2091708b8e..6b0d4dff5012 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -24,6 +24,14 @@
 #define KERNEL_DS	UL(-1)
 #define USER_DS		(TASK_SIZE_64 - 1)
 
+/*
+ * On arm64 systems, unaligned accesses by the CPU are cheap, and so there is
+ * no point in shifting all network buffers by 2 bytes just to make some IP
+ * header fields appear aligned in memory, potentially sacrificing some DMA
+ * performance on some platforms.
+ */
+#define NET_IP_ALIGN	0
+
 #ifndef __ASSEMBLY__
 #ifdef __KERNEL__
 
-- 
2.19.1

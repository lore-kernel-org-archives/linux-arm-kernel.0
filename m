From: jnair@caviumnetworks.com (Jayachandran C)
Date: Mon, 22 May 2017 07:01:47 +0000
Subject: [PATCH 2/2] arm64: switch ioremap_wc to use Device GRE
In-Reply-To: <1495436507-81890-1-git-send-email-jnair@caviumnetworks.com>
References: <1495436507-81890-1-git-send-email-jnair@caviumnetworks.com>
Message-ID: <1495436507-81890-3-git-send-email-jnair@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device "Gather" attribute is defined in the ARMv8 ARM as:
"The Gathering attribute determines whether it is permissible for either:
* Multiple memory accesses of the same type, read or write, to the same
  memory location to be merged into a single transaction.
* Multiple memory accesses of the same type, read or write, to different
  memory locations to be merged into a single memory transaction on an
  interconnect."

This attribute is more appropriate for the write combining ioremap_wc()
than the non-cached memory attribute used now, so update the ioremap_wc
implementation to use it.

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
---
 arch/arm64/include/asm/io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 35b2e50..b1c92e3 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -168,7 +168,7 @@ extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
 
 #define ioremap(addr, size)		__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
 #define ioremap_nocache(addr, size)	__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
-#define ioremap_wc(addr, size)		__ioremap((addr), (size), __pgprot(PROT_NORMAL_NC))
+#define ioremap_wc(addr, size)		__ioremap((addr), (size), __pgprot(PROT_DEVICE_GRE))
 #define ioremap_wt(addr, size)		__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
 #define iounmap				__iounmap
 
-- 
2.7.4

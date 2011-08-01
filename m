From: jamie@jamieiles.com (Jamie Iles)
Date: Mon,  1 Aug 2011 13:31:05 +0100
Subject: [PATCH 4/9] ixp4xx: make __arch_ioremap() with 0 size return NULL
In-Reply-To: <1312201870-12921-1-git-send-email-jamie@jamieiles.com>
References: <1312201870-12921-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1312201870-12921-4-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without __arch_ioremap(), __get_vm_area_node() with a zero size will
return a NULL pointer.  Make the arch specific ioremap() do the same
thing.

Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-ixp4xx/include/mach/io.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/include/mach/io.h b/arch/arm/mach-ixp4xx/include/mach/io.h
index 57b5410..99cd9ac 100644
--- a/arch/arm/mach-ixp4xx/include/mach/io.h
+++ b/arch/arm/mach-ixp4xx/include/mach/io.h
@@ -62,6 +62,9 @@ static inline int is_pci_memory(u32 addr)
 static inline void __iomem * __indirect_ioremap(unsigned long addr, size_t size,
 						unsigned int mtype)
 {
+	if (!size)
+		return NULL;
+
 	if (!is_pci_memory(addr))
 		return __arm_ioremap(addr, size, mtype);
 
-- 
1.7.4.1

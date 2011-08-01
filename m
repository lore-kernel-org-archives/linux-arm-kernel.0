From: jamie@jamieiles.com (Jamie Iles)
Date: Mon,  1 Aug 2011 13:31:04 +0100
Subject: [PATCH 3/9] ixp23xx: make __arch_ioremap() with 0 size return NULL
In-Reply-To: <1312201870-12921-1-git-send-email-jamie@jamieiles.com>
References: <1312201870-12921-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1312201870-12921-3-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without __arch_ioremap(), __get_vm_area_node() with a zero size will
return a NULL pointer.  Make the arch specific ioremap() do the same
thing.

Cc: Lennert Buytenhek <kernel@wantstofly.org>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-ixp23xx/include/mach/io.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ixp23xx/include/mach/io.h b/arch/arm/mach-ixp23xx/include/mach/io.h
index a1749d0..b3e9d08 100644
--- a/arch/arm/mach-ixp23xx/include/mach/io.h
+++ b/arch/arm/mach-ixp23xx/include/mach/io.h
@@ -23,6 +23,9 @@
 static inline void __iomem *
 ixp23xx_ioremap(unsigned long addr, unsigned long size, unsigned int mtype)
 {
+	if (!size)
+		return NULL;
+
 	if (addr >= IXP23XX_PCI_MEM_START &&
 		addr <= IXP23XX_PCI_MEM_START + IXP23XX_PCI_MEM_SIZE) {
 		if (addr + size > IXP23XX_PCI_MEM_START + IXP23XX_PCI_MEM_SIZE)
-- 
1.7.4.1

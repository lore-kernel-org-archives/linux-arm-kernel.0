From: jamie@jamieiles.com (Jamie Iles)
Date: Mon,  1 Aug 2011 13:31:03 +0100
Subject: [PATCH 2/9] ebsa110: make __arch_ioremap() with 0 size return NULL
In-Reply-To: <1312201870-12921-1-git-send-email-jamie@jamieiles.com>
References: <1312201870-12921-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1312201870-12921-2-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without __arch_ioremap(), __get_vm_area_node() with a zero size will
return a NULL pointer.  Make the arch specific ioremap() do the same
thing.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-ebsa110/include/mach/io.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ebsa110/include/mach/io.h b/arch/arm/mach-ebsa110/include/mach/io.h
index f68daa63..d8dc6ee 100644
--- a/arch/arm/mach-ebsa110/include/mach/io.h
+++ b/arch/arm/mach-ebsa110/include/mach/io.h
@@ -67,6 +67,9 @@ void __writel(u32 val, void __iomem *addr);
 static inline void __iomem *__arch_ioremap(unsigned long cookie, size_t size,
 					   unsigned int flags)
 {
+	if (!size)
+		return NULL;
+
 	return (void __iomem *)cookie;
 }
 
-- 
1.7.4.1

From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Jan 2017 14:41:40 +0100
Subject: [PATCH] ARM: mv78xx0: fix possible PCI buffer overflow
Message-ID: <20170111134159.3832518-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gcc-7.0 reports a potential array overflow:

arch/arm/mach-mv78xx0/pcie.c: In function 'mv78xx0_pcie_preinit':
arch/arm/mach-mv78xx0/pcie.c:81:4: error: output may be truncated before the last format character [-Werror=format-truncation=]

I haven't checked if this can actually happen, but making the
array one 32-bit word longer addresses the warning and makes
it completely safe.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-mv78xx0/pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
index 13a7d72ee0c4..81ff4327a962 100644
--- a/arch/arm/mach-mv78xx0/pcie.c
+++ b/arch/arm/mach-mv78xx0/pcie.c
@@ -29,7 +29,7 @@ struct pcie_port {
 	u8			root_bus_nr;
 	void __iomem		*base;
 	spinlock_t		conf_lock;
-	char			mem_space_name[16];
+	char			mem_space_name[20];
 	struct resource		res;
 };
 
-- 
2.9.0

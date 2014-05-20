From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 May 2014 17:13:03 +0200
Subject: [PATCH] ARM: mvebu: coherency: fix registration of PCI bus notifier
 when !PCI
Message-ID: <1400598783-706-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit b0063aad5dd8 ("ARM: mvebu: use hardware I/O coherency also for
PCI devices") added a reference to the pci_bus_type variable, but this
variable is only available when CONFIG_PCI is enabled. Therefore,
there is now a build failure in !CONFIG_PCI situations.

This commit fixes that by enclosing the entire initcall into a
IS_ENABLED(CONFIG_PCI) condition.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
This applies on top of mvebu/soc. No need to push for 3.15-rc, the
patch being fixed is only for 3.16.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index a222507..477202f 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -422,6 +422,7 @@ static int __init coherency_late_init(void)
 
 postcore_initcall(coherency_late_init);
 
+#if IS_ENABLED(CONFIG_PCI)
 static int __init coherency_pci_init(void)
 {
 	if (coherency_available())
@@ -431,3 +432,4 @@ static int __init coherency_pci_init(void)
 }
 
 arch_initcall(coherency_pci_init);
+#endif
-- 
1.9.3

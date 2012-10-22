From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Mon, 22 Oct 2012 12:46:19 +0800
Subject: [PATCH] ARM: PCI: fix missing unlock on error
Message-ID: <CAPgLHd-Hw-RQZnqb-Usiuq4xhY250kObCGK40cXoDE8f59Cr8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add the missing unlock on the error handle path in function
nanoengine_read_config() and nanoengine_write_config().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-sa1100/pci-nanoengine.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sa1100/pci-nanoengine.c b/arch/arm/mach-sa1100/pci-nanoengine.c
index ff02e2d..6ff07d7 100644
--- a/arch/arm/mach-sa1100/pci-nanoengine.c
+++ b/arch/arm/mach-sa1100/pci-nanoengine.c
@@ -67,8 +67,10 @@ static int nanoengine_read_config(struct pci_bus *bus, unsigned int devfn, int w
 	spin_lock_irqsave(&nano_lock, flags);
 
 	ret = nanoengine_get_pci_address(bus, devfn, where, &address);
-	if (ret != PCIBIOS_SUCCESSFUL)
+	if (ret != PCIBIOS_SUCCESSFUL) {
+		spin_unlock_irqrestore(&nano_lock, flags);
 		return ret;
+	}
 	v = __raw_readl(address);
 
 	spin_unlock_irqrestore(&nano_lock, flags);
@@ -95,8 +97,10 @@ static int nanoengine_write_config(struct pci_bus *bus, unsigned int devfn, int
 	spin_lock_irqsave(&nano_lock, flags);
 
 	ret = nanoengine_get_pci_address(bus, devfn, where, &address);
-	if (ret != PCIBIOS_SUCCESSFUL)
+	if (ret != PCIBIOS_SUCCESSFUL) {
+		spin_unlock_irqrestore(&nano_lock, flags);
 		return ret;
+	}
 	v = __raw_readl(address);
 	switch (size) {
 	case 1:

From: rrichter@cavium.com (Robert Richter)
Date: Mon,  6 Mar 2017 13:57:33 +0100
Subject: [PATCH v2 2/8] irqchip/gic-v3-its: Initialize MSIs with
 subsys_initcalls
In-Reply-To: <20170306125739.19445-1-rrichter@cavium.com>
References: <20170306125739.19445-1-rrichter@cavium.com>
Message-ID: <20170306125739.19445-3-rrichter@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows us to use kernel core functionality (e.g. cma) for ITS
initialization. MSIs must be up before the device_initcalls (pci and
platform device probe) and after arch_initcalls (dma init), so
subsys_initcall is fine.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c      | 2 +-
 drivers/irqchip/irq-gic-v3-its-platform-msi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index aee1c60d7ab5..dace9bc4ef8d 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -194,4 +194,4 @@ static int __init its_pci_msi_init(void)
 
 	return 0;
 }
-early_initcall(its_pci_msi_init);
+subsys_initcall(its_pci_msi_init);
diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
index 470b4aa7d62c..7d8c19973766 100644
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
@@ -103,4 +103,4 @@ static int __init its_pmsi_init(void)
 
 	return 0;
 }
-early_initcall(its_pmsi_init);
+subsys_initcall(its_pmsi_init);
-- 
2.11.0

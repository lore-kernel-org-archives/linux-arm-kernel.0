From: rrichter@cavium.com (Robert Richter)
Date: Tue,  8 Aug 2017 14:22:52 +0200
Subject: [PATCH v3 2/8] irqchip/gic-v3-its: Initialize MSIs with
 subsys_initcalls
In-Reply-To: <20170808122259.6299-1-rrichter@cavium.com>
References: <20170808122259.6299-1-rrichter@cavium.com>
Message-ID: <20170808122259.6299-3-rrichter@cavium.com>
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
index 77931214d954..5940fdf0036e 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -193,4 +193,4 @@ static int __init its_pci_msi_init(void)
 
 	return 0;
 }
-early_initcall(its_pci_msi_init);
+subsys_initcall(its_pci_msi_init);
diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
index 249240d9a425..6ebc871ac63f 100644
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
@@ -166,4 +166,4 @@ static int __init its_pmsi_init(void)
 	its_pmsi_acpi_init();
 	return 0;
 }
-early_initcall(its_pmsi_init);
+subsys_initcall(its_pmsi_init);
-- 
2.11.0

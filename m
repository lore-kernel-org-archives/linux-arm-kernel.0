From: yinghai@kernel.org (Yinghai Lu)
Date: Tue, 25 Sep 2012 01:26:24 -0700
Subject: [PATCH 23/29] PCI, arm: kill pci_root_buses
In-Reply-To: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
Message-ID: <1348561590-28067-24-git-send-email-yinghai@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/kernel/bios32.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 9cf16b8..83b7cdc 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -56,13 +56,10 @@ static void pcibios_bus_report_status(struct pci_bus *bus, u_int status_mask, in
 
 void pcibios_report_status(u_int status_mask, int warn)
 {
-	struct list_head *l;
+	struct pci_host_bridge *host_bridge = NULL;
 
-	list_for_each(l, &pci_root_buses) {
-		struct pci_bus *bus = pci_bus_b(l);
-
-		pcibios_bus_report_status(bus, status_mask, warn);
-	}
+	for_each_pci_host_bridge(host_bridge)
+		pcibios_bus_report_status(host_bridge->bus, status_mask, warn);
 }
 
 /*
-- 
1.7.7

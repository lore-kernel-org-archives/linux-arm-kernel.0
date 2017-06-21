From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Jun 2017 23:52:59 +0200
Subject: [PATCH 1/4] ARM/PCI: iop13xx: address uninitialized variable warning
Message-ID: <20170621215323.3921382-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The last rework returned a variable that the compiler cannot prove
to be initialized:

arch/arm/mach-iop13xx/pci.c: In function 'iop13xx_scan_bus':
arch/arm/mach-iop13xx/pci.c:509:17: error: 'ret' may be used uninitialized in this function [-Werror=maybe-uninitialized]

In the switch statement that sets the return value, this adds
a default returning an error.

Fixes: ace27646da8e ("ARM/PCI: Convert PCI scan API to pci_scan_root_bus_bridge()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-iop13xx/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-iop13xx/pci.c b/arch/arm/mach-iop13xx/pci.c
index b97879bfb81a..3c51a9bb9b49 100644
--- a/arch/arm/mach-iop13xx/pci.c
+++ b/arch/arm/mach-iop13xx/pci.c
@@ -553,6 +553,8 @@ int iop13xx_scan_bus(int nr, struct pci_host_bridge *bridge)
 		if (!ret)
 			pci_bus_atue = bridge->bus;
 		break;
+	default:
+		ret = -EINVAL;
 	}
 
 	return ret;
-- 
2.9.0

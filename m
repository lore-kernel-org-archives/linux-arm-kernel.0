From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 12 Feb 2013 17:28:54 +0100
Subject: [PATCH 20/32] arm: plat-orion: remove __init from PCIe functions
 needed after boot time
In-Reply-To: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1360686546-24277-21-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The orion_pcie_set_local_bus_nr() function will be used by the Marvell
PCIe driver in its PCI-to-PCI bridge emulation. This means that this
function can now get called at any point during the system execution,
and no longer at boot time. For example, if PCIe devices
appear/disappear during the system execution (either through hotplug,
or manipulation of PCIe devices using /sys).

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/plat-orion/pcie.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-orion/pcie.c b/arch/arm/plat-orion/pcie.c
index f20a321..da921e7 100644
--- a/arch/arm/plat-orion/pcie.c
+++ b/arch/arm/plat-orion/pcie.c
@@ -79,7 +79,7 @@ int orion_pcie_get_local_bus_nr(void __iomem *base)
 	return (stat >> PCIE_STAT_BUS_OFFS) & PCIE_STAT_BUS_MASK;
 }
 
-void __init orion_pcie_set_local_bus_nr(void __iomem *base, int nr)
+void orion_pcie_set_local_bus_nr(void __iomem *base, int nr)
 {
 	u32 stat;
 
-- 
1.7.9.5

From: sasha.levin@oracle.com (Sasha Levin)
Date: Thu,  8 Nov 2012 15:23:11 -0500
Subject: [PATCH] ARM: versatile: use BUG_ON where possible
In-Reply-To: <1352406191-14303-1-git-send-email-sasha.levin@oracle.com>
References: <1352406191-14303-1-git-send-email-sasha.levin@oracle.com>
Message-ID: <1352406191-14303-9-git-send-email-sasha.levin@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just use BUG_ON() instead of constructions such as:

	if (...)
		BUG()

A simplified version of the semantic patch that makes this transformation
is as follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e;
@@
- if (e) BUG();
+ BUG_ON(e);
// </smpl>

Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 arch/arm/mach-versatile/pci.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-versatile/pci.c b/arch/arm/mach-versatile/pci.c
index 2f84f40..3936a11 100644
--- a/arch/arm/mach-versatile/pci.c
+++ b/arch/arm/mach-versatile/pci.c
@@ -82,12 +82,9 @@ static void __iomem *__pci_addr(struct pci_bus *bus,
 	/*
 	 * Trap out illegal values
 	 */
-	if (offset > 255)
-		BUG();
-	if (busnr > 255)
-		BUG();
-	if (devfn > 255)
-		BUG();
+	BUG_ON(offset > 255);
+	BUG_ON(busnr > 255);
+	BUG_ON(devfn > 255);
 
 	return VERSATILE_PCI_CFG_VIRT_BASE + ((busnr << 16) |
 		(PCI_SLOT(devfn) << 11) | (PCI_FUNC(devfn) << 8) | offset);
-- 
1.7.10.4

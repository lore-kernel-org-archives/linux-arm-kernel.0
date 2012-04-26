From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 26 Apr 2012 11:16:55 +0100
Subject: [PATCH 1/8] ARM: PCI: remove unused sys->hw
In-Reply-To: <20120426101626.GE24211@n2100.arm.linux.org.uk>
References: <20120426101626.GE24211@n2100.arm.linux.org.uk>
Message-ID: <E1SNLkt-00080g-R0@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platforms mark their hw_pci structure as __initdata, which means
it will be discarded after init time.  Storing pointers to __initdata
in long lived data structures is a potential source of problems, and
in this case, sys->hw is unused apart from its initialization.

So, lets remove this member and its initializer.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/mach/pci.h |    1 -
 arch/arm/kernel/bios32.c        |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index d943b7d..0fc8548 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -45,7 +45,6 @@ struct pci_sys_data {
 	u8		(*swizzle)(struct pci_dev *, u8 *);
 					/* IRQ mapping				*/
 	int		(*map_irq)(const struct pci_dev *, u8, u8);
-	struct hw_pci	*hw;
 	void		*private_data;	/* platform controller private data	*/
 };
 
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index ede5f77..e17dd25 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -424,7 +424,6 @@ static void __init pcibios_init_hw(struct hw_pci *hw)
 #ifdef CONFIG_PCI_DOMAINS
 		sys->domain  = hw->domain;
 #endif
-		sys->hw      = hw;
 		sys->busnr   = busnr;
 		sys->swizzle = hw->swizzle;
 		sys->map_irq = hw->map_irq;
-- 
1.7.4.4

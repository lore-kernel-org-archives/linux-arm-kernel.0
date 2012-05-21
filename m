From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 21 May 2012 16:35:04 +0200
Subject: [PATCH 1/8] ARM: PCI: remove unused sys->hw
In-Reply-To: <E1SNLkt-00080g-R0@rmk-PC.arm.linux.org.uk>
References: <20120426101626.GE24211@n2100.arm.linux.org.uk>
 <E1SNLkt-00080g-R0@rmk-PC.arm.linux.org.uk>
Message-ID: <20120521143504.GD21513@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King wrote:
> Some platforms mark their hw_pci structure as __initdata, which means
> it will be discarded after init time.  Storing pointers to __initdata
> in long lived data structures is a potential source of problems, and
> in this case, sys->hw is unused apart from its initialization.
> 
> So, lets remove this member and its initializer.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/include/asm/mach/pci.h |    1 -
>  arch/arm/kernel/bios32.c        |    1 -
>  2 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
> index d943b7d..0fc8548 100644
> --- a/arch/arm/include/asm/mach/pci.h
> +++ b/arch/arm/include/asm/mach/pci.h
> @@ -45,7 +45,6 @@ struct pci_sys_data {
>  	u8		(*swizzle)(struct pci_dev *, u8 *);
>  					/* IRQ mapping				*/
>  	int		(*map_irq)(const struct pci_dev *, u8, u8);
> -	struct hw_pci	*hw;
>  	void		*private_data;	/* platform controller private data	*/
>  };
>  
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index ede5f77..e17dd25 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -424,7 +424,6 @@ static void __init pcibios_init_hw(struct hw_pci *hw)
>  #ifdef CONFIG_PCI_DOMAINS
>  		sys->domain  = hw->domain;
>  #endif
> -		sys->hw      = hw;
>  		sys->busnr   = busnr;
>  		sys->swizzle = hw->swizzle;
>  		sys->map_irq = hw->map_irq;
> -- 
> 1.7.4.4

I have some patches which convert the Tegra PCIe code to a platform driver. I
used to use the sys->hw field to obtain a pointer to my driver-private struct
which had the struct hw_pci embedded.

Something like this:

	struct tegra_pcie_info {
		...
		struct hw_pci hw;
		...
	};

And then uses the following function to obtain the driver-private data in the
various callbacks (.setup, ...):

	static inline struct tegra_pcie_info *sys_to_pcie(struct pci_sys_data *sys)
	{
		return container_of(sys->hw, struct tegra_pcie_info, hw);
	}

With the removal of the sys->hw field, this obviously no longer works. So
I've come up with the attached hack. I don't know if this is anywhere near
acceptable. If it isn't do you have any other suggestions?

Thierry
-------------- next part --------------
>From ed0421bb87e3fa1484fd54fa504e828e017c3221 Mon Sep 17 00:00:00 2001
From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Mon, 21 May 2012 16:25:58 +0200
Subject: [PATCH] HACK: ARM: PCI: Allow passing driver-private data

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 arch/arm/include/asm/mach/pci.h |    2 +-
 arch/arm/kernel/bios32.c        |   16 +++++++++-------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index 26c511f..5508dc8 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -52,7 +52,7 @@ struct pci_sys_data {
 /*
  * Call this with your hw_pci struct to initialise the PCI system.
  */
-void pci_common_init(struct hw_pci *);
+void pci_common_init(struct hw_pci *, void *);
 
 /*
  * PCI controllers
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 9c0c9a0..45d8171 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -423,7 +423,8 @@ static int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return irq;
 }
 
-static void pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
+static void pcibios_init_hw(struct hw_pci *hw, struct list_head *head,
+			    void *private)
 {
 	struct pci_sys_data *sys = NULL;
 	int ret;
@@ -435,11 +436,12 @@ static void pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
 			panic("PCI: unable to allocate sys data!");
 
 #ifdef CONFIG_PCI_DOMAINS
-		sys->domain  = hw->domain;
+		sys->domain       = hw->domain;
 #endif
-		sys->busnr   = busnr;
-		sys->swizzle = hw->swizzle;
-		sys->map_irq = hw->map_irq;
+		sys->busnr        = busnr;
+		sys->swizzle      = hw->swizzle;
+		sys->map_irq      = hw->map_irq;
+		sys->private_data = private;
 		INIT_LIST_HEAD(&sys->resources);
 
 		ret = hw->setup(nr, sys);
@@ -472,7 +474,7 @@ static void pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
 	}
 }
 
-void pci_common_init(struct hw_pci *hw)
+void pci_common_init(struct hw_pci *hw, void *private)
 {
 	struct pci_sys_data *sys;
 	LIST_HEAD(head);
@@ -480,7 +482,7 @@ void pci_common_init(struct hw_pci *hw)
 	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
 	if (hw->preinit)
 		hw->preinit();
-	pcibios_init_hw(hw, &head);
+	pcibios_init_hw(hw, &head, private);
 	if (hw->postinit)
 		hw->postinit();
 
-- 
1.7.10.2

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120521/90bc22d0/attachment.sig>

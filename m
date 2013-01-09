From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed,  9 Jan 2013 21:43:07 +0100
Subject: [PATCH 07/14] ARM: pci: Allow passing per-controller private data
In-Reply-To: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1357764194-12677-8-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to allow drivers to specify private data for each controller,
this commit adds a private_data field to the struct hw_pci. This field
is an array of nr_controllers pointers that will be used to initialize
the private_data field of the corresponding controller's pci_sys_data
structure.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 arch/arm/include/asm/mach/pci.h | 1 +
 arch/arm/kernel/bios32.c        | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index db9fedb..5cf2e97 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -23,6 +23,7 @@ struct hw_pci {
 #endif
 	struct pci_ops	*ops;
 	int		nr_controllers;
+	void		**private_data;
 	int		(*setup)(int nr, struct pci_sys_data *);
 	struct pci_bus *(*scan)(int nr, struct pci_sys_data *);
 	void		(*preinit)(void);
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index da7b0c9..a1f73b5 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -464,6 +464,9 @@ static void pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
 		sys->map_irq = hw->map_irq;
 		INIT_LIST_HEAD(&sys->resources);
 
+		if (hw->private_data)
+			sys->private_data = hw->private_data[nr];
+
 		ret = hw->setup(nr, sys);
 
 		if (ret > 0) {
-- 
1.8.1

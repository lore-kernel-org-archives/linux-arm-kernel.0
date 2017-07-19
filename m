From: dja@axtens.net (Daniel Axtens)
Date: Wed, 19 Jul 2017 12:15:15 +1000
Subject: [PATCH v2 3/4] powerpc: replace vga_fixup() with generic code
In-Reply-To: <20170719021516.24718-1-dja@axtens.net>
References: <20170719021516.24718-1-dja@axtens.net>
Message-ID: <20170719021516.24718-4-dja@axtens.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, we do a PCI fixup to mark a default card so that Xorg
autoconfiguration works.

There is a new generic method to do this sort of vga fixup.

Code-wise, it is identical, however instead of firing at the
FIXUP_FINAL stage it fires at the FIXUP_ENABLE stage. This means
a card will not be marked as default unless a driver enables it.

Cc: Brian King <brking@linux.vnet.ibm.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>

---

Tested with xeyes on qemu TCG, which does use this code path.
---
 arch/powerpc/Kconfig             |  1 +
 arch/powerpc/kernel/pci-common.c | 15 ---------------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 36f858c37ca7..c28b8eb1dce1 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -140,6 +140,7 @@ config PPC
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF		if PPC64
 	select ARCH_WANT_IPC_PARSE_VERSION
+	select ARCH_WANT_VGA_ARB_FALLBACK
 	select ARCH_WEAK_RELEASE_ACQUIRE
 	select BINFMT_ELF
 	select BUILDTIME_EXTABLE_SORT
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index c95fdda3a2dc..7b093a4fa85d 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1741,18 +1741,3 @@ static void fixup_hide_host_resource_fsl(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MOTOROLA, PCI_ANY_ID, fixup_hide_host_resource_fsl);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, fixup_hide_host_resource_fsl);
-
-static void fixup_vga(struct pci_dev *pdev)
-{
-	u16 cmd;
-
-	if (vga_default_device())
-		return;
-
-	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
-	if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY))
-		vga_set_default_device(pdev);
-
-}
-DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
-			      PCI_CLASS_DISPLAY_VGA, 8, fixup_vga);
-- 
2.11.0

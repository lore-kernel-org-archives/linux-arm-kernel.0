From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 11 Mar 2018 12:38:14 +0000
Subject: [PATCH v8 5/6] PCI: Add support for relative addressing in quirk
 tables
In-Reply-To: <20180311123815.17916-1-ard.biesheuvel@linaro.org>
References: <20180311123815.17916-1-ard.biesheuvel@linaro.org>
Message-ID: <20180311123815.17916-6-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow the PCI quirk tables to be emitted in a way that avoids absolute
references to the hook functions. This reduces the size of the entries,
and, more importantly, makes them invariant under runtime relocation
(e.g., for KASLR)

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/pci/quirks.c | 12 +++++++++---
 include/linux/pci.h  | 20 ++++++++++++++++++++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 8b14bd326d4a..24abfaccd2a0 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3563,9 +3563,15 @@ static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f,
 		     f->vendor == (u16) PCI_ANY_ID) &&
 		    (f->device == dev->device ||
 		     f->device == (u16) PCI_ANY_ID)) {
-			calltime = fixup_debug_start(dev, f->hook);
-			f->hook(dev);
-			fixup_debug_report(dev, calltime, f->hook);
+			void (*hook)(struct pci_dev *dev);
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+			hook = offset_to_ptr(&f->hook_offset);
+#else
+			hook = f->hook;
+#endif
+			calltime = fixup_debug_start(dev, hook);
+			hook(dev);
+			fixup_debug_report(dev, calltime, hook);
 		}
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 024a1beda008..765044bb9e8e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1790,7 +1790,11 @@ struct pci_fixup {
 	u16 device;			/* Or PCI_ANY_ID */
 	u32 class;			/* Or PCI_ANY_ID */
 	unsigned int class_shift;	/* should be 0, 8, 16 */
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+	int hook_offset;
+#else
 	void (*hook)(struct pci_dev *dev);
+#endif
 };
 
 enum pci_fixup_pass {
@@ -1804,12 +1808,28 @@ enum pci_fixup_pass {
 	pci_fixup_suspend_late,	/* pci_device_suspend_late() */
 };
 
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+#define __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
+				    class_shift, hook)			\
+	__ADDRESSABLE(hook)						\
+	asm(".section "	#sec ", \"a\"				\n"	\
+	    ".balign	16					\n"	\
+	    ".short "	#vendor ", " #device "			\n"	\
+	    ".long "	#class ", " #class_shift "		\n"	\
+	    ".long "	VMLINUX_SYMBOL_STR(hook) " - .		\n"	\
+	    ".previous						\n");
+#define DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
+				  class_shift, hook)			\
+	__DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
+				  class_shift, hook)
+#else
 /* Anonymous variables would be nice... */
 #define DECLARE_PCI_FIXUP_SECTION(section, name, vendor, device, class,	\
 				  class_shift, hook)			\
 	static const struct pci_fixup __PASTE(__pci_fixup_##name,__LINE__) __used	\
 	__attribute__((__section__(#section), aligned((sizeof(void *)))))    \
 		= { vendor, device, class, class_shift, hook };
+#endif
 
 #define DECLARE_PCI_FIXUP_CLASS_EARLY(vendor, device, class,		\
 					 class_shift, hook)		\
-- 
2.15.1

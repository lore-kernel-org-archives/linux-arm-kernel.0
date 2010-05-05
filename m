From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Wed,  5 May 2010 09:58:32 +0300
Subject: [PATCH v2 1/2] kexec: introduce phys_to_virt() function
In-Reply-To: <cover.1273041787.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1273041787.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <9cf8ec54c6a424ac84530654968d36dabfa7c4ee.1273041787.git.ext-mika.1.westerberg@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function is used by ELF crashdump code which prepares crash memory headers
for the dump capture kernel. Most architecture can use default version which
just adds PAGE_OFFSET to the virtual address but some architectures might need
some special handling.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 kexec/Makefile        |    2 ++
 kexec/crashdump-elf.c |    2 +-
 kexec/crashdump.h     |    3 +++
 kexec/phys_to_virt.c  |   16 ++++++++++++++++
 4 files changed, 22 insertions(+), 1 deletions(-)
 create mode 100644 kexec/phys_to_virt.c

diff --git a/kexec/Makefile b/kexec/Makefile
index 4e091ba..77f37ae 100644
--- a/kexec/Makefile
+++ b/kexec/Makefile
@@ -39,6 +39,8 @@ $(ARCH)_PROC_IOMEM		= kexec/proc_iomem.c
 KEXEC_SRCS += $($(ARCH)_PROC_IOMEM)
 $(ARCH)_VIRT_TO_PHYS		= kexec/virt_to_phys.c
 KEXEC_SRCS += $($(ARCH)_VIRT_TO_PHYS)
+$(ARCH)_PHYS_TO_VIRT		= kexec/phys_to_virt.c
+KEXEC_SRCS += $($(ARCH)_PHYS_TO_VIRT)
 $(ARCH)_ADD_SEGMENT		= kexec/add_segment.c
 KEXEC_SRCS += $($(ARCH)_ADD_SEGMENT)
 $(ARCH)_ADD_BUFFER		= kexec/add_buffer.c
diff --git a/kexec/crashdump-elf.c b/kexec/crashdump-elf.c
index 6bcef8d..f000e42 100644
--- a/kexec/crashdump-elf.c
+++ b/kexec/crashdump-elf.c
@@ -236,7 +236,7 @@ int FUNC(struct kexec_info *info,
 		 * memory region.
 		 */
 		phdr->p_paddr = mstart;
-		phdr->p_vaddr = mstart + elf_info->page_offset;
+		phdr->p_vaddr = phys_to_virt(elf_info, mstart);
 		phdr->p_filesz	= phdr->p_memsz	= mend - mstart + 1;
 		/* Do we need any alignment of segments? */
 		phdr->p_align	= 0;
diff --git a/kexec/crashdump.h b/kexec/crashdump.h
index 30d6f29..b6e60cc 100644
--- a/kexec/crashdump.h
+++ b/kexec/crashdump.h
@@ -46,6 +46,9 @@ int crash_create_elf64_headers(struct kexec_info *info,
 
 unsigned long crash_architecture(struct crash_elf_info *elf_info);
 
+unsigned long phys_to_virt(struct crash_elf_info *elf_info,
+			   unsigned long paddr);
+
 int xen_present(void);
 unsigned long xen_architecture(struct crash_elf_info *elf_info);
 int xen_get_nr_phys_cpus(void);
diff --git a/kexec/phys_to_virt.c b/kexec/phys_to_virt.c
new file mode 100644
index 0000000..91b6d01
--- /dev/null
+++ b/kexec/phys_to_virt.c
@@ -0,0 +1,16 @@
+#include "kexec.h"
+#include "crashdump.h"
+
+/**
+ * phys_to_virt() - translate physical address to virtual address
+ * @paddr: physical address to translate
+ *
+ * For most architectures physical address is simply virtual address minus
+ * PAGE_OFFSET. Architectures that don't follow this convention should provide
+ * their own implementation.
+ */
+unsigned long
+phys_to_virt(struct crash_elf_info *elf_info, unsigned long paddr)
+{
+	return paddr + elf_info->page_offset;
+}
-- 
1.5.6.5

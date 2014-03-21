From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Fri, 21 Mar 2014 11:16:11 -0500
Subject: [PATCH v4] ARM: vDSO gettimeofday using generic timer architecture
In-Reply-To: <CAPvkgC1K-_DTo7JreJm2v3Bp8keQY7Kwv6LD5c37-ii9+n5eMQ@mail.gmail.com>
References: <1394734769-32760-1-git-send-email-nathan_lynch@mentor.com>	<CAASgrz0SaoNGb+ss6ZS+Zh_NoBzmznaneRur7xzp4_dyGb-wMg@mail.gmail.com>
 <CAPvkgC1K-_DTo7JreJm2v3Bp8keQY7Kwv6LD5c37-ii9+n5eMQ@mail.gmail.com>
Message-ID: <532C65CB.2080501@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2014 09:58 AM, Steve Capper wrote:
> On 18 March 2014 00:49, David Riley <davidriley@chromium.org> wrote:
>> Hi Nathan,
>>
>> I gave this a try against a 3.10 system and ran into issues when
>> vdso.so grew to two pages because of of a large .GCC.command.line
>> section.  __get_datapage was returning an address that was at the
>> beginning of the second code page instead of the data page since it
>> didn't account for the additional section.  I got it working by adding
>> .GCC.command.line to the DISCARD group in the linker script, but in
>> general it feels as if this code is a bit fragile since it depends on
>> knowing exactly which sections exist in the .so for the _vdso_data
>> symbol to be correct.
>>
>> Cheers,
>> David
>>
> 
> Hi David,
> Could you please send us the following output:
> $ nm -C ./arch/arm/kernel/vdso/vdso.so.dbg
> 
> For the vdso without the extra DISCARD?
> (As I'm interested in the alignment of __vdso_data)

Something like this, I imagine: (I just added -frecord-gcc-switches to 
ccflags-y):

00000770 t __aeabi_idiv0
00000774 t __aeabi_ldiv0
00000778 t __aeabi_unwind_cpp_pr0
0000077c t __aeabi_unwind_cpp_pr1
00000780 t __aeabi_unwind_cpp_pr2
0000076c t __div0
000002e8 t do_realtime
00000240 a _DYNAMIC
00000788 t __get_datapage
00000798 a _GLOBAL_OFFSET_TABLE_
0000066c T __kernel_clock_getres
000003f8 T __kernel_clock_gettime
000006e4 T __kernel_gettimeofday
00000000 A LINUX_3.15
00001000 d _vdso_data

And yes, vdso.so.dbg and vdso.so come out larger than 4K.  So 
_vdso_data is wrong (we'd want it to be 0x2000).

The issue, I think, is the linker is free to deposit "orphan" sections 
-- those which aren't explicitly treated in the linker script -- such 
as .GCC.command.line wherever it sees fit, and the counter in the
linker script doesn't account for those.  So it seems to me that 
mapping the data page after the text is a losing game, and it's more 
robust to map it at the beginning of the VMA.

Incremental patch against v4 below, tested okay on OMAP5:

 arch/arm/include/asm/elf.h           | 11 +++++++----
 arch/arm/include/asm/vdso_datapage.h |  7 +++++++
 arch/arm/kernel/asm-offsets.c        |  5 +++++
 arch/arm/kernel/vdso.c               | 14 ++++++--------
 arch/arm/kernel/vdso/datapage.S      |  3 ++-
 arch/arm/kernel/vdso/vdso.lds.S      |  6 +++---
 6 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index fc96b78a8102..45d2ddff662a 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -3,6 +3,7 @@
 
 #include <asm/auxvec.h>
 #include <asm/hwcap.h>
+#include <asm/vdso_datapage.h>
 
 /*
  * ELF register definitions..
@@ -131,10 +132,12 @@ extern unsigned long arch_randomize_brk(struct mm_struct *mm);
 
 #ifdef CONFIG_MMU
 #ifdef CONFIG_VDSO
-#define ARCH_DLINFO							\
-do {									\
-	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
-		    (elf_addr_t)current->mm->context.vdso);		\
+#define ARCH_DLINFO								\
+do {										\
+	/* Account for the data page at the beginning of the [vdso] VMA. */	\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR,						\
+		    (elf_addr_t)current->mm->context.vdso +			\
+		    sizeof(union vdso_data_store));				\
 } while (0)
 #endif
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
diff --git a/arch/arm/include/asm/vdso_datapage.h b/arch/arm/include/asm/vdso_datapage.h
index 9011ec75a24b..f08bdb73d3f4 100644
--- a/arch/arm/include/asm/vdso_datapage.h
+++ b/arch/arm/include/asm/vdso_datapage.h
@@ -22,6 +22,8 @@
 
 #ifndef __ASSEMBLY__
 
+#include <asm/page.h>
+
 /* Try to be cache-friendly on systems that don't implement the
  * generic timer: fit the unconditionally updated fields in the first
  * 32 bytes.
@@ -46,6 +48,11 @@ struct vdso_data {
 	u32 tz_dsttime;
 };
 
+union vdso_data_store {
+	struct vdso_data data;
+	u8 page[PAGE_SIZE];
+};
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index ded041711beb..dda3363ef0bf 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -24,6 +24,7 @@
 #include <asm/memory.h>
 #include <asm/procinfo.h>
 #include <asm/suspend.h>
+#include <asm/vdso_datapage.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <linux/kbuild.h>
 
@@ -199,5 +200,9 @@ int main(void)
 #endif
   DEFINE(KVM_VTTBR,		offsetof(struct kvm, arch.vttbr));
 #endif
+  BLANK();
+#ifdef CONFIG_VDSO
+  DEFINE(VDSO_DATA_SIZE,	sizeof(union vdso_data_store));
+#endif
   return 0; 
 }
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index 91cbc5f14fb5..1a2bc699c1ac 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -33,11 +33,8 @@ static unsigned long vdso_pages;
 static unsigned long vdso_mapping_len;
 static struct page **vdso_pagelist;
 
-static union {
-	struct vdso_data	data;
-	u8			page[PAGE_SIZE];
-} vdso_data_store __page_aligned_data;
-struct vdso_data *vdso_data = &vdso_data_store.data;
+static union vdso_data_store vdso_data_store __page_aligned_data;
+static struct vdso_data *vdso_data = &vdso_data_store.data;
 
 /*
  * The vDSO data page.
@@ -62,12 +59,13 @@ static int __init vdso_init(void)
 	if (vdso_pagelist == NULL)
 		return -ENOMEM;
 
+	/* Grab the vDSO data page. */
+	vdso_pagelist[0] = virt_to_page(vdso_data);
+
 	/* Grab the vDSO code pages. */
 	for (i = 0; i < vdso_pages; i++)
-		vdso_pagelist[i] = virt_to_page(&vdso_start + i * PAGE_SIZE);
+		vdso_pagelist[i + 1] = virt_to_page(&vdso_start + i * PAGE_SIZE);
 
-	/* Grab the vDSO data page. */
-	vdso_pagelist[i] = virt_to_page(vdso_data);
 
 	/* Precompute the mapping size */
 	vdso_mapping_len = (vdso_pages + 1) << PAGE_SHIFT;
diff --git a/arch/arm/kernel/vdso/datapage.S b/arch/arm/kernel/vdso/datapage.S
index 91b19b815888..fbf36d75da06 100644
--- a/arch/arm/kernel/vdso/datapage.S
+++ b/arch/arm/kernel/vdso/datapage.S
@@ -1,8 +1,9 @@
 #include <linux/linkage.h>
+#include <asm/asm-offsets.h>
 
 	.align 2
 .L_vdso_data_ptr:
-	.long	_vdso_data - .
+	.long	_start - . - VDSO_DATA_SIZE
 
 ENTRY(__get_datapage)
 	.cfi_startproc
diff --git a/arch/arm/kernel/vdso/vdso.lds.S b/arch/arm/kernel/vdso/vdso.lds.S
index 24dd7b84e366..799d259f86e0 100644
--- a/arch/arm/kernel/vdso/vdso.lds.S
+++ b/arch/arm/kernel/vdso/vdso.lds.S
@@ -30,6 +30,8 @@ OUTPUT_ARCH(arm)
 
 SECTIONS
 {
+	PROVIDE(_start = .);
+
 	. = VDSO_LBASE + SIZEOF_HEADERS;
 
 	.hash		: { *(.hash) }			:text
@@ -55,14 +57,12 @@ SECTIONS
 	.got		: { *(.got) }
 	.rel.plt	: { *(.rel.plt) }
 
-	. = ALIGN(PAGE_SIZE);
-	PROVIDE(_vdso_data = .);
-
 	/DISCARD/	: {
 		*(.note.GNU-stack)
 		*(.data .data.* .gnu.linkonce.d.* .sdata*)
 		*(.bss .sbss .dynbss .dynsbss)
 	}
+
 }
 
 /*

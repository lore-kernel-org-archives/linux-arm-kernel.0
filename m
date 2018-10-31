From: vincent.whitchurch@axis.com (Vincent Whitchurch)
Date: Wed, 31 Oct 2018 09:42:53 +0100
Subject: [PATCH v2] ARM: module: Fix function kallsyms on Thumb-2
Message-ID: <20181031084253.9650-1-vincent.whitchurch@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thumb-2 functions have the lowest bit set in the symbol value in the
symtab.  When kallsyms are generated for the vmlinux, the kallsyms are
generated from the output of nm, and nm clears the lowest bit.

 $ arm-linux-gnueabihf-readelf -a vmlinux | grep show_interrupts
  95947: 8015dc89   686 FUNC    GLOBAL DEFAULT    2 show_interrupts
 $ arm-linux-gnueabihf-nm vmlinux | grep show_interrupts
 8015dc88 T show_interrupts
 $ cat /proc/kallsyms | grep show_interrupts
 8015dc88 T show_interrupts

However, for modules, the kallsyms uses the values in the symbol table
without modification, so for functions in modules, the lowest bit is set
in kallsyms.

 $ arm-linux-gnueabihf-readelf -a drivers/net/tun.ko | grep tun_get_socket
    268: 000000e1    44 FUNC    GLOBAL DEFAULT    2 tun_get_socket
 $ arm-linux-gnueabihf-nm drivers/net/tun.ko | grep tun_get_socket
 000000e0 T tun_get_socket
 $ cat /proc/kallsyms | grep tun_get_socket
 7fcd30e1 t tun_get_socket  [tun]

Because of this, the offset of the crashing instruction shown in oopses
is incorrect when the crash is in a module.  For example, given a
tun_get_socket which starts like this,

 000000e0 <tun_get_socket>:
       e0:       b500            push    {lr}
       e2:       f7ff fffe       bl      0 <__gnu_mcount_nc>
       e6:       4b08            ldr     r3, [pc, #32]
       e8:       6942            ldr     r2, [r0, #20]
       ea:       429a            cmp     r2, r3
       ec:       d002            beq.n   f4 <tun_get_socket+0x14>

a crash when tun_get_socket is called with NULL results in:

 PC is at tun_get_socket+0x7/0x2c [tun]
 pc : [<7fcdb0e8>]

which can result in the incorrect line being reported by gdb if this
symbol+offset is used there.  If the crash is on the first instruction
of a function, the "PC is at" line would also report the symbol name of
the preceding function.

To solve this, fix up these symbols like nm does.  For this, we need a
new hook in the generic module loading code, before the symbols' st_info
is overwritten by add_kallsyms().  After the fix:

 $ cat /proc/kallsyms | grep tun_get_socket
 7fcd30e0 t tun_get_socket  [tun]

 PC is at tun_get_socket+0x8/0x2c [tun]
 pc : [<7fcdb0e8>]

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
v2: Fix build warning with !MODULES

 arch/arm/kernel/module.c     | 14 ++++++++++++++
 include/linux/moduleloader.h |  3 +++
 kernel/module.c              |  6 ++++++
 3 files changed, 23 insertions(+)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 3ff571c2c71c..771f86318d84 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -399,6 +399,20 @@ int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
 	return 0;
 }
 
+#if defined(CONFIG_THUMB2_KERNEL) && defined(CONFIG_KALLSYMS)
+void module_fixup_kallsyms(struct mod_kallsyms *kallsyms)
+{
+	int i;
+
+	for (i = 0; i < kallsyms->num_symtab; i++) {
+		Elf_Sym *sym = &kallsyms->symtab[i];
+
+		if (ELF_ST_TYPE(sym->st_info) == STT_FUNC)
+			sym->st_value &= ~1;
+	}
+}
+#endif
+
 void
 module_arch_cleanup(struct module *mod)
 {
diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
index 31013c2effd3..b1ac5584eaa5 100644
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -86,6 +86,9 @@ void module_arch_cleanup(struct module *mod);
 /* Any cleanup before freeing mod->module_init */
 void module_arch_freeing_init(struct module *mod);
 
+struct mod_kallsyms;
+void module_fixup_kallsyms(struct mod_kallsyms *kallsyms);
+
 #ifdef CONFIG_KASAN
 #include <linux/kasan.h>
 #define MODULE_ALIGN (PAGE_SIZE << KASAN_SHADOW_SCALE_SHIFT)
diff --git a/kernel/module.c b/kernel/module.c
index 49a405891587..ded4f4b49824 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2659,6 +2659,10 @@ static void layout_symtab(struct module *mod, struct load_info *info)
 	mod->init_layout.size = debug_align(mod->init_layout.size);
 }
 
+void __weak module_fixup_kallsyms(struct mod_kallsyms *kallsyms)
+{
+}
+
 /*
  * We use the full symtab and strtab which layout_symtab arranged to
  * be appended to the init section.  Later we switch to the cut-down
@@ -2680,6 +2684,8 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
 	/* Make sure we get permanent strtab: don't use info->strtab. */
 	mod->kallsyms->strtab = (void *)info->sechdrs[info->index.str].sh_addr;
 
+	module_fixup_kallsyms(mod->kallsyms);
+
 	/* Set types up while we still have access to sections. */
 	for (i = 0; i < mod->kallsyms->num_symtab; i++)
 		mod->kallsyms->symtab[i].st_info
-- 
2.11.0

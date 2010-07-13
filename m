From: eric.miao@canonical.com (Eric Miao)
Date: Tue, 13 Jul 2010 23:33:16 +0800
Subject: [PATCH 01/13] [ARM] Introduce 'struct machine_class' for SoC level
	abstraction
In-Reply-To: <1279035208-7249-1-git-send-email-eric.miao@canonical.com>
References: <1279035208-7249-1-git-send-email-eric.miao@canonical.com>
Message-ID: <1279035208-7249-2-git-send-email-eric.miao@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce 'struct machine_class' to group common elements shared by a
class of machines (i.e. normally SoC level). The elements in 'struct
machine_desc' will override if provided. (Note zero is considered
invalid for phys_io, io_pg_offst and boot_params, and if they are
zero, the version in 'class' will be used)

Signed-off-by: Eric Miao <eric.miao@canonical.com>
---
 arch/arm/include/asm/mach/arch.h |   20 ++++++++++++++++++++
 arch/arm/kernel/asm-offsets.c    |    4 ++++
 arch/arm/kernel/head-common.S    |    3 +++
 arch/arm/kernel/head.S           |    8 +++++++-
 arch/arm/kernel/setup.c          |   15 +++++++++++----
 arch/arm/mm/mmu.c                |    5 +++++
 6 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index dd15c0f..d43bdb5 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -14,6 +14,25 @@ struct tag;
 struct meminfo;
 struct sys_timer;
 
+/*
+ * 'struct machine_class' groups the common elements shared by a class
+ * of machines. The elements in 'struct machine_desc' will override if
+ * provided. (Note zero is considered invalid for phys_io, io_pg_offst
+ * and boot_params, and if they are zero, the version in 'class' will
+ * be used)
+ */
+struct machine_class {
+	unsigned int		phys_io;	/* start of physical io	*/
+	unsigned int		io_pg_offst;	/* byte offset for io
+						 * page tabe entry	*/
+	const char		*name;		/* machine class name	*/
+	unsigned long		boot_params;	/* tagged list		*/
+
+	void			(*map_io)(void);/* IO mapping function */
+	void			(*init_irq)(void);
+	struct sys_timer	*timer;
+};
+
 struct machine_desc {
 	/*
 	 * Note! The first four elements are used
@@ -26,6 +45,7 @@ struct machine_desc {
 						 * page tabe entry	*/
 
 	const char		*name;		/* architecture name	*/
+	struct machine_class	*class;		/* machine class */
 	unsigned long		boot_params;	/* tagged list		*/
 
 	unsigned int		video_start;	/* start of video RAM	*/
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 8835115..5c9038a 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -101,6 +101,10 @@ int main(void)
   DEFINE(MACHINFO_NAME,		offsetof(struct machine_desc, name));
   DEFINE(MACHINFO_PHYSIO,	offsetof(struct machine_desc, phys_io));
   DEFINE(MACHINFO_PGOFFIO,	offsetof(struct machine_desc, io_pg_offst));
+  DEFINE(MACHINFO_CLASS,	offsetof(struct machine_desc, class));
+  BLANK();
+  DEFINE(MACHCLASS_PHYSIO,	offsetof(struct machine_class, phys_io));
+  DEFINE(MACHCLASS_PGOFFIO,	offsetof(struct machine_class, io_pg_offst));
   BLANK();
   DEFINE(PROC_INFO_SZ,		sizeof(struct proc_info_list));
   DEFINE(PROCINFO_INITFUNC,	offsetof(struct proc_info_list, __cpu_flush));
diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index b9505aa..660756b 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -207,6 +207,7 @@ ENDPROC(lookup_processor_type)
  * Returns:
  *  r3, r4, r6 corrupted
  *  r5 = mach_info pointer in physical address space
+ *  r7 = machine_class pointer in physical address space
  */
 __lookup_machine_type:
 	adr	r3, 4b
@@ -214,6 +215,8 @@ __lookup_machine_type:
 	sub	r3, r3, r4			@ get offset between virt&phys
 	add	r5, r5, r3			@ convert virt addresses to
 	add	r6, r6, r3			@ physical address space
+	ldr	r7, [r5, #MACHINFO_CLASS]	@ get machine class
+	add	r7, r7, r3
 1:	ldr	r3, [r5, #MACHINFO_TYPE]	@ get machine type
 	teq	r3, r1				@ matches loader number?
 	beq	2f				@ found
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index eb62bf9..974d19d 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -82,8 +82,9 @@ ENTRY(stext)
 	bl	__lookup_processor_type		@ r5=procinfo r9=cpuid
 	movs	r10, r5				@ invalid processor (r5=0)?
 	beq	__error_p			@ yes, error 'p'
-	bl	__lookup_machine_type		@ r5=machinfo
+	bl	__lookup_machine_type		@ r5=machinfo,r7=machine_class
 	movs	r8, r5				@ invalid machine (r5=0)?
+	mov	r11, r7
 	beq	__error_a			@ yes, error 'a'
 	bl	__vet_atags
 	bl	__create_page_tables
@@ -211,6 +212,7 @@ ENDPROC(__turn_mmu_on)
  * r8  = machinfo
  * r9  = cpuid
  * r10 = procinfo
+ * r11 = machine_class
  *
  * Returns:
  *  r0, r3, r6, r7 corrupted
@@ -296,12 +298,16 @@ __create_page_tables:
 	 * via a serial console before paging_init.
 	 */
 	ldr	r3, [r8, #MACHINFO_PGOFFIO]
+	cmp	r3, #0				@ use class->io_pg_offst if
+	ldreq	r3, [r11, #MACHCLASS_PGOFFIO]	@ mdesc->io_pg_offst == 0
 	add	r0, r4, r3
 	rsb	r3, r3, #0x4000			@ PTRS_PER_PGD*sizeof(long)
 	cmp	r3, #0x0800			@ limit to 512MB
 	movhi	r3, #0x0800
 	add	r6, r0, r3
 	ldr	r3, [r8, #MACHINFO_PHYSIO]
+	cmp	r3, #0				@ use class->phys_io if
+	ldreq	r3, [r11, #MACHINFO_PHYSIO]	@ mdesc->phys_io == 0
 	orr	r3, r3, r7
 1:	str	r3, [r0], #4
 	add	r3, r3, #1 << 20
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 55a5851..b5233ab 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -665,12 +665,14 @@ void __init setup_arch(char **cmdline_p)
 {
 	struct tag *tags = (struct tag *)&init_tags;
 	struct machine_desc *mdesc;
+	struct machine_class *class;
 	char *from = default_command_line;
 
 	unwind_init();
 
 	setup_processor();
 	mdesc = setup_machine(machine_arch_type);
+	class = mdesc->class;
 	machine_name = mdesc->name;
 
 	if (mdesc->soft_reboot)
@@ -678,8 +680,13 @@ void __init setup_arch(char **cmdline_p)
 
 	if (__atags_pointer)
 		tags = phys_to_virt(__atags_pointer);
-	else if (mdesc->boot_params)
-		tags = phys_to_virt(mdesc->boot_params);
+	else {
+		unsigned long boot_params = mdesc->boot_params ?
+					    mdesc->boot_params :
+					   (class ? class->boot_params: 0);
+		if (boot_params)
+			tags = phys_to_virt(boot_params);
+	}
 
 	/*
 	 * If we have the old style parameters, convert them to
@@ -730,8 +737,8 @@ void __init setup_arch(char **cmdline_p)
 	 * Set up various architecture-specific pointers
 	 */
 	arch_nr_irqs = mdesc->nr_irqs;
-	init_arch_irq = mdesc->init_irq;
-	system_timer = mdesc->timer;
+	init_arch_irq = mdesc->init_irq ? : (class ? class->init_irq : NULL);
+	system_timer = mdesc->timer ? : (class ? class->timer : NULL);
 	init_machine = mdesc->init_machine;
 
 #ifdef CONFIG_VT
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index f61c21c..2b7c474 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -868,6 +868,7 @@ void __init arm_mm_lmb_reserve(void)
  */
 static void __init devicemaps_init(struct machine_desc *mdesc)
 {
+	struct machine_class *class = mdesc->class;
 	struct map_desc map;
 	unsigned long addr;
 	void *vectors;
@@ -932,6 +933,10 @@ static void __init devicemaps_init(struct machine_desc *mdesc)
 	 */
 	if (mdesc->map_io)
 		mdesc->map_io();
+	else {
+		if (class && class->map_io)
+			class->map_io();
+	}
 
 	/*
 	 * Finally flush the caches and tlb to ensure that we're in a
-- 
1.7.1

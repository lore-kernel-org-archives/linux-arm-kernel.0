From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Sun, 10 Oct 2010 05:20:22 +0300
Subject: [PATCH] arm: mm: allow boards to fiddle with meminfo
Message-ID: <1286677222-17898-1-git-send-email-felipe.contreras@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So that they can reserve some memory.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/include/asm/mach/arch.h |    2 +-
 arch/arm/mm/init.c               |    7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 8a0dd18..408e4d5 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -38,7 +38,7 @@ struct machine_desc {
 	void			(*fixup)(struct machine_desc *,
 					 struct tag *, char **,
 					 struct meminfo *);
-	void			(*reserve)(void);/* reserve mem blocks	*/
+	void			(*reserve)(struct meminfo *);/* reserve mem blocks	*/
 	void			(*map_io)(void);/* IO mapping function	*/
 	void			(*init_irq)(void);
 	struct sys_timer	*timer;		/* system tick timer	*/
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 7185b00..4b5c117 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -272,8 +272,6 @@ void __init arm_memblock_init(struct meminfo *mi, struct machine_desc *mdesc)
 	int i;
 
 	memblock_init();
-	for (i = 0; i < mi->nr_banks; i++)
-		memblock_add(mi->bank[i].start, mi->bank[i].size);
 
 	/* Register the kernel text, kernel data and initrd with memblock. */
 #ifdef CONFIG_XIP_KERNEL
@@ -295,7 +293,10 @@ void __init arm_memblock_init(struct meminfo *mi, struct machine_desc *mdesc)
 
 	/* reserve any platform specific memblock areas */
 	if (mdesc->reserve)
-		mdesc->reserve();
+		mdesc->reserve(mi);
+
+	for (i = 0; i < mi->nr_banks; i++)
+		memblock_add(mi->bank[i].start, mi->bank[i].size);
 
 	memblock_analyze();
 	memblock_dump_all();
-- 
1.7.3.1.2.g7fe2b

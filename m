From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:46:46 -0400
Subject: [PATCH 01/52] ARM: introduce atag_offset to replace boot_params
Message-ID: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The boot_params member of the mdesc structure is used to provide a
default physical address for the ATAG list.  Since this value is fixed
at compile time and often based on ARCH_PHYS_OFFSET, it gets in the way
of runtime PHYS_OFFSET usage.

Let's introduce atag_offset which should contains only the relative
offset from start of memory instead of an absolute value, in preparation
to move all instance of boot_params over to it.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/include/asm/mach/arch.h |    1 +
 arch/arm/kernel/setup.c          |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 7b79a00..1bdf6e1 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -18,6 +18,7 @@ struct machine_desc {
 	unsigned int		nr;		/* architecture number	*/
 	const char		*name;		/* architecture name	*/
 	unsigned long		boot_params;	/* tagged list		*/
+	unsigned long		atag_offset;	/* tagged list (relative) */
 	const char		**dt_compat;	/* array of device tree
 						 * 'compatible' strings	*/
 
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index e0db84d..4cc3e2b 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -816,6 +816,8 @@ static struct machine_desc * __init setup_machine_tags(unsigned int nr)
 
 	if (__atags_pointer)
 		tags = phys_to_virt(__atags_pointer);
+	else if(mdesc->atag_offset)
+		tags = PAGE_OFFSET + mdesc->atag_offset;
 	else if (mdesc->boot_params) {
 #ifdef CONFIG_MMU
 		/*
-- 
1.7.4

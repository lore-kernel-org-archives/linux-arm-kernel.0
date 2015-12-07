From: keescook@chromium.org (Kees Cook)
Date: Mon, 7 Dec 2015 12:54:32 -0800
Subject: [PATCH] ARM: mm: mark section-aligned portion of rodata NX
Message-ID: <20151207205432.GA5271@www.outflux.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When rodata is large enough that it crosses a section boundary after the
kernel text, mark the rest NX. This is as close to full NX of rodata as
we can get without splitting page tables or doing section alignment via
CONFIG_DEBUG_ALIGN_RODATA.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
I am baffled why I can't put the ALIGN in the ".start = " initializer.
GCC seems to think it's non-static, but only because of the "&" operator.
Does anyone see a way to do this that doesn't require the runtime ALIGN?
---
 arch/arm/mm/init.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 321d3683dc7c..b40a0536ef60 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -579,6 +579,8 @@ struct section_perm {
 	pmdval_t clear;
 };
 
+#define RODATA_IDX	0
+
 static struct section_perm nx_perms[] = {
 	/* Make pages tables, etc before _stext RW (set NX). */
 	{
@@ -596,16 +598,14 @@ static struct section_perm nx_perms[] = {
 		.mask	= ~PMD_SECT_XN,
 		.prot	= PMD_SECT_XN,
 	},
-#ifdef CONFIG_DEBUG_ALIGN_RODATA
 	/* Make rodata NX (set RO in ro_perms below). */
-	{
+	[RODATA_IDX] = {
 		.name	= "rodata NX",
 		.start  = (unsigned long)__start_rodata,
 		.end    = (unsigned long)__init_begin,
 		.mask   = ~PMD_SECT_XN,
 		.prot   = PMD_SECT_XN,
 	},
-#endif
 };
 
 static struct section_perm ro_perms[] = {
@@ -709,6 +709,9 @@ int __fix_kernmem_perms(void *unused)
 
 void fix_kernmem_perms(void)
 {
+	/* rodata may not be section aligned, so cover as much as we can. */
+	nx_perms[RODATA_IDX].start = ALIGN(nx_perms[RODATA_IDX].start,
+					   SECTION_SIZE);
 	stop_machine(__fix_kernmem_perms, NULL, NULL);
 }
 
-- 
1.9.1


-- 
Kees Cook
Chrome OS & Brillo Security

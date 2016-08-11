From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 11 Aug 2016 21:52:19 +0800
Subject: [PATCH v2] ARM: VDSO: put RO and RO after init objects into proper
 sections
Message-ID: <1470923539-958-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vdso_data_mapping is never modified, so mark it as const.

vdso_total_pages, vdso_data_page, vdso_text_mapping and cntvct_ok are
initialized by vdso_init(), thereafter are read only.

The fact that they are read only after init makes them candidates for
__ro_after_init declarations.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---

Since v1:
  - use __ro_after_init instead of __read_mostly
  - apply __ro_after_init for vdso_total_pages and cntvct_ok as well

 arch/arm/kernel/vdso.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index 994e971..b81c7197 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -39,7 +39,7 @@
 static struct page **vdso_text_pagelist;
 
 /* Total number of pages needed for the data and text portions of the VDSO. */
-unsigned int vdso_total_pages __read_mostly;
+unsigned int vdso_total_pages __ro_after_init;
 
 /*
  * The VDSO data page.
@@ -47,13 +47,13 @@ unsigned int vdso_total_pages __read_mostly;
 static union vdso_data_store vdso_data_store __page_aligned_data;
 static struct vdso_data *vdso_data = &vdso_data_store.data;
 
-static struct page *vdso_data_page;
-static struct vm_special_mapping vdso_data_mapping = {
+static struct page *vdso_data_page __ro_after_init;
+static const struct vm_special_mapping vdso_data_mapping = {
 	.name = "[vvar]",
 	.pages = &vdso_data_page,
 };
 
-static struct vm_special_mapping vdso_text_mapping = {
+static struct vm_special_mapping vdso_text_mapping __ro_after_init = {
 	.name = "[vdso]",
 };
 
@@ -67,7 +67,7 @@ struct elfinfo {
 /* Cached result of boot-time check for whether the arch timer exists,
  * and if so, whether the virtual counter is useable.
  */
-static bool cntvct_ok __read_mostly;
+static bool cntvct_ok __ro_after_init;
 
 static bool __init cntvct_functional(void)
 {
-- 
2.8.1

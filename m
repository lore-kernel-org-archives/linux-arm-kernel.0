From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 10 Aug 2016 17:09:47 +0800
Subject: [PATCH] ARM: VDSO: put read only/mostly objects into proper sections
Message-ID: <1470820187-1032-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vdso_data_mapping is never modified, so mark it as const.

vdso_data_page and vdso_text_mapping are initialized by vdso_init(),
thereafter are mostly read during vdso special mapping handling.

The fact that they are mostly read and not written to makes them
candidates for __read_mostly declarations.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/kernel/vdso.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index 994e971..c946092 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -47,13 +47,13 @@ unsigned int vdso_total_pages __read_mostly;
 static union vdso_data_store vdso_data_store __page_aligned_data;
 static struct vdso_data *vdso_data = &vdso_data_store.data;
 
-static struct page *vdso_data_page;
-static struct vm_special_mapping vdso_data_mapping = {
+static struct page *vdso_data_page __read_mostly;
+static const struct vm_special_mapping vdso_data_mapping = {
 	.name = "[vvar]",
 	.pages = &vdso_data_page,
 };
 
-static struct vm_special_mapping vdso_text_mapping = {
+static struct vm_special_mapping vdso_text_mapping __read_mostly = {
 	.name = "[vdso]",
 };
 
-- 
2.8.1

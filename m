From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 22 Feb 2016 11:00:39 +0100
Subject: [PATCH 3/3] arm64: ptdump: include UEFI runtime service mappings
In-Reply-To: <1456135239-3607-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1456135239-3607-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1456135239-3607-4-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the UEFI runtime services page table mappings to the output
of the kernel page table dumper. These tables are only live during the
time UEFI runtime services are being invoked, but we can include them
for informational purposes nonetheless.

Cc: Matt Fleming <matt@codeblueprint.co.uk>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/dump.c               | 8 ++++++++
 drivers/firmware/efi/arm-runtime.c | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index 12e4b1732303..e7b937c9ad52 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -36,6 +36,10 @@ struct addr_marker {
 };
 
 static struct addr_marker address_markers[] = {
+#ifdef CONFIG_EFI
+	{ 0,				"UEFI runtime start" },
+	{ TASK_SIZE_64,			"UEFI runtime end" },
+#endif
 #ifdef CONFIG_KASAN
 	{ KASAN_SHADOW_START,		"Kasan shadow start" },
 	{ KASAN_SHADOW_END,		"Kasan shadow end" },
@@ -310,6 +314,10 @@ static int ptdump_show(struct seq_file *m, void *v)
 		.marker = address_markers,
 	};
 
+	if (IS_ENABLED(CONFIG_EFI)) {
+		extern struct mm_struct efi_mm;
+		walk_pgd(&st, &efi_mm, 0);
+	}
 	walk_pgd(&st, &init_mm, LOWEST_ADDR);
 
 	note_page(&st, 0, 0, 0);
diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 6ae21e41a429..3a3911641049 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -30,7 +30,7 @@
 
 extern u64 efi_system_table;
 
-static struct mm_struct efi_mm = {
+struct mm_struct efi_mm = {
 	.mm_rb			= RB_ROOT,
 	.mm_users		= ATOMIC_INIT(2),
 	.mm_count		= ATOMIC_INIT(1),
-- 
2.5.0

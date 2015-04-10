From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 10 Apr 2015 15:53:50 +0200
Subject: [PATCH v3 06/11] arm64: implement our own
 early_init_dt_add_memory_arch()
In-Reply-To: <1428674035-26603-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1428674035-26603-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1428674035-26603-7-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Override the __weak early_init_dt_add_memory_arch() with our own
version. Initially, this version just ignores MAX_PHYS_ADDR, but
later on, we will modify it so it can deal with PHYS_OFFSET not
having been assigned yet.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/init.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index ae85da6307bb..48175b769074 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -372,3 +372,32 @@ static int __init keepinitrd_setup(char *__unused)
 
 __setup("keepinitrd", keepinitrd_setup);
 #endif
+
+void __init early_init_dt_add_memory_arch(u64 base, u64 size)
+{
+	const u64 phys_offset = __pa(PAGE_OFFSET);
+
+	if (!PAGE_ALIGNED(base)) {
+		if (size < PAGE_SIZE - (base & ~PAGE_MASK)) {
+			pr_warn("Ignoring memory block 0x%llx - 0x%llx\n",
+				base, base + size);
+			return;
+		}
+		size -= PAGE_SIZE - (base & ~PAGE_MASK);
+		base = PAGE_ALIGN(base);
+	}
+	size &= PAGE_MASK;
+
+	if (base + size < phys_offset) {
+		pr_warning("Ignoring memory block 0x%llx - 0x%llx\n",
+			   base, base + size);
+		return;
+	}
+	if (base < phys_offset) {
+		pr_warning("Ignoring memory range 0x%llx - 0x%llx\n",
+			   base, phys_offset);
+		size -= phys_offset - base;
+		base = phys_offset;
+	}
+	memblock_add(base, size);
+}
-- 
1.8.3.2

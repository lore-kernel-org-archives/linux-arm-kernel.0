From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 16 Oct 2012 17:46:39 +0100
Subject: [PATCH 3/4] arm64: Ignore memory blocks below PHYS_OFFSET
In-Reply-To: <1350406000-30882-1-git-send-email-catalin.marinas@arm.com>
References: <1350406000-30882-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1350406000-30882-4-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to Documentation/arm64/booting.txt, the kernel image must be
loaded at a pre-defined offset from the start of RAM so that the kernel
can calculate PHYS_OFFSET based on this address. If the DT contains
memory blocks below this PHYS_OFFSET, report them and ignore the
corresponding memory range.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/setup.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 48ffb9f..7665a9b 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -170,7 +170,19 @@ static void __init setup_machine_fdt(phys_addr_t dt_phys)
 
 void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 {
+	base &= PAGE_MASK;
 	size &= PAGE_MASK;
+	if (base + size < PHYS_OFFSET) {
+		pr_warning("Ignoring memory block 0x%llx - 0x%llx\n",
+			   base, base + size);
+		return;
+	}
+	if (base < PHYS_OFFSET) {
+		pr_warning("Ignoring memory range 0x%llx - 0x%llx\n",
+			   base, PHYS_OFFSET);
+		size -= PHYS_OFFSET - base;
+		base = PHYS_OFFSET;
+	}
 	memblock_add(base, size);
 }
 

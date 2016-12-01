From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 01 Dec 2016 16:00:07 +0100
Subject: [PATCH/RFC] ARM64: use this_cpu_read in raw_smp_processor_id()
Message-ID: <1480604407-6022-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Direct access to cpu_number entry in per-cpu variables causes boot
failure on Exynos5433, so replace it with this_cpu_read() macro.
This approach is also used on x86_64.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
This change is needed to get linux-next to boot on Exynos5433, otherwise it
hangs somewhere in early init. There is even no message on the earlycon.

This issue appeared first on linux-next from 14.11.2016. The tree from
11.11.2016 is the last one, which boots on Exynos5433. I've tried to
debug a bit this issue, but I ran out of ideas.

Any comments or suggestions are welcome.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland
---
 arch/arm64/include/asm/smp.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index a62db952ffcb..d514383d6219 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -37,12 +37,7 @@
 
 DECLARE_PER_CPU_READ_MOSTLY(int, cpu_number);
 
-/*
- * We don't use this_cpu_read(cpu_number) as that has implicit writes to
- * preempt_count, and associated (compiler) barriers, that we'd like to avoid
- * the expense of. If we're preemptible, the value can be stale at use anyway.
- */
-#define raw_smp_processor_id() (*this_cpu_ptr(&cpu_number))
+#define raw_smp_processor_id() (this_cpu_read(cpu_number))
 
 struct seq_file;
 
-- 
1.9.1

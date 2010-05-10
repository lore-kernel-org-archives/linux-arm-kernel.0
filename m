From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 10 May 2010 23:43:13 +0300
Subject: [PATCH 4/5] Add suspend/resume support for RX1950
In-Reply-To: <1273524194-13346-1-git-send-email-anarsoul@gmail.com>
References: <1273524194-13346-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1273524194-13346-5-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-s3c2410/pm.c |    4 ++--
 arch/arm/mm/mmu.c          |    5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s3c2410/pm.c b/arch/arm/mach-s3c2410/pm.c
index 966119c..6a61486 100644
--- a/arch/arm/mach-s3c2410/pm.c
+++ b/arch/arm/mach-s3c2410/pm.c
@@ -60,10 +60,10 @@ static void s3c2410_pm_prepare(void)
 		__raw_writel(calc, phys_to_virt(H1940_SUSPEND_CHECKSUM));
 	}
 
-	/* the RX3715 uses similar code and the same H1940 and the
+	/* RX3715 and RX1950 use similar to H1940 code and the
 	 * same offsets for resume and checksum pointers */
 
-	if (machine_is_rx3715()) {
+	if (machine_is_rx3715() || machine_is_rx1950()) {
 		void *base = phys_to_virt(H1940_SUSPEND_CHECK);
 		unsigned long ptr;
 		unsigned long calc = 0;
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 241c24a..45a1bc2 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -869,9 +869,10 @@ void __init reserve_node_zero(pg_data_t *pgdat)
 	if (machine_is_p720t())
 		res_size = 0x00014000;
 
-	/* H1940 and RX3715 need to reserve this for suspend */
+	/* H1940, RX3715 and RX1950 need to reserve this for suspend */
 
-	if (machine_is_h1940() || machine_is_rx3715()) {
+	if (machine_is_h1940() || machine_is_rx3715()
+		|| machine_is_rx1950()) {
 		reserve_bootmem_node(pgdat, 0x30003000, 0x1000,
 				BOOTMEM_DEFAULT);
 		reserve_bootmem_node(pgdat, 0x30081000, 0x1000,
-- 
1.7.0.4

From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 25 Jan 2018 18:02:57 +0000
Subject: [RFC 23/37] ARM: shmobile: rcar-gen2: Export
 shmobile_set_wdt_clock_status function
In-Reply-To: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1516903391-30467-24-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch exposes a function to set the value of variable
"shmobile_wdt_clock_status" so that the watchdog driver may communicate
critical information to the SMP bring up assembly routine.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
---
 arch/arm/mach-shmobile/common.h       |  1 +
 arch/arm/mach-shmobile/pm-rcar-gen2.c | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index a8fa4f7..e4ffca8 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -5,6 +5,7 @@
 extern void shmobile_init_cntvoff(void);
 extern void shmobile_init_delay(void);
 extern void shmobile_boot_vector(void);
+extern unsigned long shmobile_wdt_clock_status;
 extern unsigned long shmobile_boot_fn;
 extern unsigned long shmobile_boot_size;
 extern void shmobile_smp_boot(void);
diff --git a/arch/arm/mach-shmobile/pm-rcar-gen2.c b/arch/arm/mach-shmobile/pm-rcar-gen2.c
index e5f215c..cfdc3cd 100644
--- a/arch/arm/mach-shmobile/pm-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/pm-rcar-gen2.c
@@ -50,6 +50,16 @@ static inline u32 phys_to_sbar(phys_addr_t addr)
 #define SYSCIER 0x0c
 #define SYSCIMR 0x10
 
+static void __iomem *shmobile_boot_vector_start;
+static unsigned long clock_status;
+
+void shmobile_set_wdt_clock_status(unsigned long value)
+{
+	memcpy_toio(shmobile_boot_vector_start + clock_status,
+		    &value, sizeof(value));
+}
+EXPORT_SYMBOL(shmobile_set_wdt_clock_status);
+
 #if defined(CONFIG_SMP)
 
 static void __init rcar_gen2_sysc_init(u32 syscier)
@@ -120,8 +130,12 @@ void __init rcar_gen2_pm_init(void)
 	if (!p)
 		return;
 
+	shmobile_boot_vector_start = p;
+	clock_status = (&shmobile_wdt_clock_status -
+				(unsigned long *)shmobile_boot_vector) *
+				sizeof(shmobile_wdt_clock_status);
+
 	memcpy_toio(p, shmobile_boot_vector, shmobile_boot_size);
-	iounmap(p);
 
 	/* setup reset vectors */
 	p = ioremap_nocache(RST, 0x63);
-- 
2.7.4

From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 13 Sep 2015 15:02:22 +0100
Subject: [PATCH v2 4/5] clocksource/acpi: Add probing infrastructure for
 ACPI-based clocksources
In-Reply-To: <1442152943-24493-1-git-send-email-marc.zyngier@arm.com>
References: <1442152943-24493-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1442152943-24493-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT enjoys a rather nice probing infrastructure for clocksources,
while ACPI is so far stuck into a very distant past.

This patch introduces a declarative API, allowing clocksources
to be self-contained and be called when parsing the GTDT table.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/clocksource/clksrc-of.c   | 4 ++++
 include/asm-generic/vmlinux.lds.h | 1 +
 include/linux/clocksource.h       | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/drivers/clocksource/clksrc-of.c b/drivers/clocksource/clksrc-of.c
index 0093a8e..a2105bd 100644
--- a/drivers/clocksource/clksrc-of.c
+++ b/drivers/clocksource/clksrc-of.c
@@ -14,6 +14,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/acpi.h>
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/clocksource.h>
@@ -38,6 +39,9 @@ void __init clocksource_of_init(void)
 		init_func(np);
 		clocksources++;
 	}
+
+	clocksources += acpi_probe_device_table(clksrc);
+
 	if (!clocksources)
 		pr_crit("%s: no matching clocksources found\n", __func__);
 }
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index cd836cd..c4bd0e2 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -525,6 +525,7 @@
 	KERNEL_DTB()							\
 	IRQCHIP_OF_MATCH_TABLE()					\
 	ACPI_PROBE_TABLE(irqchip)					\
+	ACPI_PROBE_TABLE(clksrc)					\
 	EARLYCON_TABLE()						\
 	EARLYCON_OF_TABLES()
 
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 278dd27..4bd7fe6 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -258,4 +258,7 @@ void acpi_generic_timer_init(void);
 static inline void acpi_generic_timer_init(void) { }
 #endif
 
+#define CLOCKSOURCE_ACPI_DECLARE(name, table_id, fn)		\
+	ACPI_DECLARE(clksrc, name, table_id, 0, NULL, 0, fn)
+
 #endif /* _LINUX_CLOCKSOURCE_H */
-- 
2.1.4

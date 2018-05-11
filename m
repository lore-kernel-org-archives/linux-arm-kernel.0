From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Fri, 11 May 2018 18:20:25 +0200
Subject: [PATCH 09/12] platform/early: add an init section for early driver
 data
In-Reply-To: <20180511162028.20616-1-brgl@bgdev.pl>
References: <20180511162028.20616-1-brgl@bgdev.pl>
Message-ID: <20180511162028.20616-10-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Provide a separate section in which pointers to early platform driver
structs will be stored.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/asm-generic/vmlinux.lds.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index af240573e482..6b5205f30ef2 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -214,6 +214,16 @@
 #define CPU_METHOD_OF_TABLES()	OF_TABLE(CONFIG_SMP, cpu_method)
 #define CPUIDLE_METHOD_OF_TABLES() OF_TABLE(CONFIG_CPU_IDLE, cpuidle_method)
 
+#ifdef CONFIG_EARLY_PLATFORM
+#define EARLY_PLATFORM_DRIVERS_TABLE()					\
+	. = ALIGN(8);							\
+	VMLINUX_SYMBOL(__early_platform_drivers_table) = .;		\
+	KEEP(*(__early_platform_drivers_table))				\
+	VMLINUX_SYMBOL(__early_platform_drivers_table_end) = .;
+#else
+#define EARLY_PLATFORM_DRIVERS_TABLE()
+#endif
+
 #ifdef CONFIG_ACPI
 #define ACPI_PROBE_TABLE(name)						\
 	. = ALIGN(8);							\
@@ -593,6 +603,7 @@
 	RESERVEDMEM_OF_TABLES()						\
 	TIMER_OF_TABLES()						\
 	IOMMU_OF_TABLES()						\
+	EARLY_PLATFORM_DRIVERS_TABLE()					\
 	CPU_METHOD_OF_TABLES()						\
 	CPUIDLE_METHOD_OF_TABLES()					\
 	KERNEL_DTB()							\
-- 
2.17.0

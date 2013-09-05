From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  5 Sep 2013 17:28:58 +0200
Subject: [PATCH] ARM: tegra: throw the unique chip ID into the entropy pool
Message-ID: <1378394938-1551-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a hook at common late init to extract the 64 bits of
chip-unique data and throw it into the entropy pool to make it
more device-unique.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Stephen: since I don't have the Tegra reference manual I don't
know what "UID" means, but if it means "unique ID" then this
patch should be relevant for initializing the entropy pool.
---
 arch/arm/mach-tegra/common.c | 1 +
 arch/arm/mach-tegra/fuse.c   | 9 +++++++++
 arch/arm/mach-tegra/fuse.h   | 1 +
 3 files changed, 11 insertions(+)

diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index 94a119a..c1ab5f5 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -109,6 +109,7 @@ void __init tegra_init_early(void)
 
 void __init tegra_init_late(void)
 {
+	tegra_random_init();
 	tegra_init_suspend();
 	tegra_cpuidle_init();
 	tegra_powergate_debugfs_init();
diff --git a/arch/arm/mach-tegra/fuse.c b/arch/arm/mach-tegra/fuse.c
index e035cd2..16673de 100644
--- a/arch/arm/mach-tegra/fuse.c
+++ b/arch/arm/mach-tegra/fuse.c
@@ -22,6 +22,7 @@
 #include <linux/io.h>
 #include <linux/export.h>
 #include <linux/tegra-soc.h>
+#include <linux/random.h>
 
 #include "fuse.h"
 #include "iomap.h"
@@ -165,3 +166,11 @@ unsigned long long tegra_chip_uid(void)
 	return (hi << 32ull) | lo;
 }
 EXPORT_SYMBOL(tegra_chip_uid);
+
+void __init tegra_random_init(void)
+{
+	unsigned long long uid;
+
+	uid = tegra_chip_uid();
+	add_device_randomness(&uid, sizeof(uid));
+}
diff --git a/arch/arm/mach-tegra/fuse.h b/arch/arm/mach-tegra/fuse.h
index def7968..559d101 100644
--- a/arch/arm/mach-tegra/fuse.h
+++ b/arch/arm/mach-tegra/fuse.h
@@ -55,6 +55,7 @@ unsigned long long tegra_chip_uid(void);
 void tegra_init_fuse(void);
 bool tegra_spare_fuse(int bit);
 u32 tegra_fuse_readl(unsigned long offset);
+void tegra_random_init(void);
 
 #ifdef CONFIG_ARCH_TEGRA_2x_SOC
 void tegra20_init_speedo_data(void);
-- 
1.8.3.1

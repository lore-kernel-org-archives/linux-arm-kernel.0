From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Oct 2012 23:38:58 +0200
Subject: [PATCH 3/3] pinctrl: mvebu: move to its own directory
In-Reply-To: <1351114738-26793-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1351114738-26793-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1351114738-26793-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Like the spear platform, the mvebu platform has multiple files: one
core file, and then one file per SoC family. More files will be added
later, as support for mach-orion5x and mach-mv78xx0 SoCs is added to
pinctrl-mvebu. For those reasons, having a separate subdirectory,
drivers/pinctrl/mvebu/ makes sense, and it had already been suggested
by Linus Wallej when the driver was originally submitted.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pinctrl/Kconfig                          |   25 +---------------------
 drivers/pinctrl/Makefile                         |    6 +-----
 drivers/pinctrl/mvebu/Kconfig                    |   24 +++++++++++++++++++++
 drivers/pinctrl/mvebu/Makefile                   |    5 +++++
 drivers/pinctrl/{ => mvebu}/pinctrl-armada-370.c |    0
 drivers/pinctrl/{ => mvebu}/pinctrl-armada-xp.c  |    0
 drivers/pinctrl/{ => mvebu}/pinctrl-dove.c       |    0
 drivers/pinctrl/{ => mvebu}/pinctrl-kirkwood.c   |    0
 drivers/pinctrl/{ => mvebu}/pinctrl-mvebu.c      |    0
 drivers/pinctrl/{ => mvebu}/pinctrl-mvebu.h      |    0
 10 files changed, 31 insertions(+), 29 deletions(-)
 create mode 100644 drivers/pinctrl/mvebu/Kconfig
 create mode 100644 drivers/pinctrl/mvebu/Makefile
 rename drivers/pinctrl/{ => mvebu}/pinctrl-armada-370.c (100%)
 rename drivers/pinctrl/{ => mvebu}/pinctrl-armada-xp.c (100%)
 rename drivers/pinctrl/{ => mvebu}/pinctrl-dove.c (100%)
 rename drivers/pinctrl/{ => mvebu}/pinctrl-kirkwood.c (100%)
 rename drivers/pinctrl/{ => mvebu}/pinctrl-mvebu.c (100%)
 rename drivers/pinctrl/{ => mvebu}/pinctrl-mvebu.h (100%)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index a9d756e..7b0f19d 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -186,30 +186,7 @@ config PINCTRL_EXYNOS4
 	bool "Pinctrl driver data for Exynos4 SoC"
 	select PINCTRL_SAMSUNG
 
-if PLAT_ORION
-
-config PINCTRL_MVEBU
-	bool
-	select PINMUX
-	select PINCONF
-
-config PINCTRL_DOVE
-	bool
-	select PINCTRL_MVEBU
-
-config PINCTRL_KIRKWOOD
-	bool
-	select PINCTRL_MVEBU
-
-config PINCTRL_ARMADA_370
-	bool
-	select PINCTRL_MVEBU
-
-config PINCTRL_ARMADA_XP
-	bool
-	select PINCTRL_MVEBU
-
-endif
+source "drivers/pinctrl/mvebu/Kconfig"
 
 source "drivers/pinctrl/spear/Kconfig"
 
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index f395ba5..3cb6a0a 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -36,12 +36,8 @@ obj-$(CONFIG_PINCTRL_U300)	+= pinctrl-u300.o
 obj-$(CONFIG_PINCTRL_COH901)	+= pinctrl-coh901.o
 obj-$(CONFIG_PINCTRL_SAMSUNG)	+= pinctrl-samsung.o
 obj-$(CONFIG_PINCTRL_EXYNOS4)	+= pinctrl-exynos.o
-obj-$(CONFIG_PINCTRL_MVEBU)	+= pinctrl-mvebu.o
-obj-$(CONFIG_PINCTRL_DOVE)	+= pinctrl-dove.o
-obj-$(CONFIG_PINCTRL_KIRKWOOD)	+= pinctrl-kirkwood.o
-obj-$(CONFIG_PINCTRL_ARMADA_370) += pinctrl-armada-370.o
-obj-$(CONFIG_PINCTRL_ARMADA_XP)  += pinctrl-armada-xp.o
 obj-$(CONFIG_PINCTRL_XWAY)	+= pinctrl-xway.o
 obj-$(CONFIG_PINCTRL_LANTIQ)	+= pinctrl-lantiq.o
 
+obj-$(CONFIG_PLAT_ORION)        += mvebu/
 obj-$(CONFIG_PLAT_SPEAR)	+= spear/
diff --git a/drivers/pinctrl/mvebu/Kconfig b/drivers/pinctrl/mvebu/Kconfig
new file mode 100644
index 0000000..366fa54
--- /dev/null
+++ b/drivers/pinctrl/mvebu/Kconfig
@@ -0,0 +1,24 @@
+if PLAT_ORION
+
+config PINCTRL_MVEBU
+	bool
+	select PINMUX
+	select PINCONF
+
+config PINCTRL_DOVE
+	bool
+	select PINCTRL_MVEBU
+
+config PINCTRL_KIRKWOOD
+	bool
+	select PINCTRL_MVEBU
+
+config PINCTRL_ARMADA_370
+	bool
+	select PINCTRL_MVEBU
+
+config PINCTRL_ARMADA_XP
+	bool
+	select PINCTRL_MVEBU
+
+endif
diff --git a/drivers/pinctrl/mvebu/Makefile b/drivers/pinctrl/mvebu/Makefile
new file mode 100644
index 0000000..37c2532
--- /dev/null
+++ b/drivers/pinctrl/mvebu/Makefile
@@ -0,0 +1,5 @@
+obj-$(CONFIG_PINCTRL_MVEBU)	+= pinctrl-mvebu.o
+obj-$(CONFIG_PINCTRL_DOVE)	+= pinctrl-dove.o
+obj-$(CONFIG_PINCTRL_KIRKWOOD)	+= pinctrl-kirkwood.o
+obj-$(CONFIG_PINCTRL_ARMADA_370) += pinctrl-armada-370.o
+obj-$(CONFIG_PINCTRL_ARMADA_XP)  += pinctrl-armada-xp.o
diff --git a/drivers/pinctrl/pinctrl-armada-370.c b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
similarity index 100%
rename from drivers/pinctrl/pinctrl-armada-370.c
rename to drivers/pinctrl/mvebu/pinctrl-armada-370.c
diff --git a/drivers/pinctrl/pinctrl-armada-xp.c b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
similarity index 100%
rename from drivers/pinctrl/pinctrl-armada-xp.c
rename to drivers/pinctrl/mvebu/pinctrl-armada-xp.c
diff --git a/drivers/pinctrl/pinctrl-dove.c b/drivers/pinctrl/mvebu/pinctrl-dove.c
similarity index 100%
rename from drivers/pinctrl/pinctrl-dove.c
rename to drivers/pinctrl/mvebu/pinctrl-dove.c
diff --git a/drivers/pinctrl/pinctrl-kirkwood.c b/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
similarity index 100%
rename from drivers/pinctrl/pinctrl-kirkwood.c
rename to drivers/pinctrl/mvebu/pinctrl-kirkwood.c
diff --git a/drivers/pinctrl/pinctrl-mvebu.c b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
similarity index 100%
rename from drivers/pinctrl/pinctrl-mvebu.c
rename to drivers/pinctrl/mvebu/pinctrl-mvebu.c
diff --git a/drivers/pinctrl/pinctrl-mvebu.h b/drivers/pinctrl/mvebu/pinctrl-mvebu.h
similarity index 100%
rename from drivers/pinctrl/pinctrl-mvebu.h
rename to drivers/pinctrl/mvebu/pinctrl-mvebu.h
-- 
1.7.9.5

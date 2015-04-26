From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 26 Apr 2015 22:31:11 +0800
Subject: [PATCH 10/11] ARM: imx: move clock drivers into drivers/clk
In-Reply-To: <1430058672-9267-1-git-send-email-shawn.guo@linaro.org>
References: <1430058672-9267-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1430058672-9267-11-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After the cleanup on clock drivers, they are now ready to be moved into
drivers/clk.  Let's move them into drivers/clk/imx folder.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/Makefile                         | 27 +++++++++-------------
 drivers/clk/Makefile                               |  1 +
 drivers/clk/imx/Makefile                           | 25 ++++++++++++++++++++
 {arch/arm/mach-imx => drivers/clk/imx}/clk-busy.c  |  0
 {arch/arm/mach-imx => drivers/clk/imx}/clk-cpu.c   |  0
 .../mach-imx => drivers/clk/imx}/clk-fixup-div.c   |  0
 .../mach-imx => drivers/clk/imx}/clk-fixup-mux.c   |  0
 .../clk/imx}/clk-gate-exclusive.c                  |  0
 {arch/arm/mach-imx => drivers/clk/imx}/clk-gate2.c |  0
 {arch/arm/mach-imx => drivers/clk/imx}/clk-imx1.c  |  0
 {arch/arm/mach-imx => drivers/clk/imx}/clk-imx21.c |  0
 {arch/arm/mach-imx => drivers/clk/imx}/clk-imx25.c |  0
 {arch/arm/mach-imx => drivers/clk/imx}/clk-imx27.c |  0
 {arch/arm/mach-imx => drivers/clk/imx}/clk-imx31.c |  0
 {arch/arm/mach-imx => drivers/clk/imx}/clk-imx35.c |  0
 .../mach-imx => drivers/clk/imx}/clk-imx51-imx53.c |  0
 {arch/arm/mach-imx => drivers/clk/imx}/clk-imx6q.c |  0
 .../arm/mach-imx => drivers/clk/imx}/clk-imx6sl.c  |  0
 .../arm/mach-imx => drivers/clk/imx}/clk-imx6sx.c  |  0
 {arch/arm/mach-imx => drivers/clk/imx}/clk-pfd.c   |  0
 {arch/arm/mach-imx => drivers/clk/imx}/clk-pllv1.c |  0
 {arch/arm/mach-imx => drivers/clk/imx}/clk-pllv2.c |  0
 {arch/arm/mach-imx => drivers/clk/imx}/clk-pllv3.c |  0
 {arch/arm/mach-imx => drivers/clk/imx}/clk-vf610.c |  0
 {arch/arm/mach-imx => drivers/clk/imx}/clk.c       |  0
 {arch/arm/mach-imx => drivers/clk/imx}/clk.h       |  0
 26 files changed, 37 insertions(+), 16 deletions(-)
 create mode 100644 drivers/clk/imx/Makefile
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-busy.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-cpu.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-fixup-div.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-fixup-mux.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-gate-exclusive.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-gate2.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx1.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx21.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx25.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx27.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx31.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx35.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx51-imx53.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx6q.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx6sl.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx6sx.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-pfd.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-pllv1.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-pllv2.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-pllv3.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-vf610.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk.h (100%)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 3244cf1d2773..0622cede2551 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -1,23 +1,18 @@
 obj-y := time.o cpu.o system.o irq-common.o
 
-obj-$(CONFIG_SOC_IMX1) += clk-imx1.o mm-imx1.o
-obj-$(CONFIG_SOC_IMX21) += clk-imx21.o mm-imx21.o
+obj-$(CONFIG_SOC_IMX1) += mm-imx1.o
+obj-$(CONFIG_SOC_IMX21) += mm-imx21.o
 
-obj-$(CONFIG_SOC_IMX25) += clk-imx25.o cpu-imx25.o mach-imx25.o
+obj-$(CONFIG_SOC_IMX25) += cpu-imx25.o mach-imx25.o
 
 obj-$(CONFIG_SOC_IMX27) += cpu-imx27.o pm-imx27.o
-obj-$(CONFIG_SOC_IMX27) += clk-imx27.o mm-imx27.o ehci-imx27.o
+obj-$(CONFIG_SOC_IMX27) += mm-imx27.o ehci-imx27.o
 
-obj-$(CONFIG_SOC_IMX31) += mm-imx3.o cpu-imx31.o clk-imx31.o iomux-imx31.o ehci-imx31.o pm-imx3.o
-obj-$(CONFIG_SOC_IMX35) += mm-imx3.o cpu-imx35.o clk-imx35.o ehci-imx35.o pm-imx3.o
+obj-$(CONFIG_SOC_IMX31) += mm-imx3.o cpu-imx31.o iomux-imx31.o ehci-imx31.o pm-imx3.o
+obj-$(CONFIG_SOC_IMX35) += mm-imx3.o cpu-imx35.o ehci-imx35.o pm-imx3.o
 
 imx5-pm-$(CONFIG_PM) += pm-imx5.o
-obj-$(CONFIG_SOC_IMX5) += cpu-imx5.o clk-imx51-imx53.o clk-cpu.o $(imx5-pm-y)
-
-obj-$(CONFIG_COMMON_CLK) += clk-pllv1.o clk-pllv2.o clk-pllv3.o clk-gate2.o \
-			    clk-pfd.o clk-busy.o clk.o \
-			    clk-fixup-div.o clk-fixup-mux.o \
-			    clk-gate-exclusive.o
+obj-$(CONFIG_SOC_IMX5) += cpu-imx5.o $(imx5-pm-y)
 
 obj-$(CONFIG_IMX_HAVE_IOMUX_V1) += iomux-v1.o
 obj-$(CONFIG_ARCH_MXC_IOMUX_V3) += iomux-v3.o
@@ -87,9 +82,9 @@ AFLAGS_headsmp.o :=-Wa,-march=armv7-a
 obj-$(CONFIG_SMP) += headsmp.o platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
 endif
-obj-$(CONFIG_SOC_IMX6Q) += clk-imx6q.o mach-imx6q.o
-obj-$(CONFIG_SOC_IMX6SL) += clk-imx6sl.o mach-imx6sl.o
-obj-$(CONFIG_SOC_IMX6SX) += clk-imx6sx.o mach-imx6sx.o
+obj-$(CONFIG_SOC_IMX6Q) += mach-imx6q.o
+obj-$(CONFIG_SOC_IMX6SL) += mach-imx6sl.o
+obj-$(CONFIG_SOC_IMX6SX) += mach-imx6sx.o
 
 ifeq ($(CONFIG_SUSPEND),y)
 AFLAGS_suspend-imx6.o :=-Wa,-march=armv7-a
@@ -101,7 +96,7 @@ obj-$(CONFIG_SOC_IMX50) += mach-imx50.o
 obj-$(CONFIG_SOC_IMX51) += mach-imx51.o
 obj-$(CONFIG_SOC_IMX53) += mach-imx53.o
 
-obj-$(CONFIG_SOC_VF610) += clk-vf610.o mach-vf610.o
+obj-$(CONFIG_SOC_VF610) += mach-vf610.o
 
 obj-$(CONFIG_SOC_LS1021A) += mach-ls1021a.o
 
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index d478ceb69c5f..695019261e0e 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_ARCH_BERLIN)		+= berlin/
 obj-$(CONFIG_ARCH_HI3xxx)		+= hisilicon/
 obj-$(CONFIG_ARCH_HIP04)		+= hisilicon/
 obj-$(CONFIG_ARCH_HIX5HD2)		+= hisilicon/
+obj-$(CONFIG_ARCH_MXC)			+= imx/
 obj-$(CONFIG_COMMON_CLK_KEYSTONE)	+= keystone/
 ifeq ($(CONFIG_COMMON_CLK), y)
 obj-$(CONFIG_ARCH_MMP)			+= mmp/
diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
new file mode 100644
index 000000000000..8be0a1c49a5e
--- /dev/null
+++ b/drivers/clk/imx/Makefile
@@ -0,0 +1,25 @@
+
+obj-y += \
+	clk.o \
+	clk-busy.o \
+	clk-cpu.o \
+	clk-fixup-div.o \
+	clk-fixup-mux.o \
+	clk-gate-exclusive.o \
+	clk-gate2.o \
+	clk-pllv1.o \
+	clk-pllv2.o \
+	clk-pllv3.o \
+	clk-pfd.o
+
+obj-$(CONFIG_SOC_IMX1)   += clk-imx1.o
+obj-$(CONFIG_SOC_IMX21)  += clk-imx21.o
+obj-$(CONFIG_SOC_IMX25)  += clk-imx25.o
+obj-$(CONFIG_SOC_IMX27)  += clk-imx27.o
+obj-$(CONFIG_SOC_IMX31)  += clk-imx31.o
+obj-$(CONFIG_SOC_IMX35)  += clk-imx35.o
+obj-$(CONFIG_SOC_IMX5)   += clk-imx51-imx53.o
+obj-$(CONFIG_SOC_IMX6Q)  += clk-imx6q.o
+obj-$(CONFIG_SOC_IMX6SL) += clk-imx6sl.o
+obj-$(CONFIG_SOC_IMX6SX) += clk-imx6sx.o
+obj-$(CONFIG_SOC_VF610)  += clk-vf610.o
diff --git a/arch/arm/mach-imx/clk-busy.c b/drivers/clk/imx/clk-busy.c
similarity index 100%
rename from arch/arm/mach-imx/clk-busy.c
rename to drivers/clk/imx/clk-busy.c
diff --git a/arch/arm/mach-imx/clk-cpu.c b/drivers/clk/imx/clk-cpu.c
similarity index 100%
rename from arch/arm/mach-imx/clk-cpu.c
rename to drivers/clk/imx/clk-cpu.c
diff --git a/arch/arm/mach-imx/clk-fixup-div.c b/drivers/clk/imx/clk-fixup-div.c
similarity index 100%
rename from arch/arm/mach-imx/clk-fixup-div.c
rename to drivers/clk/imx/clk-fixup-div.c
diff --git a/arch/arm/mach-imx/clk-fixup-mux.c b/drivers/clk/imx/clk-fixup-mux.c
similarity index 100%
rename from arch/arm/mach-imx/clk-fixup-mux.c
rename to drivers/clk/imx/clk-fixup-mux.c
diff --git a/arch/arm/mach-imx/clk-gate-exclusive.c b/drivers/clk/imx/clk-gate-exclusive.c
similarity index 100%
rename from arch/arm/mach-imx/clk-gate-exclusive.c
rename to drivers/clk/imx/clk-gate-exclusive.c
diff --git a/arch/arm/mach-imx/clk-gate2.c b/drivers/clk/imx/clk-gate2.c
similarity index 100%
rename from arch/arm/mach-imx/clk-gate2.c
rename to drivers/clk/imx/clk-gate2.c
diff --git a/arch/arm/mach-imx/clk-imx1.c b/drivers/clk/imx/clk-imx1.c
similarity index 100%
rename from arch/arm/mach-imx/clk-imx1.c
rename to drivers/clk/imx/clk-imx1.c
diff --git a/arch/arm/mach-imx/clk-imx21.c b/drivers/clk/imx/clk-imx21.c
similarity index 100%
rename from arch/arm/mach-imx/clk-imx21.c
rename to drivers/clk/imx/clk-imx21.c
diff --git a/arch/arm/mach-imx/clk-imx25.c b/drivers/clk/imx/clk-imx25.c
similarity index 100%
rename from arch/arm/mach-imx/clk-imx25.c
rename to drivers/clk/imx/clk-imx25.c
diff --git a/arch/arm/mach-imx/clk-imx27.c b/drivers/clk/imx/clk-imx27.c
similarity index 100%
rename from arch/arm/mach-imx/clk-imx27.c
rename to drivers/clk/imx/clk-imx27.c
diff --git a/arch/arm/mach-imx/clk-imx31.c b/drivers/clk/imx/clk-imx31.c
similarity index 100%
rename from arch/arm/mach-imx/clk-imx31.c
rename to drivers/clk/imx/clk-imx31.c
diff --git a/arch/arm/mach-imx/clk-imx35.c b/drivers/clk/imx/clk-imx35.c
similarity index 100%
rename from arch/arm/mach-imx/clk-imx35.c
rename to drivers/clk/imx/clk-imx35.c
diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/drivers/clk/imx/clk-imx51-imx53.c
similarity index 100%
rename from arch/arm/mach-imx/clk-imx51-imx53.c
rename to drivers/clk/imx/clk-imx51-imx53.c
diff --git a/arch/arm/mach-imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
similarity index 100%
rename from arch/arm/mach-imx/clk-imx6q.c
rename to drivers/clk/imx/clk-imx6q.c
diff --git a/arch/arm/mach-imx/clk-imx6sl.c b/drivers/clk/imx/clk-imx6sl.c
similarity index 100%
rename from arch/arm/mach-imx/clk-imx6sl.c
rename to drivers/clk/imx/clk-imx6sl.c
diff --git a/arch/arm/mach-imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
similarity index 100%
rename from arch/arm/mach-imx/clk-imx6sx.c
rename to drivers/clk/imx/clk-imx6sx.c
diff --git a/arch/arm/mach-imx/clk-pfd.c b/drivers/clk/imx/clk-pfd.c
similarity index 100%
rename from arch/arm/mach-imx/clk-pfd.c
rename to drivers/clk/imx/clk-pfd.c
diff --git a/arch/arm/mach-imx/clk-pllv1.c b/drivers/clk/imx/clk-pllv1.c
similarity index 100%
rename from arch/arm/mach-imx/clk-pllv1.c
rename to drivers/clk/imx/clk-pllv1.c
diff --git a/arch/arm/mach-imx/clk-pllv2.c b/drivers/clk/imx/clk-pllv2.c
similarity index 100%
rename from arch/arm/mach-imx/clk-pllv2.c
rename to drivers/clk/imx/clk-pllv2.c
diff --git a/arch/arm/mach-imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
similarity index 100%
rename from arch/arm/mach-imx/clk-pllv3.c
rename to drivers/clk/imx/clk-pllv3.c
diff --git a/arch/arm/mach-imx/clk-vf610.c b/drivers/clk/imx/clk-vf610.c
similarity index 100%
rename from arch/arm/mach-imx/clk-vf610.c
rename to drivers/clk/imx/clk-vf610.c
diff --git a/arch/arm/mach-imx/clk.c b/drivers/clk/imx/clk.c
similarity index 100%
rename from arch/arm/mach-imx/clk.c
rename to drivers/clk/imx/clk.c
diff --git a/arch/arm/mach-imx/clk.h b/drivers/clk/imx/clk.h
similarity index 100%
rename from arch/arm/mach-imx/clk.h
rename to drivers/clk/imx/clk.h
-- 
1.9.1

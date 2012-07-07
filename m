From: mturquette@ti.com (Mike Turquette)
Date: Fri, 6 Jul 2012 17:13:10 -0700
Subject: [GIT PULL] Integrator common clock
In-Reply-To: <CACRpkdZYZJL6MmQ0tZD=ZWbAX7yUDoH6Xw6CfBLYkVtF2j2gGg@mail.gmail.com>
References: <CACRpkdYj46c1dpBhassGn2DWOpcmHHUQcUGb6VZ-bVL8bc2PJw@mail.gmail.com>
 <20120620212046.GI4402@gmail.com>
 <CACRpkdaDUvfEV-7zTTyb+NbZ1WnN+iz+9QzDCVESeizCowOCsg@mail.gmail.com>
 <CACRpkdZGjMa8dBdc_wrTxHUxHUTwzQM9W55XyU+6VEBnXb8z5g@mail.gmail.com>
 <CACRpkda5xQLr+fhnsWm4ONUCzJxtMMCLkS2ek9ufDPV-u7PsGg@mail.gmail.com>
 <CAJOA=zOaXf6QzF9yhcoTTaPYr-9=L2h5r5AvmMxoSbroJJrOFg@mail.gmail.com>
 <CACRpkdZYZJL6MmQ0tZD=ZWbAX7yUDoH6Xw6CfBLYkVtF2j2gGg@mail.gmail.com>
Message-ID: <20120707001310.GA1230@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120705-00:52, Linus Walleij wrote:
> Versatile is two things (just to add to the confusion):
> 
> 1) A machine named arch/arm/mach-versatile
> 2) A platform named arch/arm/plat-versatile encompassing
>   the mach-integrator, mach-versatile, mach-realview and mach-vexpress
> 
> This new folder is for the latter, but the only *machine* using it in the
> versatile family is the Integrator.
> 
> So far. I will likely convert mach-realview next, since I can test it.

Thanks for clearing that up.  I'm still curious to know whether the
Kconfig file is even necessary for your case.  In the interest of
delaying this conversation for even longer, can you look at the below
patch and let me know if it is OK for you?

If you do not like it then I will take your patches as-is, though I do
hope to get rid of the ugly Kconfig if possible.

Thanks,
Mike


From: Mike Turquette <mturquette@linaro.org>
Date: Fri, 6 Jul 2012 16:41:40 -0700
Subject: [PATCH] remove versatile common clk kconfig

---
 arch/arm/Kconfig               |    1 -
 drivers/clk/Kconfig            |    2 --
 drivers/clk/Makefile           |    2 +-
 drivers/clk/versatile/Kconfig  |    8 --------
 drivers/clk/versatile/Makefile |    2 +-
 5 files changed, 2 insertions(+), 13 deletions(-)
 delete mode 100644 drivers/clk/versatile/Kconfig

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1c0d6b3..6f8cf40 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -258,7 +258,6 @@ config ARCH_INTEGRATOR
 	select CLK_VERSATILE
 	select HAVE_TCM
 	select ICST
-	select CLK_ICST
 	select GENERIC_CLOCKEVENTS
 	select PLAT_VERSATILE
 	select PLAT_VERSATILE_FPGA_IRQ
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 85bffd2..3f99b90 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -41,6 +41,4 @@ config COMMON_CLK_WM831X
           Supports the clocking subsystem of the WM831x/2x series of
 	  PMICs from Wolfson Microlectronics.
 
-source "drivers/clk/versatile/Kconfig"
-
 endmenu
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 90ea91d..a4d67d7 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -6,7 +6,7 @@ obj-$(CONFIG_COMMON_CLK)	+= clk.o clk-fixed-rate.o clk-gate.o \
 obj-$(CONFIG_ARCH_MXS)		+= mxs/
 obj-$(CONFIG_PLAT_SPEAR)	+= spear/
 obj-$(CONFIG_ARCH_U300)		+= clk-u300.o
-obj-$(CONFIG_CLK_VERSATILE)	+= versatile/
+obj-$(CONFIG_ARCH_INTEGRATOR)	+= versatile/
 
 # Chip specific
 obj-$(CONFIG_COMMON_CLK_WM831X) += clk-wm831x.o
diff --git a/drivers/clk/versatile/Kconfig b/drivers/clk/versatile/Kconfig
deleted file mode 100644
index 169b1bc..0000000
--- a/drivers/clk/versatile/Kconfig
+++ /dev/null
@@ -1,8 +0,0 @@
-config CLK_VERSATILE
-	bool "Clocks for the ARM Versatile family"
-	depends on COMMON_CLK
-
-config CLK_ICST
-	bool "ICST307 VCO clock driver"
-	depends on COMMON_CLK
-	depends on ICST
diff --git a/drivers/clk/versatile/Makefile b/drivers/clk/versatile/Makefile
index ac47173..50cf6a2 100644
--- a/drivers/clk/versatile/Makefile
+++ b/drivers/clk/versatile/Makefile
@@ -1,3 +1,3 @@
 # Makefile for Versatile-specific clocks
-obj-$(CONFIG_CLK_ICST)		+= clk-icst.o
+obj-$(CONFIG_ICST)		+= clk-icst.o
 obj-$(CONFIG_ARCH_INTEGRATOR)	+= clk-integrator.o
-- 
1.7.9.5

From: horms@verge.net.au (Simon Horman)
Date: Thu, 3 Oct 2013 13:24:42 +0900
Subject: [PATCH 03/05] ARM: shmobile: Remove non-multiplatform KZM9D
 reference support
In-Reply-To: <20131001103324.813.82210.sendpatchset@w520>
References: <20131001103255.813.65710.sendpatchset@w520>
 <20131001103324.813.82210.sendpatchset@w520>
Message-ID: <20131003042441.GO7925@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 07:33:24PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Now when CCF is supported remove the legacy KZM9D reference
> Kconfig bits CONFIG_MACH_KZM9D_REFERENCE for the non-multiplatform
> case.
> 
> Starting from this commit KZM9D board support is always enabled
> via CONFIG_MACH_KZM9D, and CONFIG_ARCH_MULTIPLATFORM is used
> to select between board-kzm9d.c and board-kzm9d-reference.c
> 
> The file board-kzm9d-reference.c can no longer be used together
> with the legacy sh-clk clock framework, instead CCF is used.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up in the boards3 branch.
It should make it into v3.13 but if not I'll rename the branch
soc after rebasing it on v3.13-rcX which will then be targeted at v3.14.

There was some fuzz when applying each of the hunks of the patch.
I have queued up the following, please check that it is correct.


From: Magnus Damm <damm@opensource.se>

[PATCH] ARM: shmobile: Remove non-multiplatform KZM9D reference support

Now when CCF is supported remove the legacy KZM9D reference
Kconfig bits CONFIG_MACH_KZM9D_REFERENCE for the non-multiplatform
case.

Starting from this commit KZM9D board support is always enabled
via CONFIG_MACH_KZM9D, and CONFIG_ARCH_MULTIPLATFORM is used
to select between board-kzm9d.c and board-kzm9d-reference.c

The file board-kzm9d-reference.c can no longer be used together
with the legacy sh-clk clock framework, instead CCF is used.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig       | 12 ------------
 arch/arm/mach-shmobile/Makefile      |  1 -
 arch/arm/mach-shmobile/Makefile.boot |  1 -
 3 files changed, 14 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index c9c4f15..a4a4b75 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -237,18 +237,6 @@ config MACH_KZM9D
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	select USE_OF
 
-config MACH_KZM9D_REFERENCE
-	bool "KZM9D board - Reference Device Tree Implementation"
-	depends on ARCH_EMEV2
-	select REGULATOR_FIXED_VOLTAGE if REGULATOR
-	select USE_OF
-	---help---
-	   Use reference implementation of KZM9D board support
-	   which makes a greater use of device tree at the expense
-	   of not supporting a number of devices.
-
-	   This is intended to aid developers
-
 config MACH_KZM9G
 	bool "KZM-A9-GT board"
 	depends on ARCH_SH73A0
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 0c7ba43..adcdec8 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -71,7 +71,6 @@ obj-$(CONFIG_MACH_ARMADILLO800EVA)	+= board-armadillo800eva.o
 obj-$(CONFIG_MACH_ARMADILLO800EVA_REFERENCE)	+= board-armadillo800eva-reference.o
 obj-$(CONFIG_MACH_KOELSCH)	+= board-koelsch.o
 obj-$(CONFIG_MACH_KZM9D)	+= board-kzm9d.o
-obj-$(CONFIG_MACH_KZM9D_REFERENCE)	+= board-kzm9d-reference.o
 obj-$(CONFIG_MACH_KZM9G)	+= board-kzm9g.o
 obj-$(CONFIG_MACH_KZM9G_REFERENCE)	+= board-kzm9g-reference.o
 endif
diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
index c690b50..391d72a 100644
--- a/arch/arm/mach-shmobile/Makefile.boot
+++ b/arch/arm/mach-shmobile/Makefile.boot
@@ -9,7 +9,6 @@ loadaddr-$(CONFIG_MACH_BOCKW_REFERENCE) += 0x60008000
 loadaddr-$(CONFIG_MACH_GENMAI) += 0x8008000
 loadaddr-$(CONFIG_MACH_KOELSCH) += 0x40008000
 loadaddr-$(CONFIG_MACH_KZM9D) += 0x40008000
-loadaddr-$(CONFIG_MACH_KZM9D_REFERENCE) += 0x40008000
 loadaddr-$(CONFIG_MACH_KZM9G) += 0x41008000
 loadaddr-$(CONFIG_MACH_KZM9G_REFERENCE) += 0x41008000
 loadaddr-$(CONFIG_MACH_LAGER) += 0x40008000
-- 
1.8.4

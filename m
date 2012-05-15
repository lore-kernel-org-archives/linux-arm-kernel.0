From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 May 2012 15:30:17 +0000
Subject: [GIT PULL][Update] Renesas ARM-based platforms: new boards
 support for v3.5
In-Reply-To: <201205150840.23283.arnd@arndb.de>
References: <201205112101.59949.rjw@sisk.pl> <201205142343.12682.rjw@sisk.pl>
 <201205150840.23283.arnd@arndb.de>
Message-ID: <201205151530.18193.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 May 2012, Arnd Bergmann wrote:
> On Monday 14 May 2012, Rafael J. Wysocki wrote:
> > Please pull changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3
> > 
> >     Linux 3.4-rc6
> > 
> > with top-most commit 4fc5e65cdbf736a5311b07aa54a916ccaa91ab5f
> > 
> >     Merge branch 'renesas-kzm9g' into renesas-board-new
> > 
> > from the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/renesas.git board-new
> > 
> > to receive updates of the Renesas ARM-based boards support code for v3.5.
> > Included are:
> > 
> >  * Support for the KZM-A9-GT board from Kuninori Morimoto and Magnus Damm.
> > 
> >  * Support for the armadillo800eva board from Kuninori Morimoto and Magnus Damm.
> > 
> > This is based on the Renesas core SoC code updates I've sent a separate pull
> > request for.

I got build errors with the new version now because machine_is_kzm9g is no longer
defined:

/home/arnd/linux-arm/arch/arm/mach-shmobile/platsmp.c: In function 'shmobile_smp_get_core_count':
/home/arnd/linux-arm/arch/arm/mach-shmobile/platsmp.c:29:2: error: implicit declaration of function 'of_machine_is_compatible' [-Werror=implicit-function-declaration]

I'd apply the patch below, unless someone has a better solution

	Arnd

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts b/arch/arm/boot/dts/sh73a0-kzm9g.dts
index ed1bae5..bcb9119 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g.dts
@@ -13,7 +13,7 @@
 
 / {
 	model = "KZM-A9-GT";
-	compatible = "renesas,kzm9g";
+	compatible = "renesas,kzm9g", "renesas,sh73a0";
 
 	memory {
 		device_type = "memory";
diff --git a/arch/arm/mach-shmobile/platsmp.c b/arch/arm/mach-shmobile/platsmp.c
index d959f07..2946214 100644
--- a/arch/arm/mach-shmobile/platsmp.c
+++ b/arch/arm/mach-shmobile/platsmp.c
@@ -20,7 +20,8 @@
 #include <asm/mach-types.h>
 #include <mach/common.h>
 
-#define is_sh73a0() (machine_is_ag5evm() || machine_is_kota2() || machine_is_kzm9g())
+#define is_sh73a0() (machine_is_ag5evm() || machine_is_kota2() || \
+			of_machine_is_compatible("renesas,sh73a0"))
 #define is_r8a7779() machine_is_marzen()
 
 static unsigned int __init shmobile_smp_get_core_count(void)

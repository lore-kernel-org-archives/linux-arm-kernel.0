From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 12 Sep 2014 13:10:05 +0200
Subject: [PATCH v3] ARM: mvebu: rename ARM_ERRATA_753970
In-Reply-To: <1403516086.12982.35.camel@x220>
References: <201404052101.19381.arnd@arndb.de>
 <201404052104.11363.arnd@arndb.de> <1396777049.30640.9.camel@x220>
 <53418889.2050002@free-electrons.com> <1396805315.7723.8.camel@x220>
 <1401094871.25902.20.camel@x220>
 <20140620202100.GG21711@titan.lakedaemon.net>
 <20140620205340.GX32514@n2100.arm.linux.org.uk>
 <1403514104.12982.20.camel@x220>
 <20140623090714.GH32514@n2100.arm.linux.org.uk>
 <1403516086.12982.35.camel@x220>
Message-ID: <1410520205.31130.33.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM_ERRATA_753970 was renamed to PL310_ERRATA_753970 in v3.2, through
commit fa0ce4035d48 ("ARM: 7162/1: errata: tidy up Kconfig options for
PL310 errata workarounds"). Two selects were added in v3.15 that still
use the previous name. Rename these. Make these select statements depend
on CACHE_L2X0, like all other select statements for PL310_ERRATA_753970
do, to be safe we don't inadvertently start to allow pointless
configurations in the future.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
v3: add CACHE_L2X0 dependency, as Russell requested.

Tested with "git grep" and fiddling with "make ARCH=arm [...]config".
Please shout if that's deemed insufficient.

Note that I promised this v3 over two months ago. Taking two months to
update this patch is not really something to be proud of. On the other
hand: no one bothered to prod me for this v3 or send in a proper fix
themselves. Add to this that I first reported these selects for an
outdated Kconfig symbol in April. So I begin to wonder whether these
selects statements are really needed to begin with.

 arch/arm/mach-mvebu/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index c1e4567a5ab3..101de7c3e7b3 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -37,7 +37,7 @@ config MACH_ARMADA_370
 config MACH_ARMADA_375
 	bool "Marvell Armada 375 boards" if ARCH_MULTI_V7
 	select ARM_ERRATA_720789
-	select ARM_ERRATA_753970
+	select PL310_ERRATA_753970 if CACHE_L2X0
 	select ARM_GIC
 	select ARMADA_375_CLK
 	select HAVE_ARM_SCU
@@ -52,7 +52,7 @@ config MACH_ARMADA_375
 config MACH_ARMADA_38X
 	bool "Marvell Armada 380/385 boards" if ARCH_MULTI_V7
 	select ARM_ERRATA_720789
-	select ARM_ERRATA_753970
+	select PL310_ERRATA_753970 if CACHE_L2X0
 	select ARM_GIC
 	select ARMADA_38X_CLK
 	select HAVE_ARM_SCU
-- 
1.9.3

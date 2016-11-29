From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 29 Nov 2016 12:39:59 +0000
Subject: [RFC v2 PATCH 17/23] ARM: sa11x0: assabet: add dependency on MMU
In-Reply-To: <1480423205-48436-1-git-send-email-vladimir.murzin@arm.com>
References: <1480423205-48436-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1480423205-48436-18-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building for NOMMU configuration leads to following error:

arch/arm/mach-sa1100/generic.c:350:24: warning: 'standard_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc standard_io_desc[] __initdata = {
                        ^
arch/arm/mach-sa1100/assabet.c: In function 'map_sa1100_gpio_regs':
arch/arm/mach-sa1100/assabet.c:496:38: error: 'PMD_MASK' undeclared (first use in this function)
  unsigned long phys = __PREG(GPLR) & PMD_MASK;
                                      ^
arch/arm/mach-sa1100/assabet.c:496:38: note: each undeclared identifier is reported only once for each function it appears in
In file included from ./include/linux/list.h:7:0,
                 from ./include/linux/module.h:9,
                 from arch/arm/mach-sa1100/assabet.c:14:
./arch/arm/include/asm/pgtable-2level-hwdef.h:22:29: error: 'pmdval_t' undeclared (first use in this function)
 #define PMD_TYPE_SECT  (_AT(pmdval_t, 2) << 0)
                             ^
./include/uapi/linux/const.h:21:20: note: in definition of macro '_AT'
 #define _AT(T,X) ((T)(X))
                    ^
arch/arm/mach-sa1100/assabet.c:498:13: note: in expansion of macro 'PMD_TYPE_SECT'
  int prot = PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_DOMAIN(DOMAIN_IO);
             ^
arch/arm/mach-sa1100/assabet.c:503:2: error: implicit declaration of function 'flush_pmd_entry' [-Werror=implicit-function-declaration]
  flush_pmd_entry(pmd);
  ^
arch/arm/mach-sa1100/assabet.c:497:16: warning: unused variable 'virt' [-Wunused-variable]
  unsigned long virt = (unsigned long)io_p2v(phys);
                ^
arch/arm/mach-sa1100/assabet.c: At top level:
arch/arm/mach-sa1100/assabet.c:620:24: warning: 'assabet_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc assabet_io_desc[] __initdata = {
                        ^
cc1: some warnings being treated as errors
make[1]: *** [arch/arm/mach-sa1100/assabet.o] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [arch/arm/mach-sa1100] Error 2
make: *** Waiting for unfinished jobs....

The code there performs the manual selection of page flags which makes
it dependant on MMU.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/mach-sa1100/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-sa1100/Kconfig b/arch/arm/mach-sa1100/Kconfig
index 36e3c79..af8cd56 100644
--- a/arch/arm/mach-sa1100/Kconfig
+++ b/arch/arm/mach-sa1100/Kconfig
@@ -4,6 +4,7 @@ menu "SA11x0 Implementations"
 
 config SA1100_ASSABET
 	bool "Assabet"
+	depends on MMU
 	select ARM_SA1110_CPUFREQ
 	help
 	  Say Y here if you are using the Intel(R) StrongARM(R) SA-1110
-- 
1.7.9.5

From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Fri, 9 Sep 2011 23:50:08 +0400
Subject: [GIT PULL] ARM: Cavium CNS3xxx updates for 3.1
Message-ID: <20110909195008.GA1089@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull linux-cns3xxx.git tree to receive some fixes for CNS3xxx
platforms. Note that this is for 3.1.

Several post -rc1 commits broke CNS3xxx, and the pull request contains
patches to fix things. The patches are small, so for convenience' sake
I inline the them here.

Thanks!

The following changes since commit ddf28352b80c86754a6424e3a61e8bdf9213b3c7:

  Linux 3.1-rc5 (2011-09-04 15:45:10 -0700)

are available in the git repository at:
  git://git.infradead.org/users/cbou/linux-cns3xxx.git master

Anton Vorontsov (1):
      ARM: cns3xxx: Fix newly introduced warnings in the PCIe code

Tommy Lin (1):
      ARM: cns3xxx: Fix compile error caused by hardware.h removed

 arch/arm/mach-cns3xxx/include/mach/entry-macro.S |    1 -
 arch/arm/mach-cns3xxx/include/mach/system.h      |    1 -
 arch/arm/mach-cns3xxx/include/mach/uncompress.h  |    1 -
 arch/arm/mach-cns3xxx/pcie.c                     |    2 +-
 4 files changed, 1 insertions(+), 4 deletions(-)

- - -

commit 7caaf7efb98a4f713e4c8b16289e03874aace493
Author: Anton Vorontsov <cbouatmailru@gmail.com>
Date:   Fri Sep 9 23:18:00 2011 +0400

    ARM: cns3xxx: Fix newly introduced warnings in the PCIe code
    
    commit d5341942d784134f2997b3ff82cd63cf71d1f932 ("PCI: Make the struct
    pci_dev * argument of pci_fixup_irqs const") did not change argument
    of pdev_to_cnspci(), and thus introduced the following warnings:
    
      CHECK   arch/arm/mach-cns3xxx/pcie.c
    pcie.c:177:60: warning: incorrect type in argument 1 (different modifiers)
    pcie.c:177:60:    expected struct pci_dev *dev
    pcie.c:177:60:    got struct pci_dev const *dev
      CC      arch/arm/mach-cns3xxx/pcie.o
    pcie.c: In function 'cns3xxx_pcie_map_irq':
    pcie.c:177: warning: passing argument 1 of 'pdev_to_cnspci' discards qualifiers from pointer target type
    pcie.c:52: note: expected 'struct pci_dev *' but argument is of type 'const struct pci_dev *'
    
    This patch fixes the issue.
    
    Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>

diff --git a/arch/arm/mach-cns3xxx/pcie.c b/arch/arm/mach-cns3xxx/pcie.c
index 06fd25d..0f8fca4 100644
--- a/arch/arm/mach-cns3xxx/pcie.c
+++ b/arch/arm/mach-cns3xxx/pcie.c
@@ -49,7 +49,7 @@ static struct cns3xxx_pcie *sysdata_to_cnspci(void *sysdata)
 	return &cns3xxx_pcie[root->domain];
 }
 
-static struct cns3xxx_pcie *pdev_to_cnspci(struct pci_dev *dev)
+static struct cns3xxx_pcie *pdev_to_cnspci(const struct pci_dev *dev)
 {
 	return sysdata_to_cnspci(dev->sysdata);
 }

commit 83a497cab1baec75e3e493a96e3456db14729ce0
Author: Tommy Lin <tommy.lin.1101@gmail.com>
Date:   Fri Jul 29 01:14:46 2011 +0800

    ARM: cns3xxx: Fix compile error caused by hardware.h removed
    
    Commit c9d95fbe59e426eed7f16e7cac812e46ac4772d0 "ARM: convert PCI defines
    to variables" deleted cns3xxx' hardware.h, but didn't remove references
    for it, so do it now.
    
    This patch removes lines that refer to hardware.h.
    
    Signed-off-by: Tommy Lin <tommy.lin.1101@gmail.com>
    Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
    Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>

diff --git a/arch/arm/mach-cns3xxx/include/mach/entry-macro.S b/arch/arm/mach-cns3xxx/include/mach/entry-macro.S
index 6bd83ed..d87bfc3 100644
--- a/arch/arm/mach-cns3xxx/include/mach/entry-macro.S
+++ b/arch/arm/mach-cns3xxx/include/mach/entry-macro.S
@@ -8,7 +8,6 @@
  * published by the Free Software Foundation.
  */
 
-#include <mach/hardware.h>
 #include <asm/hardware/entry-macro-gic.S>
 
 		.macro	disable_fiq
diff --git a/arch/arm/mach-cns3xxx/include/mach/system.h b/arch/arm/mach-cns3xxx/include/mach/system.h
index 58bb03a..4f16c9b 100644
--- a/arch/arm/mach-cns3xxx/include/mach/system.h
+++ b/arch/arm/mach-cns3xxx/include/mach/system.h
@@ -13,7 +13,6 @@
 
 #include <linux/io.h>
 #include <asm/proc-fns.h>
-#include <mach/hardware.h>
 
 static inline void arch_idle(void)
 {
diff --git a/arch/arm/mach-cns3xxx/include/mach/uncompress.h b/arch/arm/mach-cns3xxx/include/mach/uncompress.h
index de8ead9..a91b605 100644
--- a/arch/arm/mach-cns3xxx/include/mach/uncompress.h
+++ b/arch/arm/mach-cns3xxx/include/mach/uncompress.h
@@ -8,7 +8,6 @@
  */
 
 #include <asm/mach-types.h>
-#include <mach/hardware.h>
 #include <mach/cns3xxx.h>
 
 #define AMBA_UART_DR(base)	(*(volatile unsigned char *)((base) + 0x00))

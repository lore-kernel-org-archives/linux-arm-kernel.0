From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 20 May 2015 17:14:19 -0700
Subject: [GIT PULL] Broadcom SoC changes for 4.2 (take 2)
Message-ID: <1432167259-3116-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  http://github.com/broadcom/stblinux tags/arm-soc/for-4.2/soc-take2

for you to fetch changes up to ed5cd8163da8d3e02ef83b84e42d555d40bab96a:

  ARM: BCM63xx: Add SMP support for BCM63138 (2015-05-20 15:08:44 -0700)

----------------------------------------------------------------
This pull request contains the following changes:

- Rafal adds an additional fault code to be ignored by the kernel on BCM5301X SoC

- BCM63138 SMP support which:
	* common code to control the PMB bus, to be shared with a reset
	  controller driver in drivers/reset
	* secondary CPU initialization sequence using PMB helpers
	* small changes suggested by Russell King to allow platforms to disable VFP

----------------------------------------------------------------
Changes in v2, based on Arnd's feedback:

- incorporated Rafal's change, had been missed before
- fix build error by including include/linux/errno.h
- moved bcm63xx_pmb.h to include/linux/reset/
- used readl/writel I/O accessors instead of __raw_{read,write}l
- removed comment above bcm63xx_pmb.h about spinlock

Florian Fainelli (5):
      ARM: BCM63xx: Add Broadcom BCM63xx PMB controller helpers
      ARM: BCM63xx: Add secondary CPU PMB initialization sequence
      ARM: vfp: Add include guards
      ARM: vfp: Add vfp_disable for problematic platforms
      ARM: BCM63xx: Add SMP support for BCM63138

Rafa? Mi?ecki (1):
      ARM: BCM5301X: Ignore another (BCM4709 specific) fault code

 arch/arm/include/asm/vfp.h          |   9 ++
 arch/arm/mach-bcm/Makefile          |   7 +-
 arch/arm/mach-bcm/bcm63xx_headsmp.S |  23 ++++
 arch/arm/mach-bcm/bcm63xx_pmb.c     | 221 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-bcm/bcm63xx_smp.c     | 169 +++++++++++++++++++++++++++
 arch/arm/mach-bcm/bcm63xx_smp.h     |   9 ++
 arch/arm/mach-bcm/bcm_5301x.c       |   9 +-
 arch/arm/vfp/vfpmodule.c            |  13 +++
 include/linux/reset/bcm63xx_pmb.h   |  88 ++++++++++++++
 9 files changed, 543 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-bcm/bcm63xx_headsmp.S
 create mode 100644 arch/arm/mach-bcm/bcm63xx_pmb.c
 create mode 100644 arch/arm/mach-bcm/bcm63xx_smp.c
 create mode 100644 arch/arm/mach-bcm/bcm63xx_smp.h
 create mode 100644 include/linux/reset/bcm63xx_pmb.h

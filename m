From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 22 Feb 2012 17:44:14 +0530
Subject: [PATCH v3 0/4] ARM: Exynos4: Add irq domain and device tree support
 for wakeup interrupts
Message-ID: <1329912858-32750-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v2:
- Reworked irq domain support based on v5 of the irq_domain generalization
  patches.

Changes since v1: (only patch 4/4 has changes)
- Fixes based on Rob's comments:
  a. Fixed the function prototype of exynos4_init_irq_eint(void)
  b. Included interrupt-parent as an optional property for wakeup interrupt
      controller node.

Samsung Exynos4 includes 32 external wakeup interrupt sources. The first 16
of these interrupts are connected to GIC SPI[31:16]. The last 16 of these
interrupts are grouped together into one interrupt and connected to GIC
SPI[32].

This patchset adds irq domain and device tree support for these interrupts.
Since there are users of fixed linux irq numbers of the external wakeup
interrupts, the legacy mapping is used for the irq domain.

This patchset is based on
http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git [for-next]

with all irq_domain (v5) patches merged from
http://git.secretlab.ca/git/linux-2.6.git [irqdomain/next]

This patchset should be applied after applying the following patch.
[PATCH] ARM: Exynos: Add irq domain and device tree support for interrupt combiner

Thomas Abraham (4):
  ARM: Exynos4: Simplify EINT number to linux irq number translation
  ARM: Exynos4: Add irq_domain support for gpio wakeup interrupts
  ARM: Exynos4: Remove arch_initcall for wakeup interrupt initialization
  ARM: Exynos4: Add device tree support for gpio wakeup interrupt controller

 .../bindings/arm/samsung/wakeup-eint.txt           |   37 +++++
 arch/arm/mach-exynos/common.c                      |  148 ++++++++++++--------
 arch/arm/mach-exynos/include/mach/regs-gpio.h      |    4 +-
 3 files changed, 131 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/wakeup-eint.txt

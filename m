From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon,  7 Aug 2017 00:32:08 +0200
Subject: [PATCH 0/3] ARM: bcm2836: Move SMP startup code to arch/arm
Message-ID: <1502058731-12462-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series move the SMP startup code of BCM2836 and
BCM2837 to the right place. There was already a patch from Marc Zyngier [1],
but it breaks SMP for RPI 3 on 32-bit (other cores stays offline).

I based my patch series on Marc's patch with the following changes:
 * define enable-method and use it in the dts files
 * place SMP code into platsmp.c
 * rename bcm2836_smp_boot_secondary() to bcm2836_boot_secondary()
 * use of_find_compatible_node() instead of of_find_matching_node()

This series requires the patch "ARM: dts: bcm283x: Move the BCM2837
DT contents from arm64 to arm."

[1] - https://patchwork.kernel.org/patch/9719845/

Stefan Wahren (3):
  dt-bindings: arm: add SMP enable-method for BCM2836
  ARM: dts: bcm283x: Add 32-bit enable method for SMP
  irqchip: bcm2836: Move SMP startup code to arch/arm

 Documentation/devicetree/bindings/arm/cpus.txt |  1 +
 arch/arm/boot/dts/bcm2836.dtsi                 |  1 +
 arch/arm/boot/dts/bcm2837.dtsi                 |  1 +
 arch/arm/mach-bcm/Makefile                     |  3 +
 arch/arm/mach-bcm/platsmp.c                    | 35 ++++++++++++
 drivers/irqchip/irq-bcm2836.c                  | 79 +-------------------------
 include/linux/irqchip/irq-bcm2836.h            | 70 +++++++++++++++++++++++
 7 files changed, 113 insertions(+), 77 deletions(-)
 create mode 100644 include/linux/irqchip/irq-bcm2836.h

-- 
2.7.4

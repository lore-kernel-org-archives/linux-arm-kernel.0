From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Wed, 28 Feb 2018 14:10:54 +0100
Subject: [PATCH v2 0/4] Enable DMA on STM32 MCU based on cortex-M7
Message-ID: <1519823458-27734-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enable DMA on several STM32 MCU based on cortex-M7.
To make it possible, a dedicated dma pool memory area has to be
created. This patchset activate also ARM_MPU flag which will configure 
MPU (Memory Protection Unit) according to devicetree information (mem
and dma-pool). Note that on cortex-M7 DMA has to use a NO cache-able 
memory region.


v2:
-select ARM_MPU in mach-stm32 Kconfig instead of add it in stm32 defconfig
-Remove XIP configuration from stm32_defconfig: ARM_MPU flag imposes XIP image
to be aligned on 1MB. It is currently not the case. I had choice to either
modify current XIP start address to be aligned on 1MB or to remove global
configuration. I make choice to remove XIP configuration. Indeed, SD card
support has been recently added for most of STM32 MCU boards (except for
stm32f429-disco). As kernel is growing up for stm32 it will be more and more
difficult to flash it in embeded flash (max size: 2MB).
-fix typo in commit message

Regards
Alex

Alexandre Torgue (4):
  ARM: dts: stm32: add DMA memory pool on MCU which embed a cortex-M7
  ARM: configs: stm32: remove XIP configuration
  ARM: stm32: Select ARM_MPU for cortex-M7 machines
  ARM: dts: stm32: enable dma on MCU which embed a cortex-M7

 arch/arm/boot/dts/stm32746g-eval.dts   | 21 +++++++++++++++++++++
 arch/arm/boot/dts/stm32f769-disco.dts  | 21 +++++++++++++++++++++
 arch/arm/boot/dts/stm32h743i-disco.dts | 21 +++++++++++++++++++++
 arch/arm/boot/dts/stm32h743i-eval.dts  | 21 +++++++++++++++++++++
 arch/arm/configs/stm32_defconfig       |  2 --
 arch/arm/mach-stm32/Kconfig            |  3 +++
 6 files changed, 87 insertions(+), 2 deletions(-)

-- 
2.7.4

From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Thu, 19 Jan 2017 14:34:07 +0100
Subject: [PATCH 0/7] Add support for triggered buffer mode to STM32 ADC
Message-ID: <1484832854-6314-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patches add support for triggered buffer mode.
These are based on top of "Add PWM and IIO timer drivers for STM32"
series. Reference:
https://lkml.org/lkml/2017/1/18/588

STM32 ADC, can use either interrupts or DMA to collect data.
Either timer trigger output (TRGO) or PWM can be used as trigger source.
This patchset has been tested on STM32F429 eval board.

- Example to enable timer1 PWM:
cd /sys/devices/platform/soc/40010000.timers/40010000.timers:pwm/pwm/pwmchip4/
echo 0 > export # timer 1 channel 1
echo 1000000 > pwm0/period # 1000Hz
echo 500000 > pwm0/duty_cycle
echo 1 > pwm0/enable

- Example to enable timer3 TRGO:
cd /sys/bus/iio/devices/
cat trigger6/name 
tim1_ch1
cat trigger0/name 
tim3_trgo
echo 1000 > trigger0/sampling_frequency

- Example to configure STM32ADC in triggered buffer mode, with timer1 PWM
  or timer3 TRGO:
cd /sys/bus/iio/devices/iio\:device0
echo tim1_ch1 > trigger/current_trigger
OR: echo tim3_trgo > trigger/current_trigger
echo 1 > scan_elements/in_voltage8_en
echo 1 > buffer/enable

Fabrice Gasnier (7):
  iio: adc: stm32: add support for triggered buffer mode
  iio: adc: stm32: Enable use of stm32 timer triggers
  iio: adc: stm32: add trigger polarity extended attribute
  Documentation: dt: iio: stm32-adc: optional dma support
  iio: adc: stm32: add optional dma support
  ARM: dts: stm32: Enable dma by default on stm32f4 adc
  ARM: dts: stm32: Enable pwm1 and pwm3 for stm32f469-eval

 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |   7 +
 arch/arm/boot/dts/stm32429i-eval.dts               |  28 +
 arch/arm/boot/dts/stm32f429.dtsi                   |   6 +
 drivers/iio/adc/Kconfig                            |   6 +
 drivers/iio/adc/stm32-adc-core.c                   |   1 +
 drivers/iio/adc/stm32-adc-core.h                   |   2 +
 drivers/iio/adc/stm32-adc.c                        | 643 ++++++++++++++++++++-
 7 files changed, 690 insertions(+), 3 deletions(-)

-- 
1.9.1

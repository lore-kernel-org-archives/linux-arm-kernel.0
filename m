From: hao5781286@gmail.com (Hao Zhang)
Date: Mon, 26 Nov 2018 00:18:02 +0800
Subject: [PATCH v3 0/6] PWM support for allwinner sun8i R40/T3/V40 SOCs.
Message-ID: <20181125161534.GA4481@arx-s1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PWM support for allwinner sun8i R40/T3/V40 SOCs.

The sun8i R40/T3/V40 PWM has 8 PWM channals and divides to 4 PWM pairs,
each PWM pair built-in 1 clock module, 2 timer logic module and 1
programmable dead-time generator, it also support waveform capture.
It has 2 clock sources OSC24M and APB1, it is different with the
sun4i-pwm driver, Therefore add a new driver for it.

Some test method:
cd /sys/class/pwm/pwmchip0
echo 0 > export
cd pwm0
echo 1000 > period
echo 500 > duty_cycle
echo 1 > enable
then check the PB2 pin with oscilloscope.

v3 Changes:
1. fix coding format.
2. use 2/ilog2 instead of divide table
3. remove spinlock.
4. remove sun8i_pwm_data structure and use DT to parse pwm-channals  
5. remove inline because complier knows it better.
6. don't hardcode clock source and parse two clock source from dt "mux-0"
   and "mux-1"
7. remove bypass method.
8. add a method to change clock source when mux-0 is not support the
   input period it can change to mux-1.
9. add cycle range check.
10. add some variable to make it more readability.
11. add clk_disable_unprepare when some false accur.

v2 Changes:
1. change sun8i-r40 symbol to sun8i.
2. change pwm0_pin, pwm0-pin to pwm_ch0_pin, pwm-ch0-pin.
3. remove clk_disable_unprepare(), check !match and IS_ERR(pwm->regmap).

Hao Zhang (6):
  Documentation: ARM: sunxi: pwm: add Allwinner sun8i.
  ARM: dtsi: add pwm node for sun8i R40.
  ARM: dts: add PWM for Bananapi M2 Ultrar board.
  DEV: CLK: add function to check the using clock name of driver.
  DEV: CLK: sunxi ccu: export clk_apb1 for sun8i-r40 soc pwm.
  ARM: PWM: add allwinner sun8i R40/T3/V40 PWM support.

 .../devicetree/bindings/pwm/pwm-sun8i.txt          |  24 ++
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |   6 +
 arch/arm/boot/dts/sun8i-r40.dtsi                   |  17 +
 drivers/clk/clk.c                                  |   6 +
 drivers/clk/sunxi-ng/ccu-sun8i-r40.h               |   4 +-
 drivers/pwm/Kconfig                                |  12 +-
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-sun8i.c                            | 418 +++++++++++++++++++++
 include/dt-bindings/clock/sun8i-r40-ccu.h          |   2 +
 include/linux/clk-provider.h                       |   1 +
 10 files changed, 489 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
 create mode 100644 drivers/pwm/pwm-sun8i.c

-- 
2.7.4

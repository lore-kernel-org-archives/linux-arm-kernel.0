From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu,  4 May 2017 20:49:28 +0200
Subject: [PATCH 0/4] Meson8 pinctrl updates (PWM, I2S, SPDIF, AO pins)
Message-ID: <20170504184932.5372-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a bunch of missing pins to the Meson8 pinctrl driver.
The full pinctrl register documentation can be found in a file called
"m8_gpio.csv" which is part of older Amlogic GPL kernel releases (one
example is the GPL kernel source of the Odroid-C1, see [0]).

To sum it up, this patch adds:
- all pins with PWM function (PWM_A, PWM_B, PWM_C, PWM_D, PWM_E and PWM_F)
- I2S input and output
- SPDIF input and output
- IR remote output ("IR blaster")
- HDMI CEC in the AO domain

This patch does NOT add:
- PWM_VS (exposed on a lot of pins, as these cannot be driven by the PWM
  controllers/pwm-meson driver - these seem to be used for the backlight?)
- UART_TX_AO_A and UART_RX_AO_A on CARD_4 and CARD_5 (I'm not sure why
  there is AO functionality on non-AO pins)
- I2C_SDA_A and I2C_SCK_A on GPIOZ_9/GPIOZ_10 and GPIOZ_11/GPIOZ_12
- CLK_24M_OUT on GPIOZ_6 and CLK_32K_INCLK_32K_OUT on GPIOAO_6 as we don't
  have a driver (or documentation) how to configure the clock rate for
  these pins
- all pins for which I don't know the actual purpose (isp_led_en1 and
  isp_led_en2, all TSout pins, all TSin pins, all DVP pins, all TCON pins)


https://github.com/hardkernel/linux/blob/d1342c45452ebafb4903557f0c909f4517c90934/arch/arm/mach-meson8/tool/m8_gpio.csv

Martin Blumenstingl (4):
  pinctrl: meson: meson8b: add the PWM pins
  pinctrl: meson: meson8: add support for the I2S and SPDIF pins
  pinctrl: meson: meson8: add support for the AO remote output pin
  pinctrl: meson: meson8: add the AO HDMI CEC pin

 drivers/pinctrl/meson/pinctrl-meson8.c | 127 ++++++++++++++++++++++++++++++++-
 1 file changed, 126 insertions(+), 1 deletion(-)

-- 
2.12.2

From: rnibali@gmail.com (Roberto Nibali)
Date: Tue, 10 Apr 2012 22:10:08 +0200
Subject: [PATCH 27/40] ARM i.MX25: implement clocks using common clock
 framework
In-Reply-To: <1334065553-7565-28-git-send-email-s.hauer@pengutronix.de>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
 <1334065553-7565-28-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CAONxwYNuCND1yrc8VwqBpoDsp3CBKGqTRkPD73WXO4Tu4vu4Gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

Just a small comment below:

> +static struct clk_lookup lookups[] = {
> + ? ? ? /* i.mx25 has the i.mx21 type uart */
> + ? ? ? clkdev("imx21-uart.0", "ipg", "uart1_ipg")
> + ? ? ? clkdev("imx21-uart.0", "per", "uart_ipg_per")
> + ? ? ? clkdev("imx21-uart.1", "ipg", "uart2_ipg")
> + ? ? ? clkdev("imx21-uart.1", "per", "uart_ipg_per")
> + ? ? ? clkdev("imx21-uart.2", "ipg", "uart3_ipg")
> + ? ? ? clkdev("imx21-uart.2", "per", "uart_ipg_per")
> + ? ? ? clkdev("imx21-uart.3", "ipg", "uart4_ipg")
> + ? ? ? clkdev("imx21-uart.3", "per", "uart_ipg_per")
> + ? ? ? clkdev("imx21-uart.4", "ipg", "uart5_ipg")
> + ? ? ? clkdev("imx21-uart.4", "per", "uart_ipg_per")
> + ? ? ? clkdev("imx-gpt.0", "ipg", "ipg")
> + ? ? ? clkdev("imx-gpt.0", "per", "gpt_ipg_per")
> + ? ? ? clkdev("mxc-ehci.0", "ipg", "ipg")
> + ? ? ? clkdev("mxc-ehci.0", "ahb", "usbotg_ahb")
> + ? ? ? clkdev("mxc-ehci.0", "per", "usbdiv")
> + ? ? ? clkdev("mxc-ehci.1", "ipg", "ipg")
> + ? ? ? clkdev("mxc-ehci.1", "ahb", "usbotg_ahb")
> + ? ? ? clkdev("mxc-ehci.1", "per", "usbdiv")
> + ? ? ? clkdev("mxc-ehci.2", "ipg", "ipg")
> + ? ? ? clkdev("mxc-ehci.2", "ahb", "usbotg_ahb")
> + ? ? ? clkdev("mxc-ehci.2", "per", "usbdiv")
> + ? ? ? clkdev("fsl-usb2-udc", "ipg", "ipg")
> + ? ? ? clkdev("fsl-usb2-udc", "ahb", "usbotg_ahb")
> + ? ? ? clkdev("fsl-usb2-udc", "per", "usbdiv")
> + ? ? ? clkdev("mxc_nand.0", NULL, "nfc_ipg_per")
> + ? ? ? /* i.mx25 has the i.mx35 type cspi */
> + ? ? ? clkdev("imx35-cspi.0", NULL, "cspi1_ipg")
> + ? ? ? clkdev("imx35-cspi.1", NULL, "cspi2_ipg")
> + ? ? ? clkdev("imx35-cspi.2", NULL, "cspi3_ipg")
> + ? ? ? clkdev("mxc_pwm.0", "ipg", "pwm1_ipg")
> + ? ? ? clkdev("mxc_pwm.0", "per", "per10")
> + ? ? ? clkdev("mxc_pwm.1", "ipg", "pwm1_ipg")
> + ? ? ? clkdev("mxc_pwm.1", "per", "per10")
> + ? ? ? clkdev("mxc_pwm.2", "ipg", "pwm1_ipg")
> + ? ? ? clkdev("mxc_pwm.2", "per", "per10")
> + ? ? ? clkdev("mxc_pwm.3", "ipg", "pwm1_ipg")
> + ? ? ? clkdev("mxc_pwm.3", "per", "per10")
> + ? ? ? clkdev("imx-keypad", NULL, "kpp_ipg")
> + ? ? ? clkdev("mx25-adc", NULL, "tsc_ipg")

Wouldn't it be better to adjust this to mx25-adc.0, since it already
has a user: the new i.MX25 ADC TS driver by your colleague Juergen
Beiser, no?

> + ? ? ? clkdev("imx-i2c.0", NULL, "i2c_ipg_per")
> + ? ? ? clkdev("imx-i2c.1", NULL, "i2c_ipg_per")
> + ? ? ? clkdev("imx-i2c.2", NULL, "i2c_ipg_per")
> + ? ? ? clkdev("imx25-fec.0", "ipg", "fec_ipg")
> + ? ? ? clkdev("imx25-fec.0", "ahb", "fec_ahb")
> + ? ? ? clkdev("imxdi_rtc.0", NULL, "dryice_ipg")
> + ? ? ? clkdev("imx-fb.0", "per", "lcdc_ipg_per")
> + ? ? ? clkdev("imx-fb.0", "ipg", "lcdc_ipg")
> + ? ? ? clkdev("imx-fb.0", "ahb", "lcdc_ahb")
> + ? ? ? clkdev("imx2-wdt.0", NULL, "wdt_ipg")
> + ? ? ? clkdev("imx-ssi.0", "per", "ssi1_ipg_per")
> + ? ? ? clkdev("imx-ssi.0", "ipg", "ssi1_ipg")
> + ? ? ? clkdev("imx-ssi.1", "per", "ssi2_ipg_per")
> + ? ? ? clkdev("imx-ssi.1", "ipg", "ssi2_ipg")
> + ? ? ? clkdev("sdhci-esdhc-imx25.0", "per", "esdhc1_ipg_per")
> + ? ? ? clkdev("sdhci-esdhc-imx25.0", "ipg", "esdhc1_ipg")
> + ? ? ? clkdev("sdhci-esdhc-imx25.0", "ahb", "esdhc1_ahb")
> + ? ? ? clkdev("sdhci-esdhc-imx25.1", "per", "esdhc2_ipg_per")
> + ? ? ? clkdev("sdhci-esdhc-imx25.1", "ipg", "esdhc2_ipg")
> + ? ? ? clkdev("sdhci-esdhc-imx25.1", "ahb", "esdhc2_ahb")
> + ? ? ? clkdev("mx2-camera.0", "per", "csi_ipg_per")
> + ? ? ? clkdev("mx2-camera.0", "ipg", "csi_ipg")
> + ? ? ? clkdev("mx2-camera.0", "ahb", "csi_ahb")
> + ? ? ? clkdev(NULL, "audmux", "dummy")
> + ? ? ? clkdev("flexcan.0", NULL, "can1_ipg")
> + ? ? ? clkdev("flexcan.1", NULL, "can2_ipg")
> + ? ? ? /* i.mx25 has the i.mx35 type sdma */
> + ? ? ? clkdev("imx35-sdma", "ipg", "sdma_ipg")
> + ? ? ? clkdev("imx35-sdma", "ahb", "sdma_ahb")
> + ? ? ? clkdev(NULL, "iim", "iim_ipg")
> +};

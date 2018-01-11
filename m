From: robh@kernel.org (Rob Herring)
Date: Thu, 11 Jan 2018 14:27:07 -0600
Subject: [PATCH 5/7] clk: sunxi-ng: add support for the Allwinner H6 CCU
In-Reply-To: <20180106044918.47513-1-icenowy@aosc.io>
References: <20180106044918.47513-1-icenowy@aosc.io>
Message-ID: <20180111202707.wqvwaxxekazlbkc4@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 06, 2018 at 12:49:16PM +0800, Icenowy Zheng wrote:
> The Allwinner H6 SoC has a CCU which has been largely rearranged.
> 
> Add support for it in the sunxi-ng CCU framework.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../devicetree/bindings/clock/sunxi-ccu.txt        |    1 +
>  drivers/clk/sunxi-ng/Kconfig                       |    5 +
>  drivers/clk/sunxi-ng/Makefile                      |    1 +
>  drivers/clk/sunxi-ng/ccu-sun50i-h6.c               | 1206 ++++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu-sun50i-h6.h               |   63 +
>  include/dt-bindings/clock/sun50i-h6-ccu.h          |  159 +++
>  include/dt-bindings/reset/sun50i-h6-ccu.h          |  110 ++
>  7 files changed, 1545 insertions(+)
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h6.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h6.h
>  create mode 100644 include/dt-bindings/clock/sun50i-h6-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun50i-h6-ccu.h

[...] 

> diff --git a/include/dt-bindings/clock/sun50i-h6-ccu.h b/include/dt-bindings/clock/sun50i-h6-ccu.h
> new file mode 100644
> index 000000000000..a2d534d917bb
> --- /dev/null
> +++ b/include/dt-bindings/clock/sun50i-h6-ccu.h
> @@ -0,0 +1,159 @@
> +/*
> + * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.

Use SPDX license tag instead.

> + */
> +
> +#ifndef _DT_BINDINGS_CLK_SUN50I_H6_H_
> +#define _DT_BINDINGS_CLK_SUN50I_H6_H_
> +
> +#define CLK_PLL_PERIPH0		3
> +
> +#define CLK_CPUX		21
> +
> +#define CLK_DE			29
> +#define CLK_BUS_DE		30
> +#define CLK_DEINTERLACE		31
> +#define CLK_BUS_DEINTERLACE	32
> +#define CLK_GPU			33
> +#define CLK_BUS_GPU		34
> +#define CLK_CE			35
> +#define CLK_BUS_CE		36
> +#define CLK_VE			37
> +#define CLK_BUS_VE		38
> +#define CLK_EMCE		39
> +#define CLK_BUS_EMCE		40
> +#define CLK_VP9			41
> +#define CLK_BUS_VP9		42
> +#define CLK_BUS_DMA		43
> +#define CLK_BUS_MSGBOX		44
> +#define CLK_BUS_SPINLOCK	45
> +#define CLK_BUS_HSTIMER		46
> +#define CLK_AVS			47
> +#define CLK_BUS_DBG		48
> +#define CLK_BUS_PSI		49
> +#define CLK_BUS_PWM		50
> +#define CLK_BUS_IOMMU		51
> +
> +#define CLK_MBUS_DMA		53
> +#define CLK_MBUS_VE		54
> +#define CLK_MBUS_CE		55
> +#define CLK_MBUS_TS		56
> +#define CLK_MBUS_NAND		57
> +#define CLK_MBUS_CSI		58
> +#define CLK_MBUS_DEINTERLACE	59
> +
> +#define CLK_NAND0		61
> +#define CLK_NAND1		62
> +#define CLK_BUS_NAND		63
> +#define CLK_MMC0		64
> +#define CLK_MMC1		65
> +#define CLK_MMC2		66
> +#define CLK_BUS_MMC0		67
> +#define CLK_BUS_MMC1		68
> +#define CLK_BUS_MMC2		69
> +#define CLK_BUS_UART0		70
> +#define CLK_BUS_UART1		71
> +#define CLK_BUS_UART2		72
> +#define CLK_BUS_UART3		73
> +#define CLK_BUS_I2C0		74
> +#define CLK_BUS_I2C1		75
> +#define CLK_BUS_I2C2		76
> +#define CLK_BUS_I2C3		77
> +#define CLK_BUS_SCR0		78
> +#define CLK_BUS_SCR1		79
> +#define CLK_SPI0		80
> +#define CLK_SPI1		81
> +#define CLK_BUS_SPI0		82
> +#define CLK_BUS_SPI1		83
> +#define CLK_BUS_EMAC		84
> +#define CLK_TS			85
> +#define CLK_BUS_TS		86
> +#define CLK_IR_TX		87
> +#define CLK_BUS_IR_TX		88
> +#define CLK_BUS_THS		89
> +#define CLK_I2S3		90
> +#define CLK_I2S0		91
> +#define CLK_I2S1		92
> +#define CLK_I2S2		93
> +#define CLK_BUS_I2S0		94
> +#define CLK_BUS_I2S1		95
> +#define CLK_BUS_I2S2		96
> +#define CLK_BUS_I2S3		97
> +#define CLK_SPDIF		98
> +#define CLK_BUS_SPDIF		99
> +#define CLK_DMIC		100
> +#define CLK_BUS_DMIC		101
> +#define CLK_AUDIO_HUB		102
> +#define CLK_BUS_AUDIO_HUB	103
> +#define CLK_USB_OHCI0		104
> +#define CLK_USB_PHY0		105
> +#define CLK_USB_PHY1		106
> +#define CLK_USB_OHCI3		107
> +#define CLK_USB_PHY3		108
> +#define CLK_USB_HSIC_12M	109
> +#define CLK_USB_HSIC		110
> +#define CLK_BUS_OHCI0		111
> +#define CLK_BUS_OHCI3		112
> +#define CLK_BUS_EHCI0		113
> +#define CLK_BUS_XHCI		114
> +#define CLK_BUS_EHCI3		115
> +#define CLK_BUS_OTG		116
> +#define CLK_PCIE_REF_100M	117
> +#define CLK_PCIE_REF		118
> +#define CLK_PCIE_REF_OUT	119
> +#define CLK_PCIE_MAXI		120
> +#define CLK_PCIE_AUX		121
> +#define CLK_BUS_PCIE		122
> +#define CLK_HDMI		123
> +#define CLK_HDMI_CEC		124
> +#define CLK_BUS_HDMI		125
> +#define CLK_BUS_TCON_TOP	126
> +#define CLK_TCON_LCD0		127
> +#define CLK_BUS_TCON_LCD0	128
> +#define CLK_TCON_TV0		129
> +#define CLK_BUS_TCON_TV0	130
> +#define CLK_CSI_CCI		131
> +#define CLK_CSI_TOP		132
> +#define CLK_CSI_MCLK		133
> +#define CLK_BUS_CSI		134
> +#define CLK_HDCP		135
> +#define CLK_BUS_HDCP		136
> +
> +#endif /* _DT_BINDINGS_CLK_SUN50I_H6_H_ */
> diff --git a/include/dt-bindings/reset/sun50i-h6-ccu.h b/include/dt-bindings/reset/sun50i-h6-ccu.h
> new file mode 100644
> index 000000000000..d40ae3bf418f
> --- /dev/null
> +++ b/include/dt-bindings/reset/sun50i-h6-ccu.h
> @@ -0,0 +1,110 @@
> +/*
> + * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.

Use SPDX license tag instead.

> + */
> +
> +#ifndef _DT_BINDINGS_RESET_SUN50I_H6_H_
> +#define _DT_BINDINGS_RESET_SUN50I_H6_H_
> +
> +#define RST_MBUS		0
> +#define RST_BUS_DE		1
> +#define RST_BUS_DEINTERLACE	2
> +#define RST_BUS_GPU		3
> +#define RST_BUS_CE		4
> +#define RST_BUS_VE		5
> +#define RST_BUS_EMCE		6
> +#define RST_BUS_VP9		7
> +#define RST_BUS_DMA		8
> +#define RST_BUS_MSGBOX		9
> +#define RST_BUS_SPINLOCK	10
> +#define RST_BUS_HSTIMER		11
> +#define RST_BUS_DBG		12
> +#define RST_BUS_PSI		13
> +#define RST_BUS_PWM		14
> +#define RST_BUS_IOMMU		15
> +#define RST_BUS_DRAM		16
> +#define RST_BUS_NAND		17
> +#define RST_BUS_MMC0		18
> +#define RST_BUS_MMC1		19
> +#define RST_BUS_MMC2		20
> +#define RST_BUS_UART0		21
> +#define RST_BUS_UART1		22
> +#define RST_BUS_UART2		23
> +#define RST_BUS_UART3		24
> +#define RST_BUS_I2C0		25
> +#define RST_BUS_I2C1		26
> +#define RST_BUS_I2C2		27
> +#define RST_BUS_I2C3		28
> +#define RST_BUS_SCR0		29
> +#define RST_BUS_SCR1		30
> +#define RST_BUS_SPI0		31
> +#define RST_BUS_SPI1		32
> +#define RST_BUS_EMAC		33
> +#define RST_BUS_TS		34
> +#define RST_BUS_IR_TX		35
> +#define RST_BUS_THS		36
> +#define RST_BUS_I2S0		37
> +#define RST_BUS_I2S1		38
> +#define RST_BUS_I2S2		39
> +#define RST_BUS_I2S3		40
> +#define RST_BUS_SPDIF		41
> +#define RST_BUS_DMIC		42
> +#define RST_BUS_AUDIO_HUB	43
> +#define RST_USB_PHY0		44
> +#define RST_USB_PHY1		45
> +#define RST_USB_PHY3		46
> +#define RST_USB_HSIC		47
> +#define RST_BUS_OHCI0		48
> +#define RST_BUS_OHCI3		49
> +#define RST_BUS_EHCI0		50
> +#define RST_BUS_XHCI		51
> +#define RST_BUS_EHCI3		52
> +#define RST_BUS_OTG		53
> +#define RST_BUS_PCIE		54
> +#define RST_PCIE_POWERUP	55
> +#define RST_BUS_HDMI		56
> +#define RST_BUS_HDMI_SUB	57
> +#define RST_BUS_TCON_TOP	58
> +#define RST_BUS_TCON_LCD0	59
> +#define RST_BUS_TCON_TV0	60
> +#define RST_BUS_CSI		61
> +#define RST_BUS_HDCP		62
> +
> +#endif /* _DT_BINDINGS_RESET_SUN50I_H6_H_ */
> -- 
> 2.14.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

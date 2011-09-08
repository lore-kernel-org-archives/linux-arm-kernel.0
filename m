From: rpimentel.silva@gmail.com (Rogerio Pimentel)
Date: Thu, 8 Sep 2011 13:30:09 -0300
Subject: [PATCH 1/4] ARM: mx53: Add pads for flexcan pins
In-Reply-To: <20110906193258.GN28816@pengutronix.de>
References: <1315335696-20499-1-git-send-email-rogerio.pimentel@freescale.com>
	<20110906193258.GN28816@pengutronix.de>
Message-ID: <CAOkaPuW+6tOFKHSbG+4254t=agqYT480X6bJCP9zicE4VHnvdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/6 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
...
>> ?#define PAD_CTRL_I2C (PAD_CTL_SRE_FAST | PAD_CTL_ODE | PAD_CTL_PKE | \
>> ? ? ? ? ? ? ? ? ? ? ? PAD_CTL_PUE | PAD_CTL_DSE_HIGH | PAD_CTL_PUS_100K_UP \
>> ? ? ? ? ? ? ? ? ? ? ? | PAD_CTL_HYS)
>> +#define MX53_CAN_PAD_CTRL ? ?(PAD_CTL_PKE | PAD_CTL_PUE | PAD_CTL_DSE_HIGH | \
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? PAD_CTL_HYS)
>> +#define MX53_PAD_CTRL_1 ? ? ?(PAD_CTL_PKE | PAD_CTL_PUE | PAD_CTL_DSE_HIGH | \
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? PAD_CTL_HYS | PAD_CTL_PUS_100K_UP)
> Hmm, isn't there a better name for this define? Maybe
> MX53_CAN_RX_PAD_CTRL and MX53_CAN_TX_PAD_CTRL?

CAN_RX uses a common pad config that will be used on further pin
configs, so I think it will be redundant if I create two defines with
the same config. You can see some other pins configured using
MX53_PAD_CTRL_1 on Freescale Kernel:
http://opensource.freescale.com/git?p=imx/linux-2.6-imx.git;a=blob;f=arch/arm/plat-mxc/include/mach/iomux-mx53.h;h=4f28c0f48d299bf7b4399f964c433205549aba2d;hb=imx_2.6.35
...

>> ?#define _MX53_PAD_GPIO_19__KPP_COL_5 ? ? ? ? IOMUX_PAD(0x348, 0x20, 0, 0x840, 0, 0)
>> ?#define _MX53_PAD_GPIO_19__GPIO4_5 ? ? ? ? ? IOMUX_PAD(0x348, 0x20, 1, 0x0, 0, 0)
>> @@ -1243,14 +1247,14 @@
>> ?#define MX53_PAD_KEY_ROW1__USBPHY1_RXVALID ? ? ? ? ? (_MX53_PAD_KEY_ROW1__USBPHY1_RXVALID | MUX_PAD_CTRL(NO_PAD_CTRL))
>> ?#define MX53_PAD_KEY_COL2__KPP_COL_2 ? ? ? ? (_MX53_PAD_KEY_COL2__KPP_COL_2 | MUX_PAD_CTRL(NO_PAD_CTRL))
>> ?#define MX53_PAD_KEY_COL2__GPIO4_10 ? ? ? ? ?(_MX53_PAD_KEY_COL2__GPIO4_10 | MUX_PAD_CTRL(NO_PAD_CTRL))
>> -#define MX53_PAD_KEY_COL2__CAN1_TXCAN ? ? ? ? ? ? ? ?(_MX53_PAD_KEY_COL2__CAN1_TXCAN | MUX_PAD_CTRL(NO_PAD_CTRL))
>> +#define MX53_PAD_KEY_COL2__CAN1_TXCAN ? ? ? ? ? ? ? ?(_MX53_PAD_KEY_COL2__CAN1_TXCAN | MUX_PAD_CTRL(MX53_PAD_CTRL_1))
> I wonder if this change is universal. If an external pull-up is
> assembled using MX53_CAN_PAD_CTRL would be fine? (Note, I don't know if
> it is sensible to do so.)

At least on i.MX53 ARD board an internal pull up is used without any
pull up resistor on the board. It avoids an extra component on board.

From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 8 Sep 2014 11:26:57 +0200
Subject: arm: Add basic support for MediaTek MT8127 & MT8135 SoCs
In-Reply-To: <20140908072824.GB15722@pengutronix.de>
References: <1409874660-8710-1-git-send-email-srv_yingjoe.chen@mediatek.com>
 <20140908072824.GB15722@pengutronix.de>
Message-ID: <CABuKBeJBVo92hksBXoGmzEL_CEv0a5tK4Nod6_ZLxz5PXLS87A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-09-08 9:28 GMT+02:00 Sascha Hauer <s.hauer@pengutronix.de>:
> On Fri, Sep 05, 2014 at 07:50:55AM +0800, Joe.C wrote:
>> This series add basic device tree support MT8127 & MT8135.
>> This series is based on v3.17-rc3.
>>
>> We are planning to upstream drivers for MT8127 & MT8135 SoCs.
>> MT8135 is a tablet soc featuring 2 CA7 + 2 CA15. MT8127 is a
>> tablet soc with 4 CA7. They share many similar IP components
>> with MT65xx series.
>>
>> Please note this one is not base on intpol [1] patches I sent
>> last month. Base on the discussion on intpol, I think it might
>> take some more time. I'd like to have this merge first so we
>> can work on other stuff simultaneously.
>>
>> Joe.C
>>
>> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/279052.html
>>
>> Joe.C (5):
>>   arm: MTK: Add basic support for mt8127
>>   arm: mediatek: add dts for 8127 Moose board
>>   arm: MTK: Add basic support for mt8135
>>   arm: mediatek: add dts for MT8135 evaluation board.
>>   dt-bindings: add more chips in documentation for Mediatek SoC
>
> We could add the following patch to this series so we actually see
> something on the console during development of the other drivers.
> I only know the UART base addresses of the mt8135, so I don't know
> if MEDIATEK_ is an appropriate prefix. Maybe it should be changed to
> MT8135_.

Yes it should be MT8135_ as other chips have the UART mapped to
different addresses [0].

Cheers,
Matthias

[0] https://lkml.org/lkml/2014/8/18/454

>
> Sascha
>
> ----------------------------8<-------------------------------
>
> From 16709f768d955b561972f809f2a6260435cabbe4 Mon Sep 17 00:00:00 2001
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Date: Mon, 8 Sep 2014 09:17:02 +0200
> Subject: [PATCH] ARM: Mediatek: Add lowlevel debug uart support
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/Kconfig.debug | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index b11ad54..0d33c74 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -348,6 +348,22 @@ choice
>                   Say Y here if you want the debug print routines to direct
>                   their output to UART1 serial port on KEYSTONE2 devices.
>
> +       config DEBUG_MEDIATEK_UART0
> +               bool "Mediatek SoC Debug UART0"
> +               depends on ARCH_MEDIATEK
> +               select DEBUG_UART_8250
> +               help
> +                 Say Y here if you want kernel low-level debugging support
> +                 on Mediatek SoC based platforms.
> +
> +       config DEBUG_MEDIATEK_UART3
> +               bool "Mediatek SoC Debug UART3"
> +               depends on ARCH_MEDIATEK
> +               select DEBUG_UART_8250
> +               help
> +                 Say Y here if you want kernel low-level debugging support
> +                 on Mediatek SoC based platforms.
> +
>         config DEBUG_MMP_UART2
>                 bool "Kernel low-level debugging message via MMP UART2"
>                 depends on ARCH_MMP
> @@ -1108,6 +1124,8 @@ config DEBUG_UART_PHYS
>         default 0xd0012000 if DEBUG_MVEBU_UART
>         default 0xd4017000 if DEBUG_MMP_UART2
>         default 0xd4018000 if DEBUG_MMP_UART3
> +       default 0x11006000 if DEBUG_MEDIATEK_UART0
> +       default 0x11009000 if DEBUG_MEDIATEK_UART3
>         default 0xe0000000 if ARCH_SPEAR13XX
>         default 0xf0000be0 if ARCH_EBSA110
>         default 0xf1012000 if DEBUG_MVEBU_UART_ALTERNATE
> @@ -1164,6 +1182,8 @@ config DEBUG_UART_VIRT
>         default 0xfe012000 if ARCH_ORION5X
>         default 0xfe017000 if DEBUG_MMP_UART2
>         default 0xfe018000 if DEBUG_MMP_UART3
> +       default 0xfe806000 if DEBUG_MEDIATEK_UART0
> +       default 0xfe809000 if DEBUG_MEDIATEK_UART3
>         default 0xfe100000 if DEBUG_IMX23_UART || DEBUG_IMX28_UART
>         default 0xfe230000 if DEBUG_PICOXCELL_UART
>         default 0xfe300000 if DEBUG_BCM_KONA_UART
> --
> 1.8.3.2
>
>
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |



-- 
motzblog.wordpress.com

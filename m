From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 03 Jul 2017 16:42:15 +0200
Subject: [RFC 0/2] clk: imx7d: Uart clock set-up conflict if clk needs
 gating on set rate or re-parent
In-Reply-To: <1499092083-2852-1-git-send-email-adriana.reus@nxp.com>
References: <1499092083-2852-1-git-send-email-adriana.reus@nxp.com>
Message-ID: <1499092935.2308.18.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 03.07.2017, 17:28 +0300 schrieb Adriana Reus:
> Hi all,
> 
> I am currently trying to fix an issue occurring when trying to set the
> CLK_SET_RATE_GATE flag for the uart root clks. This causes the imx serial
> driver to fail when setting up devicetree specified frequency or parent because
> the uart clk is already in use by the ccm driver that starts up all uart clocks
> for earlycon.
> 
> Some context:
> 
> There are three main types of clock slices on imx7d ccm: "Core clock slice",
> "Bus clock slice (AXI/AHB)", and "Peripheral clock slice". Vast majority of
> clock roots fall in the peripheral slice category:
> 
>     8:1 mux -> gate -> div -> div -> gate
> 
> The root clocks that derive from peripheral slices are expected to be
> gated when changing frequency [0].
> 
> The first patch of this series sets this up. (It is only a reference point for
> this conversation, not to be merged as it WIP and needs more testing).
> 
> When setting this up, the imx serial driver
> (platform_driver_register -> of_clk_set_defaults) will fail
> to set the rate or parent specified in the devicetree:
> 
>     imx-uart 30a70000.serial: clk_set_rate() failed
>     imx-uart: probe of 30a70000.serial failed with error -16
> 
> The reason for this is that the uart clks are already prepared and enabled in
> imx7d_clocks_init by the imx_register_uart_clocks function if earlycon is
> enabled. Functionality added in patches:
> 'commit 55adc61c568af99419be1dc0412f8eae019c71f2
> ("clk: imx: add common logic to detect early UART usage")'
> 'commit 1b9af68f325cb91ac9fc691f52d69dfb0826afd7
> ("clk: imx7d: retain early UART clocks during kernel init")'
> 
> One option is to remove the imx_register_uart_clocks from the ccm driver and
> leave the uart clock set up and enable entirely to the serial driver and DT.
> The second RFC patch does this for imx7d.

This is not an option. The CCM holds a reference to those clocks,
specifically to prevent them from being disabled before a real serial
driver is bound. If this isn't done you might end up in a situation
where PM or driver probe deferal disables the UART clock/the parent of
this clock, even if it was previously enabled by the bootloader. With
earlycon this might lead to a full system hang at this point, when
earlycon tries to access a clock gated UART.

Regards,
Lucas

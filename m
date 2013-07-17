From: tony@atomide.com (Tony Lindgren)
Date: Wed, 17 Jul 2013 08:32:49 -0700
Subject: [PATCH 3/3] ARM: dts: omap4-sdp: add dynamic pin states for
 uart3/4
In-Reply-To: <1374061312-25469-4-git-send-email-grygorii.strashko@ti.com>
References: <1374061312-25469-1-git-send-email-grygorii.strashko@ti.com>
 <1374061312-25469-4-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20130717153248.GI7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grygorii Strashko <grygorii.strashko@ti.com> [130717 04:49]:
> Add dynamic "active"/"idle" pin states for uart3/4 which will be applied
> when uart3/4 state is switched from active to idle and back by Runtime
> PM or during system suspend.

This is good for testing code, but should not be merged because
omap4 has the iopad wake-ups available for uarts. So those can
be always enabled.
 
> --- a/arch/arm/boot/dts/omap4-sdp.dts
> +++ b/arch/arm/boot/dts/omap4-sdp.dts
> @@ -181,18 +181,40 @@
>  		pinctrl-single,pins = <
>  			0x100 (PIN_INPUT_PULLUP | MUX_MODE0)	/* uart3_cts_rctx.uart3_cts_rctx */
>  			0x102 (PIN_OUTPUT | MUX_MODE0)		/* uart3_rts_sd.uart3_rts_sd */
> -			0x104 (PIN_INPUT | MUX_MODE0)		/* uart3_rx_irrx.uart3_rx_irrx */
>  			0x106 (PIN_OUTPUT | MUX_MODE0)		/* uart3_tx_irtx.uart3_tx_irtx */
>  		>;
>  	};

This just need to become:
		pinctrl-single,pins = <
			...
			0x104 (WAKEUP_EN | PIN_INPUT_MUX_MODE0)	/* uart3_rx_irrx.uart3_rx_irrx */
			...
		>;
		interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
	};

And so on. For am33xx you need to remux things to GPIO for the wake-up
events, so you should maybe test on that instead.

Regards,

Tony

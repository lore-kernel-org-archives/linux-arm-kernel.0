From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 20 Jun 2012 16:05:44 +0400
Subject: [PATCH 3/5] ARM: omap3evm: enable VBUS switch for EHCI tranceiver
In-Reply-To: <1340183693-3195-4-git-send-email-zumeng.chen@windriver.com>
References: <1340183693-3195-1-git-send-email-zumeng.chen@windriver.com>
 <1340183693-3195-4-git-send-email-zumeng.chen@windriver.com>
Message-ID: <4FE1BC98.7050607@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 20-06-2012 13:14, Zumeng Chen wrote:

> This was chosen by following the trace on the schematic from component U131
> and U134 to the CPEN pin on the USB3320 device.

> TWL4030.GPIO2-...->(T2_GPIO2_3V3)U131-..>nUSB2_EN-..>U134-..>EXP_nUSB2_1V8
> which starts EHCI tranceiver USB3320.

> This will set TWL4030.GPIO2 as output pin to drive EHCI tranceiver.

> Signed-off-by: Zumeng Chen<zumeng.chen@windriver.com>
> ---
>   arch/arm/mach-omap2/board-omap3evm.c |    9 +++++++++
>   1 files changed, 9 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> index 1bfbe42..02d8047 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -360,6 +360,15 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
>
>   	platform_device_register(&leds_gpio);
>
> +	/* Enable VBUS switch by setting TWL4030.GPIO2DIR as output
> +	 * for starting USB tranceiver
> +	 */
> +	if (get_omap3_evm_rev()>= OMAP3EVM_BOARD_GEN_2) {
> +		u8 val;

    Empty line after declaration block wouldn't hurt...

> +		twl_i2c_read_u8(TWL4030_MODULE_GPIO,&val, REG_GPIODATADIR1);
> +		val |= 0x04; /* TWL4030.GPIO2DIR BIT at GPIODATADIR1(0x9B) */
> +		twl_i2c_write_u8(TWL4030_MODULE_GPIO, val, REG_GPIODATADIR1);
> +	}
>   	return 0;
>   }

WBR, Sergei

From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 02 Feb 2011 15:07:04 +0300
Subject: [PATCH v1 8/9] da850: pruss CAN board specific changes for gpios.
In-Reply-To: <1296571667-12049-9-git-send-email-subhasish@mistralsolutions.com>
References: <1296571667-12049-1-git-send-email-subhasish@mistralsolutions.com>
	<1296571667-12049-9-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <4D4948E8.4020106@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01-02-2011 17:47, Subhasish Ghosh wrote:

> This patch adds the GPIO modifications required for the pruss CAN.

> Signed-off-by: Subhasish Ghosh<subhasish@mistralsolutions.com>
> ---
>   arch/arm/mach-davinci/board-da850-evm.c |   11 ++++++++++-
>   1 files changed, 10 insertions(+), 1 deletions(-)

> diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
> index 285545f..737df73 100644
> --- a/arch/arm/mach-davinci/board-da850-evm.c
> +++ b/arch/arm/mach-davinci/board-da850-evm.c
> @@ -45,6 +45,7 @@
>
>   #define DA850_MMCSD_CD_PIN		GPIO_TO_PIN(4, 0)
>   #define DA850_MMCSD_WP_PIN		GPIO_TO_PIN(4, 1)
> +#define DA850_PRUSS_CAN_TRX_PIN	GPIO_TO_PIN(2, 0)
>
>   #define DA850_MII_MDIO_CLKEN_PIN	GPIO_TO_PIN(2, 6)
>
> @@ -1055,7 +1056,7 @@ static __init int da850_evm_init_cpufreq(void) { return 0; }
>
>   const short da850_pruss_can_pins[] = {
>   	DA850_PRUSS_PRU0_R31_0, DA850_PRUSS_PRU1_R30_15,
> -	DA850_PRUSS_PRU1_R31_18,
> +	DA850_PRUSS_PRU1_R31_18, DA850_GPIO2_0,
>   	-1
>   };
>
> @@ -1076,6 +1077,14 @@ static int __init da850_evm_setup_pruss_can(void)
>   	val |= BIT(3);
>   	__raw_writel(val, cfg_chip3_base);
>
> +	/* value = 0 to enable the CAN transceiver */
> +	ret = gpio_request_one(DA850_PRUSS_CAN_TRX_PIN,
> +					GPIOF_OUT_INIT_LOW, "pruss_can_en");
> +	if (ret) {
> +		pr_warning("Cannot setup GPIO %d\n", DA850_PRUSS_CAN_TRX_PIN);
> +		gpio_free(DA850_PRUSS_CAN_TRX_PIN);
> +	}
> +
>   	return ret;
>   }

    Should be mereged with patch 5/9, I think...

WBR, Sergei

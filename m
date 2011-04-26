From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 26 Apr 2011 14:57:13 +0400
Subject: [PATCH v4 11/11] da850: pruss CAN board specific additions.
In-Reply-To: <1303474109-6212-12-git-send-email-subhasish@mistralsolutions.com>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<1303474109-6212-12-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <4DB6A509.2010009@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 22-04-2011 16:08, Subhasish Ghosh wrote:

> This patch adds the pruss CAN pinmux and registers the device
> with the pruss mfd driver.

> Signed-off-by: Subhasish Ghosh<subhasish@mistralsolutions.com>
> ---
>   arch/arm/mach-davinci/board-da850-evm.c |   46 +++++++++++++++++++++++++++++++
>   1 files changed, 46 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
> index e7fdf31..e1ff18c 100644
> --- a/arch/arm/mach-davinci/board-da850-evm.c
> +++ b/arch/arm/mach-davinci/board-da850-evm.c
[...]
> @@ -1117,6 +1118,43 @@ static __init int da850_evm_init_cpufreq(void)
>   static __init int da850_evm_init_cpufreq(void) { return 0; }
>   #endif
>
> +static const short da850_evm_pruss_can_pins[] = {
> +	DA850_PRUSS_PRU0_R31_0, DA850_PRUSS_PRU1_R30_15,
> +	DA850_PRUSS_PRU1_R31_18, DA850_GPIO2_0,
> +	-1
> +};
> +
> +static int __init da850_evm_pruss_can_setup(void)
> +{
> +	int ret, val = 0;
> +	void __iomem *cfg_chip3_reg;
> +
> +	ret = davinci_cfg_reg_list(da850_evm_pruss_can_pins);
> +	if (ret)
> +		pr_warning("%s: da850_evm_pruss_can_pins mux setup "
> +					"failed:%d\n", __func__, ret);

    Yet you continue to initialize... you should stop here I think.

> +	/* value = 0 to enable the CAN transceiver */
> +	ret = gpio_request_one(DA850_PRUSS_CAN_TRX_PIN,
> +			GPIOF_OUT_INIT_LOW, "pruss_can_en");
> +	if (ret) {
> +		pr_warning("Cannot setup GPIO %d\n", DA850_PRUSS_CAN_TRX_PIN);
> +		gpio_free(DA850_PRUSS_CAN_TRX_PIN);

    Doesn't gpio_request_one() handle freeing GPIO on error?

WBR, Sergei

From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 26 Jul 2017 09:24:30 +0100
Subject: [PATCH 3/3] memory: atmel-ebi: Fix smc cycle xlate converter
In-Reply-To: <1500984024-26403-4-git-send-email-ada@thorsis.com>
References: <1500984024-26403-1-git-send-email-ada@thorsis.com>
 <1500984024-26403-4-git-send-email-ada@thorsis.com>
Message-ID: <20170726082430.3egpdk7dtqh2uoa5@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Jul 2017, Alexander Dahl wrote:

> The converter function for translating ns timings in register values was
> initialized with a wrong function pointer. This resulted in wrong
> register values also for the setup and pulse registers when configuring
> the EBI interface trough dts.
> 
> Includes a small fix in a comment of the smc driver, which was probably
> just a copy'n'paste mistake.
> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>  drivers/memory/atmel-ebi.c | 2 +-
>  drivers/mfd/atmel-smc.c    | 2 +-

Acked-by: Lee Jones <lee.jones@linaro.org>

>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
> index f8a01ae..ebf69ff 100644
> --- a/drivers/memory/atmel-ebi.c
> +++ b/drivers/memory/atmel-ebi.c
> @@ -72,7 +72,7 @@ struct atmel_smc_timing_xlate {
>  	{ .name = nm, .converter = atmel_smc_cs_conf_set_pulse, .shift = pos}
>  
>  #define ATMEL_SMC_CYCLE_XLATE(nm, pos)	\
> -	{ .name = nm, .converter = atmel_smc_cs_conf_set_setup, .shift = pos}
> +	{ .name = nm, .converter = atmel_smc_cs_conf_set_cycle, .shift = pos}
>  
>  static void at91sam9_ebi_get_config(struct atmel_ebi_dev *ebid,
>  				    struct atmel_ebi_dev_config *conf)
> diff --git a/drivers/mfd/atmel-smc.c b/drivers/mfd/atmel-smc.c
> index 954cf0f..20cc0ea 100644
> --- a/drivers/mfd/atmel-smc.c
> +++ b/drivers/mfd/atmel-smc.c
> @@ -206,7 +206,7 @@ EXPORT_SYMBOL_GPL(atmel_smc_cs_conf_set_pulse);
>   *	     parameter
>   *
>   * This function encodes the @ncycles value as described in the datasheet
> - * (section "SMC Pulse Register"), and then stores the result in the
> + * (section "SMC Cycle Register"), and then stores the result in the
>   * @conf->setup field at @shift position.
>   *
>   * Returns -EINVAL if @shift is invalid, -ERANGE if @ncycles does not fit in

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

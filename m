From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 09 Mar 2011 12:59:41 +0100
Subject: [PATCH v3 3/7] da850: pruss board specific additions.
In-Reply-To: <1299592667-21367-4-git-send-email-subhasish@mistralsolutions.com>
References: <1299592667-21367-1-git-send-email-subhasish@mistralsolutions.com>
	<1299592667-21367-4-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <4D776BAD.1020307@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2011 02:57 PM, Subhasish Ghosh wrote:
> This patch adds board specific initializations and setup routines.
> 
> Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
> ---
>  arch/arm/mach-davinci/board-da850-evm.c |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
> index 11f986b..c614c82 100644
> --- a/arch/arm/mach-davinci/board-da850-evm.c
> +++ b/arch/arm/mach-davinci/board-da850-evm.c
> @@ -1053,6 +1053,26 @@ static __init int da850_evm_init_cpufreq(void)
>  static __init int da850_evm_init_cpufreq(void) { return 0; }
>  #endif
>  
> +static struct da8xx_pruss_devices pruss_devices[] = {
> +	{.dev_name = NULL,},
> +};
> +
> +static int __init da8xx_evm_setup_pruss(void)
> +{
> +	u32 ret = 0;
your functions returns an int, not an u32
> +	u32 count;

use "int i" for loop counter.

> +
> +	for (count = 0; count < ARRAY_SIZE(pruss_devices); count++) {
> +		if (pruss_devices[count].setup != NULL) {

you may omit the "!= NULL"

> +			ret = pruss_devices[count].setup();
> +			if (ret)
> +				return ret;

in case of an error you don't clean up correct

> +		}
> +	}
> +
> +	return da8xx_register_pruss_mfd(pruss_devices);
> +}
> +
>  static __init void da850_evm_init(void)
>  {
>  	int ret;
> @@ -1127,6 +1147,11 @@ static __init void da850_evm_init(void)
>  
>  	da8xx_register_mcasp(0, &da850_evm_snd_data);
>  
> +	ret = da8xx_evm_setup_pruss();
> +	if (ret)
> +		pr_warning("%s: pruss initialization failed: %d\n",
> +				__func__, ret);
> +
>  	ret = davinci_cfg_reg_list(da850_lcdcntl_pins);
>  	if (ret)
>  		pr_warning("da850_evm_init: lcdcntl mux setup failed: %d\n",


-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110309/9b942493/attachment.sig>

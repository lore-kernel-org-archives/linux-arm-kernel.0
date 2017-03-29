From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 29 Mar 2017 11:13:58 +0100
Subject: [PATCH v2 7/8] bus: brcmstb_gisb: add notifier handling
In-Reply-To: <20170328213431.10904-8-opendmb@gmail.com>
References: <20170328213431.10904-1-opendmb@gmail.com>
 <20170328213431.10904-8-opendmb@gmail.com>
Message-ID: <20170329101357.GB23442@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

On Tue, Mar 28, 2017 at 02:34:30PM -0700, Doug Berger wrote:
> Check for GISB arbitration errors through a chained notifier
> when a process dies or a kernel panic occurs.  This allows a
> meaningful diagnostic message to occur along with other
> diagnostic information.
> 
> Notably writes to a bad GISB address on an ARM64 architecture
> kernel cause unrecoverable SError aborts and this allows the
> cause of the abort to be seen.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Thanks for changing this.

> ---
>  drivers/bus/brcmstb_gisb.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
> index 500b6bb5c739..774729002b8c 100644
> --- a/drivers/bus/brcmstb_gisb.c
> +++ b/drivers/bus/brcmstb_gisb.c
> @@ -24,6 +24,8 @@
>  #include <linux/of.h>
>  #include <linux/bitops.h>
>  #include <linux/pm.h>
> +#include <linux/kernel.h>
> +#include <linux/kdebug.h>
>  
>  #ifdef CONFIG_ARM
>  #include <asm/bug.h>
> @@ -290,6 +292,25 @@ static irqreturn_t brcmstb_gisb_tea_handler(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +/*
> + * Dump out gisb errors on die or panic.
> + */
> +static int dump_gisb_error(struct notifier_block *self, unsigned long v,
> +			   void *p)
> +{
> +	struct brcmstb_gisb_arb_device *gdev;
> +
> +	/* iterate over each GISB arb registered handlers */
> +	list_for_each_entry(gdev, &brcmstb_gisb_arb_device_list, next)
> +		brcmstb_gisb_arb_decode_addr(gdev, "async abort");
> +
> +	return 0;

I think this should be NOTIFY_OK.

> +}
> +
> +static struct notifier_block gisb_error_notifier = {
> +	.notifier_call = dump_gisb_error,
> +};
> +
>  static DEVICE_ATTR(gisb_arb_timeout, S_IWUSR | S_IRUGO,
>  		gisb_arb_get_timeout, gisb_arb_set_timeout);
>  
> @@ -408,6 +429,12 @@ static int __init brcmstb_gisb_arb_probe(struct platform_device *pdev)
>  	board_be_handler = brcmstb_bus_error_handler;
>  #endif
>  
> +	if (list_is_singular(&brcmstb_gisb_arb_device_list)) {
> +		register_die_notifier(&gisb_error_notifier);
> +		atomic_notifier_chain_register(&panic_notifier_list,
> +					       &gisb_error_notifier);

I don't think this is quite right. A notifier_block can only be
registered to one notifier chain at a time, and this has the potential
to corrupt both chains.

I also think you only need to register the panic notifier. An SError
should always result in a panic.

Thanks,
Mark.

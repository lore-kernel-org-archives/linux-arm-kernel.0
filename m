From: robherring2@gmail.com (Rob Herring)
Date: Wed, 11 Jan 2012 15:05:55 -0600
Subject: [PATCH 04/15] ARM: smp_twd: add device tree support
In-Reply-To: <1326287334-1905-5-git-send-email-marc.zyngier@arm.com>
References: <1326287334-1905-1-git-send-email-marc.zyngier@arm.com>
 <1326287334-1905-5-git-send-email-marc.zyngier@arm.com>
Message-ID: <4F0DF9B3.3080804@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2012 07:08 AM, Marc Zyngier wrote:
> Add bindings to support DT discovery of the ARM Timer Watchdog
> (aka TWD). Only the timer side is converted by this patch.
> 
> Cc: Rob Herring <rob.herring@calxeda.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/twd.txt |   29 +++++++++++
>  arch/arm/include/asm/smp_twd.h                |    1 +
>  arch/arm/kernel/smp_twd.c                     |   68 ++++++++++++++++++++-----
>  3 files changed, 85 insertions(+), 13 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/twd.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/twd.txt b/Documentation/devicetree/bindings/arm/twd.txt
> new file mode 100644
> index 0000000..a9d5587
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/twd.txt
> @@ -0,0 +1,29 @@
> +* ARM Timer Watchdog
> +
> +ARM 11MP, Cortex-A5 and Cortex-A9 are often associated with a per-core
> +Timer-Watchdog (aka TWD), which provides both a per-cpu local timer
> +and watchdog.
> +
> +The TWD is usually attached to a GIC to deliver its two per-processor
> +interrupts.
> +
> +Main node required properties:
> +
> +- compatible : Should be one of:
> +	"arm,cortex-a9-twd"
> +	"arm,cortex-a5-twd"
> +	"arm,arm11mp-twd"
> +	"arm,smp-twd"
> +
> +- interrupts : Two interrupts to each core, the first one for the
> +  timer, the second one for the watchdog.
> +
> +- reg : Specify the base address and the size of the TWD.
> +
> +Example:
> +
> +	twd at 2c000600 {
> +		compatible = "arm,arm11mp-twd", "arm,smp-twd";
> +		reg = <0x2c000600 0x100>;
> +		interrupts = <1 13 0xf01 1 14 0xf01>;
> +	};

Why not split the watchdog and timer into 2 nodes? It may not matter
since there is no driver for the timer. If there was, we would have a
problem as you can't match 2 drivers to 1 node.

Rob

> diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.h
> index 9b6ff85..e8998c9 100644
> --- a/arch/arm/include/asm/smp_twd.h
> +++ b/arch/arm/include/asm/smp_twd.h
> @@ -31,5 +31,6 @@ struct twd_local_timer {
>  };
>  
>  int twd_local_timer_register(struct twd_local_timer *);
> +int twd_local_timer_of_register(void);
>  
>  #endif
> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> index be245c7..53ddef8 100644
> --- a/arch/arm/kernel/smp_twd.c
> +++ b/arch/arm/kernel/smp_twd.c
> @@ -20,6 +20,8 @@
>  #include <linux/clockchips.h>
>  #include <linux/irq.h>
>  #include <linux/io.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_address.h>
>  
>  #include <asm/smp_twd.h>
>  #include <asm/localtimer.h>
> @@ -282,37 +284,77 @@ static struct local_timer_ops twd_lt_ops = {
>  	.stop	= twd_timer_stop,
>  };
>  
> -int __init twd_local_timer_register(struct twd_local_timer *tlt)
> +static int __init twd_local_timer_common_register(void)
>  {
>  	int err;
>  
> -	if (twd_base || twd_evt)
> -		return -EBUSY;
> -
> -	twd_ppi	= tlt->res[1].start;
> -
>  	twd_evt = alloc_percpu(struct clock_event_device *);
> -	twd_base = ioremap(tlt->res[0].start, resource_size(&tlt->res[0]));
> -	if (!twd_base || !twd_evt) {
> +	if (!twd_evt) {
>  		err = -ENOMEM;
> -		goto out;
> +		goto out_free;
>  	}
>  
>  	err = request_percpu_irq(twd_ppi, twd_handler, "twd", twd_evt);
>  	if (err) {
>  		pr_err("twd: can't register interrupt %d (%d)\n", twd_ppi, err);
> -		goto out;
> +		goto out_free;
>  	}
>  
>  	err = local_timer_register(&twd_lt_ops);
>  	if (err)
> -		goto out;
> +		goto out_irq;
>  
>  	return 0;
>  
> -out:
> +out_irq:
> +	free_percpu_irq(twd_ppi, twd_evt);
> +out_free:
>  	iounmap(twd_base);
> +	twd_base = NULL;
>  	free_percpu(twd_evt);
> -	twd_base = twd_evt = NULL;
> +
>  	return err;
>  }
> +
> +int __init twd_local_timer_register(struct twd_local_timer *tlt)
> +{
> +	if (twd_base || twd_evt)
> +		return -EBUSY;
> +
> +	twd_ppi	= tlt->res[1].start;
> +
> +	twd_base = ioremap(tlt->res[0].start, resource_size(&tlt->res[0]));
> +	if (!twd_base)
> +		return -ENOMEM;
> +
> +	return twd_local_timer_common_register();
> +}
> +
> +#ifdef CONFIG_OF
> +const static struct of_device_id twd_of_match[] __initconst = {
> +	{ .compatible = "arm,smp-twd", 		},
> +	{ .compatible = "arm,cortex-a9-twd",	},
> +	{ .compatible = "arm,cortex-a5-twd",	},
> +	{ .compatible = "arm,arm11mp-twd",	},
> +	{ },
> +};
> +
> +int __init twd_local_timer_of_register(void)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_matching_node(NULL, twd_of_match);
> +	if (!np)
> +		return -ENODEV;
> +
> +	twd_ppi = irq_of_parse_and_map(np, 0);
> +	if (!twd_ppi)
> +		return -EINVAL;
> +
> +	twd_base = of_iomap(np, 0);
> +	if (!twd_base)
> +		return -ENOMEM;
> +
> +	return twd_local_timer_common_register();
> +}
> +#endif

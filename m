From: stefan@agner.ch (Stefan Agner)
Date: Mon, 15 Feb 2016 19:19:20 -0800
Subject: [PATCH] ARM: don't print missing L2 cache as error
In-Reply-To: <1453944439-1070-1-git-send-email-stefan@agner.ch>
References: <1453944439-1070-1-git-send-email-stefan@agner.ch>
Message-ID: <d67716f9edf83700b18532eb66980316@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russel,

Any comment to this? Currently the kernel prints an error message as
follows on the platform at hand:
[    0.000000] L2C: failed to init: -19

--
Stefan


On 2016-01-27 17:27, Stefan Agner wrote:
> Not having a L2 cache controller is a shame, but not an error. Avoid
> printing an error message if L2 controller initialization returns
> with ENODEV.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Hi Russel,
> 
> We use a multiplatform kernel for two similar SoC's, one with L2
> cache the other without. Maybe silently ignore -ENODEV would be
> an option too, not sure what is preferred here.
> 
> --
> Stefan
> 
>  arch/arm/kernel/irq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
> index 1d45320e..f80c480 100644
> --- a/arch/arm/kernel/irq.c
> +++ b/arch/arm/kernel/irq.c
> @@ -95,7 +95,9 @@ void __init init_IRQ(void)
>  			outer_cache.write_sec = machine_desc->l2c_write_sec;
>  		ret = l2x0_of_init(machine_desc->l2c_aux_val,
>  				   machine_desc->l2c_aux_mask);
> -		if (ret)
> +		if (ret == -ENODEV)
> +			pr_info("L2C: no device found\n");
> +		else if (ret)
>  			pr_err("L2C: failed to init: %d\n", ret);
>  	}

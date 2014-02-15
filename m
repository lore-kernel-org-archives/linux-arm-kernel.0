From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 15 Feb 2014 17:46:58 +0100
Subject: [PATCH] clk:at91: Fix memory leak in of_at91_clk_master_setup()
In-Reply-To: <1392124507-14463-1-git-send-email-standby24x7@gmail.com>
References: <1392124507-14463-1-git-send-email-standby24x7@gmail.com>
Message-ID: <20140215164658.GI2932@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02/2014 at 22:15:07 +0900, Masanari Iida wrote :
> cppcheck detected following error
> [clk-master.c:245]: (error) Memory leak: characteristics
> 
> The original code forgot to free characteristics when
> irq_of_parse_and_map() failed.
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  drivers/clk/at91/clk-master.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
> index bd313f7..c1af80b 100644
> --- a/drivers/clk/at91/clk-master.c
> +++ b/drivers/clk/at91/clk-master.c
> @@ -242,7 +242,7 @@ of_at91_clk_master_setup(struct device_node *np, struct at91_pmc *pmc,
>  
>  	irq = irq_of_parse_and_map(np, 0);
>  	if (!irq)
> -		return;
> +		goto out_free_characteristics;
>  
>  	clk = at91_clk_register_master(pmc, irq, name, num_parents,
>  				       parent_names, layout,
> -- 
> 1.9.rc1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

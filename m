From: wharms@bfs.de (walter harms)
Date: Sat, 13 May 2017 15:22:25 +0200
Subject: [PATCH 2/2] ARM: davinci: PM: Do not free useful resources in
 normal path in 'davinci_pm_init'
In-Reply-To: <20170513114020.23668-1-christophe.jaillet@wanadoo.fr>
References: <20170513114020.23668-1-christophe.jaillet@wanadoo.fr>
Message-ID: <59170891.4010307@bfs.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Am 13.05.2017 13:40, schrieb Christophe JAILLET:
> This looks spurious to iounmap resources in the normal path of this init
> function.
> The 3 ioremap'ed fields of 'pm_config' can be accessed later on in other
> functions, so it is likely that we should return 'success' before unrolling
> everything.
> 
> Fixes: aa9aa1ec2df6 ("ARM: davinci: PM: rework init, remove platform device")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is just a *guess*. The end of the function looks more like a
> error handling code rather than a normal path.
> ---
>  arch/arm/mach-davinci/pm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-davinci/pm.c b/arch/arm/mach-davinci/pm.c
> index d282b0783ecf..163d865abbf9 100644
> --- a/arch/arm/mach-davinci/pm.c
> +++ b/arch/arm/mach-davinci/pm.c
> @@ -161,6 +161,7 @@ int __init davinci_pm_init(void)
>  						davinci_cpu_suspend_sz);
>  
>  	suspend_set_ops(&davinci_pm_ops);
> +	return 0;
>  
>  no_sram_mem:
>  	iounmap(pm_config.ddrpsc_reg_base);


looks like, but that would mean that is wrong also:

	davinci_sram_suspend = sram_alloc(davinci_cpu_suspend_sz, NULL);
	if (!davinci_sram_suspend) {
		pr_err("PM: cannot allocate SRAM memory\n");
		return -ENOMEM;
	}

what means 1 iounmap missing.

re,
 wh

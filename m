From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 Nov 2011 14:28:09 -0800
Subject: [PATCH 1/7] ARM: restart: add restart hook to machine_desc record
In-Reply-To: <E1RN6ZV-0001Mv-LX@rmk-PC.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6ZV-0001Mv-LX@rmk-PC.arm.linux.org.uk>
Message-ID: <20111109222808.GP31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [111106 09:00]:
> Add a restart hook to the machine_desc record so we don't have to
> populate all platforms with init_early methods to initialize the
> arm_pm_restart function pointer.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/include/asm/mach/arch.h |    1 +
>  arch/arm/kernel/setup.c          |    3 +++
>  2 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
> index 7d19425..8aa397a 100644
> --- a/arch/arm/include/asm/mach/arch.h
> +++ b/arch/arm/include/asm/mach/arch.h
> @@ -45,6 +45,7 @@ struct machine_desc {
>  #ifdef CONFIG_MULTI_IRQ_HANDLER
>  	void			(*handle_irq)(struct pt_regs *);
>  #endif
> +	void			(*restart)(char, const char *);
>  };
>  
>  /*
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index bda0a21..d187d0a 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -922,6 +922,9 @@ void __init setup_arch(char **cmdline_p)
>  	paging_init(mdesc);
>  	request_standard_resources(mdesc);
>  
> +	if (mdesc->restart)
> +		arm_pm_restart = mdesc->restart;
> +
>  	unflatten_device_tree();
>  
>  #ifdef CONFIG_SMP

Good to see this happening:

Acked-by: Tony Lindgren <tony@atomide.com>

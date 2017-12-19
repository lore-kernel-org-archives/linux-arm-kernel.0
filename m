From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Dec 2017 23:21:11 +0000
Subject: [PATCH 7/9] ARM: tegra: enable cache via TF
In-Reply-To: <6a164b2270a3e996c083e94bf5b1e27028c1135e.1500510157.git.mirq-linux@rere.qmqm.pl>
References: <cover.1500510157.git.mirq-linux@rere.qmqm.pl>
 <6a164b2270a3e996c083e94bf5b1e27028c1135e.1500510157.git.mirq-linux@rere.qmqm.pl>
Message-ID: <20171219232111.GH10595@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 02:29:25AM +0200, Micha? Miros?aw wrote:
> diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
> index 805f306fa6f7..aae7f5961563 100644
> --- a/arch/arm/mach-tegra/reset-handler.S
> +++ b/arch/arm/mach-tegra/reset-handler.S
> @@ -78,8 +78,20 @@ ENTRY(tegra_resume)
>  	orr	r1, r1, #1
>  	str	r1, [r0]
>  #endif
> +#ifdef CONFIG_TRUSTED_FOUNDATIONS
> +	adr	r3, __tegra_smc_stack
> +	stmia	r3, {r4-r12, sp, lr}
>  
> -#ifdef CONFIG_CACHE_L2X0
> +	mov	r0, #3	// local wake
> +	mov	r3, #0
> +	mov	r4, #0
> +	dsb
> +	.arch_extension	sec
> +	smc	#0
> +
> +	adr	r3, __tegra_smc_stack
> +	ldmia	r3, {r4-r12, sp, pc}

You don't want to jump to the 'lr' value previously stacked here.  I
also wonder whether you need all this stacking, or whether you're
just doing it because you don't know whether its necessary.  From
what I can see, the only register that this code cares about is r8,
although it would be wise to place a comment in the code if the smc
call corrupts the other registers.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Mar 2013 09:01:12 +0000
Subject: [PATCH] ARM: bcm281xx: Add L2 cache enable code
In-Reply-To: <1362451632-18806-1-git-send-email-csd@broadcom.com>
References: <1362451632-18806-1-git-send-email-csd@broadcom.com>
Message-ID: <201303050901.12317.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 March 2013, Christian Daudt wrote:

> diff --git a/Documentation/devicetree/bindings/misc/smc.txt b/Documentation/devicetree/bindings/misc/smc.txt
> new file mode 100644
> index 0000000..cd8c729
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/smc.txt
> @@ -0,0 +1,14 @@
> +Broadcom Secure Monitor Bounce buffer
> +-----------------------------------------------------
> +This binding defines the location of the bounce buffer
> +used for non-secure to secure communications.
> +
> +Required properties:
> +- compatible : "bcm,kona-smc"
> +- reg : Location and size of bounce buffer
> +
> +Example:
> +	smc at 0x3404c000 {
> +		compatible = "bcm,kona-smc";
> +		reg = <0x3404c000 0x400>; //1 KiB in SRAM
> +	};

For other firmware interfaces like this, we tend to list the specific commands
that the firmware understands. If you think there might be different versions
to consider, you might want to model this like

Documentation/devicetree/bindings/arm/psci.txt
> diff --git a/arch/arm/mach-bcm/bcm_kona_smc_asm.S b/arch/arm/mach-bcm/bcm_kona_smc_asm.S
> new file mode 100644
> index 0000000..a160848
> --- /dev/null
> +++ b/arch/arm/mach-bcm/bcm_kona_smc_asm.S
> +/*
> + * int bcm_kona_smc_asm(u32 service_id, u32 buffer_addr)
> + */
> +
> +ENTRY(bcm_kona_smc_asm)
> +	stmfd	sp!, {r4-r12, lr}
> +	mov	r4, r0		@ service_id
> +	mov	r5, #3		@ Keep IRQ and FIQ off in SM

Why not just use an inline assembly?

> +#ifdef CONFIG_CACHE_L2X0
> +static int __init kona_l2_cache_init(void)
> +{
> +	/*
> +	 * Currently there is no SSAPI for setting the L2 cache aux register,
> +	 * so the default value (0x1e050000) applies.
> +	 */
> +	bcm_kona_smc(SSAPI_ENABLE_L2_CACHE, 0, 0, 0, 0);

This can be written in a nicer way as

static int __init kona_l2_cache_init(void)
{
	if (!IS_ENABLED(CONFIG_CACHE_L2X0))
		return 0;
	...
}

To remove the need for the #ifdef.

> +static void __init init_irq(void)
> +{
> +	irqchip_init();
> +	bcm_kona_smc_init();
> +
> +#ifdef CONFIG_CACHE_L2X0
> +	kona_l2_cache_init();
> +#endif /* CONFIG_CACHE_L2X0 */
> +}

Why are you calling bcm_kona_smc_init() and kona_l2_cache_init() from init_irq()?

It seems completely unrelated to interrupt handling.

	Arnd

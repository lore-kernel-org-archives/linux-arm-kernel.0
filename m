From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 24 Dec 2013 19:41:51 +0400
Subject: [PATCH 3/6] ARM: shmobile: r7s72100: Add RSPI resources
In-Reply-To: <1387886210-3634-4-git-send-email-geert+renesas@linux-m68k.org>
References: <1387886210-3634-1-git-send-email-geert+renesas@linux-m68k.org>
 <1387886210-3634-4-git-send-email-geert+renesas@linux-m68k.org>
Message-ID: <52B9AB3F.4080907@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 24-12-2013 15:56, Geert Uytterhoeven wrote:

    The subject is somewhat deficient: you're only only adding resources, 
you're registering devices themselves...

> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> ---
>   arch/arm/mach-shmobile/setup-r7s72100.c |   25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)

> diff --git a/arch/arm/mach-shmobile/setup-r7s72100.c b/arch/arm/mach-shmobile/setup-r7s72100.c
> index 55f0b9c7c482..fbcb0c798994 100644
> --- a/arch/arm/mach-shmobile/setup-r7s72100.c
> +++ b/arch/arm/mach-shmobile/setup-r7s72100.c
> @@ -79,6 +79,26 @@ static struct resource mtu2_0_resources[] __initdata = {
>   					  &mtu2_##idx##_platform_data,	\
>   					  sizeof(struct sh_timer_config))
>
> +/* RSPI */
> +#define RSPI_RESOURCE(idx, baseaddr, irq)				\
> +static const struct resource rspi##idx##_resources[] __initconst = {	\
> +	DEFINE_RES_MEM(baseaddr, 0x24),					\
> +	DEFINE_RES_IRQ(irq),		/* SPEI */			\
> +	DEFINE_RES_IRQ(irq + 1),	/* SPRI */			\
> +	DEFINE_RES_IRQ(irq + 2),	/* SPTI */			\
> +}
> +
> +RSPI_RESOURCE(0, 0xe800c800, gic_iid(270));
> +RSPI_RESOURCE(1, 0xe800d000, gic_iid(273));
> +RSPI_RESOURCE(2, 0xe800d800, gic_iid(276));
> +RSPI_RESOURCE(3, 0xe800e000, gic_iid(279));
> +RSPI_RESOURCE(4, 0xe800e800, gic_iid(282));
> +
> +#define r7s72100_register_rspi(idx)					\
> +	platform_device_register_simple("rspi" #idx, idx,		\

    Hm, do you really mean device names like "rspi0.0"?

> +					rspi##idx##_resources,		\
> +					ARRAY_SIZE(rspi##idx##_resources))
> +

WBR, Sergei

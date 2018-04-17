From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 17 Apr 2018 09:52:33 +0200
Subject: [PATCH v6 08/11] ARM: sun9i: smp: Add is_sun8i field
In-Reply-To: <20180416215032.5023-9-mylene.josserand@bootlin.com>
References: <20180416215032.5023-1-mylene.josserand@bootlin.com>
 <20180416215032.5023-9-mylene.josserand@bootlin.com>
Message-ID: <20180417075233.f2z6wxcazwqheoib@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Apr 16, 2018 at 11:50:29PM +0200, Myl?ne Josserand wrote:
> To prepare the support of sun8i-a83t, add a field in the smp_data
> structure to know if we are on sun9i-a80 or sun8i-a83t.
> 
> Add also a global variable to retrieve which architecture we are
> having.
> 
> Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
> ---
>  arch/arm/mach-sunxi/mc_smp.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
> index 03f021d0c73e..9d57ea27dacc 100644
> --- a/arch/arm/mach-sunxi/mc_smp.c
> +++ b/arch/arm/mach-sunxi/mc_smp.c
> @@ -74,6 +74,7 @@ static void __iomem *sram_b_smp_base;
>  
>  extern void sunxi_mc_smp_secondary_startup(void);
>  extern void sunxi_mc_smp_resume(void);
> +static int is_sun8i;
>  
>  static bool sunxi_core_is_cortex_a15(unsigned int core, unsigned int cluster)
>  {
> @@ -624,6 +625,7 @@ struct sunxi_mc_smp_nodes {
>  struct sunxi_mc_smp_data {
>  	const char *enable_method;
>  	int (*get_smp_nodes)(struct sunxi_mc_smp_nodes *nodes);
> +	int is_sun8i;
>  };
>  
>  static void __init sunxi_mc_smp_put_nodes(struct sunxi_mc_smp_nodes *nodes)
> @@ -664,6 +666,7 @@ static const struct sunxi_mc_smp_data sunxi_mc_smp_data[] __initconst = {
>  	{
>  		.enable_method	= "allwinner,sun9i-a80-smp",
>  		.get_smp_nodes	= sun9i_a80_get_smp_nodes,
> +		.is_sun8i	= false,

I'm still not convinced about the name of that flag. sun8i doesn't
mean anything, really. What you want to discriminate against it what
you're writing in your commit log: if it is an A80 or an A83t. The
A33, H3, A23, you name it are also part of the sun8i family, yet they
are completely irrelevant to this file.

Also, false is the default value, you can leave it out.

>  	},
>  };
>  
> @@ -697,6 +700,8 @@ static int __init sunxi_mc_smp_init(void)
>  			break;
>  	}
>  
> +	is_sun8i = sunxi_mc_smp_data[i].is_sun8i;
> +

Do we really need to cache it? Can't we just have a pointer to the SMP
data structure and use that instead?

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180417/a7627c07/attachment.sig>

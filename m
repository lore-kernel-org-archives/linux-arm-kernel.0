From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sat, 26 Feb 2011 18:05:52 +0300
Subject: [PATCH] OMAP2+: sdrc: fix compile break on OMAP4-only config
	on current omap-for-linus
In-Reply-To: <alpine.DEB.2.00.1102251839360.6198@utopia.booyaka.com>
References: <alpine.DEB.2.00.1102251839360.6198@utopia.booyaka.com>
Message-ID: <4D6916D0.1080501@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 26-02-2011 4:40, Paul Walmsley wrote:

> On non-OMAP2 and non-OMAP3 kernel configs, turn omap2_sdrc_init() into
> a no-op.  Otherwise, compilation breaks on an OMAP4-only config with
> the current omap-for-linus branch:

> arch/arm/mach-omap2/built-in.o: In function `omap2_init_common_devices':
> ../mach-omap2/io.c:421: undefined reference to `omap2_sdrc_init'

> Signed-off-by: Paul Walmsley<paul@pwsan.com>
> Cc: Tony Lindgren<tony@atomide.com>
> ---
>   arch/arm/plat-omap/include/plat/sdrc.h |    5 +++++
>   1 files changed, 5 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/plat-omap/include/plat/sdrc.h b/arch/arm/plat-omap/include/plat/sdrc.h
> index efd87c8..5a44b14 100644
> --- a/arch/arm/plat-omap/include/plat/sdrc.h
> +++ b/arch/arm/plat-omap/include/plat/sdrc.h
> @@ -124,8 +124,13 @@ struct omap_sdrc_params {
>   	u32 mr;
>   };
>
> +#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
>   void __init omap2_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
>   			    struct omap_sdrc_params *sdrc_cs1);
> +#else
> +#define omap2_sdrc_init(x, y)		0

    How about empty inline instead?

> +#endif
> +

WBR, Sergei

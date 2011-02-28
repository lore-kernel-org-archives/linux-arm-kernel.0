From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 28 Feb 2011 14:49:06 +0300
Subject: [PATCH] OMAP2+: sdrc: fix compile break on OMAP4-only config
	on current omap-for-linus
In-Reply-To: <alpine.DEB.2.00.1102271701450.4608@utopia.booyaka.com>
References: <alpine.DEB.2.00.1102251839360.6198@utopia.booyaka.com>
	<4D6916D0.1080501@ru.mvista.com>
	<alpine.DEB.2.00.1102271701450.4608@utopia.booyaka.com>
Message-ID: <4D6B8BB2.2010503@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 28-02-2011 3:03, Paul Walmsley wrote:

>>     How about empty inline instead?

> Thanks for the review; that is indeed a better approach.  Following is the
> updated patch.

> Tony, do you want to take this one?


> - Paul

> From: Paul Walmsley<paul@pwsan.com>
> Date: Fri, 25 Feb 2011 17:38:25 -0700
> Subject: [PATCH] OMAP2+: sdrc: fix compile break on OMAP4-only config on current omap-for-linus

> On non-OMAP2 and non-OMAP3 kernel configs, turn omap2_sdrc_init() into
> a no-op.  Otherwise, compilation breaks on an OMAP4-only config with
> the current omap-for-linus branch:

> arch/arm/mach-omap2/built-in.o: In function `omap2_init_common_devices':
> ../mach-omap2/io.c:421: undefined reference to `omap2_sdrc_init'

> Thanks to Sergei Shtylyov <sshtylyov@mvista.com>  for suggesting the use
> of a empty static inline function rather than a macro.

    Not at all. :-)

> Signed-off-by: Paul Walmsley<paul@pwsan.com>
> Cc: Tony Lindgren<tony@atomide.com>
> Cc: Sergei Shtylyov<sshtylyov@mvista.com>
> ---
>   arch/arm/plat-omap/include/plat/sdrc.h |    6 ++++++
>   1 files changed, 6 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/plat-omap/include/plat/sdrc.h b/arch/arm/plat-omap/include/plat/sdrc.h
> index efd87c8..2a34a65 100644
> --- a/arch/arm/plat-omap/include/plat/sdrc.h
> +++ b/arch/arm/plat-omap/include/plat/sdrc.h
> @@ -124,8 +124,14 @@ struct omap_sdrc_params {
>   	u32 mr;
>   };
>
> +#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
>   void __init omap2_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
>   			    struct omap_sdrc_params *sdrc_cs1);
> +#else
> +static inline void __init omap2_sdrc_init(struct omap_sdrc_params *sdrc_cs0,

    No need to annotate it as __init.

> +					  struct omap_sdrc_params *sdrc_cs1) {};
> +#endif
> +

WBR, Sergei

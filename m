From: jarkko.nikula@bitmer.com (Jarkko Nikula)
Date: Tue, 13 Mar 2012 09:10:02 +0200
Subject: [PATCH 5/5] ARM: OMAP2+: clean up some cppcheck warnings
In-Reply-To: <20120312224257.4103.11096.stgit@dusk>
References: <20120312224006.4103.29464.stgit@dusk>
 <20120312224257.4103.11096.stgit@dusk>
Message-ID: <4F5EF2CA.70703@bitmer.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2012 12:43 AM, Paul Walmsley wrote:
> Resolve some warnings identified by cppcheck in arch/arm/mach-omap2:
...
>     [arch/arm/mach-omap2/mcbsp.c:133]: (warning) scanf without field width limits can crash with huge input data
...
> diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
> index fb4bcf8..efe59c7 100644

> --- a/arch/arm/mach-omap2/mcbsp.c
> +++ b/arch/arm/mach-omap2/mcbsp.c
> @@ -130,7 +130,7 @@ static int omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
>  	struct omap_mcbsp_platform_data *pdata = NULL;
>  	struct platform_device *pdev;
>  
> -	sscanf(oh->name, "mcbsp%d", &id);
> +	sscanf(oh->name, "mcbsp%1d", &id);
>  
Correct if I'm wrong but is this a false alarm? Can %d scan more than
sizeof(int)?

Anyway this shouldn't be fatal issue since name comes from kernel
omap_hwmod data, i.e. only developer can hit it.

Peter: worth to check and possible add this Paul's fix to your mcbsp
change set.

-- 
Jarkko

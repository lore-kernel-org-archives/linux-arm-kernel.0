From: olof@lixom.net (Olof Johansson)
Date: Mon, 13 Jan 2014 10:02:58 -0800
Subject: [patch] fix omap compile with randconfig
In-Reply-To: <20140113010025.GA14431@amd.pavel.ucw.cz>
References: <20140113010025.GA14431@amd.pavel.ucw.cz>
Message-ID: <CAOesGMjG37FprRX7U-+S3nFCuv=RVAOUv7wb8K-Tcqr26ETevw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 12, 2014 at 5:00 PM, Pavel Machek <pavel@ucw.cz> wrote:
>
> This fixes:
>
> arch/arm/mach-omap2/built-in.o: In function `omap_reserve':
> /data/l/linux-n900/arch/arm/mach-omap2/common.c:36: undefined
>   reference to `omap_fb_reserve_memblock'
>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>
> diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
> index 9beecde..857907f 100644
> --- a/arch/arm/mach-omap2/common.c
> +++ b/arch/arm/mach-omap2/common.c
> @@ -33,5 +33,7 @@ void __init omap_reserve(void)
>         omap_dsp_reserve_sdram_memblock();
>         omap_secure_ram_reserve_memblock();
>         omap_barrier_reserve_memblock();
> +#ifdef CONFIG_OMAP2_VRFB
>         omap_fb_reserve_memblock();
> +#endif
>  }

What is this patch against? omap_fb_reserve_memblock() doesn't exist
in v3.13-rc8, nor in -next.

Adding an ifdef here is likely the wrong thing anyway, there should be
a stub provided for !CONFIG_OMAP2_VRFB in the header file instead.


-Olof

From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 6 Jan 2011 10:58:22 -0700 (MST)
Subject: [PATCH v2 2/5] omap2plus: prm: Trvial build break fix for
	undefined reference to 'omap2_prm_read_mod_reg'
In-Reply-To: <1294225024-21857-2-git-send-email-santosh.shilimkar@ti.com>
References: <1294225024-21857-1-git-send-email-santosh.shilimkar@ti.com>
	<1294225024-21857-2-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <alpine.DEB.2.00.1101061056340.22048@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh

On Wed, 5 Jan 2011, Santosh Shilimkar wrote:

> omap2plus_defocnfig build breaks when customised with only ARCH_OMAP4
> selected. This is because common files make references to the functions
> which are defined only for omap2xxx and omap3xxx.

...

> 
> This patch adds stubs for these functions so that build continues to work.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/prm2xxx_3xxx.h |   63 +++++++++++++++++++++++++++++++++++-
>  1 files changed, 62 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/prm2xxx_3xxx.h
> index 53d44f6..843f329 100644
> --- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
> +++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
> @@ -228,7 +228,67 @@
>  
>  
>  #ifndef __ASSEMBLER__
> -
> +/*
> + * Stub omap2xxx/omap3xxx functions so that common files
> + * continue to build when custom builds are used
> + */
> +#if defined(CONFIG_ARCH_OMAP4) && !(defined(CONFIG_ARCH_OMAP2) ||	\
> +					defined(CONFIG_ARCH_OMAP3))
> +static inline u32 omap2_prm_read_mod_reg(s16 module, u16 idx)
> +{
> +	WARN_ONCE(1, "prm: omap2xxx/omap3xxx specific function and "
> +		"not suppose to be used on omap4\n");
> +	return 0;
> +}

I think it would be best to use WARN() on these, rather than WARN_ONCE().  
That's because these could be called from different parts of the code 
base, and the stack backtrace will help someone figure out all the code 
that needs to be fixed.

Once you do that, this patch is

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul

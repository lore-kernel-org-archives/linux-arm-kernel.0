From: premi@ti.com (Premi, Sanjeev)
Date: Thu, 6 Jan 2011 20:02:52 +0530
Subject: [PATCH v2 2/5] omap2plus: prm: Trvial build break fix for
	undefined reference to 'omap2_prm_read_mod_reg'
In-Reply-To: <1294225024-21857-2-git-send-email-santosh.shilimkar@ti.com>
References: <1294225024-21857-1-git-send-email-santosh.shilimkar@ti.com>
	<1294225024-21857-2-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930248201A7E@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org 
> [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of 
> Santosh Shilimkar
> Sent: Wednesday, January 05, 2011 4:27 PM
> To: linux-omap at vger.kernel.org
> Cc: Hilman, Kevin; tony at atomide.com; 
> linux-arm-kernel at lists.infradead.org; Shilimkar, Santosh; 
> Paul Walmsley
> Subject: [PATCH v2 2/5] omap2plus: prm: Trvial build break 
> fix for undefined reference to 'omap2_prm_read_mod_reg'

[snip]

>  
>  #ifndef __ASSEMBLER__
> -
> +/*
> + * Stub omap2xxx/omap3xxx functions so that common files
> + * continue to build when custom builds are used
> + */
> +#if defined(CONFIG_ARCH_OMAP4) && 
> !(defined(CONFIG_ARCH_OMAP2) ||	\
> +					defined(CONFIG_ARCH_OMAP3))
> +static inline u32 omap2_prm_read_mod_reg(s16 module, u16 idx)
> +{
> +	WARN_ONCE(1, "prm: omap2xxx/omap3xxx specific function and "
> +		"not suppose to be used on omap4\n");
> +	return 0;
> +}
Looking forward, the warning of incorrect SOC may be required
for when kernel is build for one specific SOC.

Wouldn't it be easy/better to have common global function:

void wrong_soc(char* func, int soc_id)
{
	WARN_ONCE(1, "Function %s cannot be used for %d", func, soc_id);
}

OR we could have soc specific functions e.g.

void omap2xxx_only (char* func)
{
	WARN_ONCE(1, "Function %s is specific to OMAP2XXX");
}
..etc..

Later these functions can be called from the stubs.

This is prelim idea, will need to be worked upon.

~sanjeev

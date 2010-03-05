From: colin.tuckley@arm.com (Colin Tuckley)
Date: Fri, 5 Mar 2010 16:35:53 -0000
Subject: [PATCH] ARM: Add Versatile Express CA9x4 processor support
In-Reply-To: <git-1267729916-8545dcd13a3ae6450278b076cb024d10d64ee785@rmk-PC>
References: <git-1267729916-61c9b6ab773870de77ff9183b8bb055a03b19671@rmk-PC>
	<git-1267729916-8545dcd13a3ae6450278b076cb024d10d64ee785@rmk-PC>
Message-ID: <000201cabc81$ec481330$c4d83990$@tuckley@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Russell King

> + * Versatile Express Core Tile Cortex A9x4 Support

Versatile Express daughter boards are *not* called "Core Tiles". They are
both physically and electrically incompatible and so we have specifically
avoided using the term.

> +static struct clcd_panel xvga_panel = {

What happened to the support for vga and svga? These are needed when using
the CLCD controller on the motherboard which doesn't support XVGA due to bus
bandwidth limitations.


> +static void ct_ca9x4_clcd_enable(struct clcd_fb *fb)
> +{
> +	v2m_cfg_write(SYS_CFG_MUXFPGA | SYS_CFG_SITE_DB1, 0);
> +	v2m_cfg_write(SYS_CFG_DVIMODE | SYS_CFG_SITE_DB1, 2);
> +	v2m_cfg_write(SYS_CFG_OSC | SYS_CFG_SITE_DB1 | 1, 63500127);
> +}

This is not the preferred way to use the SRI (which I'm now told is
officially called "The Serial Configuration Controller").

There is a documented data structure and set of routines which are used by
the boot-monitor, self-test, bootloader and my kernel patch set for the
Versatile Express. We would prefer that it be kept consistent across all
software that needs to use the SCC.

My versions of these routines also make use of spin_lock() to make them smp
safe.

Regards,

Colin

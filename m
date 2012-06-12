From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 12 Jun 2012 09:58:07 +0100
Subject: [PATCH 1/2] ARM: vexpress: Check master site in daughterboard's
 sysctl operations
In-Reply-To: <1339159835-32228-1-git-send-email-pawel.moll@arm.com>
References: <1339159835-32228-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1339491487.3063.23.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-06-08 at 13:50 +0100, Pawel Moll wrote:
> With recent enough motherboard firmware, core tile can be fitted
> in either of the two daughterboard sites. The non-DT tile code for
> V2P-CA9 did not check that when configuring DVI output nor setting
> CLCD pixel clock.
> 
> Fixed now, providing "get master site" API in motherboard's code.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

This patch makes an Ubuntu boot always hang for me, about the time it
would switch to GUI mode, it's not very consistent unfortunately.

If I modify ct_ca9x4_clcd_enable() to replace "v2m_get_master_site()"
with "1" then boot is OK. Even though if I put code it to test the
return value from v2m_get_master_site() it shows it gives 1.

I am running stock Version 3 firmware on my vexpress.

I also have some comments about this patch, see inline comments below...

> ---
>  arch/arm/mach-vexpress/ct-ca9x4.c                 |   15 ++++++++++++---
>  arch/arm/mach-vexpress/include/mach/motherboard.h |    9 ++++++---
>  arch/arm/mach-vexpress/v2m.c                      |   12 +++++++++---
>  3 files changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
> index c65cc3b..11cb248 100644
> --- a/arch/arm/mach-vexpress/ct-ca9x4.c
> +++ b/arch/arm/mach-vexpress/ct-ca9x4.c
> @@ -66,8 +66,15 @@ static void __init ct_ca9x4_init_irq(void)
>  
>  static void ct_ca9x4_clcd_enable(struct clcd_fb *fb)
>  {
> -	v2m_cfg_write(SYS_CFG_MUXFPGA | SYS_CFG_SITE_DB1, 0);
> -	v2m_cfg_write(SYS_CFG_DVIMODE | SYS_CFG_SITE_DB1, 2);
> +	u32 site = v2m_get_master_site();
> +
> +	/*
> +	 * Old firmware was using the "site" component of the command
> +	 * to control the DVI muxer (while it should be always 0 ie. MB).
> +	 * Newer firmware uses the data register. Keep both for compatibility.
> +	 */
> +	v2m_cfg_write(SYS_CFG_MUXFPGA | SYS_CFG_SITE(site), site);
> +	v2m_cfg_write(SYS_CFG_DVIMODE, 2);
>  }
>  
>  static int ct_ca9x4_clcd_setup(struct clcd_fb *fb)
> @@ -112,7 +119,9 @@ static long ct_round(struct clk *clk, unsigned long rate)
>  
>  static int ct_set(struct clk *clk, unsigned long rate)
>  {
> -	return v2m_cfg_write(SYS_CFG_OSC | SYS_CFG_SITE_DB1 | 1, rate);
> +	u32 site = v2m_get_master_site();
> +
> +	return v2m_cfg_write(SYS_CFG_OSC | SYS_CFG_SITE(site) | 1, rate);
>  }
>  
>  static const struct clk_ops osc1_clk_ops = {
> diff --git a/arch/arm/mach-vexpress/include/mach/motherboard.h b/arch/arm/mach-vexpress/include/mach/motherboard.h
> index 31a9289..f004ec9 100644
> --- a/arch/arm/mach-vexpress/include/mach/motherboard.h
> +++ b/arch/arm/mach-vexpress/include/mach/motherboard.h
> @@ -104,9 +104,10 @@
>  #define SYS_CFG_REBOOT		(9 << 20)
>  #define SYS_CFG_DVIMODE		(11 << 20)
>  #define SYS_CFG_POWER		(12 << 20)
> -#define SYS_CFG_SITE_MB		(0 << 16)
> -#define SYS_CFG_SITE_DB1	(1 << 16)
> -#define SYS_CFG_SITE_DB2	(2 << 16)
> +#define SYS_CFG_SITE(n)		((n) << 16)
> +#define SYS_CFG_SITE_MB		0

There are three uses of this latter macro you have left unaltered: in
v2m_osc1_set(), v2m_power_off() and v2m_restart(). Now 0 == (0<<16) so
the code will be functionally identical, but they should really be
updated replace SYS_CFG_SITE_MB with SYS_CFG_SITE(SYS_CFG_SITE_MB).
Though that looks a bit messy, perhaps instead we could have something
like...

#define SITE_MB	 0
#define SITE_DB1 1
#define SITE_DB2 2
#define SYS_CFG_SITE(n)		((n) << 16)
#define SYS_CFG_SITE_MB		SYS_CFG_SITE(SITE_MB)
#define SYS_CFG_SITE_DB1	SYS_CFG_SITE(SITE_DB1)
#define SYS_CFG_SITE_DB2	SYS_CFG_SITE(SITE_DB2)

> +#define SYS_CFG_SITE_DB1	1
> +#define SYS_CFG_SITE_DB2	2
>  #define SYS_CFG_STACK(n)	((n) << 12)
>  
>  #define SYS_CFG_ERR		(1 << 1)
> @@ -122,6 +123,8 @@ void v2m_flags_set(u32 data);
>  #define SYS_MISC_MASTERSITE	(1 << 14)
>  #define SYS_PROCIDx_HBI_MASK	0xfff
>  
> +int v2m_get_master_site(void);
> +
>  /*
>   * Core tile IDs
>   */
> diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
> index fde26ad..aa6f9a6 100644
> --- a/arch/arm/mach-vexpress/v2m.c
> +++ b/arch/arm/mach-vexpress/v2m.c
> @@ -147,6 +147,13 @@ void __init v2m_flags_set(u32 data)
>  	writel(data, v2m_sysreg_base + V2M_SYS_FLAGSSET);
>  }
>  
> +int __init v2m_get_master_site(void)
> +{
> +	u32 misc = readl(v2m_sysreg_base + V2M_SYS_MISC);
> +
> +	return misc & SYS_MISC_MASTERSITE ? SYS_CFG_SITE_DB2 : SYS_CFG_SITE_DB1;
> +}
> +
>  
>  static struct resource v2m_pcie_i2c_resource = {
>  	.start	= V2M_SERIAL_BUS_PCI,
> @@ -413,7 +420,6 @@ static void v2m_restart(char str, const char *cmd)
>  	if (v2m_cfg_write(SYS_CFG_REBOOT | SYS_CFG_SITE_MB, 0))
>  		printk(KERN_EMERG "Unable to reboot\n");
>  }
> -

There's a spurious blank line deletion above.

>  struct ct_desc *ct_desc;
>  
>  static struct ct_desc *ct_descs[] __initdata = {
> @@ -605,8 +611,8 @@ void __init v2m_dt_init_early(void)
>  
>  	/* Confirm board type against DT property, if available */
>  	if (of_property_read_u32(allnodes, "arm,hbi", &dt_hbi) == 0) {
> -		u32 misc = readl(v2m_sysreg_base + V2M_SYS_MISC);
> -		u32 id = readl(v2m_sysreg_base + (misc & SYS_MISC_MASTERSITE ?
> +		int site = v2m_get_master_site();
> +		u32 id = readl(v2m_sysreg_base + (site == SYS_CFG_SITE_DB2 ?
>  				V2M_SYS_PROCID1 : V2M_SYS_PROCID0));
>  		u32 hbi = id & SYS_PROCIDx_HBI_MASK;
>  

From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 May 2015 10:23:11 +0200
Subject: [PATCH v10 4/5] edac: Add APM X-Gene SoC EDAC driver
In-Reply-To: <1431991481-25684-5-git-send-email-lho@apm.com>
References: <1431991481-25684-1-git-send-email-lho@apm.com>
 <1431991481-25684-4-git-send-email-lho@apm.com>
 <1431991481-25684-5-git-send-email-lho@apm.com>
Message-ID: <4456746.y9FVaqRogk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 May 2015 17:24:40 Loc Ho wrote:
> This patch adds support for the APM X-Gene SoC EDAC driver.
> 
> Signed-off-by: Loc Ho <lho@apm.com>
> ---
>  drivers/edac/Kconfig      |    7 +
>  drivers/edac/Makefile     |    1 +
>  drivers/edac/xgene_edac.c | 1313 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1321 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/edac/xgene_edac.c

Looks reasonable overall, good job. Just a few details that are left:

> +
> +static int xgene_edac_pcp_rd(struct xgene_edac *edac, u32 reg, u32 *val);
> +static int xgene_edac_pcp_clrbits(struct xgene_edac *edac, u32 reg,
> +				  u32 bits_mask);
> +static int xgene_edac_pcp_setbits(struct xgene_edac *edac, u32 reg,
> +				  u32 bits_mask);
> +static int xgene_edac_csw_rd(struct xgene_edac *edac, u32 reg, u32 *val);
> +static int xgene_edac_mcba_rd(struct xgene_edac *edac, u32 reg, u32 *val);
> +static int xgene_edac_mcbb_rd(struct xgene_edac *edac, u32 reg, u32 *val);
> +static int xgene_edac_efuse_rd(struct xgene_edac *edac, u32 reg, u32 *val);

It's better to avoid any forward declaration for local functions, and instead
reorder the file to move the definition before the first use.

> +static int edac_mc_idx;
> +static int edac_mc_active_mask;
> +static int edac_mc_registered_mask;
> +static DEFINE_MUTEX(xgene_edac_mc_lock);

It would also be best to avoid global variables, but it seems that at
least the edac_mc_idx is needed to work with the EDAC subsystem.
Maybe Boris has an idea for how to avoid it.

> +#ifdef CONFIG_EDAC_DEBUG
> +static ssize_t xgene_edac_mc_err_inject_write(struct file *file,
> +					      const char __user *data,
> +					      size_t count, loff_t *ppos)
> +{
> +	struct mem_ctl_info *mci = file->private_data;
> +	struct xgene_edac_mc_ctx *ctx = mci->pvt_info;
> +	int i;
> +
> +	for (i = 0; i < MCU_MAX_RANK; i++) {
> +		writel(MCU_ESRR_MULTUCERR_MASK | MCU_ESRR_BACKUCERR_MASK |
> +		       MCU_ESRR_DEMANDUCERR_MASK | MCU_ESRR_CERR_MASK,
> +		       ctx->mcu_csr + MCUESRRA0 + i * MCU_RANK_STRIDE);
> +	}
> +	return count;
> +}
> +
> +static const struct file_operations xgene_edac_mc_debug_inject_fops = {
> +	.open = simple_open,
> +	.write = xgene_edac_mc_err_inject_write,
> +	.llseek = generic_file_llseek,
> +};
> +
> +static void xgene_edac_mc_create_debugfs_node(struct mem_ctl_info *mci)
> +{
> +	if (!mci->debugfs)
> +		return;
> +
> +	debugfs_create_file("inject_ctrl", S_IWUSR, mci->debugfs, mci,
> +			    &xgene_edac_mc_debug_inject_fops);
> +}
> +#else
> +static void xgene_edac_mc_create_debugfs_node(struct mem_ctl_info *mci)
> +{
> +}
> +#endif

Here, it would be better style to avoid the #ifdef. If you just use

static void xgene_edac_mc_create_debugfs_node(struct mem_ctl_info *mci)
{
	if (! IS_ENABLED(CONFIG_EDAC_DEBUG) || !mci->debugfs)
		return;

the compiler will drop all the debug code when that option is not
set, but will still check the code for correctness, and emit
any warnings that one might want to see.


> +static int xgene_edac_csw_rd(struct xgene_edac *edac, u32 reg, u32 *val)
> +{
> +	if (edac == NULL)
> +		return -EINVAL;
> +
> +	return regmap_read(edac->csw_map, reg, val);
> +}
> +
> +static int xgene_edac_mcba_rd(struct xgene_edac *edac, u32 reg, u32 *val)
> +{
> +	if (edac == NULL)
> +		return -EINVAL;
> +
> +	return regmap_read(edac->mcba_map, reg, val);
> +}
> +
> +static int xgene_edac_mcbb_rd(struct xgene_edac *edac, u32 reg, u32 *val)
> +{
> +	if (edac == NULL)
> +		return -EINVAL;
> +
> +	return regmap_read(edac->mcbb_map, reg, val);
> +}
> +
> +static int xgene_edac_efuse_rd(struct xgene_edac *edac, u32 reg, u32 *val)
> +{
> +	if (edac == NULL)
> +		return -EINVAL;
> +
> +	return regmap_read(edac->efuse_map, reg, val);
> +}

I would drop the NULL check, and just refuse to probe the
device if any of the regmaps are unavailable. You list the
properties as 'required' in DT, so if any of the pointers
are NULL here, that is really a bug somewhere (kernel or DT),
not a user error, so -EINVAL is not appropriate.

Also, these all have very few callers, so just open-code the
regmap_read() instead of having wrappers.

> +
> +static int xgene_edac_pcp_setbits(struct xgene_edac *edac, u32 reg,
> +				  u32 bits_mask)
> +{
> +	u32 val;
> +
> +	if (edac == NULL)
> +		return -EINVAL;
> +
> +	spin_lock(&edac->lock);
> +	val = readl(edac->pcp_csr + reg);
> +	val |= bits_mask;
> +	writel(val, edac->pcp_csr + reg);
> +	spin_unlock(&edac->lock);
> +	return 0;
> +}

If you cache the interrupt masks in the xgene_edac structure, you
can avoid the read-modify-write functions for updating the
register in place.

	Arnd

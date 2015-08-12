From: bp@alien8.de (Borislav Petkov)
Date: Wed, 12 Aug 2015 12:51:21 +0200
Subject: [PATCH v3 3/4] edac: Add L3/SoC EDAC support to the APM X-Gene
 SoC EDAC driver
In-Reply-To: <1439326077-25507-4-git-send-email-lho@apm.com>
References: <1439326077-25507-1-git-send-email-lho@apm.com>
 <1439326077-25507-2-git-send-email-lho@apm.com>
 <1439326077-25507-3-git-send-email-lho@apm.com>
 <1439326077-25507-4-git-send-email-lho@apm.com>
Message-ID: <20150812105121.GE14011@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 11, 2015 at 02:47:56PM -0600, Loc Ho wrote:
> This patch adds EDAC support for the L3 and SoC components.
> 
> Signed-off-by: Loc Ho <lho@apm.com>
> ---
>  drivers/edac/xgene_edac.c |  827 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 815 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
> index ba06904..d5e33bf 100644
> --- a/drivers/edac/xgene_edac.c
> +++ b/drivers/edac/xgene_edac.c
> @@ -66,6 +66,8 @@ struct xgene_edac {
>  
>  	struct list_head	mcus;
>  	struct list_head	pmds;
> +	struct list_head	l3s;
> +	struct list_head	socs;
>  
>  	struct mutex		mc_lock;
>  	int			mc_active_mask;
> @@ -877,8 +879,8 @@ static const struct file_operations xgene_edac_pmd_debug_inject_fops[] = {
>  	{ }
>  };
>  
> -static void xgene_edac_pmd_create_debugfs_nodes(
> -	struct edac_device_ctl_info *edac_dev)
> +static void
> +xgene_edac_pmd_create_debugfs_nodes(struct edac_device_ctl_info *edac_dev)
>  {
>  	struct xgene_edac_pmd_ctx *ctx = edac_dev->pvt_info;
>  	struct dentry *edac_debugfs;
> @@ -887,10 +889,6 @@ static void xgene_edac_pmd_create_debugfs_nodes(
>  	if (!IS_ENABLED(CONFIG_EDAC_DEBUG))
>  		return;
>  
> -	/*
> -	 * Todo: Switch to common EDAC debug file system for edac device
> -	 *       when available.
> -	 */
>  	if (!ctx->edac->dfs) {
>  		ctx->edac->dfs = debugfs_create_dir(edac_dev->dev->kobj.name,
>  						    NULL);

Why is this removing only the comment and not the debugfs_create_dir()
and the rest of the gunk?

xgene_edac_l3_create_debugfs_nodes() does call debugfs_create_dir()
creating a top-level edac debugfs node too. Why?

Please go through the previous comments I had and make sure you've
incorporated them all. I'm not wasting time reviewing half-baked stuff.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--

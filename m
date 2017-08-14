From: bp@alien8.de (Borislav Petkov)
Date: Mon, 14 Aug 2017 13:01:33 +0200
Subject: [PATCH v2 7/9] EDAC: Add devres helpers for
 edac_mc_alloc/edac_mc_add_mc(_with_groups)
In-Reply-To: <20170802123922.11498-8-jlu@pengutronix.de>
References: <20170802123922.11498-1-jlu@pengutronix.de>
 <20170802123922.11498-8-jlu@pengutronix.de>
Message-ID: <20170814110133.cnxpt744yhmnsotc@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 02, 2017 at 02:39:20PM +0200, Jan Luebbe wrote:
> These helpers simplify error handling in the _probe functions and automate
> deallocation in the _remove functions.
> 
> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> ---
>  drivers/edac/edac_mc.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/edac/edac_mc.h | 26 ++++++++++++++++++++++++
>  2 files changed, 80 insertions(+)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index 480072139b7a..d3ee2b851329 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -517,6 +517,34 @@ void edac_mc_free(struct mem_ctl_info *mci)
>  }
>  EXPORT_SYMBOL_GPL(edac_mc_free);
>  
> +/**
> + * devm_edac_mc_free() - Internal helper to call edac_mc_free from a devres
> + *	action.
> + */
> +static void devm_edac_mc_free(void *mci)
> +{
> +	edac_mc_free((struct mem_ctl_info *)mci);
> +}
> +
> +struct mem_ctl_info *devm_edac_mc_alloc(struct device *dev,
> +					unsigned int mc_num,
> +					unsigned int n_layers,
> +					struct edac_mc_layer *layers,
> +					unsigned int sz_pvt)
> +{
> +	struct mem_ctl_info *mci;
> +
> +	mci = edac_mc_alloc(mc_num, n_layers, layers, sz_pvt);
> +	if (!mci)
> +		return mci;
> +
> +	if (devm_add_action_or_reset(dev, devm_edac_mc_free, mci))
> +		return NULL;
> +
> +	return mci;
> +}
> +EXPORT_SYMBOL_GPL(devm_edac_mc_alloc);

Ok, I see what you want to do here but I'm not excited.

Rather, what I've been telling other EDAC driver writers is to first
probe the hardware as much as possible until they *know* they're all
ready to init and only then call the EDAC core to allocate structures.

Because, with this lazy method, the pointless memory allocation
and freeing would still happen if the late probing fails. But that
allocation and freeing is completely pointless.

So looking at armada_xp_mc_edac_probe(), for example, you should do
edac_mc_alloc() *after* armada_xp_mc_edac_read_config() has succeeded.
The same idea holds true for aurora_l2_edac_probe(): do all probing
and gathering of info from the hardware first and then call EDAC core
functions.

Thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

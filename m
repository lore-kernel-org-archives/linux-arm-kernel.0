From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 15 Mar 2013 09:53:46 +0100
Subject: [PATCH 1/2] dmaengine: add const for name parameter
In-Reply-To: <1363318601-31505-2-git-send-email-shawn.guo@linaro.org>
References: <1363318601-31505-1-git-send-email-shawn.guo@linaro.org>
 <1363318601-31505-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130315085346.GA22650@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I already sent a nearly identical patch:
https://patchwork.kernel.org/patch/2179321/

Regards,

Markus

On Fri, Mar 15, 2013 at 11:36:40AM +0800, Shawn Guo wrote:
> Mark name parameter of generic device tree helpers as const, as it
> shouldn't be changed anyway.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/dma/dmaengine.c   |    2 +-
>  drivers/dma/of-dma.c      |    6 +++---
>  include/linux/dmaengine.h |    7 ++++---
>  include/linux/of_dma.h    |    2 +-
>  4 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index b2728d6..2cbfefe 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -555,7 +555,7 @@ EXPORT_SYMBOL_GPL(__dma_request_channel);
>   * @dev:	pointer to client device structure
>   * @name:	slave channel name
>   */
> -struct dma_chan *dma_request_slave_channel(struct device *dev, char *name)
> +struct dma_chan *dma_request_slave_channel(struct device *dev, const char *name)
>  {
>  	/* If device-tree is present get slave info from here */
>  	if (dev->of_node)
> diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
> index 69d04d2..6036cd0 100644
> --- a/drivers/dma/of-dma.c
> +++ b/drivers/dma/of-dma.c
> @@ -172,8 +172,8 @@ EXPORT_SYMBOL_GPL(of_dma_controller_free);
>   * specifiers, matches the name provided. Returns 0 if the name matches and
>   * a valid pointer to the DMA specifier is found. Otherwise returns -ENODEV.
>   */
> -static int of_dma_match_channel(struct device_node *np, char *name, int index,
> -				struct of_phandle_args *dma_spec)
> +static int of_dma_match_channel(struct device_node *np, const char *name,
> +				int index, struct of_phandle_args *dma_spec)
>  {
>  	const char *s;
>  
> @@ -198,7 +198,7 @@ static int of_dma_match_channel(struct device_node *np, char *name, int index,
>   * Returns pointer to appropriate dma channel on success or NULL on error.
>   */
>  struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
> -					      char *name)
> +					      const char *name)
>  {
>  	struct of_phandle_args	dma_spec;
>  	struct of_dma		*ofdma;
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 91ac8da..68b4252 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -968,7 +968,8 @@ enum dma_status dma_sync_wait(struct dma_chan *chan, dma_cookie_t cookie);
>  enum dma_status dma_wait_for_async_tx(struct dma_async_tx_descriptor *tx);
>  void dma_issue_pending_all(void);
>  struct dma_chan *__dma_request_channel(dma_cap_mask_t *mask, dma_filter_fn fn, void *fn_param);
> -struct dma_chan *dma_request_slave_channel(struct device *dev, char *name);
> +struct dma_chan *dma_request_slave_channel(struct device *dev,
> +					   const char *name);
>  void dma_release_channel(struct dma_chan *chan);
>  #else
>  static inline enum dma_status dma_wait_for_async_tx(struct dma_async_tx_descriptor *tx)
> @@ -984,7 +985,7 @@ static inline struct dma_chan *__dma_request_channel(dma_cap_mask_t *mask,
>  	return NULL;
>  }
>  static inline struct dma_chan *dma_request_slave_channel(struct device *dev,
> -							 char *name)
> +							 const char *name)
>  {
>  	return NULL;
>  }
> @@ -1007,7 +1008,7 @@ struct dma_chan *net_dma_find_channel(void);
>  static inline struct dma_chan
>  *__dma_request_slave_channel_compat(dma_cap_mask_t *mask, dma_filter_fn fn,
>  				  void *fn_param, struct device *dev,
> -				  char *name)
> +				  const char *name)
>  {
>  	struct dma_chan *chan;
>  
> diff --git a/include/linux/of_dma.h b/include/linux/of_dma.h
> index d15073e..0c4a82e 100644
> --- a/include/linux/of_dma.h
> +++ b/include/linux/of_dma.h
> @@ -40,7 +40,7 @@ extern int of_dma_controller_register(struct device_node *np,
>  		void *data);
>  extern int of_dma_controller_free(struct device_node *np);
>  extern struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
> -						     char *name);
> +						     const char *name);
>  extern struct dma_chan *of_dma_simple_xlate(struct of_phandle_args *dma_spec,
>  		struct of_dma *ofdma);
>  #else
> -- 
> 1.7.9.5
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

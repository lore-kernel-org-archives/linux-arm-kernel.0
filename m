From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 05 Oct 2017 12:31:52 +0200
Subject: [RESEND][PATCH 2/7] nvmem: imx-ocotp: Pass parameters via a struct
In-Reply-To: <1507155921-824-3-git-send-email-pure.logic@nexus-software.ie>
References: <1507155921-824-1-git-send-email-pure.logic@nexus-software.ie>
 <1507155921-824-3-git-send-email-pure.logic@nexus-software.ie>
Message-ID: <1507199512.8473.8.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bryan,

a few small nitpicks below.

On Wed, 2017-10-04 at 23:25 +0100, Bryan O'Donoghue wrote:
> It will be useful in later patches to know the register access mode
> and bit-shift to apply to a given input offset.
> 
> Fixes: 0642bac7da42 ("nvmem: imx-ocotp: add write support")
> 
> Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
> ---
> ?drivers/nvmem/imx-ocotp.c | 32 ++++++++++++++++++++++----------
> ?1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
> index 17d160f..fed76a4 100644
> --- a/drivers/nvmem/imx-ocotp.c
> +++ b/drivers/nvmem/imx-ocotp.c
> @@ -53,11 +53,15 @@
> ?
> ?static DEFINE_MUTEX(ocotp_mutex);
> ?
> +struct octp_params {

Should this struct be called "ocotp_params"?

> +	unsigned int nregs;
> +};
> +
> ?struct ocotp_priv {
> ?	struct device *dev;
> ?	struct clk *clk;
> ?	void __iomem *base;
> -	unsigned int nregs;
> +	struct octp_params *params;
> ?	struct nvmem_config *config;
> ?};
> ?
> @@ -121,8 +125,8 @@ static int imx_ocotp_read(void *context, unsigned
> int offset,
> ?	index = offset >> 2;
> ?	count = bytes >> 2;
> ?
> -	if (count > (priv->nregs - index))
> -		count = priv->nregs - index;
> +	if (count > (priv->params->nregs - index))
> +		count = priv->params->nregs - index;
> ?
> ?	mutex_lock(&ocotp_mutex);
> ?
> @@ -308,12 +312,20 @@ static struct nvmem_config
> imx_ocotp_nvmem_config = {
> ?	.reg_write = imx_ocotp_write,
> ?};
> ?
> +static const struct octp_params params[] = {
> +	{ .nregs = 128},

Missing whitespace.

> +	{ .nregs = 64},
> +	{ .nregs = 128},
> +	{ .nregs = 128},
> +	{ .nregs = 64},
> +};
> +
> ?static const struct of_device_id imx_ocotp_dt_ids[] = {
> -	{ .compatible = "fsl,imx6q-ocotp",??(void *)128 },
> -	{ .compatible = "fsl,imx6sl-ocotp", (void *)64 },
> -	{ .compatible = "fsl,imx6sx-ocotp", (void *)128 },
> -	{ .compatible = "fsl,imx6ul-ocotp", (void *)128 },
> -	{ .compatible = "fsl,imx7d-ocotp", (void *)64 },
> +	{ .compatible = "fsl,imx6q-ocotp",??(void *)&params[0] },

The (void *) cast is superfluous with this change, I'd also add the
missing ".data =":

	{ .compatible = "fsl,imx6q-ocotp",??.data = &params[0] },


> +	{ .compatible = "fsl,imx6sl-ocotp", (void *)&params[1] },
> +	{ .compatible = "fsl,imx6sx-ocotp", (void *)&params[2] },
> +	{ .compatible = "fsl,imx6ul-ocotp", (void *)&params[3] },
> +	{ .compatible = "fsl,imx7d-ocotp", (void *)&params[4] },
> ?	{ },
> ?};
> ?MODULE_DEVICE_TABLE(of, imx_ocotp_dt_ids);
> @@ -342,8 +354,8 @@ static int imx_ocotp_probe(struct platform_device
> *pdev)
> ?		return PTR_ERR(priv->clk);
> ?
> ?	of_id = of_match_device(imx_ocotp_dt_ids, dev);
> -	priv->nregs = (unsigned long)of_id->data;
> -	imx_ocotp_nvmem_config.size = 4 * priv->nregs;
> +	priv->params = (struct octp_params *)of_id->data;
> +	imx_ocotp_nvmem_config.size = 4 * priv->params->nregs;

This would be a good opportunity to switch to of_device_get_match_data.

> ?	imx_ocotp_nvmem_config.dev = dev;
> ?	imx_ocotp_nvmem_config.priv = priv;
> ?	priv->config = &imx_ocotp_nvmem_config;

regards
Philipp

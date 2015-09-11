From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 Sep 2015 22:30:18 +0200
Subject: [PATCH v2 4/9] dmaengine: st_fdma: Add STMicroelectronics FDMA
 engine driver support
In-Reply-To: <1441980871-24475-5-git-send-email-peter.griffin@linaro.org>
References: <1441980871-24475-1-git-send-email-peter.griffin@linaro.org>
 <1441980871-24475-5-git-send-email-peter.griffin@linaro.org>
Message-ID: <2502961.3gtPceE427@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 September 2015 15:14:26 Peter Griffin wrote:
> +
> +#include "st_fdma.h"

Just move the contents of that file here, no other driver should
be including it.

> +static struct dma_chan *st_fdma_of_xlate(struct of_phandle_args *dma_spec,
> +					 struct of_dma *ofdma)
> +{
> +	struct st_fdma_dev *fdev = ofdma->of_dma_data;
> +	struct st_fdma_cfg cfg;
> +
> +	if (dma_spec->args_count < 1)
> +		return NULL;
> +
> +	cfg.of_node = dma_spec->np;
> +	cfg.req_line = dma_spec->args[0];
> +	cfg.req_ctrl = 0;
> +	cfg.type = ST_FDMA_TYPE_FREE_RUN;
> +
> +	if (dma_spec->args_count > 1)
> +		cfg.req_ctrl = dma_spec->args[1] & REQ_CTRL_CFG_MASK;
> +
> +	if (dma_spec->args_count > 2)
> +		cfg.type = dma_spec->args[2];

The binding mandates #dma-cells=<3>, so you can just return an error
otherwise.

> +	dev_dbg(fdev->dev, "xlate req_line:%d type:%d req_ctrl:%#x\n",
> +		cfg.req_line, cfg.type, cfg.req_ctrl);
> +
> +	return dma_request_channel(fdev->dma_device.cap_mask,
> +			st_fdma_filter_fn, &cfg);
> +}

Why this indirection? You should be able to just use
dma_get_any_slave_channel() to get the first available channel and
then configure it the same way that the filter function does.

> +bool st_fdma_filter_fn(struct dma_chan *chan, void *param)
> +{
> +	struct st_fdma_cfg *config = param;
> +	struct st_fdma_chan *fchan = to_st_fdma_chan(chan);
> +
> +	if (!param)
> +		return false;
> +
> +	if (fchan->fdev->dma_device.dev->of_node != config->of_node)
> +		return false;
> +
> +	fchan->cfg = *config;
> +
> +	return true;
> +}

Please drop this until there is a board file that references the
function. Otherwise it's just dead code. I assume there are some
users in arch/sh/ in a private tree?

	Arnd

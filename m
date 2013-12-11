From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Dec 2013 22:27:18 +0100
Subject: [PATCH v13] dmaengine: Add MOXA ART DMA engine driver
In-Reply-To: <1386774824-1638-1-git-send-email-jonas.jensen@gmail.com>
References: <1386340059-24738-1-git-send-email-jonas.jensen@gmail.com>
 <1386774824-1638-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <201312112227.19016.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I didn't comment on this earlier since you had already gone through 12 revisions
and I didn't want to hold up merging any longer. This can be done as a follow-up,
or you can include it if you end up doing a v14:

On Wednesday 11 December 2013, Jonas Jensen wrote:

> +bool moxart_dma_filter_fn(struct dma_chan *chan, void *param)
> +{
> +       struct moxart_filter_data *fdata = param;
> +       struct moxart_chan *ch = to_moxart_dma_chan(chan);
> +
> +       if (chan->device->dev != fdata->mdc->dma_slave.dev ||
> +           chan->device->dev->of_node != fdata->dma_spec->np) {
> +               dev_dbg(chan2dev(chan), "device not registered to this DMA engine\n");
> +               return false;
> +       }
> +
> +       dev_dbg(chan2dev(chan), "%s: ch=%p line_reqno=%u ch->ch_num=%u\n",
> +               __func__, ch, fdata->dma_spec->args[0], ch->ch_num);
> +
> +       ch->line_reqno = fdata->dma_spec->args[0];
> +
> +       return true;
> +}
> +
> +static struct dma_chan *moxart_of_xlate(struct of_phandle_args *dma_spec,
> +                                       struct of_dma *ofdma)
> +{
> +       struct moxart_dmadev *mdc = ofdma->of_dma_data;
> +       struct moxart_filter_data fdata = {
> +               .mdc = mdc,
> +       };
> +
> +       if (dma_spec->args_count < 1)
> +               return NULL;
> +
> +       fdata.dma_spec = dma_spec;
> +
> +       return dma_request_channel(mdc->dma_slave.cap_mask,
> +                                  moxart_dma_filter_fn, &fdata);
> +}

The moxart_dma_filter_fn should get removed and the moxart_of_xlate() rewritten
based on Stephen Warren's dma_get_any_slave_channel() interface once that
is available in the dmaengine git tree.

	Arnd

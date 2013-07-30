From: rizhao@nvidia.com (Richard Zhao)
Date: Tue, 30 Jul 2013 18:12:23 +0800
Subject: [PATCH 7/9] ASoC: tegra: move to generic DMA DT binding
In-Reply-To: <51F2D4DD.9060308@wwwdotorg.org>
References: <1374639002-16753-1-git-send-email-rizhao@nvidia.com>
 <1374639002-16753-8-git-send-email-rizhao@nvidia.com>
 <51F2D4DD.9060308@wwwdotorg.org>
Message-ID: <20130730101221.GO15855@rizhao-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 27, 2013 at 03:58:21AM +0800, Stephen Warren wrote:
> On 07/23/2013 10:10 PM, Richard Zhao wrote:
> > - add tegra_dma_filter_data to specify dma info
> >   DMA DT binding needs the device that raise dma request and dma name
> >   to request a dma channel. tegra30_i2s is a special case. It should be ahub
> >   device and it also has dma name that cannot handled by ASoC dmaengine code.
> >   So we pass the info using filter data in snd_dmaengine_dai_dma_data.
> > - change i2s/ac97 drivers to use generic DT binding
> > - tegra30_i2s: alloc ahub tx/rx fifo at driver probe time
> 
> > diff --git a/sound/soc/tegra/tegra30_i2s.c b/sound/soc/tegra/tegra30_i2s.c
> 
> I don't understand why the FIFO alloc/free had to move from
> startup()/shutdown() to probe()/remove().

The call path is:
[<c0520e38>] (dump_stack+0x78/0xbc) from [<c03bb854>] (tegra_pcm_request_chan+0x10/0x34)
[<c03bb854>] (tegra_pcm_request_chan+0x10/0x34) from [<c03b6c2c>] (dmaengine_pcm_new+0xe0/0x134)
[<c03b6c2c>] (dmaengine_pcm_new+0xe0/0x134) from [<c03b5824>] (soc_new_pcm+0x2f0/0x3cc)
[<c03b5824>] (soc_new_pcm+0x2f0/0x3cc) from [<c03aa1a0>] (soc_probe_link_dais+0x358/0x39c)
[<c03aa1a0>] (soc_probe_link_dais+0x358/0x39c) from [<c03ab334>] (snd_soc_instantiate_card+0x35c/0x7a0)
[<c03ab334>] (snd_soc_instantiate_card+0x35c/0x7a0) from [<c03ab9dc>] (snd_soc_register_card+0x264/0x330)
[<c03ab9dc>] (snd_soc_register_card+0x264/0x330) from [<c03be350>] (tegra_rt5640_probe+0xf4/0x17c)
[<c03be350>] (tegra_rt5640_probe+0xf4/0x17c) from [<c0294290>] (platform_drv_probe+0x18/0x1c)

So I need to request dma channel at probe time.

> This will prevent later
> changes from making the connectivity between the AHUB FIFOs and I2S
> modules more dynamic, which is kind of the whole point of the AHUB HW
> module.

That's because it's i2s driver to register pcm device rather not ahub.
Ideally dma channel is only bound to ahub.
> 
> > diff --git a/sound/soc/tegra/tegra_pcm.h b/sound/soc/tegra/tegra_pcm.h
> 
> > +#define TEGRA_DMA_NAME_MAX_LEN	10
> > +
> > +/*
> > + * Generic DMA DT binding needs the device that raise dma request and dma name
> > + * to request a dma channel. tegra30_i2s is a special case. It should be ahub
> > + * device and it also has dma name that cannot handled by ASoC dmaengine code.
> > + * So we pass the info using filter data in snd_dmaengine_dai_dma_data.
> > + */
> > +struct tegra_dma_filter_data {
> > +	struct device *dma_dev;
> > +	char dma_name[TEGRA_DMA_NAME_MAX_LEN];
> > +};
> 
> I agree with Lars-Peter's comment that it'd be better to enhance the
> ASoC dmaengine support to allow the channel name to be specified so we
> don't need to much custom code.

Not only dma-name but also dma client device for this case.

> And that should use "char *" not a
> fixed-length array.
Ok, then there' two solutions.

struct tegra30_i2s {
...
        struct snd_dmaengine_dai_dma_data capture_dma_data;
        char dma_rx_name[10];
        struct tegra_dma_filter_data filter_data_rx;
...
        struct snd_dmaengine_dai_dma_data playback_dma_data;
        char dma_tx_name[10];
        struct tegra_dma_filter_data filter_data_tx;
};

probe: i2s->filter_data_rx.dma_name = i2s.dma_rx_name

or

probe: i2s->filter_data_rx.dma_name = kasprintf(GFP_KERNEL, "channel%d" ...);
remove: kfree(i2s->filter_data_rx.dma.name)

Which one do you like?


Thanks for review!
Richard

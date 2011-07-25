From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 25 Jul 2011 17:21:44 +0530
Subject: [PATCH V4 06/14] ARM: SAMSUNG: Add common DMA operations
In-Reply-To: <1311557312-26107-7-git-send-email-boojin.kim@samsung.com>
References: <1311557312-26107-1-git-send-email-boojin.kim@samsung.com>
	<1311557312-26107-7-git-send-email-boojin.kim@samsung.com>
Message-ID: <CABb+yY0nWLpdVGqTJPO2YwkGWiDw5tRjC2xn7Le0bO0ZNFHC_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2011 at 6:58 AM, Boojin Kim <boojin.kim@samsung.com> wrote:

> +
> +static bool pl330_filter(struct dma_chan *chan, void *param)
> +{
> + ? ? ? struct dma_pl330_peri *peri = (struct dma_pl330_peri *)chan->private;
> + ? ? ? unsigned dma_ch = (unsigned)param;
> +
> + ? ? ? if (peri->peri_id != dma_ch)
> + ? ? ? ? ? ? ? return false;
> +
> + ? ? ? return true;
> +}
This is what I meant... if we keep chan_id for paltform assigned IDs,
these filter functions could simply become

static bool pl330_filter(struct dma_chan *chan, void *param)
{
        return chan->chan_id == param
}

And ideally in the long run, we could just drop the filter callback
and add expected channel ID to the request_channel call.



> +
> +static inline int s3c_dma_trigger(unsigned ch)
> +{
> + ? ? ? return s3c2410_dma_ctrl(ch, S3C2410_DMAOP_START);
> +}
> +
> +static inline int s3c_dma_started(unsigned ch)
> +{
> + ? ? ? return s3c2410_dma_ctrl(ch, S3C2410_DMAOP_STARTED);
> +}
> +
> +static inline int s3c_dma_flush(unsigned ch)
> +{
> + ? ? ? return s3c2410_dma_ctrl(ch, S3C2410_DMAOP_FLUSH);
> +}
> +
> +static inline int s3c_dma_stop(unsigned ch)
> +{
> + ? ? ? return s3c2410_dma_ctrl(ch, S3C2410_DMAOP_STOP);
> +}
> +
> +static struct samsung_dma_ops s3c_dma_ops = {
> + ? ? ? .request ? ? ? ?= s3c_dma_request,
> + ? ? ? .release ? ? ? ?= s3c_dma_release,
> + ? ? ? .prepare ? ? ? ?= s3c_dma_prepare,
> + ? ? ? .trigger ? ? ? ?= s3c_dma_trigger,
> + ? ? ? .started ? ? ? ?= s3c_dma_started,
> + ? ? ? .flush ? ? ? ? ?= s3c_dma_flush,
> + ? ? ? .stop ? ? ? ? ? = s3c_dma_stop,

These last 4 should be gnereallized into one callback with OP argument.

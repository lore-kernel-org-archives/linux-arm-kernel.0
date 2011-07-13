From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 13 Jul 2011 08:44:37 +0100
Subject: [PATCH V2 01/10] ASoc: mxs: add mxs-pcm driver
In-Reply-To: <1310483085-31442-2-git-send-email-b29396@freescale.com>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-2-git-send-email-b29396@freescale.com>
Message-ID: <20110713074437.GF23270@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2011 at 11:04:36PM +0800, Dong Aisheng wrote:
> +static int mxs_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
> +{
> +	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
> +	struct snd_dma_buffer *buf = &substream->dma_buffer;
> +	size_t size = 64 * 1024;
> +
> +	buf->dev.type = SNDRV_DMA_TYPE_DEV;
> +	buf->dev.dev = pcm->card->dev;
> +	buf->private_data = NULL;
> +	buf->area = dma_alloc_writecombine(pcm->card->dev, size,
> +					   &buf->addr, GFP_KERNEL);
...
> +static int snd_mxs_pcm_mmap(struct snd_pcm_substream *substream,
> +		struct vm_area_struct *vma)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	int ret;
> +
> +	ret = dma_mmap_coherent(NULL, vma, runtime->dma_area,
> +			runtime->dma_addr, runtime->dma_bytes);

This is wrong.  Hint 1:

int dma_mmap_writecombine(struct device *dev, struct vm_area_struct *vma,
                          void *cpu_addr, dma_addr_t dma_addr, size_t size)

Hint 2: struct device *dev - you have one above.

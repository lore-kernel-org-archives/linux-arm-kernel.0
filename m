From: broonie@kernel.org (Mark Brown)
Date: Fri, 11 Nov 2016 12:20:36 +0000
Subject: [PATCH v3] spi: spi-fsl-dspi: Add DMA support for Vybrid
In-Reply-To: <836dd6a84fa149cafdbb0b53e792d305febf6207.1478778329.git.maitysanchayan@gmail.com>
References: <836dd6a84fa149cafdbb0b53e792d305febf6207.1478778329.git.maitysanchayan@gmail.com>
Message-ID: <20161111122036.fubv7b4jc5vkdxhc@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2016 at 05:49:15PM +0530, Sanchayan Maity wrote:

A couple of small things, please send followup patches fixing them.

> +	rx_word = is_double_byte_mode(dspi);
> +
> +	len = rx_word ? (dma->curr_xfer_len / 2) : dma->curr_xfer_len;

Please use normal if statements, they're much easier to read.

> +err_slave_config:
> +	devm_kfree(dev, dma->rx_dma_buf);
> +err_rx_dma_buf:
> +	devm_kfree(dev, dma->tx_dma_buf);

You really shouldn't need to explicitly free things like this if you're
using devm_, especially in the error path from the probe function like
this where a failure is just going to result in the device failing to
instantiate so you won't have the allocation sitting around unused for
any length of time.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161111/6447812f/attachment.sig>

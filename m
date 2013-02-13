From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 13 Feb 2013 14:21:24 +0000
Subject: [PATCH 1/3] i2c: mxs: support non-dma mapable buffers
In-Reply-To: <1360763336-1931-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
References: <1360763336-1931-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
Message-ID: <20130213142124.GB17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 13, 2013 at 02:48:56PM +0100, Enrico Scholz wrote:
> diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
> index d6abaf2..c995393 100644
> --- a/drivers/i2c/busses/i2c-mxs.c
> +++ b/drivers/i2c/busses/i2c-mxs.c
> @@ -139,6 +139,13 @@ struct mxs_i2c_dev {
>  	uint32_t			addr_data;
>  	struct scatterlist		sg_io[2];
>  	bool				dma_read;
> +
> +	/*
> +	 * internal buffer for handling non-dma mapable buffers; when message
> +	 * exceeds the (arbitrary) size of '8', a buffer will be kmalloc()'ed
> +	 * instead of using this attribute
> +	 */
> +	unsigned char			xfer_buf[8];

Beware.  Remember that DMA cache maintanence operates on a granularity of
a cache line, and make sure that you're not going to be upset should the
cache line be read by accessing the other members of this struct.  It's
probably altogether safer if you kmalloc this buffer separately at driver
init time, and make it an "unsigned char *xfer_buf".

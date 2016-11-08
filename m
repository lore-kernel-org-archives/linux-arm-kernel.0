From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 8 Nov 2016 19:54:42 +0100
Subject: [PATCH v3 3/3] ARM: dmaengine: sun6i: share the dma driver with
 sun50i
In-Reply-To: <20161107182840.GA3711@arx12>
References: <20161107182840.GA3711@arx12>
Message-ID: <20161108185442.oyywmgrvmqomnqe6@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2016 at 02:28:40AM +0800, Hao Zhang wrote:
> According to the datasheet, the dma of A64 support 8/16/32/64 bits
> so, we can add the condition of device compatible in convert_buswidth
> function and other place to determine the device whether is for A64,
> and then accept the 8 bytes bus width to it.
> 
> Signed-off-by: Hao Zhang <hao5781286@gmail.com>
> ---
>  drivers/dma/sun6i-dma.c | 43 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 33 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index 8346199..8a95a1a 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -247,13 +247,17 @@ static inline s8 convert_burst(u32 maxburst)
>  	}
>  }
>  
> -static inline s8 convert_buswidth(enum dma_slave_buswidth addr_width)
> +static inline s8 convert_buswidth(enum dma_slave_buswidth addr_width,
> +				  struct sun6i_dma_dev *sdev)
>  {
> -	if ((addr_width < DMA_SLAVE_BUSWIDTH_1_BYTE) ||
> -	    (addr_width > DMA_SLAVE_BUSWIDTH_4_BYTES))
> +	if (((addr_width >= DMA_SLAVE_BUSWIDTH_1_BYTE) &&
> +	     (addr_width <= DMA_SLAVE_BUSWIDTH_4_BYTES)) ||
> +	    ((addr_width == DMA_SLAVE_BUSWIDTH_8_BYTES) &&
> +	     (of_device_is_compatible(sdev->slave.dev->of_node,
> +				      "allwinner,sun50i-a64-dma"))))
> +		return addr_width >> 1;
> +	else

Just like for the burst (https://lkml.org/lkml/2016/10/4/367) I think
this should be taken care of in the the framework's
dmaengine_slave_config function.

This is quite easy to do in the width case, since you just have to
test whether what has been set in the dma_device has support for the
burst give in the configuration.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161108/df9a830d/attachment.sig>

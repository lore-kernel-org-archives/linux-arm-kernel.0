From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Sep 2017 09:57:32 +0200
Subject: [PATCH v2 01/10] dmaengine: sun6i: Correct setting of clock
 autogating register for A83T/H3
In-Reply-To: <20170917031956.28010-2-stefan.bruens@rwth-aachen.de>
References: <20170917031956.28010-1-stefan.bruens@rwth-aachen.de>
 <20170917031956.28010-2-stefan.bruens@rwth-aachen.de>
Message-ID: <20170918075732.wptp75sh3ovhdukp@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Sep 17, 2017 at 05:19:47AM +0200, Stefan Br?ns wrote:
> The H83T uses a compatible string different from the A23, but requires
> the same clock autogating register setting.
> 
> The H3 also requires setting the clock autogating register, but has
> the register at a different offset.
> 
> Add three suitable callbacks for the existing controller generations
> and set it in the controller config structure.
> 
> Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
> ---
>  drivers/dma/sun6i-dma.c | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index bcd496edc70f..45bcd5271d94 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -48,6 +48,9 @@
>  #define SUN8I_DMA_GATE		0x20
>  #define SUN8I_DMA_GATE_ENABLE	0x4
>  
> +#define SUNXI_H3_SECURE_REG		0x20
> +#define SUNXI_H3_DMA_GATE		0x28
> +#define SUNXI_H3_DMA_GATE_ENABLE	0x4
>  /*
>   * Channels specific registers
>   */
> @@ -111,7 +114,7 @@ struct sun6i_dma_config {
>  	 * however these SoCs really have and need this bit, as seen in the
>  	 * BSP kernel source code.
>  	 */
> -	bool gate_needed;
> +	void (*clock_autogate_enable)();
>  };
>  
>  /*
> @@ -267,6 +270,20 @@ static inline s8 convert_buswidth(enum dma_slave_buswidth addr_width)
>  	return addr_width >> 1;
>  }
>  
> +static void sun6i_enable_clock_autogate_noop(struct sun6i_dma_dev *sdev)
> +{
> +}

I guess instead of that one, we could just test for the pointer and
not call the function if it's NULL?

Looks good otherwise, once fixed, you have
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170918/9c4ab33c/attachment.sig>

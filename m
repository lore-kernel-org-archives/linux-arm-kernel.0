From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 21 Aug 2013 11:47:57 +0530
Subject: [PATCH v2] DMA: fix AMBA PL08x compilation issue with 64bit
 DMA address type
In-Reply-To: <1376907568-18689-1-git-send-email-andre.przywara@linaro.org>
References: <20130815211515.GF23006@n2100.arm.linux.org.uk>
 <1376907568-18689-1-git-send-email-andre.przywara@linaro.org>
Message-ID: <20130821061757.GL5810@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 12:19:28PM +0200, Andre Przywara wrote:
> When dma_addr_t is 64 bits long, compilation of the AMBA PL08x DMA
> driver breaks due to a missing 64bit%8bit modulo operation.
> Looking more closely the divisor in these operations can only be
> 1, 2 or 4, so the full featured '%' modulo operation is overkill and
> can be replaced with simple bit masking.
> 
> Change from v1:
> Replace open-coded function with existing IS_ALIGNED macro and use a
> macro around that to avoid a line becoming too long.
> 
> Signed-off-by: Andre Przywara <andre.przywara@linaro.org>
Acked-by: Vinod Koul <vinod.koul@intel.com>

~Vinod
> ---
>  drivers/dma/amba-pl08x.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
> index bce5fbf..bff41d4 100644
> --- a/drivers/dma/amba-pl08x.c
> +++ b/drivers/dma/amba-pl08x.c
> @@ -133,6 +133,8 @@ struct pl08x_bus_data {
>  	u8 buswidth;
>  };
>  
> +#define IS_BUS_ALIGNED(bus) IS_ALIGNED((bus)->addr, (bus)->buswidth)
> +
>  /**
>   * struct pl08x_phy_chan - holder for the physical channels
>   * @id: physical index to this channel
> @@ -889,8 +891,8 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
>  				return 0;
>  			}
>  
> -			if ((bd.srcbus.addr % bd.srcbus.buswidth) ||
> -					(bd.dstbus.addr % bd.dstbus.buswidth)) {
> +			if (!IS_BUS_ALIGNED(&bd.srcbus) ||
> +				!IS_BUS_ALIGNED(&bd.dstbus)) {
>  				dev_err(&pl08x->adev->dev,
>  					"%s src & dst address must be aligned to src"
>  					" & dst width if peripheral is flow controller",
> @@ -911,9 +913,9 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
>  		 */
>  		if (bd.remainder < mbus->buswidth)
>  			early_bytes = bd.remainder;
> -		else if ((mbus->addr) % (mbus->buswidth)) {
> -			early_bytes = mbus->buswidth - (mbus->addr) %
> -				(mbus->buswidth);
> +		else if (!IS_BUS_ALIGNED(mbus)) {
> +			early_bytes = mbus->buswidth -
> +				(mbus->addr & (mbus->buswidth - 1));
>  			if ((bd.remainder - early_bytes) < mbus->buswidth)
>  				early_bytes = bd.remainder;
>  		}
> @@ -931,7 +933,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
>  			 * Master now aligned
>  			 * - if slave is not then we must set its width down
>  			 */
> -			if (sbus->addr % sbus->buswidth) {
> +			if (!IS_BUS_ALIGNED(sbus)) {
>  				dev_dbg(&pl08x->adev->dev,
>  					"%s set down bus width to one byte\n",
>  					__func__);
> -- 
> 1.7.12.1
> 

-- 

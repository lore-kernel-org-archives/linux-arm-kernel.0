From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 20 Nov 2014 01:22:09 -0800
Subject: [PATCH v4 2/4] mtd: nand: gpmi: add gpmi_move_bits function
In-Reply-To: <1413794777-32220-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1413794777-32220-1-git-send-email-boris.brezillon@free-electrons.com>
 <1413794777-32220-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20141120092209.GD3212@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 20, 2014 at 10:46:15AM +0200, Boris Brezillon wrote:
> Add a new function to move bits (not bytes) from a memory region to
> another one.
> This function is similar to memmove except it acts at bit level.
> This function is needed to implement GPMI raw access functions, given the
> fact that ECC engine does not pad ECC bits to the next byte boundary.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/mtd/nand/gpmi-nand/gpmi-lib.c  | 129 +++++++++++++++++++++++++++++++++
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.h |   4 +
>  2 files changed, 133 insertions(+)
> 
> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
> index 87e658c..5d4f140 100644
> --- a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
> @@ -1353,3 +1353,132 @@ int gpmi_read_page(struct gpmi_nand_data *this,
>  	set_dma_type(this, DMA_FOR_READ_ECC_PAGE);
>  	return start_dma_with_bch_irq(this, desc);
>  }
> +
> +void gpmi_move_bits(u8 *dst, size_t dst_bit_off,
> +		    const u8 *src, size_t src_bit_off,
> +		    size_t nbits)

Two things:

 1) Yikes! This function is a little hairy.

 2) This function really deserves a full comment header (kerneldoc?); it
 needs to have clearly-documented high-level semantics.

I'm not sure how to address #1, as the complexity is necessary. Did you
run this through some unit tests, at least?

> +{
[snip]
> +}

Brian

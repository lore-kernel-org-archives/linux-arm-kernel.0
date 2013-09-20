From: jeffrey.t.kirsher@intel.com (Jeff Kirsher)
Date: Fri, 20 Sep 2013 12:50:20 -0700
Subject: [PATCH 06/51] DMA-API: net: intel/ixgb: fix 32-bit DMA mask
 handling
In-Reply-To: <E1VMloR-0007fk-Ei@rmk-PC.arm.linux.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMloR-0007fk-Ei@rmk-PC.arm.linux.org.uk>
Message-ID: <1379706620.1972.12.camel@jtkirshe-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-09-19 at 22:30 +0100, Russell King wrote:
> The fallback to 32-bit DMA mask is rather odd:
>         err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
>         if (!err) {
>                 err = dma_set_coherent_mask(&pdev->dev,
> DMA_BIT_MASK(64));
>                 if (!err)
>                         pci_using_dac = 1;
>         } else {
>                 err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
>                 if (err) {
>                         err = dma_set_coherent_mask(&pdev->dev,
>                                                     DMA_BIT_MASK(32));
>                         if (err) {
>                                 pr_err("No usable DMA configuration,
> aborting\n");
>                                 goto err_dma_mask;
>                         }
>                 }
>         }
> This means we only set the coherent DMA mask in the fallback path if
> the DMA mask set failed, which is silly.  This fixes it to set the
> coherent DMA mask only if dma_set_mask() succeeded, and to error out
> if either fails.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/net/ethernet/intel/ixgb/ixgb_main.c |   16 +++++-----------
>  1 files changed, 5 insertions(+), 11 deletions(-)

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130920/aaac07fa/attachment.sig>

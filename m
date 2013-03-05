From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 5 Mar 2013 12:13:41 +0530
Subject: [PATCH] arm: davinci: fix edma dmaengine induced null pointer
 dereference on da830
In-Reply-To: <1362415977-12829-1-git-send-email-mporter@ti.com>
References: <1362415977-12829-1-git-send-email-mporter@ti.com>
Message-ID: <5135941D.8050506@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matt,

I dropped the copy to stable folks since they dont want to be involved
in patch reviews of this kind.

On 3/4/2013 10:22 PM, Matt Porter wrote:
> This adds additional error checking to the private edma api implementation
> to catch the case where the edma_alloc_slot() has an invalid controller
> parameter. The edma dmaengine wrapper driver relies on this condition
> being handled in order to avoid setting up a second edma dmaengine
> instance on DA830.
> 
> Verfied using a DA850 with the second EDMA controller platform instance
> removed to simulate a DA830 which only has a single EDMA controller.
> 
> Reported-by: Tomas Novotny <tomas@novotny.cz>
> Signed-off-by: Matt Porter <mporter@ti.com>
> Cc: stable at kernel.org

This should be stable at vger.kernel.org per
Documentation/stable_kernel_rules.txt. Also, I think it is better to
request the back port only from v3.7.x+ since the bug is important only
after drivers/dma/edma.c was merged. So:

Cc: stable at vger.kernel.org # v3.7.x+

> ---
>  arch/arm/mach-davinci/dma.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
> index a685e97..f9eb836 100644
> --- a/arch/arm/mach-davinci/dma.c
> +++ b/arch/arm/mach-davinci/dma.c
> @@ -747,6 +747,8 @@ int edma_alloc_slot(unsigned ctlr, int slot)
>  		slot = EDMA_CHAN_SLOT(slot);
>  
>  	if (slot < 0) {
> +		if (!edma_cc[ctlr])
> +			return -EINVAL;

Shouldn't such a check be done outside of the if() since there is an
'else if' later which also accesses edma_cc[ctlr]

	} else if (slot < edma_cc[ctlr]->num_channels ||
			slot >= edma_cc[ctlr]->num_slots) {
		return -EINVAL;

Thanks,
Sekhar

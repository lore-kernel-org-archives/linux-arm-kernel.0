From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 12 Jul 2017 14:43:58 +0100
Subject: [boot-wrapper] [PATCH 2/2] gic: Make sure all the supported SPIs
 are marked non-secure
In-Reply-To: <1499866108-15140-2-git-send-email-suzuki.poulose@arm.com>
References: <1499866108-15140-1-git-send-email-suzuki.poulose@arm.com>
 <1499866108-15140-2-git-send-email-suzuki.poulose@arm.com>
Message-ID: <3acba6ab-cc3a-54ba-2bda-4b198f73d87d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/07/17 14:28, Suzuki K Poulose wrote:
> The maximum SPI INTID is 32(N+1) - 1, where N = GICD_TYPER:ITLinesNumber.
> But currently we only mark the range, {32, 32*(N)-1} as Group1 non-secure.
> If there happens to be an SPI allocated in the last 32 INTIDs, the EL1
> will fail to use them as it would be marked Group0.
> 
> Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  gic.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/gic.c b/gic.c
> index a84779e..83e340d 100644
> --- a/gic.c
> +++ b/gic.c
> @@ -40,9 +40,10 @@ void gic_secure_init(void)
>  
>  	if (cpu == 0) {
>  		uint32_t typer = raw_readl(gicd_base + GICD_TYPER);
> +		uint32_t n_itlines = typer & GICD_TYPER_ITLineNumber;
>  
> -		/* Set SPIs to Group 1 */
> -		for (i = 1; i < (typer & GICD_TYPER_ITLineNumber); i++)
> +		/* Set SPIs {32, 32(n_itlines + 1) - 1} to Group 1 */
> +		for (i = 1; i < n_itlines + 1; i++)
>  			raw_writel(~0, gicd_base + GICD_IGROUPRn + i * 4);
>  
>  		raw_writel(GICD_CTLR_EnableGrp0 | GICD_CTLR_EnableGrp1,
> 

For both patches:

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...

From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 16 Feb 2018 17:02:42 +0000
Subject: [PATCH] irqchip/gic-v3-its: Fix misplaced __iomem annotations
In-Reply-To: <af3a8a44f6693f6293de49a1c2910a57ba12e208.1518800276.git.robin.murphy@arm.com>
References: <af3a8a44f6693f6293de49a1c2910a57ba12e208.1518800276.git.robin.murphy@arm.com>
Message-ID: <221594bd-313d-9b62-e0b3-abe1f5adbf8a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/02/18 16:57, Robin Murphy wrote:
> Save 26 lines worth of Sparse complaints by fixing up this minor
> mishap. The pointee lies in the __iomem space; the pointer does not.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 06f025fd5726..3a38b4e8685e 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -2495,7 +2495,7 @@ static int its_vpe_set_affinity(struct irq_data *d,
>  
>  static void its_vpe_schedule(struct its_vpe *vpe)
>  {
> -	void * __iomem vlpi_base = gic_data_rdist_vlpi_base();
> +	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
>  	u64 val;
>  
>  	/* Schedule the VPE */
> @@ -2527,7 +2527,7 @@ static void its_vpe_schedule(struct its_vpe *vpe)
>  
>  static void its_vpe_deschedule(struct its_vpe *vpe)
>  {
> -	void * __iomem vlpi_base = gic_data_rdist_vlpi_base();
> +	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
>  	u32 count = 1000000;	/* 1s! */
>  	bool clean;
>  	u64 val;
> 

Ah! Too bad you missed the pull request by a few hours... I'll stash
that for -rc3.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 30 Jan 2015 19:24:53 +0000
Subject: [PATCH 2/5] irqchip: gicv3-its: zero itt before handling to
 hardware
In-Reply-To: <1422604009-9248-3-git-send-email-wuyun.wu@huawei.com>
References: <1422604009-9248-1-git-send-email-wuyun.wu@huawei.com>
 <1422604009-9248-3-git-send-email-wuyun.wu@huawei.com>
Message-ID: <54CBDA85.7040902@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/01/15 07:46, Yun Wu wrote:
> Some kind of brain-dead implementations chooses to insert ITEes in
> rapid sequence of disabled ITEes, and an un-zeroed ITT will confuse
> ITS on judging whether an ITE is really enabled or not. Considering
> the implementations are still supported by the GICv3 architecture,
> in which ITT is not required to be zeroed before being handled to
> hardware, we do the favor in ITS driver.
> 
> Signed-off-by: Yun Wu <wuyun.wu@huawei.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index a391417..2a08d85 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1063,7 +1063,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
>  	nr_ites = max(2UL, roundup_pow_of_two(nvecs));
>  	sz = nr_ites * its->ite_size;
>  	sz = max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
> -	itt = kmalloc(sz, GFP_KERNEL);
> +	itt = kzalloc(sz, GFP_KERNEL);
>  	lpi_map = its_lpi_alloc_chunks(nvecs, &lpi_base, &nr_lpis);
> 
>  	if (!dev || !itt || !lpi_map) {

Fair enough. I suppose this cannot really hurt if we have stupid HW around.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...

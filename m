From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 30 Jan 2015 19:18:21 +0000
Subject: [PATCH 3/5] irqchip: gicv3-its: use 64KB page as default granule
In-Reply-To: <1422604009-9248-4-git-send-email-wuyun.wu@huawei.com>
References: <1422604009-9248-1-git-send-email-wuyun.wu@huawei.com>
 <1422604009-9248-4-git-send-email-wuyun.wu@huawei.com>
Message-ID: <54CBD8FD.1030908@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/01/15 07:46, Yun Wu wrote:
> The field of page size in register GITS_BASERn might be read-only
> if an implementation only supports a single, fixed page size. But
> currently the ITS driver will throw out an error when PAGE_SIZE
> is less than the minimum size supported by an ITS. So addressing
> this problem by using 64KB pages as default granule for all the
> ITS base tables.

Do you actually know of an implementation with such a behaviour?

> Signed-off-by: Yun Wu <wuyun.wu@huawei.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 2a08d85..430bc92 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -801,7 +801,7 @@ static int its_alloc_tables(struct its_node *its)
>  	int err;
>  	int i;
>  	int size;
> -	int psz = PAGE_SIZE;
> +	int psz = SZ_64K;
>  	u64 shr = GITS_BASER_InnerShareable;
> 
>  	for (i = 0; i < GITS_BASER_NR_REGS; i++) {

Assuming such an implementation exists, you'll have to rebase this on
top of the patch I mentioned in my reply to patch #1.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

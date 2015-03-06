From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 06 Mar 2015 16:04:56 +0000
Subject: [PATCH v4 2/5] irqchip: gicv3-its: use 64KB page as default
 granule
In-Reply-To: <1425615203-3300-3-git-send-email-wuyun.wu@huawei.com>
References: <1425615203-3300-1-git-send-email-wuyun.wu@huawei.com>
 <1425615203-3300-3-git-send-email-wuyun.wu@huawei.com>
Message-ID: <54F9D028.4010002@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/15 04:13, Yun Wu wrote:
> The field of page size in register GITS_BASERn might be read-only
> if an implementation only supports a single, fixed page size. But
> currently the ITS driver will throw out an error when PAGE_SIZE
> is less than the minimum size supported by an ITS. So addressing
> this problem by using 64KB pages as default granule for all the
> ITS base tables.
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Yun Wu <wuyun.wu@huawei.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 69eeea3..f5bfa42 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -800,7 +800,7 @@ static int its_alloc_tables(struct its_node *its)
>  {
>  	int err;
>  	int i;
> -	int psz = PAGE_SIZE;
> +	int psz = SZ_64K;
>  	u64 shr = GITS_BASER_InnerShareable;
> 
>  	for (i = 0; i < GITS_BASER_NR_REGS; i++) {

Just went through a test run with this, and this breaks any non Device
Table allocation when PAGE_SIZE != 64K.

The following hunk fixes it:

@@ -806,7 +806,7 @@ static int its_alloc_tables(struct its_node *its)
 		u64 val = readq_relaxed(its->base + GITS_BASER + i * 8);
 		u64 type = GITS_BASER_TYPE(val);
 		u64 entry_size = GITS_BASER_ENTRY_SIZE(val);
-		int order = 0;
+		int order = get_order(psz);
 		int alloc_size;
 		u64 tmp;
 		void *base;

I'll fold it in to the original patch, but I'd be grateful if you could
do a slightly more thorough testing before sending patches.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

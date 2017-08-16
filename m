From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 16 Aug 2017 16:12:03 +0100
Subject: [PATCH] irqchip/gic-v3-its: handle queue wrapping in
 its_wait_for_range_completion()
In-Reply-To: <1502888682-12148-1-git-send-email-yangyingliang@huawei.com>
References: <1502888682-12148-1-git-send-email-yangyingliang@huawei.com>
Message-ID: <ce21378f-c7ad-9a7a-563d-982b1170df93@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yang,

On 16/08/17 14:04, Yang Yingliang wrote:
> If the to_idx wrap to 0, (rd_idx >= to_idx) will be true,
> but the command is not completed.
> 
> When to_idx is smaller than from_idx, it means the queue
> is wrapped. For handling this case, add ITS_CMD_QUEUE_SZ
> to to_idx and rd_idx to.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 6893287..8e47515 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -446,13 +446,18 @@ static void its_wait_for_range_completion(struct its_node *its,
>  					  struct its_cmd_block *to)
>  {
>  	u64 rd_idx, from_idx, to_idx;
> +	u32 wrap_offset = 0;
>  	u32 count = 1000000;	/* 1s! */
>  
>  	from_idx = its_cmd_ptr_to_offset(its, from);
>  	to_idx = its_cmd_ptr_to_offset(its, to);
> +	if (to_idx < from_idx) {
> +		wrap_offset = ITS_CMD_QUEUE_SZ;
> +		to_idx += ITS_CMD_QUEUE_SZ;
> +	}
>  
>  	while (1) {
> -		rd_idx = readl_relaxed(its->base + GITS_CREADR);
> +		rd_idx = readl_relaxed(its->base + GITS_CREADR) + wrap_offset;
>  		if (rd_idx >= to_idx || rd_idx < from_idx)
>  			break;
>  
> 

I think you've spotted a real issue, but the way you solve it hurts my 
brain. I'd rather have something that makes the cases explicit. Does the 
following work for you?

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 22e228500357..374977681384 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -453,7 +453,13 @@ static void its_wait_for_range_completion(struct its_node *its,
 
 	while (1) {
 		rd_idx = readl_relaxed(its->base + GITS_CREADR);
-		if (rd_idx >= to_idx || rd_idx < from_idx)
+
+		/* Direct case */
+		if (from_idx < to_idx && rd_idx >= to_idx)
+			break;
+
+		/* Wrapped case */
+		if (from_idx >= to_idx && rd_idx >= to_idx && rd_idx < from_idx)
 			break;
 
 		count--;

Secondary question: have you seen this breaking in practice? The worse
case seems that we exit early, and potentially fail to detect a hung
ITS. But that should never happen, right?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

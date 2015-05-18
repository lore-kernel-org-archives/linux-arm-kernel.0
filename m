From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 18 May 2015 14:23:26 +0100
Subject: [PATCH] irqchip: GICv3: ITS: don't assume 64K page size in
 its_alloc_tables
In-Reply-To: <1431644545-31904-1-git-send-email-stuart.yoder@freescale.com>
References: <1431644545-31904-1-git-send-email-stuart.yoder@freescale.com>
Message-ID: <5559E7CE.1050003@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stuart,

On 15/05/15 00:02, Stuart Yoder wrote:
> its_alloc_tables() needs to account for page sizes other than
> 64KB.  Without this change, when PAGE_SIZE=4KB its_alloc_tables()
> gets stuck in an infinite loop.
> 
> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
> ---
> 
> think this should go into 4.1 if at all possible...without it I am
> unable to boot a 4.1 kernel on the LS2085 SoC

What you are suggesting here is a effectively a revert of commit
790b57a, which would break other implementations.

Can you please explain the actual issue? I'm failing to see how you end
up in an infinite loop here (the system page size and the ITS base
granule should be completely unrelated...).

Or has it anything to do with Minghuan Lian's patch
(https://lkml.org/lkml/2015/4/16/36), which looks more correct (if still
massively under-documented)?

Thanks,

	M.
> 
>  drivers/irqchip/irq-gic-v3-its.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 9687f8a..58a6612 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -800,7 +800,7 @@ static int its_alloc_tables(struct its_node *its)
>  {
>  	int err;
>  	int i;
> -	int psz = SZ_64K;
> +	int psz = PAGE_SIZE;
>  	u64 shr = GITS_BASER_InnerShareable;
>  	u64 cache = GITS_BASER_WaWb;
>  
> 


-- 
Jazz is not dead. It just smells funny...

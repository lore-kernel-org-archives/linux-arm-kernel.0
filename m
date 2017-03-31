From: james.morse@arm.com (James Morse)
Date: Fri, 31 Mar 2017 17:22:42 +0100
Subject: [PATCH v3 4/8] APEI: GHES: reserve a virtual page for SEI context
In-Reply-To: <1490869877-118713-5-git-send-email-xiexiuqi@huawei.com>
References: <1490869877-118713-1-git-send-email-xiexiuqi@huawei.com>
 <1490869877-118713-5-git-send-email-xiexiuqi@huawei.com>
Message-ID: <58DE8252.7070709@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Xie XiuQi,

On 30/03/17 11:31, Xie XiuQi wrote:
> On arm64 platform, SEI may interrupt code which had interrupts masked.
> But SEI could be masked, so it's not treated as NMI, however SEA is
> treated as NMI.
> 
> So, the  memory area used to transfer hardware error information from
> BIOS to Linux can be determined only in NMI, SEI(arm64), IRQ or timer
> handler.
> 
> In this patch, we add a virtual page for SEI context.

I don't think this is the best way of solving the interaction problem. If we
ever need to add another notification method this gets even more complicated,
and the ioremap code has to know how these methods can interact.


> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 045d101..b1f9b1f 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -155,54 +162,55 @@ static void ghes_ioremap_exit(void)

> -static void __iomem *ghes_ioremap_pfn_irq(u64 pfn)
> -{
> -	unsigned long vaddr, paddr;
> -	pgprot_t prot;
> -
> -	vaddr = (unsigned long)GHES_IOREMAP_IRQ_PAGE(ghes_ioremap_area->addr);
> +	if (in_nmi()) {
> +		raw_spin_lock(&ghes_ioremap_lock_nmi);
> +		vaddr = (unsigned long)GHES_IOREMAP_NMI_PAGE(ghes_ioremap_area->addr);
> +	} else if (this_cpu_read(sei_in_process)) {

> +		spin_lock_irqsave(&ghes_ioremap_lock_sei, flags);

I think this one should be a raw_spin_lock. I'm pretty sure this is for RT-linux
where spin_lock() on a contented lock will call schedule() in the same way
mutex_lock() does. If interrupts were masked by arch code then you need to use
raw_spin_lock.
So now we need to know how we got in here, we interrupted the SError handler so
this should only be Synchronous External Abort. Having to know how we got here
is another problem with this approach.


As suggested earlier[0], I think the best way is to allocate one page of virtual
address space per struct ghes, and move the locks out to the notify calls, which
can know how they are called.

I've pushed a branch to:
http://www.linux-arm.org/git?p=linux-jm.git;a=commit;h=refs/heads/apei_ioremap_rework/v1

I intend to post those patches as an RFC series later in the cycle, I've only
build tested it so far.


Thanks,

James

> +		vaddr = (unsigned long)GHES_IOREMAP_SEI_PAGE(ghes_ioremap_area->addr);
> +	} else {
> +		spin_lock_irqsave(&ghes_ioremap_lock_irq, flags);
> +		vaddr = (unsigned long)GHES_IOREMAP_IRQ_PAGE(ghes_ioremap_area->addr);
> +	}


[0] https://lkml.org/lkml/2017/3/20/434

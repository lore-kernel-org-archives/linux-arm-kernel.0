From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Mon, 3 Jan 2011 19:28:36 +0100
Subject: [RFC PATCH] Avoid aliasing mappings in DMA coherent allocator
In-Reply-To: <20110103095751.GA26785@n2100.arm.linux.org.uk>
References: <20101224111125.GD20587@n2100.arm.linux.org.uk>
	<loom.20101228T203522-493@post.gmane.org>
	<20110103095751.GA26785@n2100.arm.linux.org.uk>
Message-ID: <201101031928.37091.jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Monday 03 January 2011 10:57:52 Russell King - ARM Linux wrote:
> On Tue, Dec 28, 2010 at 09:29:58PM +0000, Janusz Krzysztofik wrote:
> > Works fine on OMAP1 based Amstrad Delta, both default 2MB/2MB and
> > shrinked to 1MB/1MB configurations. No need to preallocate dma
> > coherent memory for camera video buffers on boot.
>
> That's good news.
>
> > However, in 1MB/1MB configuration it failed to allocate 600kB of
> > writecombined omapfb vram, required for double-buffering, and
> > reserving up to 4MB of machine's total 32MB seems too expensive.
>
> Do you have other users of the writecombined memory?  If so, what
> size are they?

Apparently ASoC omap-pcm, 2 x 128kB.

> As the 600k allocation can only be satisfied at the beginning of the
> region, we could do top-down rather than bottom-up allocation
> (untested):

Yes, this solves the issue for me. Both omap-pcm and omapfb/lcdc are now 
able to get their requested DMA writecombined buffers (2 x 128kB + 
600kB) from the reserved 1MB area.

Tested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

I'll try to prepare for review a followup patch that updates those 
<{mach,plat}/memory.h> and similiar include files which provided their 
own non-default CONSISTENT_DMA_SIZE values. Since I'm not familiar with 
machines other that OMAP1, I'll take a 50/50 approach as a starting 
point if no other indications can be found.

Thanks,
Janusz

> diff --git a/arch/arm/mm/vmregion.c b/arch/arm/mm/vmregion.c
> index 935993e..036fdbf 100644
> --- a/arch/arm/mm/vmregion.c
> +++ b/arch/arm/mm/vmregion.c
> @@ -38,7 +38,7 @@ struct arm_vmregion *
>  arm_vmregion_alloc(struct arm_vmregion_head *head, size_t align,
>  		   size_t size, gfp_t gfp)
>  {
> -	unsigned long addr = head->vm_start, end = head->vm_end - size;
> +	unsigned long start = head->vm_start, addr = head->vm_end;
>  	unsigned long flags;
>  	struct arm_vmregion *c, *new;
>
> @@ -54,21 +54,20 @@ arm_vmregion_alloc(struct arm_vmregion_head
> *head, size_t align,
>
>  	spin_lock_irqsave(&head->vm_lock, flags);
>
> -	list_for_each_entry(c, &head->vm_list, vm_list) {
> -		if ((addr + size) < addr)
> -			goto nospc;
> -		if ((addr + size) <= c->vm_start)
> +	addr = rounddown(addr - size, align);
> +	list_for_each_entry_reverse(c, &head->vm_list, vm_list) {
> +		if (addr >= c->vm_end)
>  			goto found;
> -		addr = ALIGN(c->vm_end, align);
> -		if (addr > end)
> +		addr = rounddown(c->vm_start - size, align);
> +		if (addr < start)
>  			goto nospc;
>  	}
>
>   found:
>  	/*
> -	 * Insert this entry _before_ the one we found.
> +	 * Insert this entry after the one we found.
>  	 */
> -	list_add_tail(&new->vm_list, &c->vm_list);
> +	list_add(&new->vm_list, &c->vm_list);
>  	new->vm_start = addr;
>  	new->vm_end = addr + size;
>  	new->vm_active = 1;

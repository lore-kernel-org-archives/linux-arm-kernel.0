From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 28 Mar 2014 22:51:51 -0400 (EDT)
Subject: [PATCH] ARM: Better virt_to_page() handling
In-Reply-To: <20140328200540.GQ7528@n2100.arm.linux.org.uk>
References: <20140328152831.GK7528@n2100.arm.linux.org.uk>
 <E1WTYiT-0007Jl-Fe@rmk-PC.arm.linux.org.uk>
 <alpine.LFD.2.11.1403281506250.1571@knanqh.ubzr>
 <20140328200540.GQ7528@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.11.1403282244430.1571@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Mar 2014, Russell King - ARM Linux wrote:

> On Fri, Mar 28, 2014 at 03:52:16PM -0400, Nicolas Pitre wrote:
> > I see it might be hard to make the last two common, unless it is defined 
> > up front and the odd case does a #undef virt_to_pfn before redefining 
> > it.  Which way is best I'm not sure.
> 
> Given the problems we've had in this area with changes ending up with
> build failures, I think it's far better to have simplicity even if it
> means duplicating definitions, rather than trying to invent some clever
> way to avoid duplications.

OK, fair enough.

> > Also this needs to take care of those machines overriding PHYS_OFFSET at 
> > run time (see commit a77e0c7b2774f).
> 
> Platforms don't override PHYS_OFFSET.  They override PLAT_PHYS_OFFSET
> instead.
> 
> > However it looks like no code 
> > relying on the LPAE version of early_paging_init() has been merged in 
> > mainline yet.
> 
> I believe that's fully reliant on CONFIG_ARM_PATCH_PHYS_VIRT being set,
> and the difference for that case would be setting __pv_phys_pfn_offset
> instead of __pv_phys_offset, which is a simple modification.

Indeed.

> However, that's something which should be done by core code, not
> individually by platforms.  Since we don't have any view of code doing
> this yet, it's not relevant here.  We can only deal with what is in
> mainline and not in external trees.

Hence my suggestion to simply add a note to the commit log for this 
patch, or better would be a note added to the comment for 
early_paging_init() to that effect.


Nicolas

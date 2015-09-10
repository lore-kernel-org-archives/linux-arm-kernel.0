From: will.deacon@arm.com (Will Deacon)
Date: Thu, 10 Sep 2015 16:38:12 +0100
Subject: [PATCH] arm64: Add support for hardware updates of the access
 and dirty pte bits
In-Reply-To: <55F19785.4090106@citrix.com>
References: <1436545468-1549-1-git-send-email-catalin.marinas@arm.com>
 <55F06A87.3000204@citrix.com> <20150910100753.GE12294@localhost>
 <55F19785.4090106@citrix.com>
Message-ID: <20150910153812.GG22439@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 10, 2015 at 03:45:25PM +0100, Julien Grall wrote:
> >> Do you have any insight for debugging this problem?
> > [...]
> >>> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> >>> index 39139a3aa16d..a8be513dff6f 100644
> >>> --- a/arch/arm64/mm/proc.S
> >>> +++ b/arch/arm64/mm/proc.S
> >>> @@ -196,6 +196,19 @@ ENTRY(__cpu_setup)
> >>>  	 */
> >>>  	mrs	x9, ID_AA64MMFR0_EL1
> >>>  	bfi	x10, x9, #32, #3
> >>> +#ifdef CONFIG_ARM64_HW_AFDBM
> >>> +	/*
> >>> +	 * Hardware update of the Access and Dirty bits.
> >>> +	 */
> >>> +	mrs	x9, ID_AA64MMFR1_EL1
> >>> +	and	x9, x9, #0xf
> >>> +	cbz	x9, 2f
> >>> +	cmp	x9, #2
> >>> +	b.lt	1f
> >>> +	orr	x10, x10, #TCR_HD		// hardware Dirty flag update
> >>> +1:	orr	x10, x10, #TCR_HA		// hardware Access flag update
> >>> +2:
> >>> +#endif	/* CONFIG_ARM64_HW_AFDBM */
> >>>  	msr	tcr_el1, x10
> >>>  	ret					// return to head.S
> >>>  ENDPROC(__cpu_setup)
> > 
> > Just in case some ID registers are wrong, can you do an "#if 0" above
> > instead of CONFIG_ARM64_HW_AFDBM?
> 
> It doesn't change anything for me. I've also tried the solution
> suggested by Will (see changes below) and I still hit the BUG_ON in the
> fs driver.
> 
> The only way to get a usable userspace is disabling CONFIG_ARM64_HW_AFDBM.

Weird. That doesn't leave a lot of code. Two other things you could try
are:

  (1) Put PTE_WRITE back to bit 57
  (2) Remove the pte_hw_dirty check/set in pte_modify

I thought maybe we could be corrupting a swap entry or something, but I
really can't see how that could happen.

Will

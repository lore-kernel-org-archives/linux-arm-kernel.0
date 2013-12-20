From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 20 Dec 2013 11:57:35 +0000
Subject: [PATCH RFC v3 04/12] arm64: kernel: cpu_{suspend/resume}
 implementation
In-Reply-To: <52B42A48.5090202@marvell.com>
References: <1385033059-25896-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1385033059-25896-5-git-send-email-lorenzo.pieralisi@arm.com>
 <52B42A48.5090202@marvell.com>
Message-ID: <20131220115735.GH25477@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 11:30:16AM +0000, Leo Yan wrote:
> On 11/21/2013 07:24 PM, Lorenzo Pieralisi wrote:
> > +/*
> > + * x0 must contain the sctlr value retrieved from restored context
> > + */
> > +ENTRY(cpu_resume_mmu)
> > +	ldr	x3, =cpu_resume_after_mmu
> > +	msr	sctlr_el1, x0		// restore sctlr_el1
> > +	isb
> > +	br	x3			// global jump to virtual address
> > +ENDPROC(cpu_resume_mmu)
> > +cpu_resume_after_mmu:
> > +	mov	x0, #0			// return zero on success
> > +	ldp	x19, x20, [sp, #16]
> > +	ldp	x21, x22, [sp, #32]
> > +	ldp	x23, x24, [sp, #48]
> > +	ldp	x25, x26, [sp, #64]
> > +	ldp	x27, x28, [sp, #80]
> > +	ldp	x29, lr, [sp], #96
> > +	ret
> > +ENDPROC(cpu_resume_after_mmu)
> > +
> > +	.data
> > +ENTRY(cpu_resume)
> > +	bl	el2_setup		// if in EL2 drop to EL1 cleanly
> 
> Compare to v2's patch set, here remove the calculation fro the offset 
> b/t PHYS_OFFSET - PAGE_OFFSET; so when i verify the patch set, i saw x28 
> is zero and finally introduce the EL2's sync exception. Below are pasted 
> v2's code for reference.
> 
> do u want use firmware to set the x28 for the offset value? :-) IMHO, 
> v2's implementation is more reasonable and it's better keep the code.
> 
> ENTRY(cpu_resume)
>            adr     x4, sleep_save_sp
>            ldr     x5, =sleep_save_sp
>            sub     x28, x4, x5             // x28 = PHYS_OFFSET - 
> PAGE_OFFSET
>            /*
>             * make sure el2 is sane, el2_setup expects:
>             * x28 = PHYS_OFFSET - PAGE_OFFSET
>             */
>            bl      el2_setup               // if in EL2 drop to EL1 cleanly

With commit 85cc00eaa81d (arm64: kernel: add code to set cpu boot mode
to secondary_entry shim) we no longer compute the phys-page offset
before el2_setup.

Where does the fault happen?

-- 
Catalin

From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 18 Oct 2017 11:54:23 +0100
Subject: [PATCH v3 09/13] arm64: kernel: Add arch-specific SDEI entry
 code and CPU masking
In-Reply-To: <59E63105.9080804@arm.com>
References: <20170922182614.27885-1-james.morse@arm.com>
 <20170922182614.27885-10-james.morse@arm.com>
 <20171016134139.sqe6xabdson2d5rd@armageddon.cambridge.arm.com>
 <59E63105.9080804@arm.com>
Message-ID: <20171018105422.53lnvivuq37e2oy4@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 05:34:13PM +0100, James Morse wrote:
> On 16/10/17 14:41, Catalin Marinas wrote:
> > On Fri, Sep 22, 2017 at 07:26:10PM +0100, James Morse wrote:
> >> +	u64 elr = read_sysreg(elr_el1);
> >> +	u32 kernel_mode = read_sysreg(CurrentEL) | 1;	/* +SPSel */
> >> +	unsigned long vbar = read_sysreg(vbar_el1);
> >> +
> >> +	/* Retrieve the missing registers values */
> >> +	for (i = 0; i < clobbered_registers; i++) {
> >> +		/* from within the handler, this call always succeeds */
> >> +		sdei_api_event_context(i, &regs->regs[i]);
> >> +	}
> >> +
> >> +	/*
> >> +	 * We didn't take an exception to get here, set PAN. UAO will be cleared
> >> +	 * by sdei_event_handler()s set_fs(USER_DS) call.
> >> +	 */
> >> +	asm(ALTERNATIVE("nop", SET_PSTATE_PAN(1), ARM64_HAS_PAN,
> >> +			CONFIG_ARM64_PAN));
> 
> > Can you use uaccess_disable() directly?
> 
> Wouldn't this invoke sw-pan's __uaccess_ttbr0_disable():
> > write_sysreg(ttbr, ttbr0_el1);
> 
> Probing depends on VHE if booted at EL2, can we guarantee to have PAN (and
> therefore not-SW-PAN) too?
> 
> (otherwise I can add 'depends on !ARM64_SW_TTBR0_PAN' to the Kconfig)

We want the Kconfig to be able to include all features. What you can do
though is:

	select ARM64_PAN if ARM64_SW_TTBR0_PAN

With VHE (ARMv8.2) we can guarantee that hardware PAN is around.

-- 
Catalin

From: james.morse@arm.com (James Morse)
Date: Fri, 12 Jan 2018 15:19:09 +0000
Subject: [PATCH] arm64: kpti: Fix the interaction between ASID switching
 and software PAN
In-Reply-To: <20180112123043.43535-1-catalin.marinas@arm.com>
References: <20180112123043.43535-1-catalin.marinas@arm.com>
Message-ID: <5A58D1ED.7050504@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 12/01/18 12:30, Catalin Marinas wrote:
> With ARM64_SW_TTBR0_PAN enabled, the exception entry code checks the
> active ASID to decide whether user access was enabled (non-zero ASID)
> when the exception was taken. On return from exception, if user access
> was previously disabled, it re-instates TTBR0_EL1 from the per-thread
> saved value (updated in switch_mm() or efi_set_pgd()).
> 
> Commit 7655abb95386 ("arm64: mm: Move ASID from TTBR0 to TTBR1") makes a
> TTBR0_EL1 + ASID switching non-atomic. Subsequently, commit 27a921e75711
> ("arm64: mm: Fix and re-enable ARM64_SW_TTBR0_PAN") changes the
> __uaccess_ttbr0_disable() function and asm macro to first write the
> reserved TTBR0_EL1 followed by the ASID=0 update in TTBR1_EL1. If an
> exception occurs between these two, the exception return code will
> re-instate a valid TTBR0_EL1. Similar scenario can happen in
> cpu_switch_mm() between setting the reserved TTBR0_EL1 and the ASID
> update in cpu_do_switch_mm().
> 
> This patch reverts the entry.S check for ASID == 0 to TTBR0_EL1 and
> disables the interrupts around the TTBR0_EL1 and ASID switching code in
> __uaccess_ttbr0_disable(). It also ensures that, when returning from the
> EFI runtime services, efi_set_pgd() doesn't leave a non-zero ASID in
> TTBR1_EL1.
> 
> As a safety measure, __uaccess_ttbr0_enable() always masks out any
> existing non-zero ASID TTBR1_EL1 before writing in the new ASID.
> 
> Fixes: 27a921e75711 ("arm64: mm: Fix and re-enable ARM64_SW_TTBR0_PAN")
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Co-developed-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

I saw sporadic assert-failures and translation faults running hackbench in a
loop on Seattle with software PAN. I think this explains (and fixes) it.

Tested-by: James Morse <james.morse@arm.com>
Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James

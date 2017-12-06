From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 6 Dec 2017 12:15:08 +0000
Subject: [PATCH 1/2] arm64: SW PAN: Point saved ttbr0 at the zero page
 when switching to init_mm
In-Reply-To: <1512558968-28980-2-git-send-email-will.deacon@arm.com>
References: <1512558968-28980-1-git-send-email-will.deacon@arm.com>
 <1512558968-28980-2-git-send-email-will.deacon@arm.com>
Message-ID: <20171206121507.b3ybho3pcau3vuym@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 06, 2017 at 11:16:07AM +0000, Will Deacon wrote:
> update_saved_ttbr0 mandates that mm->pgd is not swapper, since swapper
> contains kernel mappings and should never be installed into ttbr0. However,
> this means that callers must avoid passing the init_mm to update_saved_ttbr0
> which in turn can cause the saved ttbr0 value to be out-of-date in the context
> of the idle thread. For example, EFI runtime services may leave the saved ttbr0
> pointing at the EFI page table, and kernel threads may end up with stale
> references to freed page tables.
> 
> This patch changes update_saved_ttbr0 so that the init_mm points the saved
> ttbr0 value to the empty zero page, which always exists and never contains
> valid translations. EFI and switch can then call into update_saved_ttbr0
> unconditionally.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Vinayak Menon <vinmenon@codeaurora.org>
> Reported-by: Vinayak Menon <vinmenon@codeaurora.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 May 2016 16:31:33 +0100
Subject: [PATCH] arm64/efi: remove spurious WARN_ON for !4K kernels
In-Reply-To: <1464189116-30898-1-git-send-email-mark.rutland@arm.com>
References: <1464189116-30898-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20160525153133.GI5996@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2016 at 04:11:56PM +0100, Mark Rutland wrote:
> Since commit 1fd55a9a09b0293a ("arm64/efi: Apply strict permissions to
> UEFI Runtime Services regions"), booting a !4K page kernel results in a
> boot-time splat on some systems, due to to a WARN_ONCE added in that
> commit which fires if the base address of an EFI memory descriptor is
> not aligned to the kernel page size (which might be 4K, 16K, or 64K).
> 
> On page 38 of the UEFI 2.6 specification it is stated:
> 
> 	If a 64KiB physical page contains any 4KiB page with any of the
> 	following types listed below, then all 4KiB pages in the 64KiB
> 	page must use identical ARM Memory Page Attributes (as described
> 	in Table 8):
> 	? EfiRuntimeServicesCode
> 	? EfiRuntimeServicesData
> 	? EfiReserved
> 	? EfiACPIMemoryNVS
> 	Mixed attribute mappings within a larger page are not allowed.
> 
> On page 158 of the UEFI 2.6 specification, in the description of a
> memory descriptor, the PhysicalStart and VirtualStart fields are
> mandated as being 4K aligned, with NumberOfPages describing the number
> of 4K pages in the region.
> 
> No further restriction on alignment is provided in the UEFI
> specification, neither generically nor in a rule specific to AArch64.
> 
> So while attributes within a naturally-aligned 64K region must be
> consistent across memory descriptors, the regions described by those
> descriptors are not mandated to be 64K aligned.
> 
> Not being able to apply strict permissions is sub-optimal, and worthy of
> some notice, but it is not helpful to erroneously suggest that firmware
> is buggy, nor is it beneficial to have a noisy backtrace at boot time.
> 
> This patch downgrades the WARN_ONCE to a pr_warn_once, and re-words the
> message to also describe the implication of the insufficient alignment.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Leif Lindholm <leif.lindholm@linaro.org>
> Cc: Matt Fleming <matt@codeblueprint.co.uk>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-efi at vger.kernel.org

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Not sure how this will go in (Matt or Will?).

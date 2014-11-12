From: joel.schopp@amd.com (Joel Schopp)
Date: Wed, 12 Nov 2014 12:14:40 -0600
Subject: [PATCH] arm64: efi: Fix stub cache maintenance
In-Reply-To: <1415810351-3462-1-git-send-email-mark.rutland@arm.com>
References: <1415810351-3462-1-git-send-email-mark.rutland@arm.com>
Message-ID: <5463A390.9090701@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 11/12/2014 10:39 AM, Mark Rutland wrote:
> While efi-entry.S mentions that efi_entry() will have relocated the
> kernel image, it actually means that efi_entry will have placed a copy
> of the kernel in the appropriate location, and until this is branched to
> at the end of efi_entry.S, all instructions are executed from the
> original image.
>
> Thus while the flush in efi_entry.S does ensure that the copy is visible
> to noncacheable accesses, it does not guarantee that this is true for
> the image instructions are being executed from. This could have
> disasterous effects when the MMU and caches are disabled if the image
> has not been naturally evicted to the PoC.
>
> Additionally, due to a missing dsb following the ic ialluis, the new
> kernel image is not necessarily clean in the I-cache when it is branched
> to, with similar potentially disasterous effects.
>
> This patch adds additional flushing to ensure that the currently
> executing stub text is flushed to the PoC and is thus visible to
> noncacheable accesses. As it is placed after the instructions cache
> maintenance for the new image and __flush_dcache_area already contains a
> dsb, we do not need to add a separate barrier to ensure completion of
> the icache maintenance.
>
> Comments are updated to clarify the situation with regard to the two
> images and the maintenance required for both.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Ian Campbell <ijc@hellion.org.uk>
> Cc: Joel Schopp <joel.schopp@amd.com>
> Cc: Leif Lindholm <leif.lindholm@linaro.org>
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Roy Franz <roy.franz@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>
Looks more elegant than mine and seems to work.

Acked-by: Joel Schopp <joel.schopp@amd.com>

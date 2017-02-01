From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 1 Feb 2017 14:08:43 +0000
Subject: [PATCH] efi: fdt: avoid FDT manipulation after ExitBootServices()
In-Reply-To: <1485954693-25750-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1485954693-25750-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20170201140843.GC4756@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 01:11:33PM +0000, Ard Biesheuvel wrote:
> Some AArch64 UEFI implementations disable the MMU in ExitBootServices(),
> after which unaligned accesses to RAM are no longer supported.

Urrgh. That's a pretty horrible bug. :(

> Commit abfb7b686a3e ("efi/libstub/arm*: Pass latest memory map to the
> kernel") fixed an issue in the memory map handling of the stub FDT code,
> but inadvertently created an issue with such firmwares, by moving some
> of the FDT manipulation to after the invocation of ExitBootServices().
> However, the stub's libfdt implementation uses the ordinary, accelerated
> string functions, which rely on hardware handling of unaligned accesses,
> resulting in alignment faults when executed with the MMU off.
> 
> Whether disabling the MMU in ExitBootServices() complies with the UEFI
> spec is unclear, but it is a reality we have to deal with, given that
> it wasn't a problem before commit abfb7b686a3e was applied.

I'd argue that this quite clearly violates the calling convention
requiremments in 2.3.6 (e.g. SCTLR_EL1 configuration, which permits
unaligned accesses). If ExitBootServices() changes the SCTLR_EL1 value,
it clearly violates the calling convention.

This would also mean we're calling SetVirtualAddressMap() in violation
of said convention.

For the timebeing, can we drop this statement regarding the spec from
the commit message?

Regardless, I agree that we need to handle this somehow.

> So fix the situation by moving the update_fdt_memmap() into the callback
> invoked by efi_exit_boot_services() right before it hits the button.

I think this is a sensible change, but I do suspect that we're likely
to have more fun with this broken platform in future as the stub changes
(or compilers decide to generate unaligned accesses elsewhere).

Thanks,
Mark.

From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 12 Nov 2015 15:55:23 +0000
Subject: [PATCH 0/3] remove UEFI reserved regions from the linear mapping
In-Reply-To: <1446126059-25336-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1446126059-25336-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20151112155523.GD26564@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 29, 2015 at 02:40:56PM +0100, Ard Biesheuvel wrote:
> This is yet another approach to solving the issues around removing RAM
> regions known to UEFI from the linear mapping while preserving the record
> of the fact that these regions are backed by memory.
> 
> The previous approach added a memblock flag called MEMBLOCK_NOMAP to keep
> track of RAM regions that should be removed from the linear mapping.
> 
> The primary motivation for the new approach is the observation that there
> is only a single use case that requires this, which is acpi_os_ioremap().
> Since ACPI implies UEFI on arm64 platforms, and since acpi_os_ioremap()
> uses page_is_ram() internally (which is a __weak generic function), we
> can simply reimplement page_is_ram() to take the UEFI memory map into
> account if we are booted via UEFI.

Just to check, is the above the only reason for this new approach? Or
were there other issues with the MEMBLOCK_NOMAP approach other than the
diffstat?

I quite liked the MEMBLOCK_NOMAP approach as it looked reusable.

> Once we have a page_is_ram() implementation in place that will return true
> even for RAM that is known to UEFI but not covered by the linear mapping,
> we can remove all UEFI reserved and runtime regions from the linear mapping
> as well.

I take it there aren't any lurking instances of page_is_ram() used to
test if something exists in the linear mapping?

> As is obvious from the diffstat, this is the approach with the least impact,
> both in terms of number of changes and in terms of the locality of the changes.
> If we end up needing this information for other reasons (e.g., /dev/mem access
> to /reserved-memory subnodes with the nomap property on !EFI systems), we can
> always revisit this, but for now, I think this approach is the most suitable.
> 
> Patch #1 slightly reorders the UEFI runtime services initialization routines
> so that the EFI_MEMMAP flag is only set if the permanent mapping of the UEFI
> memory map is in place.

This also means that the memory map is mapped even with EFI runtime
support disabled, but I guess that's not a big problem.

As a side thought, it would be nice if we could memremap_ro the system
table and memory map in future to prevent potential corruption, given
they have fixed VAs and are always mapped.

Thanks,
Mark.

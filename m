From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Nov 2015 15:48:37 +0000
Subject: [PATCHv3] arm64: efi: correctly map runtime regions
In-Reply-To: <1448276951-13335-1-git-send-email-mark.rutland@arm.com>
References: <1448276951-13335-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20151125154837.GF3109@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 11:09:11AM +0000, Mark Rutland wrote:
> The kernel may use a page granularity of 4K, 16K, or 64K depending on
> configuration.
> 
> When mapping EFI runtime regions, we use memrange_efi_to_native to round
> the physical base address of a region down to a kernel page boundary,
> and round the size up to a kernel page boundary, adding the residue left
> over from rounding down the physical base address. We do not round down
> the virtual base address.
> 
> In __create_mapping we account for the offset of the virtual base from a
> granule boundary, adding the residue to the size before rounding the
> base down to said granule boundary.
> 
> Thus we account for the residue twice, and when the residue is non-zero
> will cause __create_mapping to map an additional page at the end of the
> region. Depending on the memory map, this page may be in a region we are
> not intended/permitted to map, or may clash with a different region that
> we wish to map. In typical cases, mapping the next item in the memory
> map will overwrite the erroneously created entry, as we sort the memory
> map in the stub.
> 
> As __create_mapping can cope with base addresses which are not page
> aligned, we can instead rely on it to map the region appropriately, and
> simplify efi_virtmap_init by removing the unnecessary code.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Leif Lindholm <leif.lindholm@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>

Patch applied. Thanks.

-- 
Catalin

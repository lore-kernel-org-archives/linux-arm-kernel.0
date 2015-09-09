From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Wed, 9 Sep 2015 12:45:48 +0100
Subject: [PATCH v2] arm64/efi: don't pad between EFI_MEMORY_RUNTIME regions
In-Reply-To: <1441782414-16284-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1441371986-4554-1-git-send-email-ard.biesheuvel@linaro.org>
 <1441782414-16284-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150909114548.GC4973@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 09 Sep, at 09:06:54AM, Ard Biesheuvel wrote:
> The new Properties Table feature introduced in UEFIv2.5 may split
> memory regions that cover PE/COFF memory images into separate code
> and data regions. Since these regions only differ in the type (runtime
> code vs runtime data) and the permission bits, but not in the memory
> type attributes (UC/WC/WT/WB), the spec does not require them to be
> aligned to 64 KB.
> 
> As the relative offset of PE/COFF .text and .data segments cannot be
> changed on the fly, this means that we can no longer pad out those
> regions to be mappable using 64 KB pages.
> Unfortunately, there is no annotation in the UEFI memory map that
> identifies data regions that were split off from a code region, so we
> must apply this logic to all adjacent runtime regions whose attributes
> only differ in the permission bits.
> 
> So instead of rounding each memory region to 64 KB alignment at both
> ends, only round down regions that are not directly preceded by another
> runtime region with the same type attributes. Since the UEFI spec does
> not mandate that the memory map be sorted, this means we also need to
> sort it first.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> 
> As discussed off list, this is the arm64 side of what we should backport
> to stable to prevent firmware that adheres to the current version of the
> UEFI v2.5 spec with the memprotect feature enabled from blowing up the system
> upon the first OS call into the runtime services.
> 
> For arm64, we already map things in order, but since the spec does not mandate
> a sorted memory map, we need to sort it to be sure. This also allows us to
> easily find adjacent regions with < 64 KB granularity, which the current version
> of the spec allows if they only differ in permission bits (which the spec says
> are 'unused' on AArch64, which could be interpreted as 'allowed but ignored').
> 
> Changes since v1:
> - Ensure that we don't inadvertently set the XN bit on the preceding region at
>   mapping time if we the OS is running with >4 KB pages.
>   
>  arch/arm64/kernel/efi.c                 |  3 +-
>  drivers/firmware/efi/libstub/arm-stub.c | 62 +++++++++++++++-----
>  2 files changed, 49 insertions(+), 16 deletions(-)

Thanks Ard. I've picked this up in my 'urgent' queue and tagged it for
stable, but it would be really good if folks on the Cc list could
provdide ACKs and Tested-by tags because this is the kind of kernel
code where dragons lurk.

-- 
Matt Fleming, Intel Open Source Technology Center

From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 10 Feb 2017 14:18:02 +0000
Subject: [PATCH v2 2/2] efi: arm-stub: Round up FDT allocation to mapping
 size
In-Reply-To: <a25905bb-5ad5-e10e-c14a-f01313eace2d@codeaurora.org>
References: <1486676573-19237-1-git-send-email-ard.biesheuvel@linaro.org>
 <1486676573-19237-2-git-send-email-ard.biesheuvel@linaro.org>
 <a25905bb-5ad5-e10e-c14a-f01313eace2d@codeaurora.org>
Message-ID: <CAKv+Gu_GKYTCfMfutg2mCnYBF5V1HeJBdS8EVW1hC_xMAbKn6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 February 2017 at 00:40, Ruigrok, Richard <rruigrok@codeaurora.org> wrote:
>
>
> On 2/9/2017 2:42 PM, Ard Biesheuvel wrote:
>
> The FDT is mapped via a fixmap entry that is at least 2 MB in size and
> 2 MB aligned on 4 KB page size kernels.
>
> On UEFI systems, the FDT allocation may share this 2 MB block with a
> reserved region, or another memory region that we should never map,
> unless we account for this in the size of the allocation (the alignment
> is already 2 MB)
>
> So instead of taking guesses at the needed space, simply allocate 2 MB
> immediately. The allocation will be recorded as a EFI_LOADER_DATA, and
> the kernel only memblock_reserve()'s the actual size of the FDT, so the
> unused space will be released to the kernel.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/include/asm/efi.h       |  1 +
>  drivers/firmware/efi/libstub/fdt.c | 57 +++++++++-----------
>  2 files changed, 25 insertions(+), 33 deletions(-)
>
[..]
> Tested successfully on our QDT2400 system on which we were seeing a failure
> to allocate memory for initrd.
>
> Tested-by: Richard Ruigrok <rruigrok@codeaurora.org>
>

Thanks

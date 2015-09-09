From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 9 Sep 2015 09:28:05 +0200
Subject: [PATCH v2] arm64/efi: don't pad between EFI_MEMORY_RUNTIME regions
In-Reply-To: <1441782414-16284-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1441371986-4554-1-git-send-email-ard.biesheuvel@linaro.org>
 <1441782414-16284-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu9KmghcboVtkBeG-jwm4TTWaVekGked9ZN8z9G3XizeTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(snip linux-efi + matt)

On 9 September 2015 at 09:06, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
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

The x86 counterpart is under discussion here:
http://thread.gmane.org/gmane.linux.kernel.efi/6219

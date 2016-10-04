From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 4 Oct 2016 11:14:29 +0100
Subject: [PATCH] efi/arm: fix absolute relocation detection for older
 toolchains
In-Reply-To: <1475276515-21801-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1475276515-21801-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <2f5904e7-8f2b-2993-5123-73b90c34e7d7@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 01/10/16 00:01, Ard Biesheuvel wrote:
> When building the ARM kernel with CONFIG_EFI=y, the following build
> error may occur when using a less recent version of binutils (2.23 or
> older):
> 
>    STUBCPY drivers/firmware/efi/libstub/lib-sort.stub.o
>  00000000 R_ARM_ABS32       sort
>  00000004 R_ARM_ABS32       __ksymtab_strings
>  drivers/firmware/efi/libstub/lib-sort.stub.o: absolute symbol references
>  not allowed in the EFI stub
> 
> (and when building with debug symbols, the list above is much longer, and
> contains all the internal references between the .debug sections and the
> actual code)
> 
> This issue is caused by the fact that objcopy v2.23 or earlier does not
> support wildcards in its -R and -j options, which means the following
> line from the Makefile:
> 
>   STUBCOPY_FLAGS-y		:= -R .debug* -R *ksymtab* -R *kcrctab*
> 
> fails to take effect, leaving harmless absolute relocations in the binary
> that are indistinguishable from relocations that may cause crashes at
> runtime due to the fact that these relocations are resolved at link time
> using the virtual address of the kernel, which is always different from
> the address at which the EFI firmware loads and invokes the stub.
> 
> So, as a workaround, disable debug symbols explicitly when building the
> stub for ARM, and strip the ksymtab and kcrctab symbols for the only
> exported symbol we currently reuse in the stub, which is 'sort'.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Thanks fixes the issues I was seeing. So ...

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic

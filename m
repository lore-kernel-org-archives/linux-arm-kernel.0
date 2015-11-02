From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Mon, 2 Nov 2015 12:49:52 +0000
Subject: [PATCH v4 3/3] arm64/efi: isolate EFI stub from the kernel proper
In-Reply-To: <CAKv+Gu-G1YS9Ha=-rtnPKJTOxBTrdSq6=Tqwq_GPW742JUE+2Q@mail.gmail.com>
References: <1444330924-17830-1-git-send-email-ard.biesheuvel@linaro.org>
 <1444330924-17830-4-git-send-email-ard.biesheuvel@linaro.org>
 <562EA894.8070505@arm.com> <562EAA22.3010905@arm.com>
 <CAKv+Gu-G1YS9Ha=-rtnPKJTOxBTrdSq6=Tqwq_GPW742JUE+2Q@mail.gmail.com>
Message-ID: <20151102121618.GA2331@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Oct, at 11:20:51AM, Ard Biesheuvel wrote:
> From 1179099f89db54294f419493d152083fb8e5af3d Mon Sep 17 00:00:00 2001
> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Date: Tue, 27 Oct 2015 11:12:51 +0900
> Subject: [PATCH] arm64/efi: fix libstub build under CONFIG_MODVERSIONS
> 
> Now that we strictly forbid absolute relocations in libstub code,
> make sure that we don't emit any when CONFIG_MODVERSIONS is enabled,
> by stripping the kcrctab sections from the object file. This fixes
> a build problem under CONFIG_MODVERSIONS=y.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/firmware/efi/libstub/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/libstub/Makefile
> b/drivers/firmware/efi/libstub/Makefile
> index bca9a76cbd33..acc25d7c5da2 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -51,7 +51,7 @@ lib-$(CONFIG_EFI_ARMSTUB) += arm-stub.o fdt.o string.o \
>  extra-$(CONFIG_EFI_ARMSTUB) := $(lib-y)
>  lib-$(CONFIG_EFI_ARMSTUB) := $(patsubst %.o,%.stub.o,$(lib-y))
> 
> -STUBCOPY_FLAGS-y := -R .debug* -R *ksymtab*
> +STUBCOPY_FLAGS-y := -R .debug* -R *ksymtab* -R *kcrctab*
>  STUBCOPY_FLAGS-$(CONFIG_ARM64) += --prefix-alloc-sections=.init \
>     --prefix-symbols=__efistub_
>  STUBCOPY_RELOC-$(CONFIG_ARM64) := R_AARCH64_ABS

I *think* this should be OK.

Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>

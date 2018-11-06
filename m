From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 6 Nov 2018 15:11:18 +0100
Subject: [PATCH 1/4] EFI stub: remove -fdata-sections
In-Reply-To: <E1gK1aT-0000oL-Nn@rmk-PC.armlinux.org.uk>
References: <20181106133935.GB30658@n2100.armlinux.org.uk>
 <E1gK1aT-0000oL-Nn@rmk-PC.armlinux.org.uk>
Message-ID: <CAKv+Gu_-Vqa=TXDzmzorjcPVnxqO3BHvvDyJKViHFLCsnhfeEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 November 2018 at 14:40, Russell King <rmk+kernel@armlinux.org.uk> wrote:
> Remove -fdata-sections from the EFI stub build as this causes problems
> for the ARM decompressor code.
>
Just out of curiosity: what kind of problems?

In any case: it doesn't make sense to obsess about .data size
optimizations here, so

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/firmware/efi/libstub/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index c51627660dbb..98133d0577ab 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -15,7 +15,7 @@ cflags-$(CONFIG_X86)          += -m$(BITS) -D__KERNEL__ -O2 \
>  # disable the stackleak plugin
>  cflags-$(CONFIG_ARM64)         := $(subst -pg,,$(KBUILD_CFLAGS)) -fpie \
>                                    $(DISABLE_STACKLEAK_PLUGIN)
> -cflags-$(CONFIG_ARM)           := $(subst -pg,,$(KBUILD_CFLAGS)) \
> +cflags-$(CONFIG_ARM)           := $(filter-out -pg -fdata-sections,$(KBUILD_CFLAGS)) \
>                                    -fno-builtin -fpic \
>                                    $(call cc-option,-mno-single-pic-base)
>
> --
> 2.7.4
>

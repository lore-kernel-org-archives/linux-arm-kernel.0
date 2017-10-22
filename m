From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 22 Oct 2017 12:01:13 +0100
Subject: [PATCH] ARM: Fix zImage file size not aligned with
 CONFIG_EFI_STUB enabled
In-Reply-To: <20171018050108.10352-1-jeffy.chen@rock-chips.com>
References: <20171018050108.10352-1-jeffy.chen@rock-chips.com>
Message-ID: <CAKv+Gu9ReBC+rLxaD-+Mp+aWRDfsYECAeOZo9CYU3big2nPw0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 October 2017 at 06:01, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
> The zImage file size should be aligned.
>
> Fixes: e4bae4d0b5f3 ("arm/efi: Split zImage code and data into separate PE/COFF sections")
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
>
>  arch/arm/boot/compressed/vmlinux.lds.S | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
> index b38dcef90756..1636fa259577 100644
> --- a/arch/arm/boot/compressed/vmlinux.lds.S
> +++ b/arch/arm/boot/compressed/vmlinux.lds.S
> @@ -70,10 +70,6 @@ SECTIONS
>    .got                 : { *(.got) }
>    _got_end = .;
>
> -  /* ensure the zImage file size is always a multiple of 64 bits */
> -  /* (without a dummy byte, ld just ignores the empty section) */
> -  .pad                 : { BYTE(0); . = ALIGN(8); }
> -
>  #ifdef CONFIG_EFI_STUB
>    .data : ALIGN(4096) {
>      __pecoff_data_start = .;
> @@ -93,6 +89,10 @@ SECTIONS
>    __pecoff_data_rawsize = . - ADDR(.data);
>  #endif
>
> +  /* ensure the zImage file size is always a multiple of 64 bits */
> +  /* (without a dummy byte, ld just ignores the empty section) */
> +  .pad                 : { BYTE(0); . = ALIGN(8); }
> +
>    _edata = .;
>
>    _magic_sig = ZIMAGE_MAGIC(0x016f2818);
> --
> 2.11.0
>

This is not the right fix. If CONFIG_EFI_STUB is enabled, the zImage
filesize should be rounded up to 512 bytes not 8 bytes. The '. =
ALIGN(512);' in the .data section appears to ensure that, but for some
reason, that appears not to be working.

Could you share the output of

$ readelf -S arch/arm/boot/compressed/vmlinux

please? And could you please check whether this patch

https://marc.info/?l=linux-arm-kernel&m=150488477807353

fixes the issue for you?

Thanks,
Ard.

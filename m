From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 28 Nov 2017 16:32:42 +0000
Subject: [PATCH] ARM: verify size of zImage
In-Reply-To: <E1eJiiq-0006k9-FE@rmk-PC.armlinux.org.uk>
References: <E1eJiiq-0006k9-FE@rmk-PC.armlinux.org.uk>
Message-ID: <CAKv+Gu-oXSpUcJ6acBKyohQ3WxSDp3sK7A4No2y4CHCFw1kSaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(+ Gregory)

On 28 November 2017 at 16:27, Russell King <rmk+kernel@armlinux.org.uk> wrote:
> The linker can sometimes add additional sections to the zImage ELF file
> which results in the zImage binary being larger than expected.  This
> causes appended DT blobs to fail.
>
> Verify that the zImage binary is the expected size, and fail the build
> if this is not the case.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
> As this patch is different, I've dropped Matthias' tested-by.  I'd
> appreciate a replacement, thanks.  Also, I seem to remember that
> Ard's toolchain was giving issues - maybe this alternative will
> finally resolve them.
>

$ nm arch/arm/boot/compressed/vmlinux |grep _edata
007b8200 D _edata
007b8200 D _edata_real

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

although I don't remember seeing this fail. It think it may have been
Gregory who was having these issues?



>  arch/arm/boot/compressed/vmlinux.lds.S | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
> index e6bf6774c4bb..ed53ca9f482e 100644
> --- a/arch/arm/boot/compressed/vmlinux.lds.S
> +++ b/arch/arm/boot/compressed/vmlinux.lds.S
> @@ -101,6 +101,12 @@ SECTIONS
>     * this symbol allows further debug in the near future.
>     */
>    .image_end (NOLOAD) : {
> +    /*
> +     * EFI requires that the image is aligned to 512 bytes, and appended
> +     * DTB requires that we know where the end of the image is.  Ensure
> +     * that both are satisfied by ensuring that there are no additional
> +     * sections emitted into the decompressor image.
> +     */
>      _edata_real = .;
>    }
>
> @@ -128,3 +134,4 @@ SECTIONS
>    .stab.indexstr 0     : { *(.stab.indexstr) }
>    .comment 0           : { *(.comment) }
>  }
> +ASSERT(_edata_real == _edata, "error: zImage file size is incorrect");
> --
> 2.7.4
>

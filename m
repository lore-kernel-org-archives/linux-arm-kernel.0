From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 14 Jan 2014 10:05:25 +0100
Subject: [PATCH V6 6/8] Add EFI stub for ARM
In-Reply-To: <1389371417-379-7-git-send-email-roy.franz@linaro.org>
References: <1389371417-379-1-git-send-email-roy.franz@linaro.org>
 <1389371417-379-7-git-send-email-roy.franz@linaro.org>
Message-ID: <CAKv+Gu9OfieNhvj07tQv+ucQomZhDVDxwdV3Z9Tm+HaHE8HG-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 January 2014 17:30, Roy Franz <roy.franz@linaro.org> wrote:
> This patch adds EFI stub support for the ARM Linux kernel.  The EFI stub
> operates similarly to the x86 stub: it is a shim between the EFI firmware
> and the normal zImage entry point, and sets up the environment that the
> zImage is expecting.  This includes loading the initrd (optionaly) and
> device tree from the system partition based on the kernel command line.
> The stub updates the device tree as necessary, adding entries for EFI
> runtime services. The PE/COFF "MZ" header at offset 0 results in the
> first instruction being an add that corrupts r5, which is not used by
> the zImage interface.
>
> Signed-off-by: Roy Franz <roy.franz@linaro.org>
> Acked-by: Grant Likely <grant.likely@linaro.org>
> ---

[...]

> diff --git a/arch/arm/boot/compressed/efi-header.S b/arch/arm/boot/compressed/efi-header.S
> new file mode 100644
> index 0000000..dbb7101
> --- /dev/null
> +++ b/arch/arm/boot/compressed/efi-header.S
> @@ -0,0 +1,117 @@
> +@ Copyright (C) 2013 Linaro Ltd;  <roy.franz@linaro.org>
> +@
> +@ This file contains the PE/COFF header that is part of the
> +@ EFI stub.
> +@
> +
> +       .org    0x3c
> +       @
> +       @ The PE header can be anywhere in the file, but for
> +       @ simplicity we keep it together with the MSDOS header
> +       @ The offset to the PE/COFF header needs to be at offset
> +       @ 0x3C in the MSDOS header.
> +       @ The only 2 fields of the MSDOS header that are used are this
> +       @ PE/COFF offset, and the "MZ" bytes at offset 0x0.
> +       @
> +       .long   pe_header                       @ Offset to the PE header.
> +
> +      .align 3
> +pe_header:
> +       .ascii  "PE"
> +       .short  0
> +
> +coff_header:
> +       .short  0x01c2                          @ ARM or Thumb

Could you explain why you are using 0x1c2 (Thumb) here and not 0x1c0 (ARM) ?

Cheers,
Ard.

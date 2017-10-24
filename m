From: jeffy.chen@rock-chips.com (jeffy)
Date: Tue, 24 Oct 2017 17:16:02 +0800
Subject: [PATCH] ARM: Fix zImage file size not aligned with CONFIG_EFI_STUB
 enabled
In-Reply-To: <CAKv+Gu_R+OfHMxcZEJML4Pm54DyOji6S42LihMgi6+vxi9LOAQ@mail.gmail.com>
References: <20171018050108.10352-1-jeffy.chen@rock-chips.com>
 <CAKv+Gu9ReBC+rLxaD-+Mp+aWRDfsYECAeOZo9CYU3big2nPw0w@mail.gmail.com>
 <20171022124757.GL20805@n2100.armlinux.org.uk>
 <CAKv+Gu9cgt0sjW_pnaXN6J8j8BXAb7z+gLhDY3oMaKwK5vcO-Q@mail.gmail.com>
 <59ED6179.5020301@rock-chips.com>
 <20171023085006.GM20805@n2100.armlinux.org.uk>
 <59EDC34C.40109@rock-chips.com>
 <20171023105046.GT20805@n2100.armlinux.org.uk>
 <20171023114549.GU20805@n2100.armlinux.org.uk>
 <CAKv+Gu_R+OfHMxcZEJML4Pm54DyOji6S42LihMgi6+vxi9LOAQ@mail.gmail.com>
Message-ID: <59EF04D2.20102@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

On 10/24/2017 04:09 PM, Ard Biesheuvel wrote:
> The following patch appears to fix the issue as well:
>
> diff --git a/arch/arm/boot/compressed/vmlinux.lds.S
> b/arch/arm/boot/compressed/vmlinux.lds.S
> index 7a4c59154361..0e0f504e256e 100644
> --- a/arch/arm/boot/compressed/vmlinux.lds.S
> +++ b/arch/arm/boot/compressed/vmlinux.lds.S
> @@ -83,7 +83,9 @@ SECTIONS
>     __pecoff_data_rawsize = . - ADDR(.data);
>   #endif
>
> -  _edata = .;
> +  .edata (NOLOAD) : {
> +    _edata = .;
> +  }
>
>     _magic_sig = ZIMAGE_MAGIC(0x016f2818);
>     _magic_start = ZIMAGE_MAGIC(_start);
>
> because the NOLOAD triggers the linker to emit all PROGBITS sections
> before _edata, including unknown ones.
>
> E.g., in my binary, it gives me
>
> 00798020 D __pecoff_data_end
> 00798200 d __ksymtab_sort
> 00798208 B __bss_start
> 00798208 D _edata

this works too:

+++ b/arch/arm/boot/compressed/vmlinux.lds.S
@@ -70,10 +70,6 @@ SECTIONS
    .got                 : { *(.got) }
    _got_end = .;

-  /* ensure the zImage file size is always a multiple of 64 bits */
-  /* (without a dummy byte, ld just ignores the empty section) */
-  .pad                 : { BYTE(0); . = ALIGN(8); }
-
  #ifdef CONFIG_EFI_STUB
    .data : ALIGN(4096) {
      __pecoff_data_start = .;
@@ -93,7 +89,10 @@ SECTIONS
    __pecoff_data_rawsize = . - ADDR(.data);
  #endif

-  _edata = .;
+  /* ensure the zImage file size is always a multiple of 64 bits */
+  .edata : ALIGN(8) {
+    _edata = .;
+  }



    339: 006cf200     8 OBJECT  LOCAL  DEFAULT    9 __ksymtab_sort
...
    528: 006cf208     0 NOTYPE  GLOBAL DEFAULT    9 _edata

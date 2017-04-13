From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 13 Apr 2017 08:26:04 +0100
Subject: [PATCH v2] efi: Config options to assign versions in the PE-COFF
 header
In-Reply-To: <20170413035827.9820-1-glin@suse.com>
References: <20170413035827.9820-1-glin@suse.com>
Message-ID: <CAKv+Gu8ZS1rdDwLrspv_VnYHOfxkdxUpZe_h1Sw3-N2SBpeJ5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 April 2017 at 04:58, Gary Lin <glin@suse.com> wrote:
> This commit adds the new config options to allow the user to modify the
> following fields in the PE-COFF header.
>
> UINT16 MajorOperatingSystemVersion
> UINT16 MinorOperatingSystemVersion
> UINT16 MajorImageVersion
> UINT16 MinorImageVersion
>
> Those fields are mainly for the executables or libraries in Windows NT
> or higher to specify the minimum supported Windows version and the
> version of the image itself.
>
> Given the fact that those fields are ignored in UEFI, we can safely reuse
> those fields for other purposes, e.g. Security Version(*).
>
> (*) https://github.com/lcp/shim/wiki/Security-Version
>
> v2 changes:
> - Modify the header direct instead of using an external script as
>   suggested by Ard Biesheuvel
> - Include arm and arm64
>

Thanks for the update. Could we put the Kconfig changes in
drivers/firmware/efi/Kconfig, rather than duplicating them 3 times?

> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Matt Fleming <matt@codeblueprint.co.uk>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Joey Lee <jlee@suse.com>
> Cc: Vojtech Pavlik <vojtech@suse.cz>
> Signed-off-by: Gary Lin <glin@suse.com>
> ---
>  arch/arm/Kconfig                      | 24 ++++++++++++++++++++++++
>  arch/arm/boot/compressed/efi-header.S |  8 ++++----
>  arch/arm64/Kconfig                    | 24 ++++++++++++++++++++++++
>  arch/arm64/kernel/head.S              |  8 ++++----
>  arch/x86/Kconfig                      | 24 ++++++++++++++++++++++++
>  arch/x86/boot/header.S                |  8 ++++----
>  6 files changed, 84 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 0d4e71b42c77..4965ad2ccc23 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -2090,6 +2090,30 @@ config EFI
>           is only useful for kernels that may run on systems that have
>           UEFI firmware.
>
> +config EFI_MAJOR_OS
> +       hex "EFI Major OS Version"
> +       range 0x0 0xFFFF
> +       default "0x0"
> +       depends on EFI_STUB
> +
> +config EFI_MINOR_OS
> +       hex "EFI Minor OS Version"
> +       range 0x0 0xFFFF
> +       default "0x0"
> +       depends on EFI_STUB
> +
> +config EFI_MAJOR_IMAGE
> +       hex "EFI Major Image Version"
> +       range 0x0 0xFFFF
> +       default "0x0"
> +       depends on EFI_STUB
> +
> +config EFI_MINOR_IMAGE
> +       hex "EFI Minor Image Version"
> +       range 0x0 0xFFFF
> +       default "0x0"
> +       depends on EFI_STUB
> +
>  endmenu
>
>  menu "CPU Power Management"
> diff --git a/arch/arm/boot/compressed/efi-header.S b/arch/arm/boot/compressed/efi-header.S
> index 9d5dc4fda3c1..67715472a76f 100644
> --- a/arch/arm/boot/compressed/efi-header.S
> +++ b/arch/arm/boot/compressed/efi-header.S
> @@ -69,10 +69,10 @@ extra_header_fields:
>                 .long   0                       @ ImageBase
>                 .long   0x200                   @ SectionAlignment
>                 .long   0x200                   @ FileAlignment
> -               .short  0                       @ MajorOperatingSystemVersion
> -               .short  0                       @ MinorOperatingSystemVersion
> -               .short  0                       @ MajorImageVersion
> -               .short  0                       @ MinorImageVersion
> +               .short  CONFIG_EFI_MAJOR_OS     @ MajorOperatingSystemVersion
> +               .short  CONFIG_EFI_MINOR_OS     @ MinorOperatingSystemVersion
> +               .short  CONFIG_EFI_MAJOR_IMAGE  @ MajorImageVersion
> +               .short  CONFIG_EFI_MINOR_IMAGE  @ MinorImageVersion
>                 .short  0                       @ MajorSubsystemVersion
>                 .short  0                       @ MinorSubsystemVersion
>                 .long   0                       @ Win32VersionValue
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 3741859765cf..c782c422e58c 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1033,6 +1033,30 @@ config EFI
>           allow the kernel to be booted as an EFI application. This
>           is only useful on systems that have UEFI firmware.
>
> +config EFI_MAJOR_OS
> +       hex "EFI Major OS Version"
> +       range 0x0 0xFFFF
> +       default "0x0"
> +       depends on EFI_STUB
> +
> +config EFI_MINOR_OS
> +       hex "EFI Minor OS Version"
> +       range 0x0 0xFFFF
> +       default "0x0"
> +       depends on EFI_STUB
> +
> +config EFI_MAJOR_IMAGE
> +       hex "EFI Major Image Version"
> +       range 0x0 0xFFFF
> +       default "0x0"
> +       depends on EFI_STUB
> +
> +config EFI_MINOR_IMAGE
> +       hex "EFI Minor Image Version"
> +       range 0x0 0xFFFF
> +       default "0x0"
> +       depends on EFI_STUB
> +
>  config DMI
>         bool "Enable support for SMBIOS (DMI) tables"
>         depends on EFI
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 4fb6ccd886d1..9faa4b04d0ef 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -129,10 +129,10 @@ extra_header_fields:
>         .quad   0                               // ImageBase
>         .long   0x1000                          // SectionAlignment
>         .long   PECOFF_FILE_ALIGNMENT           // FileAlignment
> -       .short  0                               // MajorOperatingSystemVersion
> -       .short  0                               // MinorOperatingSystemVersion
> -       .short  0                               // MajorImageVersion
> -       .short  0                               // MinorImageVersion
> +       .short  CONFIG_EFI_MAJOR_OS             // MajorOperatingSystemVersion
> +       .short  CONFIG_EFI_MINOR_OS             // MinorOperatingSystemVersion
> +       .short  CONFIG_EFI_MAJOR_IMAGE          // MajorImageVersion
> +       .short  CONFIG_EFI_MINOR_IMAGE          // MinorImageVersion
>         .short  0                               // MajorSubsystemVersion
>         .short  0                               // MinorSubsystemVersion
>         .long   0                               // Win32VersionValue
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 5bbdef151805..233933fde7dd 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1803,6 +1803,30 @@ config EFI_STUB
>
>           See Documentation/efi-stub.txt for more information.
>
> +config EFI_MAJOR_OS
> +       hex "EFI Major OS Version"
> +       range 0x0 0xFFFF
> +       default "0x0"
> +       depends on EFI_STUB
> +
> +config EFI_MINOR_OS
> +       hex "EFI Minor OS Version"
> +       range 0x0 0xFFFF
> +       default "0x0"
> +       depends on EFI_STUB
> +
> +config EFI_MAJOR_IMAGE
> +       hex "EFI Major Image Version"
> +       range 0x0 0xFFFF
> +       default "0x0"
> +       depends on EFI_STUB
> +
> +config EFI_MINOR_IMAGE
> +       hex "EFI Minor Image Version"
> +       range 0x0 0xFFFF
> +       default "0x0"
> +       depends on EFI_STUB
> +
>  config EFI_MIXED
>         bool "EFI mixed-mode support"
>         depends on EFI_STUB && X86_64
> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> index 3dd5be33aaa7..863813007207 100644
> --- a/arch/x86/boot/header.S
> +++ b/arch/x86/boot/header.S
> @@ -156,10 +156,10 @@ extra_header_fields:
>  #endif
>         .long   0x20                            # SectionAlignment
>         .long   0x20                            # FileAlignment
> -       .word   0                               # MajorOperatingSystemVersion
> -       .word   0                               # MinorOperatingSystemVersion
> -       .word   0                               # MajorImageVersion
> -       .word   0                               # MinorImageVersion
> +       .word   CONFIG_EFI_MAJOR_OS             # MajorOperatingSystemVersion
> +       .word   CONFIG_EFI_MINOR_OS             # MinorOperatingSystemVersion
> +       .word   CONFIG_EFI_MAJOR_IMAGE          # MajorImageVersion
> +       .word   CONFIG_EFI_MINOR_IMAGE          # MinorImageVersion
>         .word   0                               # MajorSubsystemVersion
>         .word   0                               # MinorSubsystemVersion
>         .long   0                               # Win32VersionValue
> --
> 2.12.0
>

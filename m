From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 16 Jun 2016 14:04:48 +0200
Subject: [PATCH v2] ARM: mm: fix location of _etext
In-Reply-To: <20160615202447.GA5005@www.outflux.net>
References: <20160615202447.GA5005@www.outflux.net>
Message-ID: <CAKv+Gu-my1pd43WO=A_gQFgvtG3efYD97Fh8P-vG93G9zmPynw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 June 2016 at 22:24, Kees Cook <keescook@chromium.org> wrote:
> The _etext position is defined to be the end of the kernel text code,
> and should not include any part of the data segments. This interferes
> with things that might check memory ranges and expect executable code
> up to _etext. Just to be conservative, leave the kernel resource as
> it was, using __init_begin instead of _etext as the end mark.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2:
> - Switched resource tracker to using __init_begin, rmk

Actually, Linus removed the x86 /proc/iomem resources for kernel segments in

c4004b02f8e5 ("x86: remove the kernel code/data/bss resources from /proc/iomem")

so I wonder if we should not just do the same for ARM and arm64?



> ---
>  arch/arm/kernel/setup.c       | 2 +-
>  arch/arm/kernel/vmlinux.lds.S | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 7b5350060612..dd84f03dc2d4 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -844,7 +844,7 @@ static void __init request_standard_resources(const struct machine_desc *mdesc)
>         struct resource *res;
>
>         kernel_code.start   = virt_to_phys(_text);
> -       kernel_code.end     = virt_to_phys(_etext - 1);
> +       kernel_code.end     = virt_to_phys(__init_begin - 1);
>         kernel_data.start   = virt_to_phys(_sdata);
>         kernel_data.end     = virt_to_phys(_end - 1);
>
> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index e2c6da096cef..99420fc1f066 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -125,6 +125,8 @@ SECTIONS
>  #ifdef CONFIG_DEBUG_ALIGN_RODATA
>         . = ALIGN(1<<SECTION_SHIFT);
>  #endif
> +       _etext = .;                     /* End of text section */
> +
>         RO_DATA(PAGE_SIZE)
>
>         . = ALIGN(4);
> @@ -155,8 +157,6 @@ SECTIONS
>
>         NOTES
>
> -       _etext = .;                     /* End of text and rodata section */
> -
>  #ifdef CONFIG_DEBUG_RODATA
>         . = ALIGN(1<<SECTION_SHIFT);
>  #else
> --
> 2.7.4
>
>
> --
> Kees Cook
> Chrome OS & Brillo Security

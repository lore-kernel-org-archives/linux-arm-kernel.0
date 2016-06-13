From: keescook@chromium.org (Kees Cook)
Date: Mon, 13 Jun 2016 13:23:29 -0700
Subject: [PATCH] ARM: mm: fix location of _etext
In-Reply-To: <20160608231158.GA12159@www.outflux.net>
References: <20160608231158.GA12159@www.outflux.net>
Message-ID: <CAGXu5jJwtDqLALk+3QETK7Wia56yxFp30nO7vwwbNX49s5KVmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 8, 2016 at 4:11 PM, Kees Cook <keescook@chromium.org> wrote:
> The _etext position is defined to be the end of the kernel text code,
> and should not include any part of the data segments. This interferes
> with things that might check memory ranges and expect executable code
> up to _etext.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Can someone give this an Ack? I'd like to land it as it is a
prerequisite to some usercopy hardening work I'm doing.

Thanks!

-Kees

> ---
> arm64 needs this fixed too, but it has other assumptions built onto
> _etext that should be using different markers.
> ---
>  arch/arm/kernel/vmlinux.lds.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
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



-- 
Kees Cook
Chrome OS & Brillo Security

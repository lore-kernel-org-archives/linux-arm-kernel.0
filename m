From: keescook@chromium.org (Kees Cook)
Date: Tue, 16 Feb 2016 10:41:09 -0800
Subject: [PATCH 1/2] ARM: mm: DEBUG_RODATA makes no sense with XIP_KERNEL
In-Reply-To: <1455638631-3326518-1-git-send-email-arnd@arndb.de>
References: <1455638631-3326518-1-git-send-email-arnd@arndb.de>
Message-ID: <CAGXu5jJ84FupuH2Zq8TVKNTS3zMTYZiBaSbjWZWWZ1ApBzBtwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 8:03 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> When CONFIG_DEBUG_ALIGN_RODATA is set, we get a link error:
>
> arch/arm/mm/built-in.o:(.data+0x4bc): undefined reference to `__start_rodata_section_aligned'
>
> However, this combination is useless, as XIP_KERNEL implies that all the
> RODATA is already marked readonly, so both CONFIG_DEBUG_RODATA and
> CONFIG_DEBUG_ALIGN_RODATA (which depends on the other) are not
> needed with XIP_KERNEL, and this patches enforces that using a Kconfig
> dependency.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 25362dc496ed ("ARM: 8501/1: mm: flip priority of CONFIG_DEBUG_RODATA")

Oh, hm, I didn't see this before sending my fix for the rodata start issue.

> ---
>  arch/arm/mm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index fbf2296388ce..8894045caba9 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -1039,7 +1039,7 @@ config ARCH_SUPPORTS_BIG_ENDIAN
>
>  config DEBUG_RODATA
>         bool "Make kernel text and rodata read-only"
> -       depends on MMU
> +       depends on MMU && !XIP_KERNEL

If we do this, we need to probably clean up the xip linker script to
remove all the references to DEBUG_*RODATA too.

-Kees

>         default y if CPU_V7
>         help
>           If this is set, kernel text and rodata memory will be made
> --
> 2.7.0
>



-- 
Kees Cook
Chrome OS & Brillo Security

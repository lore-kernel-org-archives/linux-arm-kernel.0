From: keescook@chromium.org (Kees Cook)
Date: Fri, 3 Feb 2017 11:45:56 -0800
Subject: [PATCHv2 1/2] arch: Move CONFIG_DEBUG_RODATA and
 CONFIG_SET_MODULE_RONX to be common
In-Reply-To: <1486144343-24998-2-git-send-email-labbott@redhat.com>
References: <1486144343-24998-1-git-send-email-labbott@redhat.com>
 <1486144343-24998-2-git-send-email-labbott@redhat.com>
Message-ID: <CAGXu5jK6_y=dWHUDBto7ykN_sSOQ6Gx+sZs_gQ1Hoh5DjP-fTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 3, 2017 at 9:52 AM, Laura Abbott <labbott@redhat.com> wrote:
> There are multiple architectures that support CONFIG_DEBUG_RODATA and
> CONFIG_SET_MODULE_RONX. These options also now have the ability to be
> turned off at runtime. Move these to an architecture independent
> location and make these options def_bool y for almost all of those
> arches.
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v2: This patch is now doing just the refactor of the existing config options.
> ---
>  arch/Kconfig              | 28 ++++++++++++++++++++++++++++
>  arch/arm/Kconfig          |  3 +++
>  arch/arm/Kconfig.debug    | 11 -----------
>  arch/arm/mm/Kconfig       | 12 ------------
>  arch/arm64/Kconfig        |  5 ++---
>  arch/arm64/Kconfig.debug  | 11 -----------
>  arch/parisc/Kconfig       |  1 +
>  arch/parisc/Kconfig.debug | 11 -----------
>  arch/s390/Kconfig         |  5 ++---
>  arch/s390/Kconfig.debug   |  3 ---
>  arch/x86/Kconfig          |  5 ++---
>  arch/x86/Kconfig.debug    | 11 -----------
>  12 files changed, 38 insertions(+), 68 deletions(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 99839c2..22ee01e 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -781,4 +781,32 @@ config VMAP_STACK
>           the stack to map directly to the KASAN shadow map using a formula
>           that is incorrect if the stack is in vmalloc space.
>
> +config ARCH_NO_STRICT_RWX_DEFAULTS
> +       def_bool n
> +
> +config ARCH_HAS_STRICT_KERNEL_RWX
> +       def_bool n
> +
> +config DEBUG_RODATA
> +       def_bool y if !ARCH_NO_STRICT_RWX_DEFAULTS
> +       prompt "Make kernel text and rodata read-only" if ARCH_NO_STRICT_RWX_DEFAULTS

Ah! Yes, perfect. I totally forgot about using conditional "prompt" lines. Nice!

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security

From: keescook@chromium.org (Kees Cook)
Date: Thu, 19 Jan 2017 13:57:52 -0800
Subject: [PATCH 1/2] security: Change name of CONFIG_DEBUG_RODATA
In-Reply-To: <1484789346-21012-2-git-send-email-labbott@redhat.com>
References: <1484789346-21012-1-git-send-email-labbott@redhat.com>
 <1484789346-21012-2-git-send-email-labbott@redhat.com>
Message-ID: <CAGXu5jJxDAZJZtVCHX+RmLUHz8s4ZxBPvYadpswmZwjvCmjFEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 5:29 PM, Laura Abbott <labbott@redhat.com> wrote:
>
> Despite the word 'debug' in CONFIG_DEBUG_RODATA, this kernel option
> provides key security features that are to be expected on a modern
> system. Change the name to CONFIG_HARDENED_PAGE_MAPPINGS which more
> accurately describes what this option is intended to do.

Oh thank you. Yes, this is badly needed. I might prefer to see this as
two patches, though:

Move DEBUG_RODATA to top-level arch/Kconfig, (and add ARCH_HAS_[bikeshed]).
Rename DEBUG_RODATA to [bikeshed]

(We should do a similar renaming for DEBUG_SET_MODULE_RONX too.)

Another thing that might be even cleaner would be to entirely invert
the logic. Something like CONFIG_ARCH_MISSING_[bikeshed]?

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 186c4c2..09aff28 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -7,6 +7,7 @@ config ARM
>         select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>         select ARCH_HAVE_CUSTOM_GPIO_H
>         select ARCH_HAS_GCOV_PROFILE_ALL
> +       select ARCH_HAS_HARDENED_MAPPINGS if MMU && !XIP_KERNEL
>         select ARCH_MIGHT_HAVE_PC_PARPORT
>         select ARCH_SUPPORTS_ATOMIC_RMW
>         select ARCH_USE_BUILTIN_BSWAP
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index f68e8ec..e770dc9 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -1051,21 +1051,9 @@ config ARCH_SUPPORTS_BIG_ENDIAN
>           This option specifies the architecture can support big endian
>           operation.
>
> -config DEBUG_RODATA
> -       bool "Make kernel text and rodata read-only"
> -       depends on MMU && !XIP_KERNEL
> -       default y if CPU_V7

These changes aren't correctly representing the ARM state. I think the
ARCH_HAS is correct, but I'm not sure the best way to include the
"default y if CPU_V7".

> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -158,6 +158,22 @@ config HARDENED_USERCOPY_PAGESPAN
>           been removed. This config is intended to be used only while
>           trying to find such users.
>
> +config ARCH_HAS_HARDENED_MAPPINGS
> +       def_bool n
> +
> +config HARDENED_PAGE_MAPPINGS
> +       bool "Mark kernel mappings with stricter permissions (RO/W^X)"
> +       default y
> +       depends on ARCH_HAS_HARDENED_MAPPINGS
> +       help
> +          If this is set, kernel text and rodata memory will be made read-only,
> +         and non-text memory will be made non-executable. This provides
> +         protection against certain security attacks (e.g. executing the heap
> +         or modifying text).
> +
> +         Unless your system has known restrictions or performance issues, it
> +         is recommended to say Y here.
> +
>  source security/selinux/Kconfig
>  source security/smack/Kconfig
>  source security/tomoyo/Kconfig

Should this go in arch/Kconfig or security/Kconfig? I'm starting to
think we need a top-level kernel security Kconfig (the gcc plugins are
starting to pile up in arch/Kconfig, for example). I think since this
is arch specific, maybe arch/Kconfig? (Arguably, HARDENED_USERCOPY
shouldn't be in security/Kconfig either, since security/Kconfig is
mostly LSM or userspace-facing stuff? I dunno.)

As for the bikeshed on the naming, I like "KERNEL_RWX", and it likely
doesn't need "STRICT", IMO. CONFIG_KERNEL_RWX ? I don't have a strong
opinion beyond removing "DEBUG" from the name. :)

-Kees

-- 
Kees Cook
Nexus Security

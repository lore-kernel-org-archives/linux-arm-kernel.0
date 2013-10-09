From: keescook@chromium.org (Kees Cook)
Date: Wed, 9 Oct 2013 13:04:14 -0700
Subject: [RFC PATCH 1/5] arm: mm: add CONFIG_STRICT_MEMORY_RWX
In-Reply-To: <1381282292-25251-2-git-send-email-lauraa@codeaurora.org>
References: <1381282292-25251-1-git-send-email-lauraa@codeaurora.org>
 <1381282292-25251-2-git-send-email-lauraa@codeaurora.org>
Message-ID: <CAGXu5jJiS0vGBLjSmT37TaAn9xx+ov0QFqkZ0DaqGa0k3ffP0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 8, 2013 at 6:31 PM, Laura Abbott <lauraa@codeaurora.org> wrote:
> From: Larry Bassel <lbassel@codeaurora.org>
>
> If this is set, kernel text will be made RX, kernel data and stack
> RW, rodata R so that writing to kernel text, executing kernel data
> or stack, or writing to read-only data or kernel text will not
> succeed.
>
> Signed-off-by: Larry Bassel <lbassel@codeaurora.org>
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> ---
>  arch/arm/mm/Kconfig |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index cd2c88e..c223d5c 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -952,3 +952,15 @@ config ARCH_HAS_BARRIERS
>         help
>           This option allows the use of custom mandatory barriers
>           included via the mach/barriers.h file.
> +
> +config STRICT_MEMORY_RWX
> +       bool "restrict kernel memory permissions as much as possible"
> +       default n
> +       help
> +         If this is set, kernel text will be made RX, kernel data and stack
> +         RW, rodata R (otherwise all of the kernel 1-to-1 mapping is
> +         made RWX).
> +         The tradeoff is that several sections are padded to
> +         1M boundaries (because their permissions are different and
> +         splitting the 1M pages into 4K ones causes TLB performance
> +         problems), wasting memory.
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
>

As a bike-shedding aside, would it make sense to attempt to follow the
x86 CONFIG naming convention for this? I don't like that x86's has
"DEBUG" in the name, but it might be nice for people looking for a
single name for these things. Unfortunately, x86 already has two:

CONFIG_DEBUG_RODATA
CONFIG_DEBUG_SET_MODULE_RONX

It'd be nice to have a common set, I think.

-Kees

-- 
Kees Cook
Chrome OS Security

From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Aug 2010 05:04:59 +0200
Subject: [PATCH] ARM: uaccess: Implement strict user copy checks
In-Reply-To: <1280890950-19174-1-git-send-email-sboyd@codeaurora.org>
References: <1280890950-19174-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <201008110504.59957.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 August 2010, Stephen Boyd wrote:
> +config DEBUG_STRICT_USER_COPY_CHECKS
> +       bool "Strict user copy size checks"
> +       depends on DEBUG_KERNEL
> +       help
> +         Enabling this option turns a certain set of sanity checks for user
> +         copy operations into compile time errors.
> +
> +         The copy_from_user() etc checks are there to help test if there
> +         are sufficient security checks on the length argument of
> +         the copy operation, by having gcc prove that the argument is
> +         within bounds.
> +
> +         If unsure, or if you run an older (pre 4.4) gcc, say N.
> +

Do you actually need to disable this if running an older gcc? AFAICT, it
should just have no effect at all in that case, so the comment is slightly
misleading.

Also, why turn this specific warning into an error but not any of the other
warnings? Some architectures (alpha, sparc, mips, powerpc, sh) simply turn
on -Werror for architecture specific code in general, which seems very
useful. We can also make that a config option (probably arch independent)
that we turn on for defconfig files that we know build without warnings.

Unfortunately, there is a number of device drivers that have never been
warning-free, so we can't just enable -Werror for all code.

	Arnd

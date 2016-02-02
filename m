From: ryabinin.a.a@gmail.com (Andrey Ryabinin)
Date: Tue, 2 Feb 2016 19:02:49 +0300
Subject: [PATCH v6] kernel: add kcov code coverage
In-Reply-To: <1453726850-49137-1-git-send-email-dvyukov@google.com>
References: <1453726850-49137-1-git-send-email-dvyukov@google.com>
Message-ID: <CAPAsAGz6vVGfAPSimwqkneUmzMmrwX_WxdCoQ1xg3UyNn4+-eQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-01-25 16:00 GMT+03:00 Dmitry Vyukov <dvyukov@google.com>:

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index ecb9e75..cde6bd1 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -678,6 +678,26 @@ config DEBUG_STACKOVERFLOW
>
>           If in doubt, say "N".
>
> +config ARCH_HAS_KCOV
> +       bool
> +       help
> +         KCOV does not have any arch-specific code, but currently it is enabled
> +         only for x86_64. KCOV requires testing on other archs, and most likely
> +         disabling of instrumentation for some early boot code.
> +
> +config KCOV
> +       bool "Code coverage for fuzzing"
> +       depends on ARCH_HAS_KCOV

I think we should select DEBUG_FS here, since this useless without it.
Also you placed this into 'Memory Debugging' submenu which seems wrong.

> +       help
> +         KCOV exposes kernel code coverage information in a form suitable
> +         for coverage-guided fuzzing (randomized testing).
> +
> +         If RANDOMIZE_BASE is enabled, PC values will not be stable across
> +         different machines and across reboots. If you need stable PC values,
> +         disable RANDOMIZE_BASE.
> +
> +         For more details, see Documentation/kcov.txt.
> +
>  source "lib/Kconfig.kmemcheck"
>

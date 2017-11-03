From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 3 Nov 2017 20:09:42 +0000
Subject: [PATCH 13/15] arm64: add a workaround for GNU gold with
 ARM64_MODULE_PLTS
In-Reply-To: <20171103171203.107569-17-samitolvanen@google.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
 <20171103171203.107569-17-samitolvanen@google.com>
Message-ID: <CAKv+Gu_cov8S0CbgeKq8PQBU8Z2pKJGqgYtXK1oE2ieB3VesKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 November 2017 at 17:12, Sami Tolvanen <samitolvanen@google.com> wrote:
> CONFIG_CLANG_LTO depends on GNU gold and due to a known bug, the
> linker crashes when ARM64_MODULE_PLTS is enabled:
>
>   https://sourceware.org/bugzilla/show_bug.cgi?id=14592
>
> To work around the problem, this change:
>
>   1) Enables ARM64_MODULE_PLTS only when it's needed, i.e. when
>      RANDOMIZE_MODULE_REGION_FULL is selected,
>

This is not true. Even when RANDOMIZE_MODULE_REGION_FULL is not
enabled, we may need module PLTs.

When the module region is randomized, it shares its chunk of vmalloc
space with other users, and so there is a [low] probability that the
module region we choose is used up by vmalloc/vmap/ioremap
allocations, and so we need to be able to fall back to the general
vmalloc space.

>   2) and disables RANDOMIZE_MODULE_REGION_FULL with clang LTO.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/arm64/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 43ccddb7c8ec..a301fdc90319 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -997,8 +997,8 @@ config RELOCATABLE
>
>  config RANDOMIZE_BASE
>         bool "Randomize the address of the kernel image"
> -       select ARM64_MODULE_PLTS if MODULES
>         select RELOCATABLE
> +       select ARM64_MODULE_PLTS if RANDOMIZE_MODULE_REGION_FULL
>         help
>           Randomizes the virtual address at which the kernel image is
>           loaded, as a security feature that deters exploit attempts
> @@ -1016,7 +1016,7 @@ config RANDOMIZE_BASE
>
>  config RANDOMIZE_MODULE_REGION_FULL
>         bool "Randomize the module region independently from the core kernel"
> -       depends on RANDOMIZE_BASE
> +       depends on RANDOMIZE_BASE && !CLANG_LTO
>         default y
>         help
>           Randomizes the location of the module region without considering the
> --
> 2.15.0.403.gc27cc4dac6-goog
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

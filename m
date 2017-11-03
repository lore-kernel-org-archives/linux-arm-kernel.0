From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 3 Nov 2017 20:13:20 +0000
Subject: [PATCH 10/15] arm64: disable ARM64_ERRATUM_843419 for clang LTO
In-Reply-To: <20171103171203.107569-12-samitolvanen@google.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
 <20171103171203.107569-12-samitolvanen@google.com>
Message-ID: <CAKv+Gu8JmZ_V2aq6+TGgjyJ_ndjj8znu97E0iri+aa-FXxr9uA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 November 2017 at 17:11, Sami Tolvanen <samitolvanen@google.com> wrote:
> CONFIG_CLANG_LTO depends on GNU gold, which can generate ADR_PREL_PG_HI21
> relocations even with --fix-cortex-a53-843419.
>
> Since ARM64_ERRATUM_843419 disables kernel support for these relocations,
> disable the erratum when LTO is used.
>

I wonder it makes sense to disable such relocations entirely when we
enable this erratum. If the toolchain does not generate them, they
shouldn't occur in the first place, and having this dependency here
seems awkward as well.

> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 0df64a6a56d4..43ccddb7c8ec 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -433,6 +433,7 @@ config ARM64_ERRATUM_845719
>
>  config ARM64_ERRATUM_843419
>         bool "Cortex-A53: 843419: A load or store might access an incorrect address"
> +       depends on !CLANG_LTO
>         default y
>         select ARM64_MODULE_CMODEL_LARGE if MODULES
>         help
> --
> 2.15.0.403.gc27cc4dac6-goog
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

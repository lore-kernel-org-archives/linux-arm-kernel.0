From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 19 Nov 2015 13:18:38 +0900
Subject: [PATCH 1/2] clk: samsung: Don't build ARMv8 clock drivers on ARMv7
In-Reply-To: <1447637775-9887-2-git-send-email-k.kozlowski@samsung.com>
References: <1447637775-9887-1-git-send-email-k.kozlowski@samsung.com>
 <1447637775-9887-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <CA+Ln22HAGwfPDqXBQatBraLd=DyGYF2WyV4wJ9RvGOc58puymQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

Good idea, just a couple of nits inline. Other than that:

Acked-by: Tomasz Figa <tomasz.figa@gmail.com>

2015-11-16 10:36 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
> Currently the Exynos5433 (ARMv8 SoC) clock driver depends on ARCH_EXYNOS
> so it is built also on ARMv7. This does not bring any kind of benefit.
> There won't be a single kernel image for ARMv7 and ARMv8 SoCs (like
> multi_v7 for ARMv7).
>
> Instead build clock drivers only for respective SoC's architecture.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/clk/samsung/Kconfig  | 13 +++++++++++++
>  drivers/clk/samsung/Makefile |  4 ++--
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/samsung/Kconfig b/drivers/clk/samsung/Kconfig
> index 84196ecdaa12..5f138fc4d84d 100644
> --- a/drivers/clk/samsung/Kconfig
> +++ b/drivers/clk/samsung/Kconfig
> @@ -2,6 +2,7 @@ config COMMON_CLK_SAMSUNG
>         bool
>         select COMMON_CLK
>
> +# ARMv7 SoCs:

nit: I'm not aware of any recent upgrade of the S3C24xx line-up to
ARMv7 cores. ;) I'd suggest "32-bit ARM SoCs" or just "ARM SoCs"...

>  config S3C2410_COMMON_CLK
>         bool
>         select COMMON_CLK_SAMSUNG
> @@ -24,3 +25,15 @@ config S3C2443_COMMON_CLK
>         bool
>         select COMMON_CLK_SAMSUNG
>
> +# ARMv8 SoCs:

and then here "64-bit ARM SoCs" or "ARM64 SoCs", whichever you prefer.
I'd lean towards simple "ARM" and "ARM64".

> +config EXYNOS5433_COMMON_CLK
> +       bool
> +       depends on ARM64 || COMPILE_TEST
> +       default ARCH_EXYNOS

nit: bool and default can be combined into def_bool ARCH_EXYNOS

> +       select COMMON_CLK_SAMSUNG
> +
> +config EXYNOS7_COMMON_CLK
> +       bool
> +       depends on ARM64 || COMPILE_TEST
> +       default ARCH_EXYNOS

nit: See above.

However, I don't think we can disable compilation of particular 64-bit
SoCs, so maybe there isn't much sense in splitting their clock drivers
into separate symbols?

Best regards,
Tomasz

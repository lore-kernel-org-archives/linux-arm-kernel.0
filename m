From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Jan 2016 09:59:51 +0100
Subject: [RESEND v2 1/2] clk: samsung: Don't build ARMv8 clock drivers on
 ARMv7
In-Reply-To: <1453683021-6998-2-git-send-email-k.kozlowski@samsung.com>
References: <1453683021-6998-1-git-send-email-k.kozlowski@samsung.com>
 <1453683021-6998-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <4282078.QlIpNj3Oa6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 January 2016 09:50:20 Krzysztof Kozlowski wrote:
> 
> +# ARM64 SoCs (e.g. Exynos5433, Exynos7):
> +config EXYNOS_ARM64_COMMON_CLK
> +       def_bool ARCH_EXYNOS
> +       depends on ARM64 || COMPILE_TEST
> +       select COMMON_CLK_SAMSUNG
> 

So you always enable it on ARM64 when ARCH_EXYNOS is enabled, but
enable it silently on ARM32 when COMPILE_TEST is set?

That sounds wrong. How about

config EXYNOS_ARM64_COMMON_CLK
	bool "EXYNOS 64-bit clock support" if COMPILE_TEST
	default ARM64 && ARCH_EXYNOS
	depends on (ARM64 && ARCH_EXYNOS) || COMPILE_TEST
	select COMMON_CLK_SAMSUNG

	Arnd

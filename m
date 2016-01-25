From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 25 Jan 2016 18:10:31 +0900
Subject: [RESEND v2 1/2] clk: samsung: Don't build ARMv8 clock drivers on
 ARMv7
In-Reply-To: <4282078.QlIpNj3Oa6@wuerfel>
References: <1453683021-6998-1-git-send-email-k.kozlowski@samsung.com>
 <1453683021-6998-2-git-send-email-k.kozlowski@samsung.com>
 <4282078.QlIpNj3Oa6@wuerfel>
Message-ID: <56A5E687.3060209@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.01.2016 17:59, Arnd Bergmann wrote:
> On Monday 25 January 2016 09:50:20 Krzysztof Kozlowski wrote:
>>
>> +# ARM64 SoCs (e.g. Exynos5433, Exynos7):
>> +config EXYNOS_ARM64_COMMON_CLK
>> +       def_bool ARCH_EXYNOS
>> +       depends on ARM64 || COMPILE_TEST
>> +       select COMMON_CLK_SAMSUNG
>>
> 
> So you always enable it on ARM64 when ARCH_EXYNOS is enabled, but
> enable it silently on ARM32 when COMPILE_TEST is set?

Hmm... indeed it would better to make it toggle-able when COMPILE_TEST.

> That sounds wrong. How about
> 
> config EXYNOS_ARM64_COMMON_CLK
> 	bool "EXYNOS 64-bit clock support" if COMPILE_TEST
> 	default ARM64 && ARCH_EXYNOS
> 	depends on (ARM64 && ARCH_EXYNOS) || COMPILE_TEST
> 	select COMMON_CLK_SAMSUNG

Although this looks more complicated but it does the trick. Thanks for
the hint. Only one (not related directly to this change) issue - with
COMPILE_TEST the "EXYNOS 64-bit clock support" option goes above the
common clock framework (up to drivers section) because it is not part of
the Clocks menu. I'll fix it in v3.

Best regards,
Krzysztof

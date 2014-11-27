From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 27 Nov 2014 10:26:29 +0000
Subject: [PATCH 16/19] arm64: dts: exynos: Add dts files for 64-bit
 Exynos5433 SoC
In-Reply-To: <1417073716-22997-17-git-send-email-cw00.choi@samsung.com>
References: <1417073716-22997-1-git-send-email-cw00.choi@samsung.com>
 <1417073716-22997-17-git-send-email-cw00.choi@samsung.com>
Message-ID: <5476FC55.1020606@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/11/14 07:35, Chanwoo Choi wrote:
> This patch adds new Exynos5433 dtsi to support 64-bit Exynos5433 SoC
> based on Octal core CPUs (quad Cortex-A57 and quad Cortex-A53).
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Inki Dae <inki.dae@samsung.com>
> Acked-by: Geunsik Lim <geunsik.lim@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi | 698 +++++++++++++++++++++
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 523 +++++++++++++++
>  2 files changed, 1221 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
>  create mode 100644 arch/arm64/boot/dts/exynos/exynos5433.dtsi
> 

[...]

> diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> new file mode 100644
> index 0000000..3d8b576
> --- /dev/null
> +++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi

[...]

> +               timer {
> +                       compatible = "arm,armv8-timer";
> +                       interrupts = <1 13 0xff01>,
> +                                    <1 14 0xff01>,
> +                                    <1 11 0xff01>,
> +                                    <1 10 0xff01>;

This is wrong. Timer interrupts for both A53 and A57 are level triggered.

> +                       clock-frequency = <24000000>;

Please go and fix your firmware. Really...

> +                       use-clocksource-only;
> +                       use-physical-timer;
> +               };

Well, that's a total NAK. Neither of these properties are part of the
binding, and we've already established that none of that would never be
valid on arm64.

I suggest you finally do what we've been asking for years, which is to
fix your boot ROM by adding the 5 lines of assembly code that are needed
instead of repeatedly post the same bogus DT files.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 1 Jun 2016 12:57:52 -0700
Subject: [PATCH v5 13/22] ARM: dts: exynos: Enable UART3 on Exynos5410
In-Reply-To: <1464429273-23457-14-git-send-email-krzk@kernel.org>
References: <1464429273-23457-1-git-send-email-krzk@kernel.org>
 <1464429273-23457-14-git-send-email-krzk@kernel.org>
Message-ID: <CAOi56cXeRjGgE+=psk7K45oeAgZ27HFxbi+an-ELnA3-_Z_BTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On Sat, May 28, 2016 at 2:54 AM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Just like other Exynos5 family SoCs, this one has four UARTs. Configure
> clocks for UART3 and enable it.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

This patch landed in linux-next[1] and kernelci.org found a boot
regression on the exynos5410-odroidxu[2], where it looks like it's
faulting in clk_prepare().  Bisecting pointed to this patch.  I added
"status = disabled" back into the DTS on top of next-20160601[3] and
verified my odroid-XU to be booting fine again.

Kevin

[1] 594127ada6df ARM: dts: exynos: Enable UART3 on Exynos5410
[2] https://kernelci.org/boot/exynos5410-odroidxu/job/next/kernel/next-20160601/defconfig/multi_v7_defconfig/lab/lab-baylibre-seattle/?_id=574e97c759b5140f4141c8ef
[3] diff --git a/arch/arm/boot/dts/exynos5410.dtsi
b/arch/arm/boot/dts/exynos5410.dtsi
index a937d9bdad90..f4baf1d1e864 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -238,6 +238,7 @@
 };

 &serial_3 {
+       status = "disabled";
        clocks = <&clock CLK_UART3>, <&clock CLK_SCLK_UART3>;
        clock-names = "uart", "clk_uart_baud0";
 };

From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 28 Oct 2015 16:37:23 +0900
Subject: [GIT PULL 4/5] Late Samsung driver updates for v4.4
In-Reply-To: <562AA603.7040600@kernel.org>
References: <562AA40E.4050407@kernel.org> <562AA603.7040600@kernel.org>
Message-ID: <56307B33.90608@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24.10.2015 06:26, Kukjin Kim wrote:
> The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:
> 
>   Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/samsung-driver
> 
> for you to fetch changes up to c612d5a7785b307df96938d590c3a1edfb624ccf:
> 
>   cpufreq: s5pv210: remove superfluous CONFIG_PM ifdefs (2015-10-24
> 04:34:50 +0900)
> 
> ----------------------------------------------------------------
> Samsung driver udpates for v4.4
> 
> - add support for exynos SROM controller DT based driver
>   (drivers/soc/samsung/exynos-srom.c)
>   : Since the exynos SROM registers are used during Suspend to RAM
>     so the exynos SROM driver handles the S2R and then we can remove
>     static mapping for SROM registers.
>   : Pankaj tested boot and S2R functionality on Peach-Pi chromebook
>   : Pavel tested on SMDK5410 board
>   : Krzysztof tested on Trats2 (exynos4412) board
> - update Maintainer entry accordingly
> - remove superfluous CONFIG_PM ifdefs with Viresh's ack
> 
> ----------------------------------------------------------------
> Bartlomiej Zolnierkiewicz (1):
>       cpufreq: s5pv210: remove superfluous CONFIG_PM ifdefs
> 
> Pankaj Dubey (8):
>       ARM: EXYNOS: remove unused static mapping of CMU for exynos5
>       ARM: EXYNOS: code cleanup in map.h
>       dt-bindings: add exynos-srom device tree binding
>       ARM: dts: add SROM device node for exynos4
>       ARM: dts: add SROM device node for exynos5

Hi Olof and Kukjin,

I see that this pull request was not pulled yet. (Un)Fortunately I
spotted one mistake in DTS changes above - the length of mapped region
is too small by one word. This does not produce any visible effect but
actually is wrong because driver will read from unmapped memory.


The question is - do you prefer us to send a following up patch or to
fix it by amending the commit?

Here is a fix which can be squashed into these two commits:
-- >8 --
Subject: [PATCH] ARM: dts: Fix size of mapped SROMC memory region on
 exynos[45]

The SROMC memory region contains 5 registers so the size of mapped
memory should be 0x14 instead of 0x10.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi | 2 +-
 arch/arm/boot/dts/exynos5.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 2f31f773b096..ffda7f5118cd 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -78,7 +78,7 @@

 	sromc at 12570000 {
 		compatible = "samsung,exynos-srom";
-		reg = <0x12570000 0x10>;
+		reg = <0x12570000 0x14>;
 	};

 	mipi_phy: video-phy at 10020710 {
diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index b5d3437922c5..fb52d16fba33 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -32,7 +32,7 @@

 	sromc at 12250000 {
 		compatible = "samsung,exynos-srom";
-		reg = <0x12250000 0x10>;
+		reg = <0x12250000 0x14>;
 	};

 	combiner: interrupt-controller at 10440000 {
-- 
1.9.1

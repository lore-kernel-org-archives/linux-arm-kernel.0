From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun,  5 Nov 2017 14:30:53 +0900
Subject: [PATCH 2/2] kbuild: handle dtb-y and CONFIG_OF_ALL_DTBS natively in
 Makefile.lib
In-Reply-To: <1509859853-27473-1-git-send-email-yamada.masahiro@socionext.com>
References: <1509859853-27473-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1509859853-27473-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_OF_ALL_DTBS is enabled, "make ARCH=arm64 dtbs" compiles each
DTB twice; one from arch/arm64/boot/dts/*/Makefile and the other from
the dtb-$(CONFIG_OF_ALL_DTBS) line in arch/arm64/boot/dts/Makefile.
It could be a race problem when building DTBS in parallel.

Another minor issue is CONFIG_OF_ALL_DTBS covers only *.dts in vendor
sub-directories, so this broke when Broadcom added one more hierarchy
in arch/arm64/boot/dts/broadcom/<soc>/.

One idea to fix the issues in a clean way is to move DTB handling
to Kbuild core scripts.  Makefile.dtbinst already recognizes dtb-y
natively, so it should not hurt to do so.

Add $(dtb-y) to extra-y, and $(dtb-) as well if CONFIG_OF_ALL_DTBS is
enabled.  All clutter things in Makefiles go away.

As a bonus clean-up, I also removed dts-dirs.  Just use subdir-y
directly to traverse sub-directories.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arc/boot/dts/Makefile                       |  7 ++-
 arch/arm/boot/dts/Makefile                       |  5 --
 arch/arm64/boot/dts/Makefile                     | 58 ++++++++++--------------
 arch/arm64/boot/dts/actions/Makefile             |  3 --
 arch/arm64/boot/dts/al/Makefile                  |  3 --
 arch/arm64/boot/dts/allwinner/Makefile           |  3 --
 arch/arm64/boot/dts/altera/Makefile              |  3 --
 arch/arm64/boot/dts/amd/Makefile                 |  3 --
 arch/arm64/boot/dts/amlogic/Makefile             |  3 --
 arch/arm64/boot/dts/apm/Makefile                 |  3 --
 arch/arm64/boot/dts/arm/Makefile                 |  3 --
 arch/arm64/boot/dts/broadcom/Makefile            |  6 +--
 arch/arm64/boot/dts/broadcom/northstar2/Makefile |  3 --
 arch/arm64/boot/dts/broadcom/stingray/Makefile   |  3 --
 arch/arm64/boot/dts/cavium/Makefile              |  3 --
 arch/arm64/boot/dts/exynos/Makefile              |  3 --
 arch/arm64/boot/dts/freescale/Makefile           |  3 --
 arch/arm64/boot/dts/hisilicon/Makefile           |  3 --
 arch/arm64/boot/dts/lg/Makefile                  |  3 --
 arch/arm64/boot/dts/marvell/Makefile             |  3 --
 arch/arm64/boot/dts/mediatek/Makefile            |  3 --
 arch/arm64/boot/dts/nvidia/Makefile              |  2 -
 arch/arm64/boot/dts/qcom/Makefile                |  3 --
 arch/arm64/boot/dts/realtek/Makefile             |  3 --
 arch/arm64/boot/dts/renesas/Makefile             |  2 -
 arch/arm64/boot/dts/rockchip/Makefile            |  3 --
 arch/arm64/boot/dts/socionext/Makefile           |  2 -
 arch/arm64/boot/dts/sprd/Makefile                |  3 --
 arch/arm64/boot/dts/xilinx/Makefile              |  3 --
 arch/arm64/boot/dts/zte/Makefile                 |  3 --
 arch/h8300/boot/dts/Makefile                     |  5 --
 arch/metag/boot/dts/Makefile                     |  5 --
 arch/mips/boot/dts/Makefile                      | 32 ++++++-------
 arch/mips/boot/dts/brcm/Makefile                 |  2 -
 arch/mips/boot/dts/cavium-octeon/Makefile        |  2 -
 arch/mips/boot/dts/img/Makefile                  |  2 -
 arch/mips/boot/dts/ingenic/Makefile              |  2 -
 arch/mips/boot/dts/lantiq/Makefile               |  2 -
 arch/mips/boot/dts/mti/Makefile                  |  2 -
 arch/mips/boot/dts/netlogic/Makefile             |  2 -
 arch/mips/boot/dts/ni/Makefile                   |  2 -
 arch/mips/boot/dts/pic32/Makefile                |  2 -
 arch/mips/boot/dts/qca/Makefile                  |  2 -
 arch/mips/boot/dts/ralink/Makefile               |  2 -
 arch/mips/boot/dts/xilfpga/Makefile              |  2 -
 arch/xtensa/boot/dts/Makefile                    |  7 ++-
 scripts/Makefile.dtbinst                         |  6 +--
 scripts/Makefile.lib                             |  5 ++
 48 files changed, 53 insertions(+), 182 deletions(-)

diff --git a/arch/arc/boot/dts/Makefile b/arch/arc/boot/dts/Makefile
index 1257db1..9ece28b 100644
--- a/arch/arc/boot/dts/Makefile
+++ b/arch/arc/boot/dts/Makefile
@@ -10,7 +10,6 @@ dtb-y := $(builtindtb-y).dtb
 
 .SECONDARY: $(obj)/$(builtindtb-y).dtb.S
 
-dtstree		:= $(srctree)/$(src)
-dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
-
-always := $(dtb-y)
+# for CONFIG_OF_ALL_DTBS test
+dtstree	:= $(srctree)/$(src)
+dtb-	:= $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 5eeefbc..4b650d6 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1069,8 +1069,3 @@ dtb-$(CONFIG_ARCH_ASPEED) += aspeed-bmc-opp-palmetto.dtb \
 	aspeed-bmc-opp-romulus.dtb \
 	aspeed-ast2500-evb.dtb
 endif
-
-dtstree		:= $(srctree)/$(src)
-dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
-
-always		:= $(dtb-y)
diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 8e19512..a7ecb42 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -1,33 +1,25 @@
-dts-dirs += actions
-dts-dirs += al
-dts-dirs += allwinner
-dts-dirs += altera
-dts-dirs += amd
-dts-dirs += amlogic
-dts-dirs += apm
-dts-dirs += arm
-dts-dirs += broadcom
-dts-dirs += cavium
-dts-dirs += exynos
-dts-dirs += freescale
-dts-dirs += hisilicon
-dts-dirs += marvell
-dts-dirs += mediatek
-dts-dirs += nvidia
-dts-dirs += qcom
-dts-dirs += realtek
-dts-dirs += renesas
-dts-dirs += rockchip
-dts-dirs += socionext
-dts-dirs += sprd
-dts-dirs += xilinx
-dts-dirs += lg
-dts-dirs += zte
-
-subdir-y	:= $(dts-dirs)
-
-dtstree		:= $(srctree)/$(src)
-
-dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(foreach d,$(dts-dirs), $(wildcard $(dtstree)/$(d)/*.dts)))
-
-always		:= $(dtb-y)
+subdir-y += actions
+subdir-y += al
+subdir-y += allwinner
+subdir-y += altera
+subdir-y += amd
+subdir-y += amlogic
+subdir-y += apm
+subdir-y += arm
+subdir-y += broadcom
+subdir-y += cavium
+subdir-y += exynos
+subdir-y += freescale
+subdir-y += hisilicon
+subdir-y += marvell
+subdir-y += mediatek
+subdir-y += nvidia
+subdir-y += qcom
+subdir-y += realtek
+subdir-y += renesas
+subdir-y += rockchip
+subdir-y += socionext
+subdir-y += sprd
+subdir-y += xilinx
+subdir-y += lg
+subdir-y += zte
diff --git a/arch/arm64/boot/dts/actions/Makefile b/arch/arm64/boot/dts/actions/Makefile
index 89bb1b5..cc46612 100644
--- a/arch/arm64/boot/dts/actions/Makefile
+++ b/arch/arm64/boot/dts/actions/Makefile
@@ -1,4 +1 @@
 dtb-$(CONFIG_ARCH_ACTIONS) += s900-bubblegum-96.dtb
-
-always		:= $(dtb-y)
-subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/al/Makefile b/arch/arm64/boot/dts/al/Makefile
index 8606a57..036e387 100644
--- a/arch/arm64/boot/dts/al/Makefile
+++ b/arch/arm64/boot/dts/al/Makefile
@@ -1,4 +1 @@
 dtb-$(CONFIG_ARCH_ALPINE)	+= alpine-v2-evp.dtb
-
-always		:= $(dtb-y)
-subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index 871ed768..4dab590 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -8,6 +8,3 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-pc2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-prime.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo2.dtb
-
-always		:= $(dtb-y)
-subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/altera/Makefile b/arch/arm64/boot/dts/altera/Makefile
index 7511b51..68ba088 100644
--- a/arch/arm64/boot/dts/altera/Makefile
+++ b/arch/arm64/boot/dts/altera/Makefile
@@ -1,4 +1 @@
 dtb-$(CONFIG_ARCH_STRATIX10) += socfpga_stratix10_socdk.dtb
-
-always		:= $(dtb-y)
-subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/amd/Makefile b/arch/arm64/boot/dts/amd/Makefile
index cb1c779..465cea6 100644
--- a/arch/arm64/boot/dts/amd/Makefile
+++ b/arch/arm64/boot/dts/amd/Makefile
@@ -1,6 +1,3 @@
 dtb-$(CONFIG_ARCH_SEATTLE) += amd-overdrive.dtb \
 			amd-overdrive-rev-b0.dtb amd-overdrive-rev-b1.dtb \
 			husky.dtb
-
-always		:= $(dtb-y)
-subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index d864403..4eb8f82 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -19,6 +19,3 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxm-nexbox-a1.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q200.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q201.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-rbox-pro.dtb
-
-always		:= $(dtb-y)
-subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/apm/Makefile b/arch/arm64/boot/dts/apm/Makefile
index 4334978..b96cd38 100644
--- a/arch/arm64/boot/dts/apm/Makefile
+++ b/arch/arm64/boot/dts/apm/Makefile
@@ -1,5 +1,2 @@
 dtb-$(CONFIG_ARCH_XGENE) += apm-mustang.dtb
 dtb-$(CONFIG_ARCH_XGENE) += apm-merlin.dtb
-
-always		:= $(dtb-y)
-subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/arm/Makefile b/arch/arm64/boot/dts/arm/Makefile
index 01c342f..7ca6a6e 100644
--- a/arch/arm64/boot/dts/arm/Makefile
+++ b/arch/arm64/boot/dts/arm/Makefile
@@ -2,6 +2,3 @@ dtb-$(CONFIG_ARCH_VEXPRESS) += foundation-v8.dtb foundation-v8-gicv3.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += juno.dtb juno-r1.dtb juno-r2.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += vexpress-v2f-1xv7-ca53x2.dtb
-
-always		:= $(dtb-y)
-subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
index d720d0d..da268c6 100644
--- a/arch/arm64/boot/dts/broadcom/Makefile
+++ b/arch/arm64/boot/dts/broadcom/Makefile
@@ -1,6 +1,4 @@
 dtb-$(CONFIG_ARCH_BCM2835) += bcm2837-rpi-3-b.dtb
 
-dts-dirs	+= northstar2
-dts-dirs	+= stingray
-always		:= $(dtb-y)
-subdir-y	:= $(dts-dirs)
+subdir-y	+= northstar2
+subdir-y	+= stingray
diff --git a/arch/arm64/boot/dts/broadcom/northstar2/Makefile b/arch/arm64/boot/dts/broadcom/northstar2/Makefile
index c589b9b..8373600 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/Makefile
+++ b/arch/arm64/boot/dts/broadcom/northstar2/Makefile
@@ -1,5 +1,2 @@
 dtb-$(CONFIG_ARCH_BCM_IPROC) += ns2-svk.dtb
 dtb-$(CONFIG_ARCH_BCM_IPROC) += ns2-xmc.dtb
-
-always		:= $(dtb-y)
-subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/broadcom/stingray/Makefile b/arch/arm64/boot/dts/broadcom/stingray/Makefile
index 8edcc52..ea5516b 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/Makefile
+++ b/arch/arm64/boot/dts/broadcom/stingray/Makefile
@@ -1,5 +1,2 @@
 dtb-$(CONFIG_ARCH_BCM_IPROC) += bcm958742k.dtb
 dtb-$(CONFIG_ARCH_BCM_IPROC) += bcm958742t.dtb
-
-always		:= $(dtb-y)
-subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/cavium/Makefile b/arch/arm64/boot/dts/cavium/Makefile
index c63145e..f7c0ca8 100644
--- a/arch/arm64/boot/dts/cavium/Makefile
+++ b/arch/arm64/boot/dts/cavium/Makefile
@@ -1,5 +1,2 @@
 dtb-$(CONFIG_ARCH_THUNDER) += thunder-88xx.dtb
 dtb-$(CONFIG_ARCH_THUNDER2) += thunder2-99xx.dtb
-
-always		:= $(dtb-y)
-subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/exynos/Makefile b/arch/arm64/boot/dts/exynos/Makefile
index 4633adf..14031e1 100644
--- a/arch/arm64/boot/dts/exynos/Makefile
+++ b/arch/arm64/boot/dts/exynos/Makefile
@@ -2,6 +2,3 @@ dtb-$(CONFIG_ARCH_EXYNOS) += \
 	exynos5433-tm2.dtb	\
 	exynos5433-tm2e.dtb	\
 	exynos7-espresso.dtb
-
-always		:= $(dtb-y)
-subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index fe18e3d..f1b5363 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -12,6 +12,3 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-simu.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-rdb.dtb
- 
-always		:= $(dtb-y)
-subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/hisilicon/Makefile b/arch/arm64/boot/dts/hisilicon/Makefile
index cb25d7a..942c9ab 100644
--- a/arch/arm64/boot/dts/hisilicon/Makefile
+++ b/arch/arm64/boot/dts/hisilicon/Makefile
@@ -4,6 +4,3 @@ dtb-$(CONFIG_ARCH_HISI) += hi6220-hikey.dtb
 dtb-$(CONFIG_ARCH_HISI) += hip05-d02.dtb
 dtb-$(CONFIG_ARCH_HISI) += hip06-d03.dtb
 dtb-$(CONFIG_ARCH_HISI) += hip07-d05.dtb
-
-always		:= $(dtb-y)
-subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/lg/Makefile b/arch/arm64/boot/dts/lg/Makefile
index c0bbe06..de5dc19 100644
--- a/arch/arm64/boot/dts/lg/Makefile
+++ b/arch/arm64/boot/dts/lg/Makefile
@@ -1,5 +1,2 @@
 dtb-$(CONFIG_ARCH_LG1K) += lg1312-ref.dtb
 dtb-$(CONFIG_ARCH_LG1K) += lg1313-ref.dtb
-
-always		:= $(dtb-y)
-subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index b471235..7a42e0d 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -9,6 +9,3 @@ dtb-$(CONFIG_ARCH_MVEBU) += armada-7040-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-mcbin.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-8080-db.dtb
-
-always		:= $(dtb-y)
-subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 80d1743..f225012 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -4,6 +4,3 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
-
-always		:= $(dtb-y)
-subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/nvidia/Makefile b/arch/arm64/boot/dts/nvidia/Makefile
index a9d5196..1b69cfd 100644
--- a/arch/arm64/boot/dts/nvidia/Makefile
+++ b/arch/arm64/boot/dts/nvidia/Makefile
@@ -4,5 +4,3 @@ dtb-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210-p2371-2180.dtb
 dtb-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210-p2571.dtb
 dtb-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210-smaug.dtb
 dtb-$(CONFIG_ARCH_TEGRA_186_SOC) += tegra186-p2771-0000.dtb
-
-always		:= $(dtb-y)
diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 65af6f9..7a65ef1 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -5,6 +5,3 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-bullhead-rev-101.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-angler-rev-101.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-mtp.dtb
-
-always		:= $(dtb-y)
-subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/realtek/Makefile b/arch/arm64/boot/dts/realtek/Makefile
index 88cb515..6e2ae59 100644
--- a/arch/arm64/boot/dts/realtek/Makefile
+++ b/arch/arm64/boot/dts/realtek/Makefile
@@ -1,4 +1 @@
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-zidoo-x9s.dtb
-
-always		:= $(dtb-y)
-subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 960dade..5e0bb28 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -3,5 +3,3 @@ dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-salvator-xs.dtb
 dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-es1-salvator-x.dtb r8a7795-es1-h3ulcb.dtb
 dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-salvator-x.dtb r8a7796-m3ulcb.dtb
 dtb-$(CONFIG_ARCH_R8A77995) += r8a77995-draak.dtb
-
-always		:= $(dtb-y)
diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 6b6bb1d..573a041 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -10,6 +10,3 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-firefly.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-kevin.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
-
-always		:= $(dtb-y)
-subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/socionext/Makefile b/arch/arm64/boot/dts/socionext/Makefile
index 5eed3ce..a042316 100644
--- a/arch/arm64/boot/dts/socionext/Makefile
+++ b/arch/arm64/boot/dts/socionext/Makefile
@@ -4,5 +4,3 @@ dtb-$(CONFIG_ARCH_UNIPHIER) += \
 	uniphier-ld20-global.dtb \
 	uniphier-ld20-ref.dtb \
 	uniphier-pxs3-ref.dtb
-
-always		:= $(dtb-y)
diff --git a/arch/arm64/boot/dts/sprd/Makefile b/arch/arm64/boot/dts/sprd/Makefile
index c91b62e..38cefdb 100644
--- a/arch/arm64/boot/dts/sprd/Makefile
+++ b/arch/arm64/boot/dts/sprd/Makefile
@@ -1,5 +1,2 @@
 dtb-$(CONFIG_ARCH_SPRD) += sc9836-openphone.dtb \
 			sp9860g-1h10.dtb
-
-always		:= $(dtb-y)
-subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
index 74e1956..a2d6708 100644
--- a/arch/arm64/boot/dts/xilinx/Makefile
+++ b/arch/arm64/boot/dts/xilinx/Makefile
@@ -1,4 +1 @@
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-ep108.dtb
-
-always		:= $(dtb-y)
-subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/zte/Makefile b/arch/arm64/boot/dts/zte/Makefile
index 71e0708..14a1cdf 100644
--- a/arch/arm64/boot/dts/zte/Makefile
+++ b/arch/arm64/boot/dts/zte/Makefile
@@ -1,5 +1,2 @@
 dtb-$(CONFIG_ARCH_ZX) += zx296718-evb.dtb
 dtb-$(CONFIG_ARCH_ZX) += zx296718-pcbox.dtb
-
-always		:= $(dtb-y)
-subdir-y	:= $(dts-dirs)
diff --git a/arch/h8300/boot/dts/Makefile b/arch/h8300/boot/dts/Makefile
index 6f3fe47..ae31884 100644
--- a/arch/h8300/boot/dts/Makefile
+++ b/arch/h8300/boot/dts/Makefile
@@ -7,8 +7,3 @@ obj-y += $(BUILTIN_DTB)
 dtb-$(CONFIG_H8300H_SIM) := h8300h_sim.dtb
 dtb-$(CONFIG_H8S_SIM) := h8s_sim.dtb
 dtb-$(CONFIG_H8S_EDOSK2674) := edosk2674.dtb
-
-dtstree		:= $(srctree)/$(src)
-dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
-
-always	    := $(dtb-y)
diff --git a/arch/metag/boot/dts/Makefile b/arch/metag/boot/dts/Makefile
index 83d5b88..0060147 100644
--- a/arch/metag/boot/dts/Makefile
+++ b/arch/metag/boot/dts/Makefile
@@ -12,9 +12,4 @@ endif
 dtb-$(CONFIG_METAG_BUILTIN_DTB)	+= $(builtindtb-y).dtb
 obj-$(CONFIG_METAG_BUILTIN_DTB)	+= $(builtindtb-y).dtb.o
 
-dtstree		:= $(srctree)/$(src)
-dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
-
 .SECONDARY: $(obj)/$(builtindtb-y).dtb.S
-
-always += $(dtb-y)
diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index 7891ffa..b2b0d88 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -1,20 +1,14 @@
-dts-dirs	+= brcm
-dts-dirs	+= cavium-octeon
-dts-dirs	+= img
-dts-dirs	+= ingenic
-dts-dirs	+= lantiq
-dts-dirs	+= mti
-dts-dirs	+= netlogic
-dts-dirs	+= ni
-dts-dirs	+= pic32
-dts-dirs	+= qca
-dts-dirs	+= ralink
-dts-dirs	+= xilfpga
+subdir-y	+= brcm
+subdir-y	+= cavium-octeon
+subdir-y	+= img
+subdir-y	+= ingenic
+subdir-y	+= lantiq
+subdir-y	+= mti
+subdir-y	+= netlogic
+subdir-y	+= ni
+subdir-y	+= pic32
+subdir-y	+= qca
+subdir-y	+= ralink
+subdir-y	+= xilfpga
 
-obj-y		:= $(addsuffix /, $(dts-dirs))
-
-dtstree		:= $(srctree)/$(src)
-dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(foreach d,$(dts-dirs), $(wildcard $(dtstree)/$(d)/*.dts)))
-
-always		:= $(dtb-y)
-subdir-y	:= $(dts-dirs)
+obj-$(BUILTIN_DTB)	:= $(addsuffix /, $(subdir-y))
diff --git a/arch/mips/boot/dts/brcm/Makefile b/arch/mips/boot/dts/brcm/Makefile
index ad76130..bacb131 100644
--- a/arch/mips/boot/dts/brcm/Makefile
+++ b/arch/mips/boot/dts/brcm/Makefile
@@ -37,5 +37,3 @@ obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 
 # Force kbuild to make empty built-in.o if necessary
 obj-				+= dummy.o
-
-always				:= $(dtb-y)
diff --git a/arch/mips/boot/dts/cavium-octeon/Makefile b/arch/mips/boot/dts/cavium-octeon/Makefile
index a6fb331..e9592a9 100644
--- a/arch/mips/boot/dts/cavium-octeon/Makefile
+++ b/arch/mips/boot/dts/cavium-octeon/Makefile
@@ -4,5 +4,3 @@ obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 
 # Force kbuild to make empty built-in.o if necessary
 obj-				+= dummy.o
-
-always				:= $(dtb-y)
diff --git a/arch/mips/boot/dts/img/Makefile b/arch/mips/boot/dts/img/Makefile
index 135f987..a46d773 100644
--- a/arch/mips/boot/dts/img/Makefile
+++ b/arch/mips/boot/dts/img/Makefile
@@ -5,5 +5,3 @@ obj-$(CONFIG_MACH_PISTACHIO)	+= pistachio_marduk.dtb.o
 
 # Force kbuild to make empty built-in.o if necessary
 obj-				+= dummy.o
-
-always				:= $(dtb-y)
diff --git a/arch/mips/boot/dts/ingenic/Makefile b/arch/mips/boot/dts/ingenic/Makefile
index e3d0ec1..ddd0faf 100644
--- a/arch/mips/boot/dts/ingenic/Makefile
+++ b/arch/mips/boot/dts/ingenic/Makefile
@@ -5,5 +5,3 @@ obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 
 # Force kbuild to make empty built-in.o if necessary
 obj-				+= dummy.o
-
-always				:= $(dtb-y)
diff --git a/arch/mips/boot/dts/lantiq/Makefile b/arch/mips/boot/dts/lantiq/Makefile
index 5976f08..586b1c9 100644
--- a/arch/mips/boot/dts/lantiq/Makefile
+++ b/arch/mips/boot/dts/lantiq/Makefile
@@ -4,5 +4,3 @@ obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 
 # Force kbuild to make empty built-in.o if necessary
 obj-				+= dummy.o
-
-always				:= $(dtb-y)
diff --git a/arch/mips/boot/dts/mti/Makefile b/arch/mips/boot/dts/mti/Makefile
index 9a1a6dc..faf7ac4 100644
--- a/arch/mips/boot/dts/mti/Makefile
+++ b/arch/mips/boot/dts/mti/Makefile
@@ -5,5 +5,3 @@ obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 
 # Force kbuild to make empty built-in.o if necessary
 obj-				+= dummy.o
-
-always				:= $(dtb-y)
diff --git a/arch/mips/boot/dts/netlogic/Makefile b/arch/mips/boot/dts/netlogic/Makefile
index 6b2cf49..77ffb30 100644
--- a/arch/mips/boot/dts/netlogic/Makefile
+++ b/arch/mips/boot/dts/netlogic/Makefile
@@ -8,5 +8,3 @@ obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 
 # Force kbuild to make empty built-in.o if necessary
 obj-				+= dummy.o
-
-always				:= $(dtb-y)
diff --git a/arch/mips/boot/dts/ni/Makefile b/arch/mips/boot/dts/ni/Makefile
index 094da72..6cd9c60 100644
--- a/arch/mips/boot/dts/ni/Makefile
+++ b/arch/mips/boot/dts/ni/Makefile
@@ -2,5 +2,3 @@ dtb-$(CONFIG_FIT_IMAGE_FDT_NI169445)	+= 169445.dtb
 
 # Force kbuild to make empty built-in.o if necessary
 obj-					+= dummy.o
-
-always					:= $(dtb-y)
diff --git a/arch/mips/boot/dts/pic32/Makefile b/arch/mips/boot/dts/pic32/Makefile
index 0ee591b..5a08e48 100644
--- a/arch/mips/boot/dts/pic32/Makefile
+++ b/arch/mips/boot/dts/pic32/Makefile
@@ -7,5 +7,3 @@ obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 
 # Force kbuild to make empty built-in.o if necessary
 obj-				+= dummy.o
-
-always				:= $(dtb-y)
diff --git a/arch/mips/boot/dts/qca/Makefile b/arch/mips/boot/dts/qca/Makefile
index 87cf351c..181db5d 100644
--- a/arch/mips/boot/dts/qca/Makefile
+++ b/arch/mips/boot/dts/qca/Makefile
@@ -7,5 +7,3 @@ dtb-$(CONFIG_ATH79)			+= ar9331_tl_mr3020.dtb
 
 # Force kbuild to make empty built-in.o if necessary
 obj-				+= dummy.o
-
-always				:= $(dtb-y)
diff --git a/arch/mips/boot/dts/ralink/Makefile b/arch/mips/boot/dts/ralink/Makefile
index e0e3a9d..7b64654 100644
--- a/arch/mips/boot/dts/ralink/Makefile
+++ b/arch/mips/boot/dts/ralink/Makefile
@@ -9,5 +9,3 @@ obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 
 # Force kbuild to make empty built-in.o if necessary
 obj-				+= dummy.o
-
-always				:= $(dtb-y)
diff --git a/arch/mips/boot/dts/xilfpga/Makefile b/arch/mips/boot/dts/xilfpga/Makefile
index 8b9ea11..77c8096 100644
--- a/arch/mips/boot/dts/xilfpga/Makefile
+++ b/arch/mips/boot/dts/xilfpga/Makefile
@@ -4,5 +4,3 @@ obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 
 # Force kbuild to make empty built-in.o if necessary
 obj-				+= dummy.o
-
-always				:= $(dtb-y)
diff --git a/arch/xtensa/boot/dts/Makefile b/arch/xtensa/boot/dts/Makefile
index c62dd6c..f8052ba 100644
--- a/arch/xtensa/boot/dts/Makefile
+++ b/arch/xtensa/boot/dts/Makefile
@@ -12,7 +12,6 @@ ifneq ($(CONFIG_BUILTIN_DTB),"")
 obj-$(CONFIG_OF) += $(BUILTIN_DTB)
 endif
 
-dtstree := $(srctree)/$(src)
-dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
-
-always += $(dtb-y)
+# for CONFIG_OF_ALL_DTBS test
+dtstree	:= $(srctree)/$(src)
+dtb-	:= $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
diff --git a/scripts/Makefile.dtbinst b/scripts/Makefile.dtbinst
index 993fb85..8e8fdfd 100644
--- a/scripts/Makefile.dtbinst
+++ b/scripts/Makefile.dtbinst
@@ -5,8 +5,6 @@
 # INSTALL_DTBS_PATH directory or the default location:
 #
 #   $INSTALL_PATH/dtbs/$KERNELRELEASE
-#
-# Traverse through subdirectories listed in $(dts-dirs).
 # ==========================================================================
 
 src := $(obj)
@@ -20,8 +18,8 @@ include include/config/auto.conf
 include scripts/Kbuild.include
 include $(src)/Makefile
 
-dtbinst-files	:= $(dtb-y)
-dtbinst-dirs	:= $(dts-dirs)
+dtbinst-files	:= $(sort $(dtb-y) $(if $(CONFIG_OF_ALL_DTBS), $(dtb-)))
+dtbinst-dirs	:= $(subdir-y) $(subdir-m)
 
 # Helper targets for Installing DTBs into the boot directory
 quiet_cmd_dtb_install =	INSTALL $<
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 5e975fe..09ec69d2 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -69,6 +69,11 @@ obj-dirs := $(dir $(multi-objs) $(obj-y))
 real-objs-y := $(foreach m, $(filter-out $(subdir-obj-y), $(obj-y)), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y))),$($(m:.o=-objs)) $($(m:.o=-y)),$(m))) $(extra-y)
 real-objs-m := $(foreach m, $(obj-m), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-m))),$($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-m)),$(m)))
 
+# DTB
+# If CONFIG_OF_ALL_DTBS is enabled, all DT blobs are built
+extra-y				+= $(dtb-y)
+extra-$(CONFIG_OF_ALL_DTBS)	+= $(dtb-)
+
 # Add subdir path
 
 extra-y		:= $(addprefix $(obj)/,$(extra-y))
-- 
2.7.4

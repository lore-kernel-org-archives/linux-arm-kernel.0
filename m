From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 5 Aug 2014 13:09:26 +1000
Subject: linux-next: build failures after merge of the drm tree
Message-ID: <20140805130926.4e8c8fe5@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

After merging the drm tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: "drm_sysfs_connector_remove" [drivers/gpu/drm/i2c/tda998x.ko] undefined!
ERROR: "drm_sysfs_connector_add" [drivers/gpu/drm/i2c/tda998x.ko] undefined!

Caused by commit c707c3619ca8 ("drm/i2c: tda998x: add component
support") interacting with commit 34ea3d386347 ("drm: add register and
unregister functions for connectors").  Maybe it should have been fixed
up in the merge commit 920f946428b7 ("Merge branch 'tda998x-devel' of
git://ftp.arm.linux.org.uk/~rmk/linux-cubox into drm-next")?

I reverted commit c707c3619ca8 for today.

But then the arm multi_v7_defconfig build produced these errors:

ERROR (phandle_references): Reference to non-existent node or label "disp_pd"

ERROR: Input tree has errors, aborting (use -f to force output)
make[2]: *** [arch/arm/boot/dts/exynos5420-arndale-octa.dtb] Error 2
make[2]: *** Waiting for unfinished jobs....
ERROR (phandle_references): Reference to non-existent node or label "disp_pd"

ERROR: Input tree has errors, aborting (use -f to force output)
make[2]: *** [arch/arm/boot/dts/exynos5420-smdk5420.dtb] Error 2
ERROR (phandle_references): Reference to non-existent node or label "disp_pd"

ERROR: Input tree has errors, aborting (use -f to force output)
ERROR (phandle_references): Reference to non-existent node or label "disp_pd"

make[2]: *** [arch/arm/boot/dts/exynos5800-peach-pi.dtb] Error 2
ERROR: Input tree has errors, aborting (use -f to force output)

Caused by commit 5a8da524049c ("ARM: dts: exynos5420: add dsi node")
interacting with commit d51cad7df871 ("ARM: dts: remove display power
domain for exynos5420") from the arm-soc tree.

I applied this merge fix patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 5 Aug 2014 13:03:01 +1000
Subject: [PATCH] ARM: dts: exynos5420: remove disp_pd

per comit d51cad7df871 ("ARM: dts: remove display power
domain for exynos5420").

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/arm/boot/dts/exynos5420.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 95ec37dff3e8..bfe056d9148c 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -525,7 +525,6 @@
 		compatible = "samsung,exynos5410-mipi-dsi";
 		reg = <0x14500000 0x10000>;
 		interrupts = <0 82 0>;
-		samsung,power-domain = <&disp_pd>;
 		phys = <&mipi_phy 1>;
 		phy-names = "dsim";
 		clocks = <&clock CLK_DSIM1>, <&clock CLK_SCLK_MIPI1>;
-- 
2.0.1

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140805/0adfee2c/attachment.sig>

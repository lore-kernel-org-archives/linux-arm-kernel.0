From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 Mar 2017 16:02:41 +0200
Subject: [GIT PULL] Amlogic 64-bit DT updates for v4.12
In-Reply-To: <m28tnn69ls.fsf@baylibre.com>
References: <m28tnn69ls.fsf@baylibre.com>
Message-ID: <CAK8P3a02e3DxjuW9pA66NSCc9vw_h1Xuk6TdEbRnEQ4v4W7NHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 11:45 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> Olof, Arnd,
>
> Below are some 64-bit DT changes for Amlogic platforms for v4.12.  Note
> that this branch includes a merge of an immutable branch from the clk
> tree (clk-meson) due to dependencies on new clocks added to the meson
> clock driver and used in these DT updates.

I did not pull this one because of the silly dependency. The device tree
files should be completely independent of the driver changes.

Here I see commits like these:

commit fd86d3edb417d5c719fa0ffc4adf9b99e1f2db48
Author: Neil Armstrong <narmstrong@baylibre.com>
Date:   Wed Mar 22 11:32:26 2017 +0100

    clk: meson-gxbb: Expose GP0 dt-bindings clock id

    This patch exposes the GP0 PLL clock id in the dt bindings.

    Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
    Signed-off-by: Michael Turquette <mturquette@baylibre.com>
    Link: lkml.kernel.org/r/1490178747-14837-5-git-send-email-narmstrong at baylibre.com

diff --git a/include/dt-bindings/clock/gxbb-clkc.h
b/include/dt-bindings/clock/gxbb-clkc.h
index ef7d6b792405..cce6cb5418f1 100644
--- a/include/dt-bindings/clock/gxbb-clkc.h
+++ b/include/dt-bindings/clock/gxbb-clkc.h
@@ -10,6 +10,7 @@
 #define CLKID_FCLK_DIV2                4
 #define CLKID_FCLK_DIV3                5
 #define CLKID_FCLK_DIV4                6
+#define CLKID_GP0_PLL          9
 #define CLKID_CLK81            12
 #define CLKID_MPLL2            15
 #define CLKID_SPI              34

commit 7c4aabd0e19491749488b363fa409956fa3857bb
Author: Neil Armstrong <narmstrong@baylibre.com>
Date:   Wed Mar 22 11:18:53 2017 +0100

    clk: meson-gxbb: Add MALI clock IDS

    Add missing MALI clock IDs and expose the muxes and gates in the
dt-bindings.

    Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
    Signed-off-by: Michael Turquette <mturquette@baylibre.com>
    Link: lkml.kernel.org/r/1490177935-9646-2-git-send-email-narmstrong at baylibre.com

diff --git a/include/dt-bindings/clock/gxbb-clkc.h
b/include/dt-bindings/clock/gxbb-clkc.h
index f08f06dd7702..ef7d6b792405 100644
--- a/include/dt-bindings/clock/gxbb-clkc.h
+++ b/include/dt-bindings/clock/gxbb-clkc.h
@@ -35,5 +35,10 @@
 #define CLKID_SD_EMMC_C                96
 #define CLKID_SAR_ADC_CLK      97
 #define CLKID_SAR_ADC_SEL      98
+#define CLKID_MALI_0_SEL       100
+#define CLKID_MALI_0           102
+#define CLKID_MALI_1_SEL       103
+#define CLKID_MALI_1           105
+#define CLKID_MALI             106

 #endif /* __GXBB_CLKC_H */

commit 7e148d522982b29c454a31386eb3d27b10d5adbc
Author: Jerome Brunet <jbrunet@baylibre.com>
Date:   Thu Mar 9 11:41:54 2017 +0100

    dt-bindings: clk: gxbb: expose i2s output clock gates

    Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
    Signed-off-by: Michael Turquette <mturquette@baylibre.com>
    Link: lkml.kernel.org/r/20170309104154.28295-10-jbrunet at baylibre.com

diff --git a/include/dt-bindings/clock/gxbb-clkc.h
b/include/dt-bindings/clock/gxbb-clkc.h
index 692846c7941b..f08f06dd7702 100644
--- a/include/dt-bindings/clock/gxbb-clkc.h
+++ b/include/dt-bindings/clock/gxbb-clkc.h
@@ -16,6 +16,10 @@
 #define CLKID_I2C              22
 #define CLKID_SAR_ADC          23
 #define CLKID_ETH              36
+#define CLKID_AIU_GLUE         38
+#define CLKID_I2S_OUT          40
+#define CLKID_MIXER_IFACE      44
+#define CLKID_AIU              47
 #define CLKID_USB0             50
 #define CLKID_USB1             51
 #define CLKID_USB              55

Which add random macros in the middle of the number space.

Since the header changes are in an immutable branch, it's probably
too late to fix this for 4.12, but maybe we can get the header into a
form that allows us to do future DT changes without having to
wait an extra release. The clock driver apparently already defines
some of the numbers above, so you can fill all of those in already.

     Arnd

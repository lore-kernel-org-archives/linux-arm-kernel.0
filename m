From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 28 Feb 2018 09:00:50 -0300
Subject: [PATCH] ARM: dts: mx5: Pass the memory unit-address
In-Reply-To: <20180228030328.GC3217@dragon>
References: <1519784015-16507-1-git-send-email-festevam@gmail.com>
 <20180228030328.GC3217@dragon>
Message-ID: <CAOMZO5DDf7nRM0UQRiyEKwc=7Ta-s-yExgUhrxt8=QRZBqJ5MQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Wed, Feb 28, 2018 at 12:03 AM, Shawn Guo <shawnguo@kernel.org> wrote:

> One thing I'm unsure is which memory node will be fixed up with correct
> memory configuration, considering we will have two memory nodes.  One is
> the following that defined in imx51.dtsi.
>
>  memory { device_type = "memory"; };
>
> And the other is memory at 90000000.

On my tests the correct memory@ is filled with the real memory size.

One further cleanup I can make to avoid this double memory node is:

--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -20,6 +20,7 @@
        };

        memory at 10000000 {
+               device_type = "memory";
                reg = <0x10000000 0x40000000>;
        };

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index c003e62..f3376f0 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -23,7 +23,6 @@
         * Also for U-Boot there must be a pre-existing /memory node.
         */
        chosen {};
-       memory { device_type = "memory"; };

        aliases {
                ethernet0 = &fec;

If you agree I can do this for all i.MX dts.

What do you think?

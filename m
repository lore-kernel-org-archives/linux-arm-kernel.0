From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 10 Jan 2016 16:38:43 +0100
Subject: mvsdio not working on OpenRD
In-Reply-To: <20160110042619.GA22738@jirafa.cyrius.com>
References: <20160110042619.GA22738@jirafa.cyrius.com>
Message-ID: <20160110153843.GA22229@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 09, 2016 at 08:26:19PM -0800, Martin Michlmayr wrote:
> Rick Thomas reported that MMC no longer works on his OpenRD Base.
> 
> With Debian's 3.16 kernel (using mach ID):
> 
> mvsdio mvsdio: no pins associated
> mmc0: host does not support reading read-only switch.  assuming write-enable.
> mmc0: new high speed SDHC card at address 0007
> mmcblk0: mmc0:0007 SD4GB 3.70 GiB?
>  mmcblk0: p1
> 
> With Debian's 4.3 and 4.4-rc8 kernels (using Device Tree):
> 
> kirkwood-pinctrl f1010000.pin-controller: pin PIN13 already requested by f1012100.serial; cannot claim for f1090000.mvsdio
> kirkwood-pinctrl f1010000.pin-controller: pin-13 (f1090000.mvsdio) status -22
> kirkwood-pinctrl f1010000.pin-controller: could not request pin 13 (PIN13) from group mpp13  on device f1010000.pin-controller
> mvsdio f1090000.mvsdio: Error applying setting, reverse things back
> mvsdio f1090000.mvsdio: Got CD GPIO
> [and no mmc0 or mmcblk0]
> 
> -- 
> Martin Michlmayr
> http://www.cyrius.com/

Hi Rick, Martin

If i remember correctly, the OpenRD has some odd muxing going on with
MMC and the second serial port. This fits the error message:

                        pmx_uart1: pmx-uart1 {
                                marvell,pins = "mpp13", "mpp14";
                                marvell,function = "uart1";
                        };

and

                        pmx_sdio: pmx-sdio {
                                marvell,pins = "mpp12", "mpp13", "mpp14",
                                               "mpp15", "mpp16", "mpp17";
                                marvell,function = "sdio";
			};

Either you can have MMC, or you can have the RS-232/RS485 on a DB9 or
you can have MMC. You cannot have both.

It seems like older Debian kernels has defaulted to MMC, so we should
probably disable the serial port.

Please can you try the following patch. If this works, i can add it to
mainline. The issue we might run into is that somebody else wants
serial not MMC....

       Andrew

diff --git a/arch/arm/boot/dts/kirkwood-openrd-base.dts b/arch/arm/boot/dts/kirkwood-openrd-base.dts
index 8af58999606d..883bd416ba0b 100644
--- a/arch/arm/boot/dts/kirkwood-openrd-base.dts
+++ b/arch/arm/boot/dts/kirkwood-openrd-base.dts
@@ -18,11 +18,6 @@
 / {
        model = "OpenRD Base";
        compatible = "marvell,openrd-base", "marvell,openrd", "marvell,kirkwood-88f6281", "marvell,kirkwood";
-
-       ocp at f1000000 {
-               serial at 12100 {
-                       status = "okay";
-               };
        };
 };

From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 16 Oct 2013 14:19:54 +0200
Subject: at91sam9g20-ek pinctrl conflicts
In-Reply-To: <20131016120617.GB27808@ns203013.ovh.net>
References: <20131016110405.GH2443@sirena.org.uk>
 <20131016120617.GB27808@ns203013.ovh.net>
Message-ID: <20131016121954.GC27808@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:06 Wed 16 Oct     , Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 12:04 Wed 16 Oct     , Mark Brown wrote:
> > Hi,
> > 
> > Booting an at91sam9g20-ek I see errors loading the MMC driver due to
> > conflicts with SPI:
> > 
> > pinctrl-at91 pinctrl.2: pin pioA1 already requested by fffc8000.spi; cannot claim for fffa8000.mmc
> > pinctrl-at91 pinctrl.2: pin-1 (fffa8000.mmc) status -22
> > pinctrl-at91 pinctrl.2: could not request pin 1 (pioA1) from group mmc0_slot1_cmd_dat0-0  on device pinctrl.2
> 
> it's not really an error as the hw support both but not at the same time
> > 
> > One of the devices seems to be configured incorrectly here but I don't
> > have schematics so it's not immediately obvious which.
> 
> it's SPI *or* MMC, on the default hw configuration it's mmc

this should fix the issue

diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index 1373546..cb2c010 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -96,7 +96,6 @@
                        };

                        spi0: spi at fffc8000 {
-                               status = "okay";
                                cs-gpios = <0>, <&pioC 11 0>, <0>, <0>;
                                mtd_dataflash at 0 {
                                        compatible = "atmel,at45", "atmel,dataflash";

Best Regards,
J.
> 
> Best Regards,
> J.
> > 
> > Thanks,
> > Mark
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

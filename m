From: matt.porter@linaro.org (Matt Porter)
Date: Fri, 1 Nov 2013 18:52:36 -0400
Subject: [PATCH v2 9/9] ARM: dts: add usb udc support to bcm281xx
In-Reply-To: <52741581.9020106@cogentembedded.com>
References: <1383335158-19730-1-git-send-email-matt.porter@linaro.org>
 <1383335158-19730-10-git-send-email-matt.porter@linaro.org>
 <52741581.9020106@cogentembedded.com>
Message-ID: <20131101225236.GB17505@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 01, 2013 at 11:56:33PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 11/01/2013 10:45 PM, Matt Porter wrote:
> 
> >Adds USB OTG/PHY and clock support to BCM281xx and enables
> >UDC support on the bcm11351-brt and bcm28155-ap boards.
> 
> >Signed-off-by: Matt Porter <matt.porter@linaro.org>
> >Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> >Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
> >---
> >  arch/arm/boot/dts/bcm11351-brt.dts |  6 ++++++
> >  arch/arm/boot/dts/bcm11351.dtsi    | 18 ++++++++++++++++++
> >  arch/arm/boot/dts/bcm28155-ap.dts  |  8 ++++++++
> >  3 files changed, 32 insertions(+)
> 
> [...]
> >diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
> >index 0755f43..247f9fd 100644
> >--- a/arch/arm/boot/dts/bcm11351.dtsi
> >+++ b/arch/arm/boot/dts/bcm11351.dtsi
> >@@ -284,4 +284,22 @@
> >  			#clock-cells = <0>;
> >  		};
> >  	};
> >+
> >+	usbotg: usbotg at 3f120000 {
> 
>    According to ePAPR spec [1], the node name should be "usb at 3f120000".

Will address in v3.

> >+		compatible = "snps,dwc2";
> >+		reg = <0x3f120000 0x10000>;
> >+		interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
> >+		clocks = <&usb_otg_ahb_clk>;
> >+		clock-names = "otg";
> >+		phys = <&usbphy>;
> >+		phy-names = "usb2-phy";
> >+		status = "disabled";
> >+	};
> >+
> >+	usbphy: usbphy at 3f130000 {
> 
>    This one should probably be named "usb-phy at 3f130000", just like
> "ethernet-phy" from the ePAPR spec.

Yes, agreed that will follow the same naming convention. I'll roll this
in v3. Thanks for the review.

-Matt

> >+		compatible = "brcm,kona-usb2-phy";
> >+		reg = <0x3f130000 0x28>;
> >+		#phy-cells = <0>;
> >+		status = "disabled";
> >+	};
> >  };
> 
> [1] http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf
> 
> WBR, Sergei
> 

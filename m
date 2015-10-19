From: chunfeng.yun@mediatek.com (chunfeng yun)
Date: Mon, 19 Oct 2015 13:31:27 +0800
Subject: [PATCH v10 3/3] arm64: dts: mediatek: add xHCI & usb phy for
 mt8173
In-Reply-To: <56237BF2.5070809@cogentembedded.com>
References: <1445140279-18121-1-git-send-email-chunfeng.yun@mediatek.com>
 <1445140279-18121-4-git-send-email-chunfeng.yun@mediatek.com>
 <56237BF2.5070809@cogentembedded.com>
Message-ID: <1445232687.28324.4.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2015-10-18 at 14:01 +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 10/18/2015 6:51 AM, Chunfeng Yun wrote:
> 
> > add xHCI and phy drivers for MT8173-EVB
> >
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> 
> [...]
> 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > index d18ee42..46f5f50 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> [...]
> > @@ -487,6 +488,47 @@
> >   			clock-names = "source", "hclk";
> >   			status = "disabled";
> >   		};
> > +
> > +		usb30: usb at 11270000 {
> > +			compatible = "mediatek,mt8173-xhci";
> > +			reg = <0 0x11270000 0 0x1000>,
> > +			      <0 0x11280700 0 0x0100>;
> > +			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_LOW>;
> > +			power-domains = <&scpsys MT8173_POWER_DOMAIN_USB>;
> > +			clocks = <&topckgen CLK_TOP_USB30_SEL>,
> > +				 <&pericfg CLK_PERI_USB0>,
> > +				 <&pericfg CLK_PERI_USB1>;
> > +			clock-names = "sys_ck",
> > +				      "wakeup_deb_p0",
> > +				      "wakeup_deb_p1";
> > +			phys = <&phy_port0 PHY_TYPE_USB3>,
> > +			       <&phy_port1 PHY_TYPE_USB2>;
> > +			mediatek,syscon-wakeup = <&pericfg>;
> > +			status = "okay";
> > +		};
> > +
> > +		u3phy: usb-phy at 11290000 {
> > +			compatible = "mediatek,mt8173-u3phy";
> > +			reg = <0 0x11290000 0 0x800>;
> > +			clocks = <&apmixedsys CLK_APMIXED_REF2USB_TX>;
> > +			clock-names = "u3phya_ref";
> > +			#address-cells = <2>;
> > +			#size-cells = <2>;
> > +			ranges;
> > +			status = "okay";
> 
>     Don't you need the "power-domains" prop here as well?
No, the power-domains of MAC and PHY are separated, but PHY's can't be
operated by software.

Thanks.
> 
> > +
> > +			phy_port0: port at 11290800 {
> > +				reg = <0 0x11290800 0 0x800>;
> > +				#phy-cells = <1>;
> > +				status = "okay";
> > +			};
> > +
> > +			phy_port1: port at 11291000 {
> > +				reg = <0 0x11291000 0 0x800>;
> > +				#phy-cells = <1>;
> > +				status = "okay";
> > +			};
> > +		};
> >   	};
> >   };
> >
> 
> MBR, Sergei
> 

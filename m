From: yong.wu@mediatek.com (Yong Wu)
Date: Tue, 14 Apr 2015 17:07:54 +0800
Subject: [PATCH 3/5] dt-bindings: mediatek: Add smi dts binding
In-Reply-To: <20150306111338.GD8700@leverpostej>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
 <1425638900-24989-4-git-send-email-yong.wu@mediatek.com>
 <20150306111338.GD8700@leverpostej>
Message-ID: <1429002474.14855.7.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,
    Thanks very much for review. 
    About the clock name should be the PoV of _this_ device. Could you
help check below?

On Fri, 2015-03-06 at 11:13 +0000, Mark Rutland wrote:
> On Fri, Mar 06, 2015 at 10:48:18AM +0000, yong.wu at mediatek.com wrote:
> > From: Yong Wu <yong.wu@mediatek.com>
> > 
> > This patch add smi binding document.
> 
> Please move binding documents to the start of the series. It makes
> things far easier to review.
> 
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi.txt
> > @@ -0,0 +1,17 @@
> > +SMI hardware block diagram please help check <bindings/iommu/mediatek,iommu.txt>
> > +
> > +Required properties:
> > +- compatible : must be "mediatek,mediatek,mt8173-smi-larb"
> 
> Double vendor prefix?
> 
> What does "larb" mean? It would be nice for the intorductory paragraph
> in this file to explain.
> 
> > +- reg : the register of each local arbiter
> > +- clocks : the clocks of each local arbiter
> > +- clock-name: larb_sub*(3 clockes at most)
> 
> The names required _must_ be specified here, or clock-names is
> pointless.
> 
> The clock names should be from the PoV of _this_ device (i.e. they
> should be the names of the inputs) not from the PoV of the provider
> (i.e. they should not be the names of the outputs from the provider).
> 
> Mark.
> 
     After we check with our SMI Designer. Every SMI local arbiter need
two clocks, which is called  APB clocks and SMI clock.
     APB clock : Advanced Peripheral Bus Clock. It is the clock for
setting the register of local arbiter.
     SMI clock : Smart Multimedia Interface Clock, It is the clock for
transfering the data and command. 

     And all the local arbiters need the smi common clock, so we
separate it. 

     Then I prepare to design the smi the dtsi like this: 

      smi_common:smi at 14022000 {
                 compatible = ?mediate, mt8173-smi?;
                 reg = <0 0x14022000 0 0x1000>;
                 clocks = <&mmsys MM_SMI_COMMON>;
                 clocks-names = ?smi_common?;
      };

      larb0: larb at 14021000 {
                 compatible = ?mediate, mt8173-smi-larb?;
                 reg = <0 0x14021000 0 0x1000>;
                 smi = <&smi_common>;
                 clocks = <&mmsys MM_SMI_LARB0>, 
		 	<&mmsys MM_SMI_LARB0>;
                 clocks-names = ?apb_clk?, ?smi_clk?;
     };

     larb1: larb at 16010000 {
                 compatible = ?mediate, mt8173-smi-larb?;
                 reg = <0 0x16010000 0 0x1000>;
                 smi = <&smi_common>;
                 clocks = <&vdecsys VDEC_CKEN>, 
			 <&mmsys VDEC_LARB_CKEN>;
                 clocks-names = ?apb_clk?, ?smi_clk?;
      };
      ? 
     In some local arbiter, the source clock of the APB clock and the
SMI clock may be the same, like larb0. so the two clocks are the same.
And they may be different in other local arbiteres, like larb1.      

     If it is designed like this, is it ok?

> > +
> > +Example:
> > +	larb1:larb at 16010000 {
> > +	        compatible = "mediatek,mt8173-smi-larb";
> > +		reg = <0 0x16010000 0 0x1000>;
> > +		clocks = <&mmsys MM_SMI_COMMON>,
> > +		        <&vdecsys VDEC_CKEN>,
> > +                        <&vdecsys VDEC_LARB_CKEN>;
> > +		clock-names = "larb_sub0", "larb_sub1", "larb_sub2";
> > +	};
> > -- 
> > 1.8.1.1.dirty
> > 
> > 

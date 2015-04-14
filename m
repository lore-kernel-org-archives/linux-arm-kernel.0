From: yong.wu@mediatek.com (Yong Wu)
Date: Tue, 14 Apr 2015 21:55:42 +0800
Subject: [PATCH 3/5] dt-bindings: mediatek: Add smi dts binding
In-Reply-To: <1429019389.16264.5.camel@mhfsdcap03>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
 <1425638900-24989-4-git-send-email-yong.wu@mediatek.com>
 <20150306111338.GD8700@leverpostej> <1429002474.14855.7.camel@mhfsdcap03>
 <20150414100657.GB28709@leverpostej> <1429019389.16264.5.camel@mhfsdcap03>
Message-ID: <1429019742.16400.1.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-04-14 at 21:49 +0800, Yong Wu wrote:
> Hi Mark,
> 
> On Tue, 2015-04-14 at 11:06 +0100, Mark Rutland wrote:
> > On Tue, Apr 14, 2015 at 10:07:54AM +0100, Yong Wu wrote:
> > > Hi Mark,
> > >     Thanks very much for review. 
> > >     About the clock name should be the PoV of _this_ device. Could you
> > > help check below?
> > > 
> > > On Fri, 2015-03-06 at 11:13 +0000, Mark Rutland wrote:
> > > > On Fri, Mar 06, 2015 at 10:48:18AM +0000, yong.wu at mediatek.com wrote:
> > > > > From: Yong Wu <yong.wu@mediatek.com>
> > > > > 
> > > > > This patch add smi binding document.
> > > > 
> > > > Please move binding documents to the start of the series. It makes
> > > > things far easier to review.
> > > >  
> > > > What does "larb" mean? It would be nice for the intorductory paragraph
> > > > in this file to explain.
> > > > 
> > > > > +- reg : the register of each local arbiter
> > > > > +- clocks : the clocks of each local arbiter
> > > > > +- clock-name: larb_sub*(3 clockes at most)
> > > > 
> > > > The names required _must_ be specified here, or clock-names is
> > > > pointless.
> > > > 
> > > > The clock names should be from the PoV of _this_ device (i.e. they
> > > > should be the names of the inputs) not from the PoV of the provider
> > > > (i.e. they should not be the names of the outputs from the provider).
> > > > 
> > > > Mark.
> > > > 
> > >      After we check with our SMI Designer. Every SMI local arbiter need
> > > two clocks, which is called  APB clocks and SMI clock.
> > >      APB clock : Advanced Peripheral Bus Clock. It is the clock for
> > > setting the register of local arbiter.
> > >      SMI clock : Smart Multimedia Interface Clock, It is the clock for
> > > transfering the data and command. 
> > > 
> > >      And all the local arbiters need the smi common clock, so we
> > > separate it. 
> > > 
> > >      Then I prepare to design the smi the dtsi like this: 
> > > 
> > >       smi_common:smi at 14022000 {
> > >                  compatible = ?mediate, mt8173-smi?;
> > >                  reg = <0 0x14022000 0 0x1000>;
> > >                  clocks = <&mmsys MM_SMI_COMMON>;
> > >                  clocks-names = ?smi_common?;
> > >       };
> > > 
> > >       larb0: larb at 14021000 {
> > >                  compatible = ?mediate, mt8173-smi-larb?;
> > >                  reg = <0 0x14021000 0 0x1000>;
> > >                  smi = <&smi_common>;
> > >                  clocks = <&mmsys MM_SMI_LARB0>, 
> > > 		 	<&mmsys MM_SMI_LARB0>;
> > >                  clocks-names = ?apb_clk?, ?smi_clk?;
> > >      };
> > > 
> > >      larb1: larb at 16010000 {
> > >                  compatible = ?mediate, mt8173-smi-larb?;
> > >                  reg = <0 0x16010000 0 0x1000>;
> > >                  smi = <&smi_common>;
> > >                  clocks = <&vdecsys VDEC_CKEN>, 
> > > 			 <&mmsys VDEC_LARB_CKEN>;
> > >                  clocks-names = ?apb_clk?, ?smi_clk?;
> > >       };
> > >       ? 
> > >      In some local arbiter, the source clock of the APB clock and the
> > > SMI clock may be the same, like larb0. so the two clocks are the same.
> > > And they may be different in other local arbiteres, like larb1.      
> > > 
> > >      If it is designed like this, is it ok?
> > 
> > That looks pretty good; the clocks and names on the larb nodes seem
> > sensible.
> > 
> > The naming of the "smi_common" clock on the smi_common node looks a bit
> > odd though. Is that really what the clock input is called?
> > 
> > Mark.
>      After check with DE, the smi_common clock also have its APB clock
> and the smi clock(they have the same clock source).
>     And I prepare to delete "_clk" in all the clock-names.
>     So it may be like this:
>          smi_common:smi at 14022000 {
>                  compatible = ?mediate, mt8173-smi?;
>                   reg = <0 0x14022000 0 0x1000>;
>                   clocks = <&mmsys MM_SMI_COMMON>, 
> 			   <&mmsys MM_SMI_COMMON>;
>                   clocks-names = ?apk?,"smi";
>         };
>      How about this?
      Sorry, I wrote wrong, it should be 
      clock-names = ?apb?,"smi";
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

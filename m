From: yong.wu@mediatek.com (Yong Wu)
Date: Mon, 9 Mar 2015 20:18:34 +0800
Subject: [PATCH 5/5] dts: mt8173: Add iommu/smi nodes for mt8173
In-Reply-To: <CAGS+omDotK45t5a4FKpU9z2Bg=e9aWDpXt+mCX92CM-2ZMQGNg@mail.gmail.com>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
 <1425638900-24989-6-git-send-email-yong.wu@mediatek.com>
 <CAGS+omDotK45t5a4FKpU9z2Bg=e9aWDpXt+mCX92CM-2ZMQGNg@mail.gmail.com>
Message-ID: <1425903514.13300.35.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Daniel,

     Thanks very much. I will fix this in next version.

On Sat, 2015-03-07 at 23:20 +0800, Daniel Kurtz wrote:
> Hi Yong,
> 
> On Fri, Mar 6, 2015 at 6:48 PM,  <yong.wu@mediatek.com> wrote:
> > From: Yong Wu <yong.wu@mediatek.com>
> >
> > This patch add the iommu/larbs nodes for mt8173
> >
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8173.dtsi      |  60 ++++++++++++
> >  include/dt-bindings/iommu/mt8173-iommu-port.h | 127 ++++++++++++++++++++++++++
> >  2 files changed, 187 insertions(+)
> >  create mode 100644 include/dt-bindings/iommu/mt8173-iommu-port.h
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > index c2a057f..805a7cd 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > @@ -16,6 +16,7 @@
> >  #include <dt-bindings/reset-controller/mt8173-resets.h>
> >  #include "mt8173-pinfunc.h"
> >  #include <dt-bindings/clock/mt8173-clk.h>
> > +#include <dt-bindings/iommu/mt8173-iommu-port.h>
> >
> >  / {
> >         compatible = "mediatek,mt8173";
> > @@ -249,6 +250,65 @@
> >                         interrupts = <0 86 8>;
> >                         clocks = <&uart_clk>;
> >                 };
> > +
> > +               iommu: mmsys_iommu at 10205000 {
> > +                       compatible = "mediatek,mt8173-iommu";
> > +                       reg = <0 0x10205000 0 0x1000>;
> > +                       interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>;
> > +                       clocks = <&infrasys INFRA_M4U>;
> > +                       clock-names = "infra_m4u";
> > +                       larb = <&larb0 &larb1 &larb2 &larb3 &larb4 &larb5>;
> > +                       #iommu-cells = <1>;
> > +               };
> > +
> > +               larb0:larb at 14021000 {
> > +                       compatible = "mediatek,mt8173-smi-larb";
> > +                       reg = <0 0x14021000 0 0x1000>;
> > +                       clocks = <&mmsys MM_SMI_COMMON>, <&mmsys MM_SMI_LARB0>;
> > +                       clock-names = "larb_sub0", "larb_sub1";
> > +               };
> > +
> > +               larb1:larb at 16010000 {
> > +                       compatible = "mediatek,mt8173-smi-larb";
> > +                       reg = <0 0x16010000 0 0x1000>;
> > +                       clocks = <&mmsys MM_SMI_COMMON>,
> > +                                       <&vdecsys VDEC_CKEN>,
> > +                                       <&vdecsys VDEC_LARB_CKEN>;
> > +                       clock-names = "larb_sub0", "larb_sub1", "larb_sub2";
> > +               };
> > +
> > +               larb2:larb at 16010000 {
> 
> I think this one should be:
>    larb2: larb at 15001000 {
> 
> Also, I am not a devicetree expert, but I believe nodes are usually
> arranged in register order.
> If that is the case, the order, as unfortunate as this looks, should be:
> 
>  larb0: larb at 14021000
>  larb4: larb at 14027000
>  larb2: larb at 15001000
>  larb1: larb at 16010000
>  larb3: larb at 18001000
>  larb5: larb at 19001000
> 
> -Dan
> 
> 
> > +                       compatible = "mediatek,mt8173-smi-larb";
> > +                       reg = <0 0x15001000 0 0x1000>;
> > +                       clocks = <&mmsys MM_SMI_COMMON>,
> > +                                       <&imgsys IMG_LARB2_SMI>;
> > +                       clock-names = "larb_sub0", "larb_sub1";
> > +               };
> > +
> > +               larb3:larb at 18001000 {
> > +                       compatible = "mediatek,mt8173-smi-larb";
> > +                       reg = <0 0x18001000 0 0x1000>;
> > +                       clocks = <&mmsys MM_SMI_COMMON>,
> > +                                       <&vencsys VENC_CKE0>,
> > +                                       <&vencsys VENC_CKE1>;
> > +                       clock-names = "larb_sub0", "larb_sub1", "larb_sub2";
> > +               };
> > +
> > +               larb4:larb at 14027000 {
> > +                       compatible = "mediatek,mt8173-smi-larb";
> > +                       reg = <0 0x14027000 0 0x1000>;
> > +                       clocks = <&mmsys MM_SMI_COMMON>, <&mmsys MM_SMI_LARB4>;
> > +                       clock-names = "larb_sub0", "larb_sub1";
> > +               };
> > +
> > +               larb5:larb at 19001000 {
> > +                       compatible = "mediatek,mt8173-smi-larb";
> > +                       reg = <0 0x19001000 0 0x1000>;
> > +                       clocks = <&mmsys MM_SMI_COMMON>,
> > +                                       <&vencltsys VENCLT_CKE0>,
> > +                                       <&vencltsys VENCLT_CKE1>;
> > +                       clock-names = "larb_sub0", "larb_sub1", "larb_sub2";
> > +               };
> >         };
> >
> >  };
> > --
> > 1.8.1.1.dirty

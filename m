From: yong.wu@mediatek.com (Yong Wu)
Date: Wed, 29 Jul 2015 15:29:16 +0800
Subject: [PATCH v3 6/6] dts: mt8173: Add iommu/smi nodes for mt8173
In-Reply-To: <CAGS+omB5xS8LoQR9-S8iqhdsRb4OWQ_B656dJSincLZ9nby1ZA@mail.gmail.com>
References: <1437037475-9065-1-git-send-email-yong.wu@mediatek.com>
 <1437037475-9065-7-git-send-email-yong.wu@mediatek.com>
 <CAGS+omB5xS8LoQR9-S8iqhdsRb4OWQ_B656dJSincLZ9nby1ZA@mail.gmail.com>
Message-ID: <1438154956.25925.132.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-07-23 at 22:40 +0800, Daniel Kurtz wrote:
> Hi Yong,
> 
> On Thu, Jul 16, 2015 at 5:04 PM, Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > This patch add the iommu/larbs nodes for mt8173
> 
> To what tree does this apply?
> Please rebase these patches (especially this one) on an Matthias'
> current v4.2-next/for-next.

Hi Daniel,
    Sorry for reply so late. I will rebase these patch next time.
    And the m4u/smi dsti is based on clocks, So I have to add the
patches of the latest MTK clocks[1] locally, then prepare this iommu
dtsi patch.

[1]:http://lists.infradead.org/pipermail/linux-mediatek/2015-July/001800.html

> 
> 
> >
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8173.dtsi |   81 ++++++++++++++++++++++++++++++
> >  1 file changed, 81 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > index e81ac1f..7b8e73c 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > @@ -14,6 +14,7 @@
> >  #include <dt-bindings/clock/mt8173-clk.h>
> >  #include <dt-bindings/interrupt-controller/irq.h>
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/memory/mt8173-larb-port.h>
> >  #include <dt-bindings/power/mt8173-power.h>
> >  #include <dt-bindings/reset-controller/mt8173-resets.h>
> >  #include "mt8173-pinfunc.h"
> > @@ -240,6 +241,17 @@
> >                         reg = <0 0x10200620 0 0x20>;
> >                 };
> >
> > +               iommu: mmsys_iommu at 10205000 {
> 
> This name should be generic, like this (this comment really applies to
> the binding patch):
> 
>    iommu: iommu at 10205000

Thanks.

> 
> > +                       compatible = "mediatek,mt8173-m4u";
> > +                       reg = <0 0x10205000 0 0x1000>;
> > +                       interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>;
> > +                       clocks = <&infracfg CLK_INFRA_M4U>;
> > +                       clock-names = "bclk";
> > +                       mediatek,larb = <&larb0 &larb1 &larb2
> > +                                       &larb3 &larb4 &larb5>;
> 
> Tiny nit... please align the "&".
> 
> Otherwise, this one is:
> 
> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

Thanks very much. I will improve them next version.
Look forward to that line:)

> 
> Thanks!
> -Dan
> 
> > +                       #iommu-cells = <2>;
> > +               };
> > +
> >                 apmixedsys: clock-controller at 10209000 {
> >                         compatible = "mediatek,mt8173-apmixedsys";
> >                         reg = <0 0x10209000 0 0x1000>;
> > @@ -401,29 +413,98 @@
> >                         #clock-cells = <1>;
> >                 };
> >
> > +               larb0: larb at 14021000 {
> > +                       compatible = "mediatek,mt8173-smi-larb";
> > +                       reg = <0 0x14021000 0 0x1000>;
> > +                       mediatek,smi = <&smi_common>;
> > +                       power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
> > +                       clocks = <&mmsys CLK_MM_SMI_LARB0>,
> > +                                <&mmsys CLK_MM_SMI_LARB0>;
> > +                       clock-names = "apb", "smi";
> > +               };
> > +
> > +               smi_common: smi at 14022000 {
> > +                       compatible = "mediatek,mt8173-smi";
> > +                       reg = <0 0x14022000 0 0x1000>;
> > +                       power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
> > +                       clocks = <&mmsys CLK_MM_SMI_COMMON>,
> > +                                <&mmsys CLK_MM_SMI_COMMON>;
> > +                       clock-names = "apb", "smi";
> > +               };
> > +
> > +               larb4: larb at 14027000 {
> > +                       compatible = "mediatek,mt8173-smi-larb";
> > +                       reg = <0 0x14027000 0 0x1000>;
> > +                       mediatek,smi = <&smi_common>;
> > +                       power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
> > +                       clocks = <&mmsys CLK_MM_SMI_LARB4>,
> > +                                <&mmsys CLK_MM_SMI_LARB4>;
> > +                       clock-names = "apb", "smi";
> > +               };
> > +
> >                 imgsys: imgsys at 15000000 {
> >                         compatible = "mediatek,mt8173-imgsys", "syscon";
> >                         reg = <0 0x15000000 0 0x1000>;
> >                         #clock-cells = <1>;
> >                 };
> >
> > +               larb2: larb at 15001000 {
> > +                       compatible = "mediatek,mt8173-smi-larb";
> > +                       reg = <0 0x15001000 0 0x1000>;
> > +                       mediatek,smi = <&smi_common>;
> > +                       power-domains = <&scpsys MT8173_POWER_DOMAIN_ISP>;
> > +                       clocks = <&imgsys CLK_IMG_LARB2_SMI>,
> > +                                <&imgsys CLK_IMG_LARB2_SMI>;
> > +                       clock-names = "apb", "smi";
> > +               };
> > +
> >                 vdecsys: vdecsys at 16000000 {
> >                         compatible = "mediatek,mt8173-vdecsys", "syscon";
> >                         reg = <0 0x16000000 0 0x1000>;
> >                         #clock-cells = <1>;
> >                 };
> >
> > +               larb1: larb at 16010000 {
> > +                       compatible = "mediatek,mt8173-smi-larb";
> > +                       reg = <0 0x16010000 0 0x1000>;
> > +                       mediatek,smi = <&smi_common>;
> > +                       power-domains = <&scpsys MT8173_POWER_DOMAIN_VDEC>;
> > +                       clocks = <&vdecsys CLK_VDEC_CKEN>,
> > +                                <&vdecsys CLK_VDEC_LARB_CKEN>;
> > +                       clock-names = "apb", "smi";
> > +               };
> > +
> >                 vencsys: vencsys at 18000000 {
> >                         compatible = "mediatek,mt8173-vencsys", "syscon";
> >                         reg = <0 0x18000000 0 0x1000>;
> >                         #clock-cells = <1>;
> >                 };
> >
> > +               larb3: larb at 18001000 {
> > +                       compatible = "mediatek,mt8173-smi-larb";
> > +                       reg = <0 0x18001000 0 0x1000>;
> > +                       mediatek,smi = <&smi_common>;
> > +                       power-domains = <&scpsys MT8173_POWER_DOMAIN_VENC>;
> > +                       clocks = <&vencsys CLK_VENC_CKE1>,
> > +                                <&vencsys CLK_VENC_CKE0>;
> > +                       clock-names = "apb", "smi";
> > +               };
> > +
> >                 vencltsys: vencltsys at 19000000 {
> >                         compatible = "mediatek,mt8173-vencltsys", "syscon";
> >                         reg = <0 0x19000000 0 0x1000>;
> >                         #clock-cells = <1>;
> >                 };
> > +
> > +               larb5: larb at 19001000 {
> > +                       compatible = "mediatek,mt8173-smi-larb";
> > +                       reg = <0 0x19001000 0 0x1000>;
> > +                       mediatek,smi = <&smi_common>;
> > +                       power-domains = <&scpsys MT8173_POWER_DOMAIN_VENC_LT>;
> > +                       clocks = <&vencltsys CLK_VENCLT_CKE1>,
> > +                                <&vencltsys CLK_VENCLT_CKE0>;
> > +                       clock-names = "apb", "smi";
> > +               };
> >         };
> >  };
> >
> > --
> > 1.7.9.5
> >
> 
> 
> 

From: koro.chen@mediatek.com (Koro Chen)
Date: Mon, 13 Jul 2015 15:19:29 +0800
Subject: [PATCH v2] arm64: dts: mt8173: Add afe device node
In-Reply-To: <CAGS+omBqO6Zcw9KuN6p9YDvRD=UfmOnokUPeRo-iv6ruTBChwg@mail.gmail.com>
References: <1436412725-55129-1-git-send-email-koro.chen@mediatek.com>
 <CAGS+omBqO6Zcw9KuN6p9YDvRD=UfmOnokUPeRo-iv6ruTBChwg@mail.gmail.com>
Message-ID: <1436771969.15768.6.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-07-09 at 18:45 +0800, Daniel Kurtz wrote:
> On Thu, Jul 9, 2015 at 11:32 AM, Koro Chen <koro.chen@mediatek.com> wrote:
> > This adds afe (audio front end) device node to the MT8173 dtsi file.
> >
> > Signed-off-by: Koro Chen <koro.chen@mediatek.com>
> 
> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> 
> I believe this patch depends on the fix in:
> https://patchwork.kernel.org/patch/6752521/  
> 
> If so, I think it would have been better to upload them together and
> mention the dependency in the cover letter.
> However, now that they are both on the list, we just need to ensure
> they are merged together.

The above patch was already merged, so now it is OK to merge this one
(If there is no problem for this patch, of course)
> 
> -Dan
> 
> 
> > ---
> > This patch is based on Matthias's tree:
> > https://github.com/mbgg/linux-mediatek
> > branch: v4.2-next/arm64
> >
> > Changes since v1:
> > - change node name to afe: audio-controller at 11220000
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > index 0696f8f..ce9255a 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > @@ -14,6 +14,7 @@
> >  #include <dt-bindings/clock/mt8173-clk.h>
> >  #include <dt-bindings/interrupt-controller/irq.h>
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/power/mt8173-power.h>
> >  #include <dt-bindings/reset-controller/mt8173-resets.h>
> >  #include "mt8173-pinfunc.h"
> >
> > @@ -393,6 +394,37 @@
> >                         #size-cells = <0>;
> >                         status = "disabled";
> >                 };
> > +
> > +               afe: audio-controller at 11220000  {
> > +                       compatible = "mediatek,mt8173-afe-pcm";
> > +                       reg = <0 0x11220000 0 0x1000>;
> > +                       interrupts = <GIC_SPI 134 IRQ_TYPE_EDGE_FALLING>;
> > +                       power-domains = <&scpsys MT8173_POWER_DOMAIN_AUDIO>;
> > +                       clocks = <&infracfg CLK_INFRA_AUDIO>,
> > +                                <&topckgen CLK_TOP_AUDIO_SEL>,
> > +                                <&topckgen CLK_TOP_AUD_INTBUS_SEL>,
> > +                                <&topckgen CLK_TOP_APLL1_DIV0>,
> > +                                <&topckgen CLK_TOP_APLL2_DIV0>,
> > +                                <&topckgen CLK_TOP_I2S0_M_SEL>,
> > +                                <&topckgen CLK_TOP_I2S1_M_SEL>,
> > +                                <&topckgen CLK_TOP_I2S2_M_SEL>,
> > +                                <&topckgen CLK_TOP_I2S3_M_SEL>,
> > +                                <&topckgen CLK_TOP_I2S3_B_SEL>;
> > +                       clock-names = "infra_sys_audio_clk",
> > +                                     "top_pdn_audio",
> > +                                     "top_pdn_aud_intbus",
> > +                                     "bck0",
> > +                                     "bck1",
> > +                                     "i2s0_m",
> > +                                     "i2s1_m",
> > +                                     "i2s2_m",
> > +                                     "i2s3_m",
> > +                                     "i2s3_b";
> > +                       assigned-clocks = <&topckgen CLK_TOP_AUD_1_SEL>,
> > +                                         <&topckgen CLK_TOP_AUD_2_SEL>;
> > +                       assigned-clock-parents = <&topckgen CLK_TOP_APLL1>,
> > +                                                <&topckgen CLK_TOP_APLL2>;
> > +               };
> >         };
> >  };
> >
> > --
> > 1.8.1.1.dirty
> >

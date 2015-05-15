From: djkurtz@chromium.org (Daniel Kurtz)
Date: Fri, 15 May 2015 22:17:43 +0800
Subject: [PATCH 4/4] ARM64: MediaTek MT8173: Add SCPSYS device node
In-Reply-To: <1431349882-12260-5-git-send-email-s.hauer@pengutronix.de>
References: <1431349882-12260-1-git-send-email-s.hauer@pengutronix.de>
 <1431349882-12260-5-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CAGS+omAWBHMgY45qrqU-ERDEniscoJ+NgVWVjT=kTKMHPdWyEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 11, 2015 at 9:11 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> This adds the SCPSYS device node to the MT8173 dtsi file.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 924fdb6..3c569b5 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -125,6 +125,18 @@
>                                                 <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
>                 };
>
> +               scpsys: scpsys at 10006000 {
> +                       compatible = "mediatek,mt8173-scpsys";
> +                       #power-domain-cells = <1>;
> +                       reg = <0 0x10006000 0 0x1000>;
> +                       clocks = <&topckgen CLK_TOP_VDEC_SEL>,
> +                               <&topckgen CLK_TOP_MFG_SEL>,
> +                               <&topckgen CLK_TOP_VENC_SEL>,
> +                               <&topckgen CLK_TOP_MM_SEL>,
> +                               <&topckgen CLK_TOP_VENC_LT_SEL>;
> +                       clock-names = "vdec", "mfg", "venc", "disp", "ven2";

(1) I think people like to align multi-line dts field values, so there
should be one more ' ' before each <&topckgen ...>.

(2) it is a bit awkward that these names do not match their clock
names.  This seems more straightforward:

  clock-names = "vdec", "mfg", "venc", "mm", "venc_lt";

(3) the scpsys binding patch does not list the clock fields.

(4) I don't think a patch with these CLK_TOP_* has been sent to the
list for review yet.

Thanks,
-Dan

> +               };
> +
>                 sysirq: intpol-controller at 10200620 {
>                         compatible = "mediatek,mt8173-sysirq",
>                                         "mediatek,mt6577-sysirq";
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

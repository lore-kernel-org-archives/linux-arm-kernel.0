From: djkurtz@chromium.org (Daniel Kurtz)
Date: Fri, 22 May 2015 12:19:25 +0800
Subject: [PATCH 5/5] ARM64: MediaTek MT8173: Add SCPSYS device node
In-Reply-To: <1432262503.14396.14.camel@mtksdaap41>
References: <1432131540-2523-1-git-send-email-s.hauer@pengutronix.de>
 <1432131540-2523-6-git-send-email-s.hauer@pengutronix.de>
 <CAGS+omDHEY54TzhNTJcFOeHkGbXAQwiTh9gxc=PsbzjwmpHEDA@mail.gmail.com>
 <20150521174916.GQ6325@pengutronix.de> <1432262503.14396.14.camel@mtksdaap41>
Message-ID: <CAGS+omB4j0YyTP5e4q_jXY2TOA1MTD-dPvsKJMAmj5NooWHxeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 22, 2015 at 10:41 AM, James Liao <jamesjj.liao@mediatek.com> wrote:
> Hi Daniel,
>
> On Thu, 2015-05-21 at 19:49 +0200, Sascha Hauer wrote:
>> On Thu, May 21, 2015 at 10:32:40PM +0800, Daniel Kurtz wrote:
>> > > +               scpsys: scpsys at 10006000 {
>> > > +                       compatible = "mediatek,mt8173-scpsys";
>> > > +                       #power-domain-cells = <1>;
>> > > +                       reg = <0 0x10006000 0 0x1000>;
>> > > +                       clocks = <&clk26m>,
>> >
>> > Why is mfg using <&clk26m> and not <&topckgen CLK_TOP_MFG_SEL>?
>>
>> Because James Liao said to me that it is derived from clk26m and not
>> from mfg_sel.
>
> Sascha is right. I had confirmed with our designer that MFG on MT8173
> uses clk26m to check state. I also tested MFG domain power on/off with
> CLK_TOP_MFG_SEL off and it worked correctly.

Wait - the designer said to use clk26m, but you tested with CLK_TOP_MFG_SEL.
Now I am even more confused.
Which is the correct clock to use for the mfg power domains?

>
>> > I saw another patch set on the list today from James Liao that adds more clocks.
>> > Perhaps we can move the SCPSYS set on top of that one and include more clocks?
>> >
>> > > +                                <&topckgen CLK_TOP_MM_SEL>;
>
> The clocks used by scpsys driver are subsystem bus clocks that need to
> be on before power on these domains. On MT8173, subsystem bus clocks are
> come from topckgen.
>
> My patch set yesterday add subsystem clocks, which are not needed by
> power domain on/off. So I think these 2 patch set are independent.

In other versions of the SCPSYS patch set, the scpsys node has
additional "subsystem bus clocks".
So will we need additional patches later to add back these additional
clocks which have been removed from the current version of this pach?
In other words, will there be a follow up patch like below, plus
another patch to add these clocks to "enum clk_id":

@@ -163,9 +163,12 @@
  compatible = "mediatek,mt8173-scpsys";
  #power-domain-cells = <1>;
  reg = <0 0x10006000 0 0x1000>;
- clocks = <&clk26m>,
- <&topckgen CLK_TOP_MM_SEL>;
- clock-names = "mfg", "mm";
+ clocks = <&topckgen CLK_TOP_MFG_SEL>,
+ <&topckgen CLK_TOP_MM_SEL>,
+ <&topckgen CLK_TOP_VDEC_SEL>,
+ <&topckgen CLK_TOP_VENC_SEL>,
+ <&topckgen CLK_TOP_VENC_LT_SEL>;
+ clock-names = "mfg", "mm", "vdec", "venc", "venc_lt";
  infracfg = <&infracfg>;
  };


@@ -57,7 +57,10 @@ enum clk_id {
  MT8173_CLK_NONE,
  MT8173_CLK_MM,
  MT8173_CLK_MFG,
- MT8173_CLK_MAX = MT8173_CLK_MFG,
+ MT8173_CLK_VDEC,
+ MT8173_CLK_VENC,
+ MT8173_CLK_VENC_LT,
+ MT8173_CLK_MAX = MT8173_CLK_VENC_LT,
 };


If so, is there a reason we cannot just include these clocks in the
current version of the SCPSYS driver?

Best,
-Dan

>
>
> Best regards,
>
> James
>
>

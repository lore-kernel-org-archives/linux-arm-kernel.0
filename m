From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Mon, 2 Oct 2017 18:49:09 +0800
Subject: [PATCH 01/12] mmc: dt-bindings: update Mediatek MMC bindings
In-Reply-To: <1506650162.19851.12.camel@mhfsdcap03>
References: <1505207272-16983-1-git-send-email-chaotian.jing@mediatek.com>
 <1505207272-16983-2-git-send-email-chaotian.jing@mediatek.com>
 <20170913141026.43oh4n4foipmahsk@rob-hp-laptop>
 <1505355021.8308.4.camel@mhfsdcap03>
 <CAPDyKFrUe-0hEsxVRQSZvujcXY8WrR6m-0DMW=VwDDLvz7Lexw@mail.gmail.com>
 <1506475100.19851.9.camel@mhfsdcap03>
 <1506650162.19851.12.camel@mhfsdcap03>
Message-ID: <1506941349.24270.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-09-29 at 09:56 +0800, Chaotian Jing wrote:
> On Wed, 2017-09-27 at 09:18 +0800, Chaotian Jing wrote:
> > On Wed, 2017-09-27 at 00:33 +0200, Ulf Hansson wrote:
> > > On 14 September 2017 at 04:10, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> > > > On Wed, 2017-09-13 at 09:10 -0500, Rob Herring wrote:
> > > >> On Tue, Sep 12, 2017 at 05:07:41PM +0800, Chaotian Jing wrote:
> > > >> > Change the comptiable for support of multi-platform
> > > >> > Add description for reg
> > > >> > Add description for source_cg
> > > >> > Add description for mediatek,latch-ck
> > > >>
> > > >> This is at least the 3rd patch with exactly the same vague subject.
> > > >> Please make the subject somewhat unique.
> > > >>
> > > > Thx, will change the subject at next version
> > > >> >
> > > >> > Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> > > >> > ---
> > > >> >  Documentation/devicetree/bindings/mmc/mtk-sd.txt | 13 ++++++++++---
> > > >> >  1 file changed, 10 insertions(+), 3 deletions(-)
> > > >> >
> > > >> > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > > >> > index 4182ea3..405cd06 100644
> > > >> > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > > >> > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > > >> > @@ -7,10 +7,15 @@ This file documents differences between the core properties in mmc.txt
> > > >> >  and the properties used by the msdc driver.
> > > >> >
> > > >> >  Required properties:
> > > >> > -- compatible: Should be "mediatek,mt8173-mmc","mediatek,mt8135-mmc"
> > > >> > +- compatible: value should be either of the following.
> > > >> > +   "mediatek,mt8135-mmc": for mmc host ip compatible with mt8135
> > > >> > +   "mediatek,mt8173-mmc": for mmc host ip compatible with mt8173
> > > >> > +   "mediatek,mt2701-mmc": for mmc host ip compatible with mt2701
> > > >> > +   "mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
> > > >> > +- reg: physical base address of the controller and length
> > > >> >  - interrupts: Should contain MSDC interrupt number
> > > >> > -- clocks: MSDC source clock, HCLK
> > > >> > -- clock-names: "source", "hclk"
> > > >> > +- clocks: MSDC source clock, HCLK, source_cg
> > > >> > +- clock-names: "source", "hclk", "source_cg"
> > > >>
> > > >> All chips support source_cg? That's not backwards compatible for
> > > >> existing compatible strings if the driver requires it.
> > > > Not all chips support source_cg, for chips which do not support
> > > > source_cg, no need source_cg here, and the driver will parse it
> > > > to know if current chip support it.
> > > 
> > > In such case you must not add add a required binding for it. I think
> > > that is what Rob is trying to point out for you.
> > > 
> > > [...]
> > > 
> > > Kind regards
> > > Uffe
> > The source_cg is required(MUST) at MT2712 and future SoCs, but not
> > required(do not have it) at previous SoCs, so that put it at required
> > properties, let the driver to handle it.
> 
> Any other comments about it ? still must not add a required binding for
> it ? if add a optional binding for it, how to add it ? as cannot
> duplicate "clocks" & "clock-names" in one node.


Chaotian,

You can follow examples of scpsys [1]:

- clock, clock-names: clocks according to the common clock binding.
                      These are clocks which hardware needs to be
                      enabled before enabling certain power domains.
	Required clocks for MT2701: "mm", "mfg", "ethif"
	Required clocks for MT6797: "mm", "mfg", "vdec"
	Required clocks for MT8173: "mm", "mfg", "venc", "venc_lt"

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/tree/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt?h=v4.13.4

Joe.C

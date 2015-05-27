From: yong.wu@mediatek.com (Yong Wu)
Date: Wed, 27 May 2015 14:12:49 +0800
Subject: [PATCH 3/5] dt-bindings: ARM: Mediatek: Document devicetree
 bindings for clock controllers
In-Reply-To: <20150526110819.GI6325@pengutronix.de>
References: <1432192376-6712-1-git-send-email-jamesjj.liao@mediatek.com>
 <1432192376-6712-4-git-send-email-jamesjj.liao@mediatek.com>
 <20150526075643.GF6325@pengutronix.de>
 <1432630536.15597.16.camel@mtksdaap41>
 <20150526110819.GI6325@pengutronix.de>
Message-ID: <1432707169.721.81.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-05-26 at 13:08 +0200, Sascha Hauer wrote:
> On Tue, May 26, 2015 at 04:55:36PM +0800, James Liao wrote:
> > Hi Sascha,
> > 
> > On Tue, 2015-05-26 at 09:56 +0200, Sascha Hauer wrote:
> > > On Thu, May 21, 2015 at 03:12:54PM +0800, James Liao wrote:
> > > > This adds the binding documentation for the mmsys, imgsys, vdecsys,
> > > > vencsys and vencltsys controllers found on Mediatek SoCs.
> > > > 
> > > > index 0000000..a5b94a7
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
> > > > +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencltsys.txt
> > > > +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt
> > > 
> > > Do these really become multiple drivers so that it's worth abstracting
> > > them in the clock framework?
> > 
> > These clocks need to be controlled among several drivers. For example,
> > vdecsys clocks will be controlled by VDEC driver (not ready yet) and
> > MT8173 SMI driver [1]. That means these clocks need a mechanism to share
> > between these 2 drivers. CCF share clocks by using of reference count,
> > so I think it's suitable to implement these subsystem clocks.
> > 
> > As I know SMI driver need to access clocks among mmsys, imgsys, vdecsys,
> > vencsys and vencltsys. So in this patch I added clocks of these
> > subsystems into CCF.
> > 
> > [1]
> > http://lists.infradead.org/pipermail/linux-mediatek/2015-March/000058.html
> 
> Looking at the 3.18 tree we have this:
> 
> 	vdecsys: vdecsys at 16000000 {
> 		compatible = "mediatek,mt8173-vdecsys", "syscon";
> 		reg = <0 0x16000000 0 0x1000>;
> 		#clock-cells = <1>;
> 	};
> 
> 	larb1:larb at 16010000 {
> 		compatible = "mediatek,mt8173-smi-larb";
> 		reg = <0 0x16010000 0 0x1000>;
> 		clocks = <&mmsys MM_SMI_COMMON>,
> 			 <&vdecsys VDEC_CKEN>,
> 			 <&vdecsys VDEC_LARB_CKEN>;
> 		clock-names = "larb_sub0", "larb_sub1", "larb_sub2";
> 	};
> 
> I believe that the larb needs the MM_SMI_COMMON clock to modify the larb
> registers, but is it really necessary to enable VDEC_CKEN and
> VDEC_LARB_CKEN just to set the F_SMI_MMU_EN bit in the larb?
Yes. SMI need the two clock while smi work.
the lastest smi binding is [1].
smi need "apb" and "smi" clocks.

[1]http://lists.linuxfoundation.org/pipermail/iommu/2015-May/013025.html

> 
> With the above we have the situation that the vdec driver calls into the
> iommu driver which then calls into the larb driver which calls back into
> the vdec driver via the clk API. This seems very suspicious.
iommu driver will call into the larb driver.
but I don't think the larb driver will call into the vdec driver. is it
right?

At the end of the latest smi driver[2].
smi has provide two interface. the multimedia HW could call it to enable
smi clock, then they can delete some node like <&vdecsys VDEC_CKEN>. in
their dtsi.
//=====
+int mtk_smi_larb_get(struct device *plarbdev);
+void mtk_smi_larb_put(struct device *plarbdev);
//=====
 SMI only help control the smi relational clockes.
The other clocks of multimedia module also should control theirself.

[2]http://lists.linuxfoundation.org/pipermail/iommu/2015-May/013030.html

> 
> Sascha
> 

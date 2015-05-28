From: yong.wu@mediatek.com (Yong Wu)
Date: Thu, 28 May 2015 13:14:46 +0800
Subject: [PATCH 3/5] dt-bindings: ARM: Mediatek: Document devicetree
 bindings for clock controllers
In-Reply-To: <20150527072759.GS6325@pengutronix.de>
References: <1432192376-6712-1-git-send-email-jamesjj.liao@mediatek.com>
 <1432192376-6712-4-git-send-email-jamesjj.liao@mediatek.com>
 <20150526075643.GF6325@pengutronix.de>
 <1432630536.15597.16.camel@mtksdaap41>
 <20150526110819.GI6325@pengutronix.de> <1432707169.721.81.camel@mhfsdcap03>
 <20150527072759.GS6325@pengutronix.de>
Message-ID: <1432790086.721.199.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-05-27 at 09:27 +0200, Sascha Hauer wrote:
> On Wed, May 27, 2015 at 02:12:49PM +0800, Yong Wu wrote:
> > On Tue, 2015-05-26 at 13:08 +0200, Sascha Hauer wrote:
> > > On Tue, May 26, 2015 at 04:55:36PM +0800, James Liao wrote:
> > > > Hi Sascha,
> > > > 
> > > > On Tue, 2015-05-26 at 09:56 +0200, Sascha Hauer wrote:
> > > > > On Thu, May 21, 2015 at 03:12:54PM +0800, James Liao wrote:
> > > > > > This adds the binding documentation for the mmsys, imgsys, vdecsys,
> > > > > > vencsys and vencltsys controllers found on Mediatek SoCs.
> > > > > > 
> > > > > > index 0000000..a5b94a7
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
> > > > > > +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencltsys.txt
> > > > > > +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt
> > > > > 
> > > > > Do these really become multiple drivers so that it's worth abstracting
> > > > > them in the clock framework?
> > > > 
> > > > These clocks need to be controlled among several drivers. For example,
> > > > vdecsys clocks will be controlled by VDEC driver (not ready yet) and
> > > > MT8173 SMI driver [1]. That means these clocks need a mechanism to share
> > > > between these 2 drivers. CCF share clocks by using of reference count,
> > > > so I think it's suitable to implement these subsystem clocks.
> > > > 
> > > > As I know SMI driver need to access clocks among mmsys, imgsys, vdecsys,
> > > > vencsys and vencltsys. So in this patch I added clocks of these
> > > > subsystems into CCF.
> > > > 
> > > > [1]
> > > > http://lists.infradead.org/pipermail/linux-mediatek/2015-March/000058.html
> > > 
> > > Looking at the 3.18 tree we have this:
> > > 
> > > 	vdecsys: vdecsys at 16000000 {
> > > 		compatible = "mediatek,mt8173-vdecsys", "syscon";
> > > 		reg = <0 0x16000000 0 0x1000>;
> > > 		#clock-cells = <1>;
> > > 	};
> > > 
> > > 	larb1:larb at 16010000 {
> > > 		compatible = "mediatek,mt8173-smi-larb";
> > > 		reg = <0 0x16010000 0 0x1000>;
> > > 		clocks = <&mmsys MM_SMI_COMMON>,
> > > 			 <&vdecsys VDEC_CKEN>,
> > > 			 <&vdecsys VDEC_LARB_CKEN>;
> > > 		clock-names = "larb_sub0", "larb_sub1", "larb_sub2";
> > > 	};
> > > 
> > > I believe that the larb needs the MM_SMI_COMMON clock to modify the larb
> > > registers, but is it really necessary to enable VDEC_CKEN and
> > > VDEC_LARB_CKEN just to set the F_SMI_MMU_EN bit in the larb?
> > Yes. SMI need the two clock while smi work.
> > the lastest smi binding is [1].
> > smi need "apb" and "smi" clocks.
> > 
> > [1]http://lists.linuxfoundation.org/pipermail/iommu/2015-May/013025.html
> > 
> > > 
> > > With the above we have the situation that the vdec driver calls into the
> > > iommu driver which then calls into the larb driver which calls back into
> > > the vdec driver via the clk API. This seems very suspicious.
> > iommu driver will call into the larb driver.
> > but I don't think the larb driver will call into the vdec driver. is it
> > right?
> 
> When the larb has clocks from the vdec like in the above example from
> the 3.18 kernel then the larb indirectly via the clk API writes to the
> vdec register space.
> In the latest code you referenced the vdec clocks are no longer assigned
> to the larbs. This means we no longer need the vdec clocks abstracted in
> CCF.
Hi Sascha,
  Sorry. I don't understand "assigned to the larbs" very well.
  The latest SMI driver will call all the local arbiters, It will create
a device for each local arbiter and use their clocks. SMI need enable
the clock to enable/disable iommu and transfer data from EMI for each
multimedia module. 

  Now we focus on the necessity of putting the clocks of subsystem into
CCF.
  
   Vdec only have 2 clocks, Both vdec and SMI need them.
   I take the venc for example.
   venc has 4 clock as below.
     <&vencsys VENC_CKE0>,
     <&vencsys VENC_CKE1>,
     <&vencsys VENC_CKE2>,
     <&vencsys VENC_CKE3>,
   SMI and venc need VENC_CKE0 and VENC_CKE1 both.
   VENC_CKE2 is the clock for jpeg encode.
   VENC_CKE3 is the clock for jpeg decode.
   The four clocks are in the same register.
   And while venc HW working, we also need smi common clock which is in
display subsystem.
  
   Then how to share the clocks between smi and multimedia subsystem.
   A. write the clock register directly in each module.
      ->SMI can not access the register of venc/vdec,this may be wrong.
   B. The multimedia subsystem provide the enable/disable clock
interface, Then smi call it.
      ->There are so many multimedia subsystem, such as display, vdec,
venc, mdp, camera,jpg. if all of them offer the clock interface, then
smi call them. The interface will be so many! even though SMI allow to
register clock callback for each local arbiter.
      Take a example, If jpg need work, SMI should enable the clock of
larb3(venc) and the smi common clock in display subsystem.
      This will strengthen the relationship of all multimedia modules.
      The relationship of clocks may be confuse.
   C. CCF.
      ->if we use ccf, the code may be easier to read.
 
   Could you help give some suggestion about this.
> 
> Sascha
> 
> 

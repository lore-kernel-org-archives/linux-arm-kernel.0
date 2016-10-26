From: leoyang.li@nxp.com (Leo Li)
Date: Wed, 26 Oct 2016 22:09:07 +0000
Subject: [PATCH 1/6] dt/bindings: adjust bindings for Layerscape SCFG MSI
In-Reply-To: <20161026103101.GC19965@leverpostej>
References: <1477398945-22774-1-git-send-email-Minghuan.Lian@nxp.com>
 <20161026103101.GC19965@leverpostej>
Message-ID: <DB4PR04MB07813D4DA5D5567229394A7D8FAB0@DB4PR04MB0781.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland at arm.com]
> Sent: Wednesday, October 26, 2016 5:31 AM
> To: M.H. Lian <minghuan.lian@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org; Marc Zyngier <marc.zyngier@arm.com>; Stuart
> Yoder <stuart.yoder@nxp.com>; Leo Li <leoyang.li@nxp.com>; Scott Wood
> <scott.wood@nxp.com>; Shawn Guo <shawnguo@kernel.org>; Mingkai Hu
> <mingkai.hu@nxp.com>
> Subject: Re: [PATCH 1/6] dt/bindings: adjust bindings for Layerscape SCFG MSI
> 
> On Tue, Oct 25, 2016 at 08:35:40PM +0800, Minghuan Lian wrote:
> > 1. The different version of a SoC may have different MSI
> > implementation. But compatible "fsl,<soc-name>-msi" can not describe
> > the SoC version.
> 
> Surely, "fsl,<soc-name>-<rev>-msi" can describe this?
> 
> If the hardware differs, it needs a new compatible string.
> 
> If there's some configuration value that varies across revisions (e.g.
> number of slots), you can add a proeprty to describe that explciitly.
> 
> > The MSI driver will use SoC match interface to get SoC type and
> > version instead of compatible string. So all MSI node can use the
> > common compatible "fsl,ls-scfg-msi" and the original compatible is
> > unnecessary.
> >
> > 2. Layerscape SoCs may have one or several MSI controllers.
> > In order to increase MSI interrupt number of a PCIe, the patch moves
> > all MSI node into the parent node "msi-controller". So a PCIe can
> > request MSI from all the MSI controllers.
> 
> This is not necessary, and does not represent a real block of hardware.
> So NAK for this approach.
> 
> The msi-parent property can contain a list of MSI controllers. See the examples
> in Documentation/devicetree/bindings/interrupt-controller/msi.txt.
> Likewise, the msi-map property can map to a number of MSI controllers.
> 
> If the core code can only consider one at a time, then that's an issue to be
> addressed in core code, not one to be bodged around in bindings.
> 
> >
> > Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> > ---
> >  .../interrupt-controller/fsl,ls-scfg-msi.txt       | 57 +++++++++++++++++++---
> >  1 file changed, 49 insertions(+), 8 deletions(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-m
> > si.txt
> > b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-m
> > si.txt
> > index 9e38949..29f95fd 100644
> > ---
> > a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-m
> > si.txt
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-sc
> > +++ fg-msi.txt
> > @@ -1,18 +1,28 @@
> >  * Freescale Layerscape SCFG PCIe MSI controller
> >
> > +Layerscape SoCs may have one or multiple MSI controllers.
> > +Each MSI controller must be showed as a child node.
> > +
> >  Required properties:
> >
> > -- compatible: should be "fsl,<soc-name>-msi" to identify
> > -	      Layerscape PCIe MSI controller block such as:
> > -              "fsl,1s1021a-msi"
> > -              "fsl,1s1043a-msi"
> > +- compatible: should be "fsl,ls-scfg-msi"
> 
> This breaks old DTBs, and throws away information which you describe above as
> valuable. So another NAK for that.

I agree with you that we should maintain the backward compatibility.  But on the other hand, I just found that there is a silly typo in the original binding that "ls" is wrongly spelled as "1s" and they look too close to be noticed in previous patch reviews.  :(  The driver and all the DTSes used the binding with the typo which covered up the problem.  So even if we want to keep the "fsl,<soc-name>-msi" binding, we probably want to fix the typo, right?  And that breaks the backward compatibility too.

Regards,
Leo

From: yong.wu@mediatek.com (Yong Wu)
Date: Wed, 27 May 2015 15:36:04 +0800
Subject: [PATCH v2 2/6] dt-bindings: mediatek: Add smi dts binding
In-Reply-To: <CAAFQd5D_-FrVNNPfMTwaWgDHfOPWVnRCvBCV2JS6Q2xPUiEScA@mail.gmail.com>
References: <1431683009-18158-1-git-send-email-yong.wu@mediatek.com>
 <1431683009-18158-3-git-send-email-yong.wu@mediatek.com>
 <CAAFQd5D_-FrVNNPfMTwaWgDHfOPWVnRCvBCV2JS6Q2xPUiEScA@mail.gmail.com>
Message-ID: <1432712164.721.135.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,
	
On Mon, 2015-05-25 at 15:48 +0900, Tomasz Figa wrote:
> Hi,
> 
> Please see my comments inline.
> 
> On Fri, May 15, 2015 at 6:43 PM, Yong Wu <yong.wu@mediatek.com> wrote:
> > This patch add smi binding document.
> >
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  .../bindings/soc/mediatek/mediatek,smi-larb.txt    | 24 ++++++++++++++++++++++
> >  .../bindings/soc/mediatek/mediatek,smi.txt         | 22 ++++++++++++++++++++
> >  2 files changed, 46 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,smi-larb.txt
> >  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,smi.txt
> >
> > diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi-larb.txt b/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi-larb.txt
> > new file mode 100644
> > index 0000000..c06c5b6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi-larb.txt
> > @@ -0,0 +1,24 @@
> > +SMI(Smart Multimedia Interface) Local Arbiter
> > +
> > +The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
> > +
> > +Required properties:
> > +- compatible : must be "mediatek,mt8173-smi-larb"
> > +- reg : the register and size of each local arbiter.
> 
> Shouldn't it be "of this local arbiter"?
> 
> > +- smi : must be "&smi_common". Refer to bindings/soc/mediatek,smi.txt.
> 
> This is incorrect. Device tree source authors are free to use any
> labels for their nodes and documentation should not rely on the fact
> that there is some node with some particular label. This should be
> something like:
> 
> - smi : a phandle to node of XYZ
> 
> with proper description of that node in place of XYZ.
Thanks. how about this?
smi : a phandle to the smi_common node 
> 
> > +- clocks : must contain one entry for each clock-names.
> > +       There are 2 clockes:
> > +       APB clock : Advanced Peripheral Bus clock, It's the clock for setting
> > +               the register.
> > +       SMI clock : It's the clock for transfer data and command.
> 
> The description of each clock should go to "clock-names" property.
> Please use some of already existing bindings as an example.
> 
> > +- clock-name: must be "apb" and "smi".
> 
> typo: Should be "clock-names".
> 
> I'd recommend describing this property as below:
> 
> - clock-names: must contain 2 entries, as follows:
>   - "apb" : <here comes the description of APB clock>,
>   - "smi" : <here comes the description of SMI clock>.
Thanks. I will follow this.

> > +
> > +Example:
> > +       larb0:larb at 14021000 {
> > +               compatible = "mediatek,mt8173-smi-larb";
> > +               reg = <0 0x14021000 0 0x1000>;
> > +               smi = <&smi_common>;
> > +               clocks = <&mmsys MM_SMI_LARB0>,
> > +                        <&mmsys MM_SMI_LARB0>;
> > +               clock-names = "apb", "smi";
And another question,
Could I add a item(port-count) in larb node. like:
	          port-count = M4U_PORT_LARB0_NR;
This item will only check the portid in client dsti is right or not?
                   iommu = <&iommu larbid portid>

Then, the port-count is necessary to add? or we could assume all the
input is correct.

> > +       };
> > diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi.txt b/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi.txt
> > new file mode 100644
> > index 0000000..c2389b4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi.txt
> > @@ -0,0 +1,22 @@
> > +SMI(Smart Multimedia Interface)
> > +
> > +The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
> > +
> > +Required properties:
> > +- compatible : must be "mediatek,mt8173-smi"
> > +- reg : the register and size of the smi.
> 
> nit: s/smi/SMI block/
> 
> > +- clocks : must contain one entry for each clock-names.
> > +       There are 2 clockes:
> > +       APB clock : Advanced Peripheral Bus clock, It's the clock for setting
> > +               the register.
> > +       SMI clock : It's the clock for transfer data and command.
> > +- clock-name: must be "apb" and "smi".
> 
> See my comment for those properties in the first binding.
> 
> Best regards,
> Tomasz

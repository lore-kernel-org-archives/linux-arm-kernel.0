From: yong.wu@mediatek.com (Yong Wu)
Date: Mon, 17 Sep 2018 14:15:19 +0800
Subject: [PATCH 01/13] dt-bindings: mediatek: Add binding for mt8183
 IOMMU and SMI
In-Reply-To: <5b9f3f52.1c69fb81.a7f7c.f34e@mx.google.com>
References: <1535954502-30646-1-git-send-email-yong.wu@mediatek.com>
 <1535954502-30646-2-git-send-email-yong.wu@mediatek.com>
 <5b9f3f52.1c69fb81.a7f7c.f34e@mx.google.com>
Message-ID: <1537164919.12287.0.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2018-09-16 at 17:26 -0500, Rob Herring wrote:
> On Mon, Sep 03, 2018 at 02:01:30PM +0800, Yong Wu wrote:
> > This patch adds decriptions for mt8183 IOMMU and SMI.
> > 
> > mt8183 has one M4U like mt8173 and is also MTK IOMMU gen2 which
> > uses ARM Short-Descriptor translation table format.
> > 
> > The mt8183 M4U-SMI HW diagram is as below:
> > 
> >                           EMI
> >                            |
> >                           M4U
> >                            |
> >                        ----------
> >                        |        |
> >                    gals0-rx   gals1-rx
> >                        |        |
> >                        |        |
> >                    gals0-tx   gals1-tx
> >                        |        |
> >                       ------------
> >                        SMI Common
> >                       ------------
> >                            |
> >   +-----+-----+--------+-----+-----+-------+-------+
> >   |     |     |        |     |     |       |       |
> >   |     |  gals-rx  gals-rx  |   gals-rx gals-rx gals-rx
> >   |     |     |        |     |     |       |       |
> >   |     |     |        |     |     |       |       |
> >   |     |  gals-tx  gals-tx  |   gals-tx gals-tx gals-tx
> >   |     |     |        |     |     |       |       |
> > larb0 larb1  larb2   larb3  larb4 larb5  larb6    CCU
> > disp  vdec   IPU0    IPU1   venc  IPU1    cam
> > 
> > All the connections are HW fixed, SW can NOT adjust it.
> > 
> > Compared with mt8173, we add a GALS(Global Async Local Sync) module
> > between SMI-common and M4U, and additional between larb2/3/5/6 and
> > SMI-common. GALS can help synchronize for the modules in different
> > clock frequence, it can be seen as a "asynchronous fifo".
> 
> s/frequence/frequency/
> 
> 
> > GALS can only help transfer the command/data while it don't have the
> > register, thus it has the special "smi" clock and it don't have the
> > "apb" clock. From the diagram above, we add "gals0" and "gals1"
> > clockes for smi-common and add a "gals" clock for smi-larb.
> 
> s/clockes/clocks/
> s/don't/doesn't/
> 
> > From the diagram above, CCU(Camera Control Unit) is connected with
> > smi-common directly, we can look it as "larb7" but its register space
> > is different with the normal larb.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  .../devicetree/bindings/iommu/mediatek,iommu.txt   |  15 ++-
> >  .../memory-controllers/mediatek,smi-common.txt     |  11 +-
> >  .../memory-controllers/mediatek,smi-larb.txt       |   3 +
> >  include/dt-bindings/memory/mt8183-larb-port.h      | 130 +++++++++++++++++++++
> >  4 files changed, 153 insertions(+), 6 deletions(-)
> >  create mode 100644 include/dt-bindings/memory/mt8183-larb-port.h
> 
> With those fixed,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks Rob. I will fix them in next version.

> 

From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 18 May 2015 14:09:16 +0200
Subject: [RFC v2 PATCH 0/6] MT8173 IOMMU SUPPORT
In-Reply-To: <1431683009-18158-1-git-send-email-yong.wu@mediatek.com>
References: <1431683009-18158-1-git-send-email-yong.wu@mediatek.com>
Message-ID: <CABuKBe+3EOx1viFJzXKirY_J9g7ChN+TOZceBvnvff3PdKe7Aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yong,

2015-05-15 11:43 GMT+02:00 Yong Wu <yong.wu@mediatek.com>:
>   This patch adds support for m4u(Multimedia Memory Management Unit),
> Currently it only support the m4u with 2 levels of page table on mt8173.
>
>   It is based on Robin Murphy's arm64: IOMMU-backed DMA mapping[1].
>
>   Please check the hardware block diagram of Mediatek IOMMU.
>
>               EMI (External Memory Interface)
>                |
>               m4u (Multimedia Memory Management Unit)
>                |
>               smi (Smart Multimedia Interface)
>                |
>         +---------------+-------
>         |               |
>         |               |
>     vdec larb       disp larb      ... SoCs have different local arbiter(larb).
>         |               |
>         |               |
>    +----+----+    +-----+-----+
>    |    |    |    |     |     |    ...
>    |    |    |    |     |     |    ...
>    |    |    |    |     |     |    ...
>   MC   PP   VLD  OVL0 RDMA0 WDMA0  ... There are different ports in each larb.
>
>   Normally we specify a local arbiter(larb) for each multimedia hardware like
> display, video decode, video encode and camera. And there are different ports in
> each larb. Take a example, there are some ports like MC, PP, UFO, VLD, AVC_MV,
> PRED_RD, PRED_WR in video larb, all the ports are according to the video hardware.
>
>   From the diagram, all the multimedia module connect with m4u via smi.
> SMI is responsible to enable/disable iommu and control the clocks for each local
> arbiter. If we should enable the iommu of video decode, it should config the
> video's ports. And if the video hardware work wether enable/disable iommu,
> it should enable the clock of its larb's clock. So we add a special driver for smi.
>
> [1] http://lists.linuxfoundation.org/pipermail/iommu/2015-February/012236.html
>
> v2:
> -add arm short descriptor support.
> -seperate smi common from smi and change the clock-names according
>  to smi HW.
> -delete the hardcode of the port-names in mt8173.
>  replace this with larb-portes-nr in dtsi.
> -fix some coding style issues.
>
> v1:
> http://lists.infradead.org/pipermail/linux-mediatek/2015-March/000058.html
>
> Yong Wu (6):
>   dt-bindings: iommu: Add binding for mediatek IOMMU
>   dt-bindings: mediatek: Add smi dts binding
>   iommu: add ARM short descriptor page table allocator.
>   iommu/mediatek: Add mt8173 IOMMU driver
>   soc: mediatek: Add SMI driver
>   dts: mt8173: Add iommu/smi nodes for mt8173
>

Some general comments.
It seems that your patches are not based on v4.1.-rc1, can you please
fix this in the next version, they don't apply cleanly.
Please use the checkpatch script before sending the next version, I
had some whitespace errors reported when applying the series.

Thanks,
Matthias

-- 
motzblog.wordpress.com

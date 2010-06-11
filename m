From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 11 Jun 2010 12:25:26 +0200
Subject: s3c-hsotg fixes
In-Reply-To: <1276244457-4072-1-git-send-email-ben-linux@fluff.org>
References: <1276244457-4072-1-git-send-email-ben-linux@fluff.org>
Message-ID: <006c01cb0950$6ced3630$46c7a290$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Friday, June 11, 2010 10:21 AM Ben Dooks wrote:

> Some further fixes for the s3c-hsotg block, as well as a repost of
> the missed USB phy clock setting patch which either got missed or
> passed over from last time.
> 
> As a note, this series has a patch adding support for dedicated FIFO
> mode, this is in my view a fix, as when the hsotg block is compiled
> with dedicated fifos then each USB IN non-periodic pipe needs to be
> alloacted a unique TX FIFO. We have no actual data on how well the
> block performs when all IN TX NP FIFOs are all set to the same one,
> but it really should be fixed.

This patch series improves the driver a lot. Now it is possible to get
CDC Ethernet gadget working on S5PV210 SoC (Samsung Aquila machine).
However there are still some issues left to be resolved. I've noticed
the following things:

1. CDC Ethernet gadget: there are problems after unplugging and 
plugging the usb cable again while data is being transferred. To trigger
this it is enough to run 'ping host' command on the device and replug
the usb cable. After that no data packets are sent do the usb host
(checked with hardware usb analyser), although the ep0 control transfers
are performed correctly (device has been enumerated correctly).

2. RNDIS Ethernet gadget: after some stress tests I get an error, which
causes RNDIS session to hang (what is probably a direct result of the
otg block reinit/reset). Here is an example log:

[   69.155000] s3c-hsotg s3c-hsotg: s3c_hsotg_handle_rx: unknown status 00000000
[   69.155000] s3c-hsotg s3c-hsotg: DCFG=0x00040020, DCTL=0x00000000,
DIEPMSK=000000af
[   69.155000] s3c-hsotg s3c-hsotg: GAHBCFG=0x00000001, 0x44=0x00000000
[   69.155000] s3c-hsotg s3c-hsotg: GRXFSIZ=0x00000800, GNPTXFSIZ=0x04000800
[   69.155000] s3c-hsotg s3c-hsotg: DPTx[1] FSize=768, StAddr=0x00000f00
[   69.155000] s3c-hsotg s3c-hsotg: DPTx[2] FSize=768, StAddr=0x00001200
[   69.155000] s3c-hsotg s3c-hsotg: DPTx[3] FSize=768, StAddr=0x00001500
[   69.155000] s3c-hsotg s3c-hsotg: DPTx[4] FSize=768, StAddr=0x00001800
[   69.155000] s3c-hsotg s3c-hsotg: DPTx[5] FSize=768, StAddr=0x00001b00
[   69.155000] s3c-hsotg s3c-hsotg: DPTx[6] FSize=768, StAddr=0x00001e00
[   69.155000] s3c-hsotg s3c-hsotg: DPTx[7] FSize=768, StAddr=0x00002100
[   69.155000] s3c-hsotg s3c-hsotg: DPTx[8] FSize=768, StAddr=0x00002400
[   69.155000] s3c-hsotg s3c-hsotg: DPTx[9] FSize=768, StAddr=0x00002700
[   69.155000] s3c-hsotg s3c-hsotg: DPTx[10] FSize=768, StAddr=0x00002a00
[   69.155000] s3c-hsotg s3c-hsotg: DPTx[11] FSize=768, StAddr=0x00002d00
[   69.155000] s3c-hsotg s3c-hsotg: DPTx[12] FSize=768, StAddr=0x00003000
[   69.155000] s3c-hsotg s3c-hsotg: DPTx[13] FSize=768, StAddr=0x00003300
[   69.155000] s3c-hsotg s3c-hsotg: DPTx[14] FSize=768, StAddr=0x00003600
[   69.155000] s3c-hsotg s3c-hsotg: DPTx[15] FSize=768, StAddr=0x00003900
[   69.155000] s3c-hsotg s3c-hsotg: ep0-in: EPCTL=0x00028000, SIZ=0x00000000,
DMA=0x085290ed
[   69.155000] s3c-hsotg s3c-hsotg: ep0-out: EPCTL=0x80028000, SIZ=0x60000000,
DMA=0xca625c65
[   69.155000] s3c-hsotg s3c-hsotg: ep1-in: EPCTL=0x00488200, SIZ=0x20000000,
DMA=0x5f9184b4
[   69.155000] s3c-hsotg s3c-hsotg: ep1-out: EPCTL=0x00000200, SIZ=0x00000000,
DMA=0x318b408d
[   69.155000] s3c-hsotg s3c-hsotg: ep2-in: EPCTL=0x00000200, SIZ=0x00000000,
DMA=0x50d8cf8b
[   69.155000] s3c-hsotg s3c-hsotg: ep2-out: EPCTL=0x800b8200, SIZ=0x00180800,
DMA=0x5792d85e
[   69.155000] s3c-hsotg s3c-hsotg: ep3-in: EPCTL=0x00cc8008, SIZ=0x00000000,
DMA=0x5dee1680
[   69.155000] s3c-hsotg s3c-hsotg: ep3-out: EPCTL=0x00000200, SIZ=0x00000000,
DMA=0xa96c912b
[   69.155000] s3c-hsotg s3c-hsotg: ep4-in: EPCTL=0x00000200, SIZ=0x00000000,
DMA=0x5e84ae7a
[   69.155000] s3c-hsotg s3c-hsotg: ep4-out: EPCTL=0x00000200, SIZ=0x00000000,
DMA=0xef2e9c78
[   69.155000] s3c-hsotg s3c-hsotg: ep5-in: EPCTL=0x00000200, SIZ=0x00000000,
DMA=0x9d8f4d72
[   69.155000] s3c-hsotg s3c-hsotg: ep5-out: EPCTL=0x00000200, SIZ=0x00000000,
DMA=0x93e82a21
[   69.155000] s3c-hsotg s3c-hsotg: ep6-in: EPCTL=0x00000200, SIZ=0x00000000,
DMA=0x202acadf
[   69.155000] s3c-hsotg s3c-hsotg: ep6-out: EPCTL=0x00000200, SIZ=0x00000000,
DMA=0x5520c3c9
[   69.155000] s3c-hsotg s3c-hsotg: ep7-in: EPCTL=0x00000200, SIZ=0x00000000,
DMA=0x782200c2
[   69.155000] s3c-hsotg s3c-hsotg: ep7-out: EPCTL=0x00000200, SIZ=0x00000000,
DMA=0xeb0b8035
[   69.155000] s3c-hsotg s3c-hsotg: ep8-in: EPCTL=0x00000200, SIZ=0x00000000,
DMA=0x002de535
[   69.155000] s3c-hsotg s3c-hsotg: ep8-out: EPCTL=0x00000200, SIZ=0x00000000,
DMA=0x8c0b77f7
[   69.155000] s3c-hsotg s3c-hsotg: ep9-in: EPCTL=0x00000000, SIZ=0x00000000,
DMA=0xa59e32a0
[   69.155000] s3c-hsotg s3c-hsotg: ep9-out: EPCTL=0x00000000, SIZ=0x00000000,
DMA=0x07aa36a2
[   69.155000] s3c-hsotg s3c-hsotg: ep10-in: EPCTL=0x00000000, SIZ=0x00000000,
DMA=0xc6732fd5
[   69.155000] s3c-hsotg s3c-hsotg: ep10-out: EPCTL=0x00000000, SIZ=0x00000000,
DMA=0xfbf3f43d
[   69.155000] s3c-hsotg s3c-hsotg: ep11-in: EPCTL=0x00000000, SIZ=0x00000000,
DMA=0xb1d750a4
[   69.155000] s3c-hsotg s3c-hsotg: ep11-out: EPCTL=0x00000000, SIZ=0x00000000,
DMA=0x30024c06
[   69.155000] s3c-hsotg s3c-hsotg: ep12-in: EPCTL=0x00000000, SIZ=0x00000000,
DMA=0x154162af
[   69.155000] s3c-hsotg s3c-hsotg: ep12-out: EPCTL=0x00000000, SIZ=0x00000000,
DMA=0x60f9ef07
[   69.155000] s3c-hsotg s3c-hsotg: ep13-in: EPCTL=0x00000000, SIZ=0x00000000,
DMA=0xbea16bb2
[   69.155000] s3c-hsotg s3c-hsotg: ep13-out: EPCTL=0x00000000, SIZ=0x00000000,
DMA=0xd1723f0c
[   69.155000] s3c-hsotg s3c-hsotg: ep14-in: EPCTL=0x00000000, SIZ=0x00000000,
DMA=0x40d1795b
[   69.155000] s3c-hsotg s3c-hsotg: ep14-out: EPCTL=0x00000000, SIZ=0x00000000,
DMA=0xc0b155d6
[   69.155000] s3c-hsotg s3c-hsotg: DVBUSDIS=0x00000b8f, DVBUSPULSE=000002c6

I will try to investigate these issues further.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center

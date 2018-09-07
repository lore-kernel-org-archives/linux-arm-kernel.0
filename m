From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Fri, 7 Sep 2018 15:21:36 +0800
Subject: [SPAM][PATCH] usb: xhci: fix interrupt transfer error happened
 on MTK platforms
In-Reply-To: <1536301896.6414.48.camel@mtkswgap22>
References: <afafa68eb3a74a414848c116382e95811f924905.1536298766.git.chunfeng.yun@mediatek.com>
 <1536301896.6414.48.camel@mtkswgap22>
Message-ID: <1536304896.32173.37.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,

I'll send a new version, thanks

On Fri, 2018-09-07 at 14:31 +0800, Sean Wang wrote:
> Hi,
> 
> Should add Fixes: tag and Cc: <stable@vger.kernel.org> also to apply the patch to the stable tree. Otherwise, the problem still is kept in the stable kernel.
> 
> The patch really can solve the problem by testing with the ASIX AX88179 u3 Ethernet can't work since v4.17.x.
> 
> So, Tested-by: Sean Wang <sean.wang@mediatek.com>
>  
> and attach the log testing with AX88179
> 
> [  126.369574] usb 2-1: new SuperSpeed Gen 1 USB device number 2 using xhci-mtk
> [  126.730806] ax88179_178a 2-1:1.0 eth2: register 'ax88179_178a' at usb-1a0c0000.usb-1, ASIX AX88179 USB 3.0 Gigabit Ethernet, 00:11:6b:68:4c:9e
> [  126.759932] ax88179_178a 2-1:1.0 enx00116b684c9e: renamed from eth2
> 
> ~# ifconfig enx00116b684c9e 10.10.10.1
> ~# ping 10[  147.613266] ax88179_178a 2-1:1.0 enx00116b684c9e: ax88179 - Link status is: 1
> .10.10.3
> PING 10.10.10.3 (10.10.10.3) 56(84) bytes of data.
> 64 bytes from 10.10.10.3: icmp_seq=1 ttl=64 time=0.414 ms
> 64 bytes from 10.10.10.3: icmp_seq=2 ttl=64 time=0.422 ms
> 64 bytes from 10.10.10.3: icmp_seq=3 ttl=64 time=0.376 ms
> 64 bytes from 10.10.10.3: icmp_seq=4 ttl=64 time=0.309 ms
> 64 bytes from 10.10.10.3: icmp_seq=5 ttl=64 time=0.392 ms
> 64 bytes from 10.10.10.3: icmp_seq=6 ttl=64 time=0.355 ms
> 64 bytes from 10.10.10.3: icmp_seq=7 ttl=64 time=0.407 ms
> 64 bytes from 10.10.10.3: icmp_seq=8 ttl=64 time=0.325 ms
> 
> On Fri, 2018-09-07 at 13:51 +0800, Chunfeng Yun wrote:
> > The MTK xHCI controller use some reserved bytes in endpoint context for
> > bandwidth scheduling, so need keep them in xhci_endpoint_copy();
> > 
> > The issue is introduced by:
> > commit f5249461b504 ("xhci: Clear the host side toggle manually when
> > endpoint is soft reset")
> > It resets endpoints and will drop bandwidth scheduling parameters used
> > by interrupt or isochronous endpoints on MTK xHCI controller.
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >  drivers/usb/host/xhci-mem.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> > index ef350c3..b1f27aa 100644
> > --- a/drivers/usb/host/xhci-mem.c
> > +++ b/drivers/usb/host/xhci-mem.c
> > @@ -1613,6 +1613,10 @@ void xhci_endpoint_copy(struct xhci_hcd *xhci,
> >  	in_ep_ctx->ep_info2 = out_ep_ctx->ep_info2;
> >  	in_ep_ctx->deq = out_ep_ctx->deq;
> >  	in_ep_ctx->tx_info = out_ep_ctx->tx_info;
> > +	if (xhci->quirks & XHCI_MTK_HOST) {
> > +		in_ep_ctx->reserved[0] = out_ep_ctx->reserved[0];
> > +		in_ep_ctx->reserved[1] = out_ep_ctx->reserved[1];
> > +	}
> >  }
> >  
> >  /* Copy output xhci_slot_ctx to the input xhci_slot_ctx.
> 
> 

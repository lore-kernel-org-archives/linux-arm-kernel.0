From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Mon, 1 Jun 2015 22:52:17 +0800
Subject: [PATCH 3/6] xhci: probe phy before add usb_hcd
In-Reply-To: <20150527121843.GA8611@saruman.tx.rr.com>
References: <1432727283-20303-1-git-send-email-chunfeng.yun@mediatek.com>
 <1432727283-20303-4-git-send-email-chunfeng.yun@mediatek.com>
 <20150527121843.GA8611@saruman.tx.rr.com>
Message-ID: <1433170337.12128.18.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-05-27 at 07:18 -0500, Felipe Balbi wrote:
> On Wed, May 27, 2015 at 07:48:00PM +0800, chunfeng.yun at mediatek.com wrote:
> > From: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > 
> > find the phy driver before add primary usb_hcd to avoid acessing
> > xHCI register which may hangup the system when the phy is not loaded
> > yet and the related powers or clocks put in phy driver are not
> > enabled.
> 
> it seems like the same clock is needed by PHY and XHCI. This patch looks
> incorrect.


Hi,

I agree that the driver should enable clock it used by itself and not
depends on init order. This should be fixed.

But in general, I think it make sense to only add hcd after all required
resource are ready. At least it remove unnecessary calls to
usb_add_hcd/usb_remove_hcd. Is it better if the commit message is
changed to something like the below?

Currently xhci_plat_probe() call usb_add_hcd before trying to init the
phy. However if the phy is not ready at the moment, it have to remove
the hcd and probe again later 

Change the init order so we only add hcd when all required resource are
ready.

Joe.C

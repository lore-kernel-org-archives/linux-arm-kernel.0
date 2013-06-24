From: balbi@ti.com (Felipe Balbi)
Date: Mon, 24 Jun 2013 09:37:52 +0300
Subject: [PATCH v7 7/9] usb: musb: omap2430: use the new generic PHY
 framework
In-Reply-To: <51C7D9CC.8090901@ti.com>
References: <1371113039-5784-1-git-send-email-kishon@ti.com>
 <1371113039-5784-8-git-send-email-kishon@ti.com>
 <20130618094703.GV5461@arwen.pp.htv.fi> <51C7D9CC.8090901@ti.com>
Message-ID: <20130624063752.GA7145@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 24, 2013 at 11:01:56AM +0530, Kishon Vijay Abraham I wrote:
> >>@@ -397,9 +407,10 @@ static int omap2430_musb_init(struct musb *musb)
> >>  	if (glue->status != OMAP_MUSB_UNKNOWN)
> >>  		omap_musb_set_mailbox(glue);
> >>
> >>-	usb_phy_init(musb->xceiv);
> >>+	phy_init(musb->phy);
> >>
> >>  	pm_runtime_put_noidle(musb->controller);
> >>+	phy_pm_runtime_put(musb->phy);
> >
> >see, weird unbalanced calls :-)
> >
> >Make it all explicit:
> >
> >phy_pm_runtime_get_sync(phy);
> >phy_init(phy);
> >phy_pm_runtime_put(phy);
> 
> I think then it makes sense to drop get_sync from phy_init()?

maybe not, you don't know if the phy has already autosuspended or not.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130624/8f85e599/attachment.sig>

From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Tue, 11 Oct 2016 10:44:06 +0800
Subject: [RESEND PATCH v6, 3/5] usb: xhci-mtk: make IPPC register optional
In-Reply-To: <62b78471-d93f-a5c2-20ef-dfeeea1720db@gmail.com>
References: <1474437277-27201-1-git-send-email-chunfeng.yun@mediatek.com>
 <1474437277-27201-4-git-send-email-chunfeng.yun@mediatek.com>
 <62b78471-d93f-a5c2-20ef-dfeeea1720db@gmail.com>
Message-ID: <1476153846.15546.15.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-10-10 at 12:55 +0200, Matthias Brugger wrote:
> 
> On 09/21/2016 07:54 AM, Chunfeng Yun wrote:
> > Make IPPC register optional to support host side of dual-role mode,
> > due to it is moved into common glue layer for simplification.
> >
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >  drivers/usb/host/xhci-mtk.c |   36 +++++++++++++++++++++++++++++-------
> >  1 file changed, 29 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> > index 79959f1..4bf99b9 100644
> > --- a/drivers/usb/host/xhci-mtk.c
> > +++ b/drivers/usb/host/xhci-mtk.c
> > @@ -94,6 +94,9 @@ static int xhci_mtk_host_enable(struct xhci_hcd_mtk *mtk)
> >  	int ret;
> >  	int i;
> >
> > +	if (ippc == NULL)
> > +		return 0;
> > +
> >  	/* power on host ip */
> >  	value = readl(&ippc->ip_pw_ctr1);
> >  	value &= ~CTRL1_IP_HOST_PDN;
> > @@ -139,6 +142,9 @@ static int xhci_mtk_host_disable(struct xhci_hcd_mtk *mtk)
> >  	int ret;
> >  	int i;
> >
> > +	if (ippc == NULL)
> > +		return 0;
> > +
> >  	/* power down all u3 ports */
> >  	for (i = 0; i < mtk->num_u3_ports; i++) {
> >  		value = readl(&ippc->u3_ctrl_p[i]);
> > @@ -173,6 +179,9 @@ static int xhci_mtk_ssusb_config(struct xhci_hcd_mtk *mtk)
> >  	struct mu3c_ippc_regs __iomem *ippc = mtk->ippc_regs;
> >  	u32 value;
> >
> > +	if (ippc == NULL)
> > +		return 0;
> > +
> 
> I would prefer to add a flag/bool in xhci_hcd_mtk to signal the absence 
> of the ippc. Or at least use a macro which checks the presence before 
> calling any of this three functions.

Ok. I will modify it later.

thanks.
> 
> Regards,
> Matthias

From: pratheesh@ti.com (TK, Pratheesh Gangadhar)
Date: Fri, 4 Mar 2011 10:10:40 +0530
Subject: [PATCH v9 1/1] PRUSS UIO driver support
References: <1299175677-17859-1-git-send-email-pratheesh@ti.com>
	<1299175677-17859-2-git-send-email-pratheesh@ti.com>
	<201103031915.55825.arnd@arndb.de>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C008B9D@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> -----Original Message-----
> From: TK, Pratheesh Gangadhar
> Sent: Friday, March 04, 2011 8:55 AM
> > > +struct uio_pruss_dev {
> > > +       struct uio_info *info;
> > > +       struct clk *pruss_clk;
> > > +       dma_addr_t sram_paddr;
> > > +       dma_addr_t ddr_paddr;
> > > +       void __iomem *prussio_vaddr;
> > > +       void *sram_vaddr;
> > > +       void *ddr_vaddr;
> > > +       unsigned int hostirq_start;
> > > +       unsigned int pintc_base;
> > > +};
> > > +
> > > +struct pruss_priv {
> > > +       struct uio_pruss_dev *pupdev;
> > > +};
> >
> > I cannot see the point of struct pruss_priv, I think it would be better
> to
> > just merge the two data structures into one. Everything else looks
> > good to me now.
> 
> pruss_priv is needed to get access to uio_pruss_dev from uio_info *info in
> UIO interrupt handler (pruss_handler) and shall be per interrupt entry.
> 
> +static irqreturn_t pruss_handler(int irq, struct uio_info *info) {
> +	struct pruss_priv *priv = info->priv;
> +	struct uio_pruss_dev *gdev = priv->pupdev;
> 
> Note that info is a pointer to array supporting 8 interrupts. This allows
> to
> redirect to driver structure via info->priv quickly.
> 

I get your point, no need of additional structure here, can directly assign 
uio_pruss_dev pointer to info->priv. Will resubmit with this change.

Thanks,
Pratheesh

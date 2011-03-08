From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 8 Mar 2011 11:34:59 +0100 (CET)
Subject: [PATCH v9 1/1] PRUSS UIO driver support
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024C008B02@dbde02.ent.ti.com>
References: <1299175677-17859-1-git-send-email-pratheesh@ti.com>
	<1299175677-17859-2-git-send-email-pratheesh@ti.com>
	<201103031915.55825.arnd@arndb.de>
	<B85A65D85D7EB246BE421B3FB0FBB593024C008B02@dbde02.ent.ti.com>
Message-ID: <alpine.LFD.2.00.1103081133510.2787@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 4 Mar 2011, TK, Pratheesh Gangadhar wrote:

> Hi,
> > -----Original Message-----
> > From: Arnd Bergmann [mailto:arnd at arndb.de]
> > Sent: Thursday, March 03, 2011 11:46 PM
> > On Thursday 03 March 2011 19:07:57 Pratheesh Gangadhar wrote:
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
> > I cannot see the point of struct pruss_priv, I think it would be better to
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
> Note that info is a pointer to array supporting 8 interrupts. This allows to
> redirect to driver structure via info->priv quickly.

struct uio_pruss_dev *dev = container_of(info, struct uio_pruss_dev, info);

Perhaps ?

Thanks,

	tglx

From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sun, 16 Sep 2012 09:21:45 +0200
Subject: [PATCH 05/24] ARM: imx: use __iomem pointers for MMIO
In-Reply-To: <201209151742.41828.arnd@arndb.de>
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
 <1347658492-11608-6-git-send-email-arnd@arndb.de>
 <CAOMZO5DemdKtxORhRwyGyF46rdden5QRZh9D9f4KRki5+BfM2A@mail.gmail.com>
 <201209151742.41828.arnd@arndb.de>
Message-ID: <20120916072145.GZ6180@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 15, 2012 at 05:42:41PM +0000, Arnd Bergmann wrote:
> On Friday 14 September 2012, Fabio Estevam wrote:
> > On Fri, Sep 14, 2012 at 6:34 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > > ARM is moving to stricter checks on readl/write functions,
> > > so we need to use the correct types everywhere.
> > >
> > > This found a bug in mach-armadillo5x0.c, where we attempt mmio
> > > on the MXC_CCM_RCSR address that is currently defined to 0xc
> > > and consequently causes an illegal address access.
> > ...
> > 
> > >         /* set NAND page size to 2k if not configured via boot mode pins */
> > > -       __raw_writel(__raw_readl(MXC_CCM_RCSR) | (1 << 30), MXC_CCM_RCSR);
> > > +       /* FIXME __raw_writel(__raw_readl(MXC_CCM_RCSR) | (1 << 30), MXC_CCM_RCSR); */
> > 
> > Good catch, the correct access would be:
> > __raw_readl(mx3_ccm_base + MXC_CCM_RCSR) ...
> > 
> > I will fix this after your series reaches linux-next.
> > 
> 
> I think I'd prefer it if you can fix it on the current kernel. This seems to
> be a serious bug that we actually want to fix in 3.6 or maybe backport to
> the stable series (I don't know when it was introduced). I'll just drop
> this hunk from my patch then.

This was introduced between 3.4 and 3,5 with:

commit eb92044eb3d59d29c9812e85e3a4bf41f6f38e3a
Author: Sascha Hauer <s.hauer@pengutronix.de>
Date:   Tue Apr 3 12:42:27 2012 +0200

    ARM i.MX3: Make ccm base address a variable
    
    Instead of having a cpu_is_* in each ccm register access it
    is more efficient to make it a variable.
    
    Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

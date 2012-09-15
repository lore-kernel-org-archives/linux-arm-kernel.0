From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 15 Sep 2012 17:42:41 +0000
Subject: [PATCH 05/24] ARM: imx: use __iomem pointers for MMIO
In-Reply-To: <CAOMZO5DemdKtxORhRwyGyF46rdden5QRZh9D9f4KRki5+BfM2A@mail.gmail.com>
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
 <1347658492-11608-6-git-send-email-arnd@arndb.de>
 <CAOMZO5DemdKtxORhRwyGyF46rdden5QRZh9D9f4KRki5+BfM2A@mail.gmail.com>
Message-ID: <201209151742.41828.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 September 2012, Fabio Estevam wrote:
> On Fri, Sep 14, 2012 at 6:34 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > ARM is moving to stricter checks on readl/write functions,
> > so we need to use the correct types everywhere.
> >
> > This found a bug in mach-armadillo5x0.c, where we attempt mmio
> > on the MXC_CCM_RCSR address that is currently defined to 0xc
> > and consequently causes an illegal address access.
> ...
> 
> >         /* set NAND page size to 2k if not configured via boot mode pins */
> > -       __raw_writel(__raw_readl(MXC_CCM_RCSR) | (1 << 30), MXC_CCM_RCSR);
> > +       /* FIXME __raw_writel(__raw_readl(MXC_CCM_RCSR) | (1 << 30), MXC_CCM_RCSR); */
> 
> Good catch, the correct access would be:
> __raw_readl(mx3_ccm_base + MXC_CCM_RCSR) ...
> 
> I will fix this after your series reaches linux-next.
> 

I think I'd prefer it if you can fix it on the current kernel. This seems to
be a serious bug that we actually want to fix in 3.6 or maybe backport to
the stable series (I don't know when it was introduced). I'll just drop
this hunk from my patch then.

	Arnd

From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 24 Oct 2013 08:40:51 +0800
Subject: [PATCH 1/3] usb: ehci: add freescale imx28 special write
 register method
In-Reply-To: <CAOMZO5B6Hq+_p6X-+LMpaax2wT3h+xBiscYXsQ8za+_fzOuP_A@mail.gmail.com>
References: <1382517309-6730-1-git-send-email-peter.chen@freescale.com>
 <CAOMZO5B6Hq+_p6X-+LMpaax2wT3h+xBiscYXsQ8za+_fzOuP_A@mail.gmail.com>
Message-ID: <20131024004050.GA32138@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 10:09:39AM -0200, Fabio Estevam wrote:
> Hi Peter,
> 
> On Wed, Oct 23, 2013 at 6:35 AM, Peter Chen <peter.chen@freescale.com> wrote:
> > According to Freescale imx28 Errata, "ENGR119653 USB: ARM to USB
> > register error issue", All USB register write operations must
> > use the ARM SWP instruction. So, we implement a special ehci_write
> > for imx28.
> >
> > Discussion for it at below:
> > http://marc.info/?l=linux-usb&m=137996395529294&w=2
> >
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > ---
> >  drivers/usb/host/ehci.h |   13 +++++++++++++
> >  1 files changed, 13 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
> > index 2d40192..577b75d 100644
> > --- a/drivers/usb/host/ehci.h
> > +++ b/drivers/usb/host/ehci.h
> > @@ -203,6 +203,7 @@ struct ehci_hcd {                   /* one per controller */
> >         unsigned                has_synopsys_hc_bug:1; /* Synopsys HC */
> >         unsigned                frame_index_bug:1; /* MosChip (AKA NetMos) */
> >         unsigned                need_oc_pp_cycle:1; /* MPC834X port power */
> > +       unsigned                imx28_write_fix:1; /* For Freescale i.MX28 */
> >
> >         /* required for usb32 quirk */
> >         #define OHCI_CTRL_HCFS          (3 << 6)
> > @@ -680,6 +681,13 @@ static inline unsigned int ehci_readl(const struct ehci_hcd *ehci,
> >  #endif
> >  }
> >
> > +#ifdef CONFIG_SOC_IMX28
> > +static inline void imx28_ehci_writel(u32 val32, volatile u32 *addr)
> > +{
> > +       __asm__ ("swp %0, %0, [%1]" : : "r"(val32), "r"(addr));
> > +}
> > +#endif
> > +
> >  static inline void ehci_writel(const struct ehci_hcd *ehci,
> >                 const unsigned int val, __u32 __iomem *regs)
> >  {
> > @@ -687,6 +695,11 @@ static inline void ehci_writel(const struct ehci_hcd *ehci,
> >         ehci_big_endian_mmio(ehci) ?
> >                 writel_be(val, regs) :
> >                 writel(val, regs);
> > +#elif defined(CONFIG_SOC_IMX28)
> > +       if (ehci->imx28_write_fix)
> > +               imx28_ehci_writel(val, regs);
> > +       else
> > +               writel(val, regs);
> 
> Have you tested this on mx23?
> 
> What if we have a kernel built for both mx23 and mx28?
> 

The condition ehci->imx28_write_fix will only be set
for imx28 platform, you can refer patch 2/3 and patch 3/3.
-- 

Best Regards,
Peter Chen

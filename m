From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 4 Nov 2013 21:08:53 +0800
Subject: [PATCHv3] ARM: imx: add support code for IMX50 based machines
In-Reply-To: <CAL_Jsq+Uon4QBU0wUYvWib4AYg=m0EFEBm7i03Zzy=bxU4c_zA@mail.gmail.com>
References: <1383524020-1518-1-git-send-email-gerg@uclinux.org>
 <CAL_Jsq+Uon4QBU0wUYvWib4AYg=m0EFEBm7i03Zzy=bxU4c_zA@mail.gmail.com>
Message-ID: <20131104130850.GB24970@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 03, 2013 at 09:16:52PM -0600, Rob Herring wrote:
> > @@ -108,6 +108,7 @@ void tzic_handle_irq(struct pt_regs *);
> >  #define imx27_handle_irq avic_handle_irq
> >  #define imx31_handle_irq avic_handle_irq
> >  #define imx35_handle_irq avic_handle_irq
> > +#define imx50_handle_irq tzic_handle_irq
> 
> Has no one converted AVIC and TZIC to use IRQCHIP_DECLARE? This and
> the corresponding handle_irq hook would not be needed if that was
> done.

No, not yet.  There are still non-DT users for avic and tzic, which
makes the adoption of IRQCHIP_DECLARE less meaningful and a little
difficult.  So my plan is that we convert all those non-DT users over to
DT, and then move avic and tzic to IRQCHIP_DECLARE.

<snip>

> > +static void __init imx50_dt_init(void)
> > +{
> > +       of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> 
> This is the default operation now if init_machine is NULL.

Oh, it reminds me that mxc_arch_reset_init_dt() should be called here to
get mxc_restart() work.

> > +}
> > +
> > +static const char *imx50_dt_board_compat[] __initdata = {
> > +       "fsl,imx50",
> > +       NULL
> > +};
> > +
> > +DT_MACHINE_START(IMX50_DT, "Freescale i.MX50 (Device Tree Support)")
> > +       .map_io         = mx53_map_io,
> > +       .init_irq       = mx53_init_irq,
> > +       .handle_irq     = imx50_handle_irq,
> > +       .init_machine   = imx50_dt_init,
> > +       .dt_compat      = imx50_dt_board_compat,
> > +       .restart        = mxc_restart,
> > +MACHINE_END
> 
> I still think any mx53 clean-up should be done first to enable mx50
> rather than adding a mx50 machine first and then trying to consolidate
> mx50 and mx53.

We already reuse imx53 stuff as much as possible here, and I do not see
there will be so much code to be consolidated further.  There are indeed
something to be cleaned up as part of the whole i.MX DT conversion, like
static mapping, but it's nothing related to imx50 addition.  Since the
imx50 addition does not make the cleanup later more difficult, I would
prefer to just support it now.

Shawn

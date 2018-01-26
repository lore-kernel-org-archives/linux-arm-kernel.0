From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 26 Jan 2018 16:59:05 +0000
Subject: [RFC 10/37] soc: renesas: rcar-rst: Enable watchdog as reset
 trigger for Gen2
In-Reply-To: <e1670c79-2fef-b45b-4688-a6ba8ebd8c24@cogentembedded.com>
References: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1516903391-30467-11-git-send-email-fabrizio.castro@bp.renesas.com>
 <e1670c79-2fef-b45b-4688-a6ba8ebd8c24@cogentembedded.com>
Message-ID: <TY1PR06MB0895CA9B4668F49991FD607FC0E00@TY1PR06MB0895.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sergei,

thank you for your feedback.

> Subject: Re: [RFC 10/37] soc: renesas: rcar-rst: Enable watchdog as reset trigger for Gen2
>
> Hello!
>
> On 1/25/2018 9:02 PM, Fabrizio Castro wrote:
>
> > This patch allows for platform specific quirks as some of the SoC need
> > further customization for the watchdog to work properly, like for R-Car
> > Gen2 and for RZ/G.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
> > ---
> >   drivers/soc/renesas/rcar-rst.c | 21 ++++++++++++++++++++-
> >   1 file changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/soc/renesas/rcar-rst.c b/drivers/soc/renesas/rcar-rst.c
> > index f7a0d54..5f52aea 100644
> > --- a/drivers/soc/renesas/rcar-rst.c
> > +++ b/drivers/soc/renesas/rcar-rst.c
> > @@ -13,8 +13,18 @@
> >   #include <linux/of_address.h>
> >   #include <linux/soc/renesas/rcar-rst.h>
> >
> > +#define WDTRSTCR_RESET0xA55A0002
> > +#define WDTRSTCR0x0054
> > +
> > +static int gen2_configuration(void __iomem *base)
> > +{
> > +iowrite32(WDTRSTCR_RESET, base + WDTRSTCR);
> > +return 0;
> > +}
> > +
> >   struct rst_config {
> > -unsigned int modemr;/* Mode Monitoring Register Offset */
> > +unsigned int modemr;/* Mode Monitoring Register Offset */
> > +int (*configure)(void *base);/* Platform specific configuration */
> >   };
> >
> >   static const struct rst_config rcar_rst_gen1 __initconst = {
> > @@ -23,6 +33,7 @@ static const struct rst_config rcar_rst_gen1 __initconst = {
> >
> >   static const struct rst_config rcar_rst_gen2 __initconst = {
> >   .modemr = 0x60,
> > +.configure = gen2_configuration,
>
>     Why not call the method gen2_configure() then?

Yeah, the name gen2_configuration isn't great!
As you may have noticed already, Geert suggested rcar_rst_enable_wdt_reset.
I am definitely going to change it (if I am keeping the function pointer at all!), expect to see another version of this patch in the next few days to address this.

Thanks,
Fab

>
> [...]
>
> MBR, Sergei



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.

From: anup.patel@broadcom.com (Anup Patel)
Date: Mon, 5 Oct 2015 06:27:16 +0000
Subject: [PATCH 3/5] mtd: brcmnand: Optional DT flag to reset IPROC NAND
 controller
In-Reply-To: <20151004214943.GA28904@localhost>
References: <1443808606-21203-1-git-send-email-anup.patel@broadcom.com>
 <1443808606-21203-4-git-send-email-anup.patel@broadcom.com>
 <20151004214943.GA28904@localhost>
Message-ID: <39063E8F96E11742B35A201CC5D095B7AD54C1@SJEXCHMB10.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Brian Norris [mailto:computersforpeace at gmail.com]
> Sent: 05 October 2015 03:20
> To: Anup Patel
> Cc: linux-arm-kernel at lists.infradead.org; Rob Herring; Pawel Moll; Mark
> Rutland; Ian Campbell; Kumar Gala; Catalin Marinas; Will Deacon; David
> Woodhouse; Ray Jui; Scott Branden; Florian Fainelli; Pramod Kumar; Vikram
> Prakash; Sandeep Tripathy; devicetree at vger.kernel.org; linux-
> kernel at vger.kernel.org; linux-mtd at lists.infradead.org; bcm-kernel-feedback-
> list; Rafal Milecki
> Subject: Re: [PATCH 3/5] mtd: brcmnand: Optional DT flag to reset IPROC NAND
> controller
> 
> + Rafal (to extend this mighty CC list)
> 
> On Fri, Oct 02, 2015 at 11:26:44PM +0530, Anup Patel wrote:
> > The BRCM NAND controller on NS2 SoC requires a reset to cleanup
> > previously configured NAND controller state.
> >
> > This patch adds optional boolean device tree flag named
> > "brcm,nand-iproc-reset". If this flag is present in NAND controller DT
> > node then BRCM IPROC NAND driver will reset the NAND controller before
> > any commands are issued.
> 
> Is there a reason not to do this reset unconditionally? I recall this came up in
> discussion previously, when the OpenWRT folks were trying to integrate with
> BCMA, where this reset was one of the few differences between the platform-
> device-based driver (i.e., this one) and the BCMA based driver. Might it help
> simplify things a bit if we just did the same thing everywhere?

This driver is currently shared by Cygnus and NS2.

We had similar suggestion when this patch was reviewed
internally in Broadcom.

The rationale for adding optional DT flag is as follows:
1. The NAND controller reset is currently required for NS2 only so
that it is in sane state before any NAND commands are issued. We
are not sure if Cygnus and all future iProc SoCs will require NAND
controller reset.
2. The NAND controller reset in probe would certainly increase
Linux boot time so for certain iProc SoCs we might choose avoid
NAND controller reset to reduce boot time if possible.

Regards
Anup

> 
> Brian
> 
> > Signed-off-by: Anup Patel <anup.patel@broadcom.com>
> > Reviewed-by: Pramod KUMAR <pramodku@broadcom.com>
> > Reviewed-by: Ray Jui <rjui@broadcom.com>
> > Reviewed-by: Scott Branden <sbranden@broadcom.com>
> > ---
> >  drivers/mtd/nand/brcmnand/iproc_nand.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/drivers/mtd/nand/brcmnand/iproc_nand.c
> > b/drivers/mtd/nand/brcmnand/iproc_nand.c
> > index 683495c..d837207 100644
> > --- a/drivers/mtd/nand/brcmnand/iproc_nand.c
> > +++ b/drivers/mtd/nand/brcmnand/iproc_nand.c
> > @@ -11,6 +11,7 @@
> >   * GNU General Public License for more details.
> >   */
> >
> > +#include <linux/delay.h>
> >  #include <linux/device.h>
> >  #include <linux/io.h>
> >  #include <linux/ioport.h>
> > @@ -35,6 +36,10 @@ struct iproc_nand_soc_priv {
> >  #define IPROC_NAND_APB_LE_MODE             BIT(24)
> >  #define IPROC_NAND_INT_CTRL_READ_ENABLE    BIT(6)
> >
> > +#define IPROC_NAND_RESET_OFFSET            0x3f8
> > +#define IPROC_NAND_RESET_BIT_SHIFT         0
> > +#define IPROC_NAND_RESET_BIT
> BIT(IPROC_NAND_RESET_BIT_SHIFT)
> > +
> >  static bool iproc_nand_intc_ack(struct brcmnand_soc *soc)  {
> >  	struct iproc_nand_soc_priv *priv = soc->priv; @@ -93,6 +98,7 @@
> > static void iproc_nand_apb_access(struct brcmnand_soc *soc, bool
> > prepare)
> >
> >  static int iproc_nand_probe(struct platform_device *pdev)  {
> > +	u32 reset;
> >  	struct device *dev = &pdev->dev;
> >  	struct iproc_nand_soc_priv *priv;
> >  	struct brcmnand_soc *soc;
> > @@ -124,6 +130,19 @@ static int iproc_nand_probe(struct platform_device
> *pdev)
> >  	soc->ctlrdy_set_enabled = iproc_nand_intc_set;
> >  	soc->prepare_data_bus = iproc_nand_apb_access;
> >
> > +	if (of_property_read_bool(dev->of_node, "brcm,nand-iproc-reset")) {
> > +		/* Put controller in reset and wait 10 usecs */
> > +		reset = readl(priv->idm_base + IPROC_NAND_RESET_OFFSET);
> > +		reset |= IPROC_NAND_RESET_BIT;
> > +		writel(reset, priv->idm_base + IPROC_NAND_RESET_OFFSET);
> > +		udelay(10);
> > +		/* Bring controller out of reset and wait 10 usecs */
> > +		reset = readl(priv->idm_base + IPROC_NAND_RESET_OFFSET);
> > +		reset &= ~IPROC_NAND_RESET_BIT;
> > +		writel(reset, priv->idm_base + IPROC_NAND_RESET_OFFSET);
> > +		udelay(10);
> > +	}
> > +
> >  	return brcmnand_probe(pdev, soc);
> >  }
> >
> > --
> > 1.9.1
> >

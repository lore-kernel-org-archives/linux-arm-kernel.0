From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 13 Dec 2011 20:47:14 +0800
Subject: [PATCH 1/1] arm/imx6q-sabrelite: add enet phy ksz9021rn fixup
In-Reply-To: <20111213121348.GA1757@richard-laptop>
References: <1323757530-19402-1-git-send-email-richard.zhao@linaro.org>
 <1323764658-26381-1-git-send-email-richard.zhao@linaro.org>
 <20111213120750.GB10022@S2101-09.ap.freescale.net>
 <20111213121348.GA1757@richard-laptop>
Message-ID: <20111213124712.GD10022@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2011 at 08:13:51PM +0800, Richard Zhao wrote:
> On Tue, Dec 13, 2011 at 08:07:55PM +0800, Shawn Guo wrote:
> > On Tue, Dec 13, 2011 at 04:24:18PM +0800, Richard Zhao wrote:
> > > tune phy RGMII pad skew.
> > > 
> > > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > > ---
> > >  arch/arm/mach-imx/mach-imx6q.c |   21 +++++++++++++++++++++
> > >  1 files changed, 21 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> > > index d24d6c4..b3dcdcb 100644
> > > --- a/arch/arm/mach-imx/mach-imx6q.c
> > > +++ b/arch/arm/mach-imx/mach-imx6q.c
> > > @@ -16,6 +16,8 @@
> > >  #include <linux/of.h>
> > >  #include <linux/of_irq.h>
> > >  #include <linux/of_platform.h>
> > > +#include <linux/phy.h>
> > > +#include <linux/micrel_phy.h>
> > >  #include <asm/hardware/cache-l2x0.h>
> > >  #include <asm/hardware/gic.h>
> > >  #include <asm/mach/arch.h>
> > > @@ -23,8 +25,27 @@
> > >  #include <mach/common.h>
> > >  #include <mach/hardware.h>
> > >  
> > > +/* For imx6q sabrelite board: set KSZ9021RN RGMII pad skew */
> > 
> > Neither the comment nor the commit message can help me understand why
> > this fixup is needed.
> As commit log tells, it's for tune pad skew.
> > 
> > > +static int ksz9021rn_phy_fixup(struct phy_device *phydev)
> > > +{
> > > +	/* min rx data delay */
> > > +	phy_write(phydev, 0x0b, 0x8105);
> > > +	phy_write(phydev, 0x0c, 0x0000);
> > > +
> > > +	/* max rx/tx clock delay, min rx/tx control delay */
> > > +	phy_write(phydev, 0x0b, 0x8104);
> > > +	phy_write(phydev, 0x0c, 0xf0f0);
> > > +	phy_write(phydev, 0x0b, 0x104);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static void __init imx6q_init_machine(void)
> > >  {
> > > +	if (of_machine_is_compatible("fsl,imx6q-sabrelite"))
> > > +		phy_register_fixup_for_uid(PHY_ID_KSZ9021, MICREL_PHY_ID_MASK,
> > > +					 ksz9021rn_phy_fixup);
> > > +
> > 
> > I would suggest put any setup specific to particular board after the
> > common part, if we could.
> For this case, it's ok  for me to put it after populate devices.
> A little concern that, generally speaking, adding devices imply possiblely call
> driver probe, fixups usually are added before driver probe.
> 
Fair point.  I do not have a strong opinion on this.  You can leave
it as it is.  I will apply the patch after patch #2.

-- 
Regards,
Shawn

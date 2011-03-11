From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 11 Mar 2011 13:52:46 +0100
Subject: [PATCH 1/8] macb: unify at91 and avr32 platform data
In-Reply-To: <20110311085605.GK6198@pulham.picochip.com>
References: <1299751843-9743-1-git-send-email-jamie@jamieiles.com>
	<1299751843-9743-2-git-send-email-jamie@jamieiles.com>
	<4D78CCBC.2010807@atmel.com>
	<20110310131724.GG6198@pulham.picochip.com>
	<20110311014140.GI9351@game.jcrosoft.org>
	<20110311085605.GK6198@pulham.picochip.com>
Message-ID: <20110311125246.GL9351@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08:56 Fri 11 Mar     , Jamie Iles wrote:
> On Fri, Mar 11, 2011 at 02:41:40AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 13:17 Thu 10 Mar     , Jamie Iles wrote:
> > > On Thu, Mar 10, 2011 at 02:06:04PM +0100, Nicolas Ferre wrote:
> > > > On 3/10/2011 11:10 AM, Jamie Iles :
> > > > > --- a/drivers/net/macb.c
> > > > > +++ b/drivers/net/macb.c
> > > > > @@ -18,12 +18,10 @@
> > > > >  #include <linux/netdevice.h>
> > > > >  #include <linux/etherdevice.h>
> > > > >  #include <linux/dma-mapping.h>
> > > > > +#include <linux/platform_data/macb.h>
> > > > >  #include <linux/platform_device.h>
> > > > >  #include <linux/phy.h>
> > > > >  
> > > > > -#include <mach/board.h>
> > > > > -#include <mach/cpu.h>
> > > > 
> > > > I did not bouble check but do we need no more cpu_is_ macros?
> > > 
> > > No, I couldn't see any in there and it builds for all of the AT91 
> > > targets and all of the AVR32 ones that I tried.  I can't see any macros 
> > > in there that are likely to use cpu_is_* internally either.
> >
> > keep as we need to remove the #ifdef AT91 to cpu_is
> > 
> > I've patch for this
> 
> Is this for the user IO register where the value written is conditional 
> on both RMII/MII and arch type?
yes for 

#if defined(CONFIG_ARCH_AT91)
		macb_writel(bp, USRIO, (MACB_BIT(RMII) | MACB_BIT(CLKEN)));
#else
		macb_writel(bp, USRIO, 0);
#endif
	else
#if defined(CONFIG_ARCH_AT91)
		macb_writel(bp, USRIO, MACB_BIT(CLKEN));
#else
		macb_writel(bp, USRIO, MACB_BIT(MII));
#endif

Best Regards,
J.

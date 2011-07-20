From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 21 Jul 2011 07:16:39 +0800
Subject: [PATCH] arm/mxc: add the missing UART_PADDR for i.mx53
In-Reply-To: <4E27444D.2010005@boundarydevices.com>
References: <1310251913-9877-1-git-send-email-troy.kisky@boundarydevices.com>
	<1311167599-21790-1-git-send-email-shawn.guo@linaro.org>
	<4E27444D.2010005@boundarydevices.com>
Message-ID: <20110720231638.GK6999@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2011 at 02:10:37PM -0700, Troy Kisky wrote:
> On 7/20/2011 6:13 AM, Shawn Guo wrote:
> > The UART_PADDR definition for i.mx53 and i.mx50 is missing in
> > debug-macro.S.  It causes the build of i.mx53/50 fail.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Reported-by: Troy Kisky <troy.kisky@boundarydevices.com>
> > ---
> > Troy,
> > 
> > Since I'm keen to get the build failure fixed, I just repost
> > the patch you sent with Sascha's comment fixed.  Hope you do
> > not mind.
> > 
> >  arch/arm/plat-mxc/include/mach/debug-macro.S |    8 ++++++++
> >  1 files changed, 8 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/plat-mxc/include/mach/debug-macro.S b/arch/arm/plat-mxc/include/mach/debug-macro.S
> > index 91fc7cd..8cf8dee 100644
> > --- a/arch/arm/plat-mxc/include/mach/debug-macro.S
> > +++ b/arch/arm/plat-mxc/include/mach/debug-macro.S
> > @@ -44,6 +44,14 @@
> >  #define UART_PADDR	MX51_UART1_BASE_ADDR
> >  #endif
> >  
> > +#if defined(CONFIG_SOC_IMX50) || defined(CONFIG_SOC_IMX53)
> > +#ifdef UART_PADDR
> > +#error "CONFIG_DEBUG_LL is incompatible with multiple archs"
> > +#endif
> > +/* i.MX50 gets the same UART1 base address as i.MX53 */
> > +#define UART_PADDR	MX53_UART1_BASE_ADDR
> > +#endif
> > +
> 
> If your debug-macro.S is like mine then you should have
> 
No, it is not.

> #ifdef CONFIG_ARCH_MX5
> #ifdef UART_PADDR
> #error "CONFIG_DEBUG_LL is incompatible with multiple archs"
> #endif
> #define UART_PADDR      MX51_UART1_BASE_ADDR
> #endif
> 
> 
> So, all MX5's are using MX51_UART1_BASE_ADDR.
> I can't see that your patch changes CONFIG_ARCH_MX5
> to CONFIG_SOC_IMX51. It isn't functionally the same as my version.
> 
We started from the difference base.  No, it is not functionally the
same as yours, so even remove your reported-by? :)

-- 
Regards,
Shawn

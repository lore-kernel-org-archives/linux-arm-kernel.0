From: olof@lixom.net (Olof Johansson)
Date: Mon, 7 Jul 2014 21:23:03 -0700
Subject: [PATCH] ARM: imx: fix shared gate clock
In-Reply-To: <20140707135636.GS30239@dragon>
References: <1404701631-13870-1-git-send-email-shawn.guo@freescale.com>
 <CAOMZO5CMc6dqzh62cie=Ve_o9QHig=G4VqB11skCip+jXwV-9g@mail.gmail.com>
 <20140707135636.GS30239@dragon>
Message-ID: <20140708042303.GA28931@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 07, 2014 at 09:56:37PM +0800, Shawn Guo wrote:
> On Mon, Jul 07, 2014 at 09:49:00AM -0300, Fabio Estevam wrote:
> > On Sun, Jul 6, 2014 at 11:53 PM, Shawn Guo <shawn.guo@freescale.com> wrote:
> > > Let's say clock A and B are two gate clocks that share the same register
> > > bit in hardware.  Therefore they are registered as shared gate clocks
> > > with imx_clk_gate2_shared().
> > >
> > > In a scenario that only clock A is enabled by clk_enable(A) while B is
> > > not used, the shared gate will be unexpectedly disabled in hardware.
> > > It happens because clk_enable(A) increments the share_count from 0 to 1,
> > > while clock B is unused to clock core, and therefore the core function
> > > will just disable B by calling clk->ops->disable() directly.  The
> > > consequence of that call is share_count is decremented to 0 and the gate
> > > is disabled in hardware, even though clock A is still in use.
> > >
> > > The patch fixes the issue by initializing the share_count per hardware
> > > state and returns enable state per share_count from .is_enabled() hook,
> > > in case it's a shared gate.
> > >
> > > While at it, add a check in clk_gate2_disable() to ensure it's never
> > > called with a zero share_count.
> > >
> > > Reported-by: Fabio Estevam <fabio.estevam@freescale.com>
> > > Fixes: f9f28cdf2167 ("ARM: imx: add shared gate clock support")
> > > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > > ---
> > > Fabio,
> > >
> > > Per my testing, it fixes the shared gate clock issue you reported.
> > > But I'd like to get your confirmation before I ask arm-soc folks to
> > > apply it for 3.16-rc.
> > 
> > I can get audio working now and I have also inspected CCGR5 register
> > and it looks correct now:
> > 
> > Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Thanks, Fabio.
> 
> Arnd, Olof,
> 
> Can you please apply this patch for 3.16?

Done, thanks.


-Olof

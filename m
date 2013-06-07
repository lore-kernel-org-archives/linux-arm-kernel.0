From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 7 Jun 2013 16:43:55 +0800
Subject: [PATCH v2 1/1] ARM: imx: clk-pllv3: change wait method for PLL
 lock
In-Reply-To: <20130607083528.GG12361@pengutronix.de>
References: <1370593146-14025-1-git-send-email-peter.chen@freescale.com>
 <20130607082457.GF12361@pengutronix.de>
 <20130607083134.GE21641@nchen-desktop>
 <20130607083528.GG12361@pengutronix.de>
Message-ID: <20130607084354.GF21641@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 10:35:28AM +0200, Uwe Kleine-K?nig wrote:
> On Fri, Jun 07, 2013 at 04:31:35PM +0800, Peter Chen wrote:
> > On Fri, Jun 07, 2013 at 10:24:57AM +0200, Uwe Kleine-K?nig wrote:
> > > On Fri, Jun 07, 2013 at 04:19:06PM +0800, Peter Chen wrote:
> > > > For some unknown reasons, the jiffies will be updated more
> > > > than one tick at every short time. Eg, at this code:
> > > > After timeout = jiffies + msecs_to_jiffies(10),
> > > > the interrupt occurs, and the softirq updates jiffies (eg,  + 2 jiffies),
> > > > then return back from interrupt, the time between above operations
> > > > are tiny, the PLL is still not locked, but the timeout condition is satisfied.
> > > > 
> > > > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > > Does this mean my patch doesn't solve the issue for you?
> > 
> > Not try, but your patch just delay timeout assignment, if there
> > is jiffies update after that but before timeout check, it still
> > has problem.
> But if that large update happens because there was a long preemption the
> pll should be locked because I only start counting when the pll is
> programmed.
> 
> IMHO you should try my patch as it is the better fix (assuming it fixes
> it for you).

I will try your fix, but still it just reduces the possibilities.
The problem is not the preemption takes too long, it is the jiffies
updates more than one tick at one short preemption.

-- 

Best Regards,
Peter Chen

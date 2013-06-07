From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 7 Jun 2013 10:53:21 +0800
Subject: [PATCH 1/1] ARM: imx: clk-pllv3: change wait method for PLL lock
In-Reply-To: <20130606121647.GR23140@pengutronix.de>
References: <1370501726-7421-1-git-send-email-peter.chen@freescale.com>
 <20130606121647.GR23140@pengutronix.de>
Message-ID: <20130607025320.GA21641@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 06, 2013 at 02:16:47PM +0200, Uwe Kleine-K?nig wrote:
> Hello
> 
> [added jstultz to Cc:]
> 
> On Thu, Jun 06, 2013 at 02:55:26PM +0800, Peter Chen wrote:
> > For tickless system, the jiffies may be updated long time (>20ms).
> ... may not be updated for a long time ... ?
> 
> > At high loading system, the current waiting method will cause waiting
> > timeout, and cause a kernel dump at below case.
> > After timeout = jiffies + msecs_to_jiffies(10),
> > the timer interrupt occurs, it updates jiffies (eg,  + 2 jiffies),
> > then return back from interrupt, the time between above operations
> > are tiny, the PLL is still not locked, but the timeout condition is satisfied.
> Hmm, I admit I didn't follow the tickless stuff, but still I wonder if
> the analysis is right. I thought on tickless jiffies are updated as
> before by the boot cpu that cannot run in tickless mode?
> 
> Anyhow, this only affects the commit log, not the problem.
>  

I add jiffies print at irq_exit (kernel/softirq.c), and it
is not updated every jiffies.

Meanwhile, I ran out this PLL Lock timeout issue with
iperf test using usb ethernet gadget at current code (v3.5.7 kernel).
After using udelay, this issue is disappeared.

-- 

Best Regards,
Peter Chen

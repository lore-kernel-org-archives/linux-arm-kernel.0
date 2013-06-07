From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 7 Jun 2013 11:28:46 +0800
Subject: [PATCH 1/1] ARM: imx: clk-pllv3: change wait method for PLL lock
In-Reply-To: <20130606092156.GL18614@n2100.arm.linux.org.uk>
References: <1370501726-7421-1-git-send-email-peter.chen@freescale.com>
 <20130606092156.GL18614@n2100.arm.linux.org.uk>
Message-ID: <20130607032845.GB21641@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 06, 2013 at 10:21:56AM +0100, Russell King - ARM Linux wrote:
> On Thu, Jun 06, 2013 at 02:55:26PM +0800, Peter Chen wrote:
> > @@ -62,9 +63,11 @@ static int clk_pllv3_prepare(struct clk_hw *hw)
> >  	writel_relaxed(val, pll->base);
> >  
> >  	/* Wait for PLL to lock */
> > -	while (!(readl_relaxed(pll->base) & BM_PLL_LOCK))
> > -		if (time_after(jiffies, timeout))
> > +	while (!(readl_relaxed(pll->base) & BM_PLL_LOCK)) {
> > +		udelay(100);
> > +		if (--count == 0)
> >  			return -ETIMEDOUT;
> > +	}
> 
> This is still buggy in the ways you describe above.
> 
> 	do {
> 		if (readl_relaxed(pll->base) & BM_PLL_LOCK)
> 			break;
> 		udelay(100);
> 	} while (--count);
> 
> 	if (count == 0 && !(readl_relaxed(pll->base) & BM_PLL_LOCK))
> 		return -ETIMEDOUT;
> 
> Notice - we only return -ETIMEDOUT if the condition we're waiting for
> has not been satisfied _after_ the loop terminates, specifically, if
> this happens during the last 100us of our wait.

Thanks for your comments, it can make code be more reasonable.

> 
> You can apply the same fix to your original; you don't need to move
> to using udelay() and a counter if you can tolerate some noise in
> the waiting time.
> 
> The lesson here is: if you're waiting for any kind of an event, then
> be very careful how you code the failure path so you don't miss a
> success coincident with the timeout condition becoming true.
> 

-- 

Best Regards,
Peter Chen

From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 20 Jan 2011 18:10:50 +0000
Subject: [PATCH] ARM: TWD: fix the clock calculation for TWD
In-Reply-To: <20110120163836.GF6335@n2100.arm.linux.org.uk>
References: <1295505237-5735-1-git-send-email-chao.xie@marvell.com>
	<20110120140811.GE6335@n2100.arm.linux.org.uk>
	<20110120144409.GA25954@pulham.picochip.com>
	<20110120163836.GF6335@n2100.arm.linux.org.uk>
Message-ID: <20110120181050.GF25954@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 20, 2011 at 04:38:36PM +0000, Russell King - ARM Linux wrote:
> On Thu, Jan 20, 2011 at 02:44:09PM +0000, Jamie Iles wrote:
> > On Thu, Jan 20, 2011 at 02:08:11PM +0000, Russell King - ARM Linux wrote:
> > > On Thu, Jan 20, 2011 at 02:33:57PM +0800, Chao Xie wrote:
> > > > The original code will do count * (HZ /5). It will make the twd
> > > > timer rate decreased if HZ can not be excatly divided. For
> > > > example HZ=128.
> > > > 
> > > > Signed-off-by: Chao Xie <chao.xie@marvell.com>
> > > > ---
> > > >  arch/arm/kernel/smp_twd.c |    3 ++-
> > > >  1 files changed, 2 insertions(+), 1 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> > > > index 35882fb..ca6405b 100644
> > > > --- a/arch/arm/kernel/smp_twd.c
> > > > +++ b/arch/arm/kernel/smp_twd.c
> > > > @@ -111,7 +111,8 @@ static void __cpuinit twd_calibrate_rate(void)
> > > >  
> > > >  		count = __raw_readl(twd_base + TWD_TIMER_COUNTER);
> > > >  
> > > > -		twd_timer_rate = (0xFFFFFFFFU - count) * (HZ / 5);
> > > > +		twd_timer_rate = ((unsigned long)(0xFFFFFFFFU - count))
> > > > +			* HZ / 5;
> > > >  
> > > >  		printk("%lu.%02luMHz.\n", twd_timer_rate / 1000000,
> > > >  			(twd_timer_rate / 100000) % 100);
> > > 
> > > I don't think this patch has any effect what so ever, so I just tried:
> > > 
> > > #define HZ      128
> > > unsigned long twd_timer_rate;
> > > void calc1(unsigned long count)
> > > {
> > >         twd_timer_rate = (0xffffffffU - count) * (HZ / 5);
> > > }
> > > void calc2(unsigned long count)
> > > {
> > >         twd_timer_rate = ((unsigned long)(0xffffffffU - count)) * (HZ / 5);
> > > }
> > 
> > Hi Russell,
> > 
> > In Chao's patch the parentheses around (HZ / 5) have been removed so its 
> > now dowing the multiplication before the division (if I remember the 
> > precedences correctly!).  I don't think the cast to unsigned long is 
> > needed though.
> 
> Hmm.  That means the maximum twd timer rate we can support is about
> 860MHz.  Is that enough?

I'm not familiar with any ARM SMP systems so I wouldn't like to commit 
to that!  If the answer is no, then I guess could we do something like 
the (untested in a kernel) patch below to get a few more bits and we 
should then be able to support rates of up to ~4294MHz.

Jamie

8<----

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index fd91566..334ad95 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -89,6 +89,8 @@ static void __cpuinit twd_calibrate_rate(void)
 	 * the timer ticks
 	 */
 	if (twd_timer_rate == 0) {
+		u64 rate64;
+
 		printk(KERN_INFO "Calibrating local timer... ");
 
 		/* Wait for a tick to start */
@@ -111,7 +113,9 @@ static void __cpuinit twd_calibrate_rate(void)
 
 		count = __raw_readl(twd_base + TWD_TIMER_COUNTER);
 
-		twd_timer_rate = (0xFFFFFFFFU - count) * (HZ / 5);
+		rate64 = (0xFFFFFFFFLLU - count) * (u64)HZ;
+		do_div(rate64, 5);
+		twd_timer_rate = rate64;
 
 		printk("%lu.%02luMHz.\n", twd_timer_rate / 1000000,
 			(twd_timer_rate / 1000000) % 100);

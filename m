From: will.deacon@arm.com (Will Deacon)
Date: Thu, 12 Jul 2012 09:44:33 +0100
Subject: [PATCH v2 2/2] ARM: delay: allow timer-based delay
 implementation to be selected
In-Reply-To: <4FFE7DB2.4040702@renesas.com>
References: <1340991231-17682-1-git-send-email-will.deacon@arm.com>
 <1340991231-17682-3-git-send-email-will.deacon@arm.com>
 <4FFE7DB2.4040702@renesas.com>
Message-ID: <20120712084432.GA2816@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 12, 2012 at 08:33:06AM +0100, Shinya Kuribayashi wrote:
> Hi Will, Stephen,

Hi Shinya,

> On 6/30/2012 2:33 AM, Will Deacon wrote:
> > +void __init init_current_timer_delay(unsigned long freq)
> > +{
> > +	pr_info("Switching to timer-based delay loop\n");
> > +	lpj_fine			= freq / HZ;
> > +	arm_delay_ops.delay		= __timer_delay;
> > +	arm_delay_ops.const_udelay	= __timer_const_udelay;
> > +	arm_delay_ops.udelay		= __timer_udelay;
> > +}
> 
> Once this function is processed, the udelay() behavior changes
> _immediately_ from loop-based delay to timer-based one, without waiting
> for 'loops_per_jiffy' itself being corrected in calibrate_delay().
> 
> As a result, actual udelay()s may be toooo long than expected, in
> particular udelay()s used between init_current_timer_delay() and
> calibrate_delay().  It's unlikely be short, as the frequency of a
> counter for read_current_timer is typically slower than CPU frequency.

Surely using udelay before calibrate_delay_loop has been called is a
fundamental error?

Will

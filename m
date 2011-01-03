From: johnstul@us.ibm.com (john stultz)
Date: Mon, 03 Jan 2011 11:47:29 -0800
Subject: [PATCH] ARM: sched_clock: improve mult/shift accuracy with
	high frequency clocks
In-Reply-To: <20110103003718.GF17727@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1012202014500.10437@xanadu.home>
	<20101221105149.GO28157@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1012291703300.10437@xanadu.home>
	<20110103003718.GF17727@n2100.arm.linux.org.uk>
Message-ID: <1294084049.2571.30.camel@work-vm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-01-03 at 00:37 +0000, Russell King - ARM Linux wrote:
> On Wed, Dec 29, 2010 at 08:31:58PM -0500, Nicolas Pitre wrote:
> > On Tue, 21 Dec 2010, Russell King - ARM Linux wrote:
> > 
> > > On Mon, Dec 20, 2010 at 08:21:41PM -0500, Nicolas Pitre wrote:
> > > > 
> > > > The minsec argument to clocks_calc_mult_shift() [ which appears to be
> > > > misnamed by the way ] is used to clamp the magnitude of the mult factor
> > > > so that the given range won't overflow a 64 bit result.  The mult factor
> > > > is itself already limited to a maximum of 32 bits.  Given that the largest
> > > > clock tick range we may have is also 32 bits, there is no way our usage of
> > > > any computed mult factor would ever overflow 64 bits.
> > > > 
> > > > The choice of 60 seconds here for minsec is rather arbitrary.  If the
> > > > mult factor wasn't already limited to 32 bits, this value of 60 would
> > > > create overflows for clocks which take more than 60 seconds to wrap.
> > > 
> > > 60 seconds was arbitary, chosen from the selection of clock rates which
> > > I had available at the time (the highest of which was 24MHz).
> > 
> > Fair enough.  It is just not universally optimal given the different 
> > clock ranges this code now covers.
> > 
> > > > And for clocks which take less than 60 seconds to wrap then we do lose
> > > > precision as the mult factor is made smaller (fewer bits) to be adjusted
> > > > to a range which is larger than what we actually use.  This currently
> > > > affects clocks faster than 71MHz.
> > > > 
> > > > We could use minsec = 0 instead of 60 and a good 32-bit mult factor would
> > > > be computed in all cases.  But let's be formal and provide the actual
> > > > range to clocks_calc_mult_shift(). None of the cyc_to_fixed_sched_clock()
> > > > users are affected as they all are using clocks < 71MHz.
> > > 
> > > Maybe __clocksource_updatefreq_scale() needs a similar fix too, instead
> > > of assuming 5 seconds?  It also has access to the mask and rate.
> > 
> > There is a comment to that effect right above the 
> > clocks_calc_mult_shift() indicating that this is a known issue in that 
> > case already.  
> > 
> > And looking at that code, it appears that there is a balance to be made 
> > between cs->max_idle_ns and cs->mult, the former currently being 
> > determined by the later.  But if cs->mult is maximized to 32 bits, that 
> > leaves only 31 bits for cs->max_idle_ns which corresponds to approx 2 
> > seconds only.
> > 
> > So this is not clear to me what would be the optimal mult/shift values 
> > in the __clocksource_updatefreq_scale() context, while this is rather 
> > obvious in the init_sched_clock() context.  Hence this patch.
> 
> As clocksources are about precision (I believe it has been stated so in
> the past) it seems that fudging the shift and multiplier to get an
> extended period out of the clock is not the correct approach.
> 
> Maybe Thomas or John can shed some light on this?

Right, so there's conflicting goals of long idle times and fine-grained
time accuracy that pull the clocksource mult/shift pair calculation in
different directions.

Originally, the advice was pick a mult/shift pair that allows for a few
seconds of time to accrue before we overflow. However this was a little
vague and as the number of clocksources grew, and the desired idle times
were increasing,  I started to see that the lack of consistency was
going to give us troubles.

So the clocksource_register_hz/khz interfaces try to consolidate that
decision into one place, utilizing the MAX_UPDATE_LENGTH value
(currently 5 seconds) as the max idle time. Clocksource driver writers
don't have to worry about making the correct decision, the kernel should
do it for you.

Now, at some point I expect folks to get grumpy about the max idle time
being limited to 5 seconds, and we'll have to either push it out for
everyone (at the cost of less accurate NTP steering), or make it a
architecture specific config option.

Now, for sched_clock, there are a different set of expectations with
regards to accuracy and expected idle times, and we'll probably need a
similar consolidation effort to make sure the mult/shift calculations
are correct and the resulting limits are taken into account by the
scheduler when going into NOHZ mode.

thanks
-john

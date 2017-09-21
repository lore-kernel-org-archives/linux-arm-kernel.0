From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Sep 2017 08:59:07 +0100
Subject: On NTP, RTCs and accurately setting their time
In-Reply-To: <20170920224522.GB20974@obsidianresearch.com>
References: <20170920112152.GL20805@n2100.armlinux.org.uk>
 <20170920162208.GB536@obsidianresearch.com>
 <20170920165141.GP20805@n2100.armlinux.org.uk>
 <20170920224522.GB20974@obsidianresearch.com>
Message-ID: <20170921075907.GR20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 20, 2017 at 04:45:22PM -0600, Jason Gunthorpe wrote:
> On Wed, Sep 20, 2017 at 05:51:41PM +0100, Russell King - ARM Linux wrote:
> > I sort-of agree as far as the time offset information goes, but there's
> > a complication that we only open the RTC to set the time at the
> > point in
> 
> Hi Russell,
> 
> What do you think of this untested approach in the below patch?
> 
> Upon more careful inspection I think I found a way to make the
> rounding in rtc_set_ntp_time compatible with a wide range of rtc
> devices, so the subsecond capable ops I suggested do not seem
> necessary.

Looks like a possibility, but...

> +/* True if now.tv_nsec is close enough to time_sec_nsec that we can call the
> + * drivers's set_time_ns(). Arbitrarily choose 1ms as the allowable error
> + * margin.
> + *
> + * This also rounds tv_sec to the second that covers the tv_nsec tick we are
> + * targeting.
> + */
> +#define TIME_SET_NSEC_FUZZ (1000*1000)
> +static inline bool rtc_tv_nsec_ok(struct rtc_device *rtc,
> +				  struct timespec64 *now)
> +{
> +	long diff;
> +
> +	diff = (now->tv_nsec - rtc->time_set_nsec) % NSEC_PER_SEC;
> +	if (diff < TIME_SET_NSEC_FUZZ) {
> +		if (rtc->time_set_nsec + diff >= NSEC_PER_SEC) {
> +			now->tv_sec -= 1;
> +			now->tv_nsec = NSEC_PER_SEC-1;
> +		}
> +		return true;
> +	}
> +
> +	diff = (rtc->time_set_nsec - now->tv_nsec) % NSEC_PER_SEC;
> +	if (diff < TIME_SET_NSEC_FUZZ) {
> +		if (now->tv_nsec + diff >= NSEC_PER_SEC) {
> +			now->tv_sec += 1;
> +			now->tv_nsec = 0;
> +		}
> +		return true;
> +	}

I don't think this is correct - and I think it's overly expensive.
I threw this into a test program to prove the point, and it confirmed
my suspicions - the above will always return true.

Here's the test program output:

now=0.990000000, offset=         0: diff= 990000000 true 2: 0.990000000
now=0.999000000, offset=         0: diff= 999000000 true 2: 0.999000000
now=0.999900000, offset=         0: diff= 999900000 true 2: 0.999900000
now=1.000000000, offset=         0: diff=         0 true 1: 1.000000000
now=1.000100000, offset=         0: diff=    100000 true 1: 1.000100000
now=1.001000000, offset=         0: diff=   1000000 true 2: 1.001000000
now=1.010000000, offset=         0: diff=  10000000 true 2: 1.010000000
now=0.990000000, offset= 470000000: diff= 520000000 true 2: 0.990000000
now=0.999000000, offset= 470000000: diff= 529000000 true 2: 0.999000000
now=0.999900000, offset= 470000000: diff= 529900000 true 2: 0.999900000
now=1.000000000, offset= 470000000: diff=-470000000 true 1: 1.000000000
now=1.000100000, offset= 470000000: diff=-469900000 true 1: 1.000100000
now=1.001000000, offset= 470000000: diff=-469000000 true 1: 1.001000000
now=1.010000000, offset= 470000000: diff=-460000000 true 1: 1.010000000
now=0.990000000, offset=1000000000: diff= -10000000 true 1: 0.990000000
now=0.999000000, offset=1000000000: diff=  -1000000 true 1: 0.999000000
now=0.999900000, offset=1000000000: diff=   -100000 true 1: 0.999900000
now=1.000000000, offset=1000000000: diff=         0 true 1: 0.999999999
now=1.000100000, offset=1000000000: diff=-999900000 true 1: 1.000100000
now=1.001000000, offset=1000000000: diff=-999000000 true 1: 1.001000000
now=1.010000000, offset=1000000000: diff=-990000000 true 1: 1.010000000
now=0.990000000, offset=1470000000: diff=-480000000 true 1: 0.990000000
now=0.999000000, offset=1470000000: diff=-471000000 true 1: 0.999000000
now=0.999900000, offset=1470000000: diff=-470100000 true 1: 0.999900000
now=1.000000000, offset=1470000000: diff=-470000000 true 1: 0.999999999
now=1.000100000, offset=1470000000: diff=-469900000 true 1: 0.999999999
now=1.001000000, offset=1470000000: diff=-469000000 true 1: 0.999999999
now=1.010000000, offset=1470000000: diff=-460000000 true 1: 0.999999999

which should be self explanatory.  Another point to note is that
the computation of the time to be set is also incorrect - for
example, in the case of offset=0, we can see if we're slightly
early, we set tv_sec=0 rather than tv_sec=1.

In the offset=1sec case, it also isn't working as we'd expect -
this case should be providing tv_sec for the preceding second, but
it doesn't.

I don't yet have a proposal to fix this...

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

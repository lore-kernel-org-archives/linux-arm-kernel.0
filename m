From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Dec 2016 18:08:14 +0000
Subject: [PATCH 2/3] rtc: armada38x: Convert to time64_t
In-Reply-To: <20161208171010.29446-3-gregory.clement@free-electrons.com>
References: <20161208171010.29446-1-gregory.clement@free-electrons.com>
 <20161208171010.29446-3-gregory.clement@free-electrons.com>
Message-ID: <20161208180814.GK14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2016 at 06:10:09PM +0100, Gregory CLEMENT wrote:
> It is one more step to remove the deprecated functions rtc_time_to_tm
> and rtc_tm_to_time.

I fail to see any advantage to this patch, or in fact the y2038 patch
merged into rtc.

Let's first look at the original rtc_time_to_tm():

+void rtc_time_to_tm(unsigned long time, struct rtc_time *tm)
+{
+       days = time / 86400;
+       year = 1970 + days / 365;

time is an unsigned long, so is 32-bit or 64-bit.  Let's assume 32-bit.
The maximum value it can have is 2^32-1 - which gives a maximum days
value of 49710 (it always fits in an int or unsigned int as a positive
value on any arch supported by Linux.)

That gives a maximum value of 'year' as 2106.  So, actually
rtc_time_to_tm() doesn't have a y2038 problem, it has a y2106 problem.
So, the commentary in the original commit is actually wrong!


Okay, that aside, let's look at what your patch actually achieves.

Old code to set the time:

	unsigned long time;

	ret = rtc_tm_to_time(tm, &time);
	if (ret)
		goto out;
	/* write time to a 32-bit register */

New code:

	time64_t time;

	time = rtc_tm_to_time64(tm);
	/* write time to a 32-bit register */

I fail to see how this is any kind of improvement, or aids to solve the
y2106 problem (not y2038) here.

A better approach would have been to also provide a rtc_tm_to_time32()
following the function signature of rtc_tm_to_time(), but replacing the
unsigned long pointer with a u32 pointer, and (importantly) making it
fail if the time was unrepresentable as a u32 value.

Why u32 and not time_t?  time_t is a signed value, which suffers from
the y2038 problem.  u32 suffers from a y2106 problem, and is what we
have with the original rtc_tm_to_time() on 32-bit platforms.  So it's
safe _not_ to needlessly chop off a bit there which wasn't done in the
original code.

This would mean that drivers (such as armada38x) which are only capable
of storing a 32-bit time fail gracefully to set times beyond y2106.

The problem as I see it right now is that the y2038 patch which
deprecates rtc_time_to_tm() etc wasn't thought out thoroughly enough,
and is making the situation much worse by pushing the problem in many
drivers in a way that results in it being less visible.

I think this needs to be reconsidered, and it needs a much better
implementation - one which at least tells the user that their hardware
has broken when trying to set the time to something the hardware can't
support.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 May 2011 23:36:36 +0100
Subject: [PATCH 01/10] Add a common struct clk
In-Reply-To: <4DBEDC12.4090203@gmail.com>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-2-git-send-email-s.hauer@pengutronix.de>
	<4DBDC3B5.7070808@gmail.com> <1304298586.2686.29.camel@pororo>
	<4DBE2064.2060303@gmail.com> <1304307632.2686.33.camel@pororo>
	<4DBEDC12.4090203@gmail.com>
Message-ID: <20110502223636.GB28001@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 02, 2011 at 11:30:10AM -0500, Rob Herring wrote:
> On 05/01/2011 10:40 PM, Jeremy Kerr wrote:
>> Hi Rob,
>>
>>> I think you will find many examples in the kernel where that is not done
>>> by drivers.
>>
>> Drivers should be checking the return value of clk_get - if they don't,
>> it's a bug. This is the logical place to check, rather than before all
>> clock API calls.
>
> Maybe so, but it's common practice. Why not allow it, but add a warning?  
> Or allow NULL, but not an error value.

If drivers don't check the return value of clk_get() then they'll suffer
kernel oopses.  What's to say that if the driver doesn't check the return
value from clk_get() that they'll bother checking the return value from
any of the other clk_* API functions.  Nothing.

So, checking for ERR values inside the clk_* functions is silly, and just
means that buggy drivers continue with undiscovered bugs because they
happen not to fail.

>> For cases where there is no clock provided for the device (but is a
>> valid clock on some machines), the platform code should return a no-op
>> clock from the clk_get call. This 'noop clock' would be a good contender
>> for inclusion into the kernel-wide infrastructure, like clk_fixed.
>
> There could be cases where the driver wants to know if there is no  
> clock.

How exactly would a driver know that the clock it has is a no-op clock
with it being a pointer to some random data structure?  A better question
would be in the case of a cpufreq driver, how would such a driver know
that it's pointless trying to set the rate on a fixed rate clock?

There's soo many combinations here where you can say "if a clock has
property X, then maybe the driver doesn't want to do Y".  So, instead
of trying to cover all the possibilities, take a step back and look at
the bigger picture.

1. in a cpufreq driver, if it gets a clock, one would hope that the
clock it has been provided with is adjustable - in other words,
clk_set_rate() stands a chance of succeeding.  If it fails, then it
has the wrong clock.

2. if the clock it has does not support adjustments in this way, then
there is a bug in the data involved in selecting that clock, and that's
what's at fault.  You find this out when you try to change its rate
via clk_set_rate() which should fail.

3. (to head off something that I can see being proposed) no, I don't
think we need a system of properties.

A cpufreq driver which obtains clks should be no different from any
other driver.  It should get a clk via clk_get(), and report errors if
that fails.  If clk_set_rate() fails, then it should report that error
too.  There's really nothing "special" here.

This does bring us to an interesting question though: should clk_set_rate()
succeed or fail with a NULL clk?  There is no clock to control, so my
feeling is that it should fail, just like clk_get_rate() should return
zero because the rate is meaningless.  There is no rate to get and no
rate to set.

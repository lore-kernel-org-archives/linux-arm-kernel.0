From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 20 Feb 2013 10:10:27 -0700
Subject: [PATCH v3 2/8] reset: Add reset controller API
In-Reply-To: <1361358260.4937.26.camel@pizza.hi.pengutronix.de>
References: <1361273732-23357-1-git-send-email-p.zabel@pengutronix.de>
 <1361273732-23357-3-git-send-email-p.zabel@pengutronix.de>
 <5123F112.7050105@wwwdotorg.org>
 <1361358260.4937.26.camel@pizza.hi.pengutronix.de>
Message-ID: <51250383.2070800@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/20/2013 04:04 AM, Philipp Zabel wrote:
> Hi,
> 
> Am Dienstag, den 19.02.2013, 14:39 -0700 schrieb Stephen Warren:
>> On 02/19/2013 04:35 AM, Philipp Zabel wrote:
>>> This adds a simple API for devices to request being reset
>>> by separate reset controller hardware and implements the
>>> reset signal device tree binding.

>>> +# reset controllers early, since gpu drivers might rely on them to initialize
>>> +obj-$(CONFIG_RESET_CONTROLLER)	+= reset/
>>
>> That sounds odd now. Shouldn't -EPROBE_DEFERRED sort out any ordering
>> issues?
> 
> Even so, isn't it useful to avoid the -EPROBE_DEFERRED loop when we
> expect other drivers to depend on resources provided by the reset
> controller drivers, but not the other way around?

If this Makefile ordering is solely to reduce the number of times
-EPROBE_DEFERRED is returned, it's probably fine. I just want to make
sure that the ordering isn't required to ensure correctness.

It's quite possible that in general a reset controller driver depends on
clocks, GPIOs, ... from other nodes though, so I'm not sure quite how
much this will buy us in the general case.

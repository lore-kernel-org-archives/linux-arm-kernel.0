From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 31 Aug 2017 13:39:22 -0500
Subject: linux-next regression caused by "gpiolib: request the gpio before
 querying its direction"
In-Reply-To: <20170831113935.38028ff8@windsurf.lan>
References: <20170830112424.7a3a7c36@windsurf.lan>
 <3cce6903-d167-1bfc-38b4-1fdd7b3ff24b@codeaurora.org>
 <87ziah2m3f.fsf@free-electrons.com> <20170830161730.41919554@windsurf.lan>
 <CACRpkdbxdkHukALfYMrM7w=1KNJKLBhGebbkEpMb3C3+nCfWOA@mail.gmail.com>
 <20170831091812.6f7d417e@windsurf.lan>
 <CAMuHMdVGkTQ0vnOg5o+t1J9qe79ySm0R8aE4msyuNLoVGHLD6A@mail.gmail.com>
 <20170831092211.GP20805@n2100.armlinux.org.uk>
 <20170831113935.38028ff8@windsurf.lan>
Message-ID: <a841b6f2-ded1-2b16-3713-fc29af43d7a7@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/31/2017 04:39 AM, Thomas Petazzoni wrote:
>>
>> IMHO, the pinmux settings should always be specified in DT, and that's
>> what we should be using everywhere, not doing broken backdoor games like
>> "the gpio is being requested, it's obvious that we want this pin to be
>> a gpio" - that really doesn't follow.
> Agreed.

How many drivers need to be "fixed" if this is the plan?  I don't think 
we can make a blanket change to all drivers whose ->request functions 
touch the muxes without testing on all those platforms.  And it's not 
just the muxes.  The whole point behind my patch was to avoid 
gpiochip_add_data() touching the hardware without claiming the GPIO first.

The overall goal of my patch was to allow "sparse" GPIO maps.  The 
problem with gpiochip_add_data() is that it touches all GPIOs even 
before I call gpiochip_add_pin_range().

Maybe the for-loop that it's in gpiochip_add_data() should be moved to 
gpiochip_add_pin_range(), so that we only query the direction of a pin 
after it's been added, not before?

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

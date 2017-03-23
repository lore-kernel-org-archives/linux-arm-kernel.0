From: mike.leach@linaro.org (Mike Leach)
Date: Thu, 23 Mar 2017 12:27:09 +0000
Subject: [PATCH v3 3/5] coresight: add support for debug module
In-Reply-To: <20170323054319.GA7716@leoy-linaro>
References: <1488520809-31670-1-git-send-email-leo.yan@linaro.org>
 <1488520809-31670-4-git-send-email-leo.yan@linaro.org>
 <671a0b39-b635-6e0e-d3fa-967651f2e29c@arm.com>
 <CAJ9a7VgCjXNGC4C49PxL-nBxzhMCmA8Mb-0C_epahizA5EL2HA@mail.gmail.com>
 <e7a97c52-f61a-e503-f626-09563fa100b8@arm.com>
 <CAJ9a7VhvCS3xXAHBt0AUVB2Zp2P1HP_LQm4KiptiBT9VJ1fC0Q@mail.gmail.com>
 <4961636d-d77c-0f9a-7076-4db1ef456073@arm.com>
 <1e6d6a91-3bdc-7cfb-a96f-780c959e0316@arm.com>
 <7a028460-d598-e337-5e09-234beddca88b@arm.com>
 <20170323054319.GA7716@leoy-linaro>
Message-ID: <CAJ9a7Vj8Rt7+Pq+pYg-K+xHNYnSyR+oN4RHM6XTb_Ju+akgbug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also agree with Suzuki's excellent summary.

A couple of notes on using EDPRCR....

The logic for this assuming a correctly implemented system should be
something like.....

if (prsr() == powered_down) { // if we are powered down request power up.
    sw_unlock()   // ensure that the sw lock register on the device is unlocked
    write(prcr(bit3=1))
    wait_with_timeout(prsr()==powered_up)   // must wait to see if the
system does power up - otherwise bad things happen!
    if(timed_out)
       fail("power up request for CPU N failed.")  // nothing to do
after this point though if a CPU can't be powered is should not be
included in the list to be checked on crash.
}
ensure_os_lock_unlocked()  // os lock has to be unlocked for bit 0 of
prcr to be writeable.
sw_unlock()   // ensure that the sw lock register on the device is unlocked
write(prcr(bit3=1 | bit0=1)) // the core is powered, set the
nopowerdown request bit so we don't lose it & emulate power down


I think that some of the above logic is already in the driver, so
needs to be adapted for the PRCR handling.


On the "bad" systems, the initial prsr check is likely to fail (crash
/ buslock) if the debug logic is not correctly powered. The user will
then have to use one or more of the PM mitigations previously
discussed that are appropriate for that specific platform and retry

Regards

Mike


On 23 March 2017 at 05:43, Leo Yan <leo.yan@linaro.org> wrote:
> On Wed, Mar 22, 2017 at 05:25:50PM +0000, Sudeep Holla wrote:
>>
>>
>> On 22/03/17 17:09, Suzuki K Poulose wrote:
>> > On 22/03/17 16:17, Sudeep Holla wrote:
>>
>> [...]
>>
>> >>
>> >> Point taken. So we could just specify that all necessary power
>> >> domains need to be on for proper functionality for this feature and
>> >> that it's highly platform specific instead of mixing cpu/cluster
>> >> idle details here.
>> >>
>> >>> The key point is that the caveat in using this driver is that
>> >>> the power management has to be considered on a platform specific
>> >>> basis before it is configured; and appropriate actions may be
>> >>> needed for it to work correctly. Without this then the driver
>> >>> could cause more issues than it debugs. A user selecting this
>> >>> _must_ be told about these issues
>> >>>
>> >
>> > So given all the possible caveats, I think we :
>> >
>> > 1) Shouldn't enable the driver by default at runtime even if it is
>> > built-in.
>> > 2) Should provide mechanisms to turn it on at boot (via
>> > kernel commandline) or anytime later (via sysfs), which kind of puts
>> > the responsibility back on the user : "You know what you are doing".
>> > 3) Shouldn't turn the driver on based on "nohlt" which the user
>> > could use it for some other purposes, without explicit intention of
>> > turning this driver on).
>> > 4) Should document the fact that, on some
>> > platforms, the user may have to disable CPUidle explicitly to get the
>> > driver working. But let us not make it the default. The user with a
>> > not so ideal platform could add "nohlt" and get it working.
>> >
>>
>> Agreed on all points and well summarized.
>> I would like to highlight (3) and (4) as it needs to be well understood.
>>
>> "nohlt" has a *different* meaning already, so using that in this
>> driver for something else is simple wrong as it affects the system in
>> unintended ways. And yes if user (mis)uses it to get things working,
>> it's fine but shouldn't be recommended way.
>
> Understand this point.
>
> I will try to use general way to constraint CPUIdle like other
> drivers.
>
> Thanks all for these good suggestions :)
>
> Thanks,
> Leo Yan



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Blackburn Design Centre. UK

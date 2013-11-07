From: nm@ti.com (Nishanth Menon)
Date: Thu, 7 Nov 2013 09:48:06 -0600
Subject: [PATCH v4] ARM: omap: edma: add suspend suspend/resume hooks
In-Reply-To: <527BB38A.1060609@gmail.com>
References: <1383164468-4610-1-git-send-email-zonque@gmail.com>
 <CANacCWz_ahKaACbAHuue1XwaN3gutBA7Z6W+=zWBn8LvLwDM5w@mail.gmail.com>
 <527A7E20.4040107@ti.com> <527B95E3.9060802@ti.com>
 <527B9673.60400@gmail.com> <527BAF63.10308@ti.com>
 <527BB38A.1060609@gmail.com>
Message-ID: <527BB636.60403@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/2013 09:36 AM, Daniel Mack wrote:
> On 11/07/2013 04:18 PM, Nishanth Menon wrote:
>> Tested this on a vendor V3.12 tag based kernel:
>>
>> Test patch: http://pastebin.com/AmnktQ7B
>> test: echo -n "1">/sys/power/pm_print_times; rtcwake -d /dev/rtc0 -m
>> mem -s 5
>>
>>
>> with the current patch: http://pastebin.com/RujarRLV
>> suspend_late and resume_early: http://pastebin.com/RujarRLV
> 
> These two are identical.
> 
>> suspend_noirq and resume_noirq: http://pastebin.com/nKfbm7Mj
> 
> And I can't see any difference between this one and the first one,
> except for slightly different timings. Am I missing anything?

aah, that happens to be a little key :)
if you see the current patch, it happens around line 417,
with suspend_late, it moves deeper(or later) into suspend around 738
with noirq - it is as late as it can get - around line 823 just before
the last set of arch suspend calls are done.

>> one needs to be careful of the sequence - donot forget that
>> omap_device also does stuff in the background to every SoC device in
>> noirq - sequence is paramount. you would want to ensure edma is saving
>> after every single dependent device is done with it's stuff and
>> guarenteed to never request any further transaction, and resume is
>> done before any of the dependent devices need edma. but edma is also a
>> peripheral that omap_device and generic runtime pm framework deals
>> with - so ensure sequences consider that as well.
> 
> So, what would you say which sequence is correct then? :)

Disclaimer: I have not dug deeper, other than a cursory look. With
proper error handling, proper split between suspend and suspend_late
seems appropriate to me(at noirq, runtime_get could fail as pmruntime
is disabled as part of suspend sequence and could race with
omap_device handling in a future cleanup there) - with the assumption
that all drivers that are using things have cleaned up prior to that.
edma is a generic engine that many drivers may choose to use - example
of MMC used in this discussion is just one of other potential users -
for a generic driver like dma, you'd want to stay as deep in the
suspend as possible. you may also want to ensure that further calls
will not succeed until resume is invoked.

-- 
Regards,
Nishanth Menon

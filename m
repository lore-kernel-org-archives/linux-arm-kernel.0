From: acourbot@nvidia.com (Alexandre Courbot)
Date: Tue, 11 Nov 2014 13:29:46 +0900
Subject: [PATCH 0/3] Add support for Tegra Activity Monitor
In-Reply-To: <545CBC87.7050404@collabora.com>
References: <1414594232-15684-1-git-send-email-tomeu.vizoso@collabora.com>
 <545C8BCC.3090908@nvidia.com> <545CBC87.7050404@collabora.com>
Message-ID: <546190BA.7050502@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/2014 09:35 PM, Tomeu Vizoso wrote:
> On 11/07/2014 10:07 AM, Alexandre Courbot wrote:
>> On 10/29/2014 11:50 PM, Tomeu Vizoso wrote:
>>> Hello,
>>>
>>> these patches implement support for setting the rate of the EMC clock based on
>>> stats collected from the ACTMON, a piece of hw in the Tegra124 that counts
>>> memory accesses (among others).
>>>
>>> It depends on the following in-flight patches:
>>>
>>> * MC driver: http://thread.gmane.org/gmane.linux.ports.tegra/19623
>>> * EMC driver: http://thread.gmane.org/gmane.linux.ports.arm.kernel/365125
>>> * CPUFreq driver: http://thread.gmane.org/gmane.linux.kernel/1812962
>>>
>>> I have pushed a branch here for testing:
>>
>> I am not too familiar with DVFS, but after going through this series it
>> really seems to me that this could use devfreq. In its current form this
>> driver mixes control and policy and lacks flexibility, preventing e.g.
>> to switch to a performance or power-saving profile. Could you study the
>> feasibility of using devfreq for this?
>
> Yeah, I started writing a devfreq driver, but then I looked in more
> detail to the downstream driver and realized that most of the
> functionality that devfreq provides overlaps with the hw.
>
> The ACTMON can be configured to fire an interrupt when a set of
> thresholds are crossed, similar to the simple-ondemand governor but a
> bit more sophisticated.

I think (after a quick look at devfreq's source) that you can avoid 
polling altogether if you set polling_ms to 0 in your 
devfreq_dev_profile instance. Then it is up to you to call 
update_devfreq() from your custom governor whenever it sees fit.

ACTMON support seems to overlap between being a governor (which reacts 
to ACTMON interrupts and calls update_devfreq() when needed) and part of 
a devfreq_dev_profile (get_dev_status() needs to use the actmon 
counters). If we keep your current design where the driver simply 
controls a clock, you could have the ACTMON driver obtain that clock, 
register its governor, create a non-polling devfreq_dev_profile that 
controls that clock, and just call devfreq_add_device() with both. Then 
we will have the benefit of being able to use ACTMON as well as the 
performance and powersave governors on EMC, and switch policies dynamically.

Another benefit is that you will have a placeholder in the governor to 
implement suspend/resume for the ACTMON IP, in case this becomes 
necessary in the future.

Do you think that would work? Apart from the polling which doesn't seem 
to be an issue, have you seen any other redundancy between devfreq and 
ACTMON?

> The only functionality of the governors that
> isn't covered by the ACTMON hw is determining the new frequency after a
> threshold has been crossed, but if we want to retain the flexibility of
> the downstream solution, we would need to write a new governor anyway.

Yes, and that's fine. Actually if the parameters of the ACTMON governor 
could be fine-tuned via sysfs, that would just be perfect.

> I realize that it would be cool to reuse the code in devfreq, but being
> able to let the hw sample the counters, calculating averages and
> checking if a threshold has been crossed without the cpu having to
> intervene gives this SoC quite an edge when compared to its competitors.

AFAICT we can keep that edge while getting the benefit of using a common 
framework. Also I expect quite some resistance against the merge of this 
driver if it is not using devfreq. You probably can tell us better 
whether it is fit or not, but can you examine my points above and let us 
know what you think? After a quick look, it actually looks quite 
exploitable for our use-case.

Cheers,
Alex.

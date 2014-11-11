From: acourbot@nvidia.com (Alexandre Courbot)
Date: Tue, 11 Nov 2014 16:32:22 +0900
Subject: [PATCH 0/3] Add support for Tegra Activity Monitor
In-Reply-To: <5461B35A.3080604@nvidia.com>
References: <1414594232-15684-1-git-send-email-tomeu.vizoso@collabora.com>
 <545C8BCC.3090908@nvidia.com> <545CBC87.7050404@collabora.com>
 <546190BA.7050502@nvidia.com> <5461B35A.3080604@nvidia.com>
Message-ID: <5461BB86.509@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/2014 03:57 PM, Terje Bergstr?m wrote:
> On 11.11.2014 06:29, Alexandre Courbot wrote:
>> I think (after a quick look at devfreq's source) that you can avoid
>> polling altogether if you set polling_ms to 0 in your
>> devfreq_dev_profile instance. Then it is up to you to call
>> update_devfreq() from your custom governor whenever it sees fit.
>>
>> ACTMON support seems to overlap between being a governor (which reacts
>> to ACTMON interrupts and calls update_devfreq() when needed) and part of
>> a devfreq_dev_profile (get_dev_status() needs to use the actmon
>> counters). If we keep your current design where the driver simply
>> controls a clock, you could have the ACTMON driver obtain that clock,
>> register its governor, create a non-polling devfreq_dev_profile that
>> controls that clock, and just call devfreq_add_device() with both. Then
>> we will have the benefit of being able to use ACTMON as well as the
>> performance and powersave governors on EMC, and switch policies
>> dynamically.
>
> Another way to use it is that governor is just a governor. It takes in
> load values and generates new target frequencies, and doesn't know
> anything about HW.
>
> Device profile is the one that enables threshold interrupts and disables
> polling. Device profile receives the interrupt, retrieves new load
> number from hardware, and calls update_devfreq().
>
> This way we keep all HW specific code in device profile, and there's
> potential to use a generic governor instead of writing your own.

I see several obstacles with this approach:

1) update_devfreq() is a governor private function (defined in 
drivers/devfreq/governor.h) and it would need to be called from the 
device profile.

2) devfreq events (start monitoring, stop monitoring, suspend, resume, 
...) are processed by the governor. So it would still need access to the 
actmon registers to honor these requests.

3) simple monitors like performance and powersave set the frequency (max 
or min) once and for all when they are started, and don't need to be 
called again afterwards. But this is probably what will happen if you 
let the devfreq_dev_profile handle the ACTMON registers, since it can 
make no assumption on when the governor expects to be invoked.

It would be good to have the feedback of devfreq's maintainers about 
this (added them). How could an IP capable of monitoring activity 
through counters and firing interrupts when these counters reach a 
certain threshold be integrated nicely into devfreq? The functions seem 
to overlap between the governor (reacting to specific events, in this 
case ACTMON interrupts) and dev_profile (querying current status through 
the counters), and it seems difficult to come with a design where the 
governor and dev_profile are not tightly intertwined.

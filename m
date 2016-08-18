From: dianders@chromium.org (Doug Anderson)
Date: Thu, 18 Aug 2016 15:08:12 -0700
Subject: [PATCH] soc: rockchip: power-domain: Don't (incorrectly) set
 rk3399 up/down counts
In-Reply-To: <86565478.t9HNV2EDZM@phil>
References: <1471546561-4459-1-git-send-email-dianders@chromium.org>
 <86565478.t9HNV2EDZM@phil>
Message-ID: <CAD=FV=W++ONg4UjjPTmzXMp9wVWjJDNyOpQW33Oc_1Y8BfTYjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 18, 2016 at 3:03 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> Hi Doug,
>
> Am Donnerstag, 18. August 2016, 11:56:01 CEST schrieb Douglas Anderson:
>> On rk3288 it was important that powerdown and powerup counts for the
>> CPU/GPU in the kernel because:
>
> somehow this sentence seems to miss some verb or so :-)

Sigh.  I guess I can't type.

On rk3288 it was important that powerdown and powerup counts for the
CPU/GPU be set in the kernel because:

>> * The power on default was crazy long.
>> * We couldn't rely on the firmware to set this up because really this
>>   wasn't the firmware's job--the kernel was the only one that really
>>   cared about bringing up / down CPUs and the GPU and doing suspend /
>>   resume (which involves bringing up / down CPUs).
>>
>> On newer ARM systems (like rk3399) ARM Trusted Firmware is in charge of
>> bringing up and down the CPUs and it really should be in charge of
>> setting all these counts right.  After all ATF is in charge of suspend /
>> resume and CPU up / down.  Let's get out of the way and let ATF do its
>> job.
>>
>> A few other motivations for doing this:
>> * Depending on another configuration (PMU_24M_EN_CFG) these counts can
>>   be either in 24M or 32k cycles.  Thus, though ATF isn't really so
>>   involved in bringing up the GPU, ATF should probably manage the counts
>>   for everything so it can also manage the 24M / 32k choice.
>> * It turns out that (right now) 24M mode is broken on rk3399 and not
>>   being used.  That means that the count the kernel was programming
>>   in (24) was not 1 us (which it seems was intended) but was actually
>>   .75 ms
>> * On rk3399 there are actually 2 separate registers for setting CPU
>>   up/down time plus 1 register for GPU up/down time.  The curent kernel
>>   code actually was putting the register for the "little" cores in the
>>   "CPU" slot and the register for the "big" cores in the "GPU" slot.  It
>>   was never initting the GPU counts.
>>
>> Note: this change assumes that ATF will actually set these values at
>> boot, as I'm proposing in <http://crosreview.com/372381>.
>
> I'd hope to see a link to an ATF github pull request here :-)
> But I guess that simply needs some more discussion on your side.

Caesar is going to get confirmation that the patch is OK then I think
he'll work on the ATF pull request.  Once done we can update the link
here?


>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> change itself looks good to me.
>
> So I guess we'll just need to wait for the counterpart to land in the ATF or
> do you know if the poweron-defaults are somewhat sane?

Power on defaults are crappy (750 ms to turn on/off a CPU), so
non-ideal.  Probably best to wait for ATF to land.


-Doug

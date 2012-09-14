From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Fri, 14 Sep 2012 23:21:43 +0530
Subject: [PATCH] RTC: TWL: ensure all interrupts are disabled during probe
In-Reply-To: <87r4q4aea1.fsf@deeprootsystems.com>
References: <1347569157-19262-1-git-send-email-khilman@deeprootsystems.com>
 <CAM=Q2cufVSReuvs3Yf6jvuBFeV9j5iPWV-DaMqRkCJFXUMZPQg@mail.gmail.com>
 <87r4q4aea1.fsf@deeprootsystems.com>
Message-ID: <CAM=Q2csh-sqMPY5qQFgC4PZ4rwsj8-kK933L3Cs=iE1zT0mr+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 7:37 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Shubhrajyoti Datta <omaplinuxkernel@gmail.com> writes:
>
>> Hi Kevin,
>>
>> On Fri, Sep 14, 2012 at 2:15 AM, Kevin Hilman
>> <khilman@deeprootsystems.com> wrote:
>>> From: Kevin Hilman <khilman@ti.com>
>>>
>>> On some platforms, bootloaders are known to do some interesting RTC
>>> programming.  Without going into the obscurities as to why this may be
>>> the case, suffice it to say the the driver should not make any
>>> assumptions about the state of the RTC when the driver loads.  In
>>> particular, the driver probe should be sure that all interrupts are
>>> disabled until otherwise programmed.
>>>
>>> This was discovered when finding bursty I2C traffic every second on
>>> Overo platforms.  This I2C overhead was keeping the SoC from hitting
>>> deep power states.  The cause was found to be the RTC firing every
>>> second on the I2C-connected TWL PMIC.
>>>
>>> Special thanks to Felipe Balbi for suggesting to look for a rogue
>>> driver as the source of the I2C traffic rather than the I2C driver
>>> itself.
>>>
>>> Special thanks to Steve Sakoman for helping track down the source of
>>> the continuous RTC interrups on the Overo boards.
>>>
>>
>> Tested that the continuous interrupt issue after doing a i2c mm on omap4sdp.
>> This patch solves the issue.
>> thanks,
>>
>>> Cc: Felipe Balbi <balbi@ti.com>
>>> Cc: Steve Sakoman <steve@sakoman.com>
>>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>>> ---
>>> Patch applies to v3.6-rc5
>>>
>>>  drivers/rtc/rtc-twl.c |    5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
>>> index c5d06fe..9277d94 100644
>>> --- a/drivers/rtc/rtc-twl.c
>>> +++ b/drivers/rtc/rtc-twl.c
>>> @@ -495,6 +495,11 @@ static int __devinit twl_rtc_probe(struct platform_device *pdev)
>>>         if (ret < 0)
>>>                 goto out1;
>>>
>>> +       /* ensure interrupts are disabled, bootloaders can be strange */
>>> +       ret = twl_rtc_write_u8(0, REG_RTC_INTERRUPTS_REG);
>>> +       if (ret < 0)
>>> +               dev_warn(&pdev->dev, "unable to disable interrupt\n");
>>> +
>> Now that it is always 0 can the below read be removed as it is redundant now.
>
> Possibly, but I don't know this HW well enough to know if there are any
> persistent bits in that register on any of the various derivations of
> this PMIC.  Since this read-back value is used throughout the driver, I
> decided not to mess with it when doing this targetted fix.

Indeed makes sense.

>
> Kevin
>

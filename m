From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 7 Jun 2017 10:38:47 -0500
Subject: [[PATCH]] drivers: leds/trigger: system cannot enter suspend
In-Reply-To: <AM3PR04MB4044D34CA2E85B0CE70ED778AC80@AM3PR04MB404.eurprd04.prod.outlook.com>
References: <1496716596-45414-1-git-send-email-bo.zhang@nxp.com>
 <20170606192554.GA32171@amd> <1a14165d-2976-50df-18d6-74e5fdec2913@gmail.com>
 <8afffd09-cb1f-d080-ef4a-ecaa089ad470@ti.com> <20170606203813.GD32171@amd>
 <AM3PR04MB4044D34CA2E85B0CE70ED778AC80@AM3PR04MB404.eurprd04.prod.outlook.com>
Message-ID: <81f270ba-6f3c-7759-789b-181203efb7b7@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/06/2017 11:24 PM, Bruce Zhang wrote:
> Hi Pavel,
> 
> It can also fix my issue by reverting  the commit 5ab92a7cb. But this action only does not make led_set_brightness_nosleep function to set brightness. The heartbeat trigger timer is still running even though it is not harmful.

Unfortunately, this is sort of design issue of leds triggers framework as it
doesn't have Suspend related interfaces, so triggers continue running 
even if led, by it self, is suspended from led_classdev_suspend().
For example, heartbeat trigger timer can be source of spurious wake-ups 
in some cases.

I've had to deal with such kind of issues but related to ledtrig-cpu.c
connected to gpio.



> 
> On Tue 2017-06-06 15:19:23, Grygorii Strashko wrote:
>>
>>
>> On 06/06/2017 03:05 PM, Jacek Anaszewski wrote:
>>> On 06/06/2017 09:25 PM, Pavel Machek wrote:
>>>> On Tue 2017-06-06 10:36:36, Zhang Bo wrote:
>>>>> System cannot enter suspend mode because of heartbeat led trigger.
>>>>> In autosleep_wq, try_to_suspend function will try to enter suspend
>>>>> mode in specific period. it will get wakeup_count then call
>>>>> pm_notifier chain callback function and freeze processes.
>>>>> Heartbeat_pm_notifier is called and it call led_trigger_unregister
>>>>> to change the trigger of led device to none. It will send uevent
>>>>
>>>> Why is heartbeat_pm_notifier calling led_trigger_unregister? That
>>>> sounds like a bug.
>>>
>>> I suggest using git blame. The commit message adding this code is
>>> pretty informative.
>>>
>>
>> In my opinion original commit do not contain ehough info about root
>> cause of the problem (commit 5ab92a7cb "leds: handle suspend/resume in
>> heartbeat trigger")
> 
> Zhang: Can you try to revert commit 5ab92a7cb in your tree, to see if it fixes your problem?
> 
> Thanks,
> 									Pavel


-- 
regards,
-grygorii

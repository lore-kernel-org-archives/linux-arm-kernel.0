From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 6 Jun 2017 15:19:23 -0500
Subject: [[PATCH]] drivers: leds/trigger: system cannot enter suspend
In-Reply-To: <1a14165d-2976-50df-18d6-74e5fdec2913@gmail.com>
References: <1496716596-45414-1-git-send-email-bo.zhang@nxp.com>
 <20170606192554.GA32171@amd> <1a14165d-2976-50df-18d6-74e5fdec2913@gmail.com>
Message-ID: <8afffd09-cb1f-d080-ef4a-ecaa089ad470@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/06/2017 03:05 PM, Jacek Anaszewski wrote:
> On 06/06/2017 09:25 PM, Pavel Machek wrote:
>> On Tue 2017-06-06 10:36:36, Zhang Bo wrote:
>>> System cannot enter suspend mode because of heartbeat led trigger.
>>> In autosleep_wq, try_to_suspend function will try to enter suspend
>>> mode in specific period. it will get wakeup_count then call pm_notifier
>>> chain callback function and freeze processes.
>>> Heartbeat_pm_notifier is called and it call led_trigger_unregister to
>>> change the trigger of led device to none. It will send uevent
>>
>> Why is heartbeat_pm_notifier calling led_trigger_unregister? That
>> sounds like a bug.
> 
> I suggest using git blame. The commit message adding this code is pretty
> informative.
> 

In my opinion original commit do not contain ehough info about root cause 
of the problem (commit 5ab92a7cb "leds: handle suspend/resume in heartbeat trigger")

"The following phenomena was observed: when suspending the
    system, sometimes the heartbeat LED was left on, glowing and
    wasting power while the rest of the system is asleep, also
    disturbing power dissapation measures on the odd suspend
    cycle when it's left on.
"

But why is this happen? In general, leds expected to be switched off during suspend
from led_classdev_suspend() which sets LED_SUSPENDED and so blocks 
led_set_brightness_nosleep() and led_set_brightness_sync().

I think, there was some race between led_classdev_suspend() and
set_brightness_work and led_heartbeat_function() which is timer callback.

So, In my opinion, real solution is to remove heartbeat_pm_notifier() and ensure
that LED_SUSPENDED flag is processed correctly during suspend. Another option could be
to use syscore_ops as it's done in ledtrig-cpu.c.

-- 
regards,
-grygorii

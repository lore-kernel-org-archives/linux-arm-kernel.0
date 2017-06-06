From: jacek.anaszewski@gmail.com (Jacek Anaszewski)
Date: Tue, 6 Jun 2017 22:00:50 +0200
Subject: [[PATCH]] drivers: leds/trigger: system cannot enter suspend
In-Reply-To: <AM3PR04MB404B1161E73CF4D2FB3C5058ACB0@AM3PR04MB404.eurprd04.prod.outlook.com>
References: <1496648191-134355-1-git-send-email-bo.zhang@nxp.com>
 <9d1f4e47-0713-043a-4359-db8f856e0b0e@gmail.com>
 <AM3PR04MB404B1161E73CF4D2FB3C5058ACB0@AM3PR04MB404.eurprd04.prod.outlook.com>
Message-ID: <26a7dbc6-3547-5139-c3ff-b1fbb93293cc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bo,

On 06/06/2017 04:47 AM, Bruce Zhang wrote:
> Hi Jacek,
> 
> The led_syfs_disable() is used to avoid heartbeat_trig_activate/ heartbeat_trig_deactivate called when this led device is suspended.
> I am not encounter this issue, but I think it is a risk.

The led_sysfs_enable{disable} have been designed mainly to allow for
disabling an access to a LED flash class device, when it is under
v4l2-flash sub-device control. While it seems that calling it here
shouldn't do any harm, since vl42_flash sub-dev removes any trigger on
open, it would be semantically inconsistent, since suspending/resuming
a trigger shouldn't influence any LED class device sysfs availability.

Moreover, it will not eliminate the possibility that heartbeat trigger
is set in the meantime on some other LED class device, which will also
send an uevent. This is however under userspace control.

Please don't use this API here.

> -----Original Message-----
> From: Jacek Anaszewski [mailto:jacek.anaszewski at gmail.com] 
> Sent: Tuesday, June 06, 2017 3:27 AM
> To: Bruce Zhang <bo.zhang@nxp.com>; linux-arm-kernel at lists.infradead.org
> Cc: pavel at ucw.cz; Linux LED Subsystem <linux-leds@vger.kernel.org>
> Subject: Re: [[PATCH]] drivers: leds/trigger: system cannot enter suspend
> 
> Hi Zhang,
> 
> Thanks for the patch. It seems to be almost ready to merge.
> Just two issues below.
> 
> Please also always cc linux-leds at vger.kernel.org when modifying LED subsystem.
> 
> On 06/05/2017 09:36 AM, Zhang Bo wrote:
>> System cannot enter suspend mode because of heartbeat led trigger.
>> Heartbeat_pm_notifier is called when system prepare to enter suspend 
>> mode, then call led_trigger_unregister to change the trigger of led 
>> device to none. It will send uevent message and the wakeup source count changed.
>>
>> Add suspend/resume ops to the struct led_trigger, implement these two 
>> ops for ledtrig-heartbeat. Add led_trigger_suspend/led_trigger_resume 
>> funcitons to iterate through all LED class devices registered on given 
>> trigger and call their suspend/resume ops and disable/enable sysfs at the same time.
>>
>> Call led_trigger_suspend{resuem} API in pm_notifier function to 
>> suspend/resume all led devices listed in given trigger.
>>
>> Signed-off-by: Zhang Bo <bo.zhang@nxp.com>
>> ---
>>  drivers/leds/led-triggers.c              | 34 +++++++++++++++++++++++++++++++
>>  drivers/leds/trigger/ledtrig-heartbeat.c | 35 ++++++++++++++++++++++++++------
>>  include/linux/leds.h                     |  6 ++++++
>>  3 files changed, 69 insertions(+), 6 deletions(-)  mode change 100644 
>> => 100755 drivers/leds/led-triggers.c  mode change 100644 => 100755 
>> drivers/leds/trigger/ledtrig-heartbeat.c
>>  mode change 100644 => 100755 include/linux/leds.h
> 
> You accidentally changed file permissions.
> 
>> diff --git a/drivers/leds/led-triggers.c b/drivers/leds/led-triggers.c 
>> old mode 100644 new mode 100755 index 431123b..1cb1674
>> --- a/drivers/leds/led-triggers.c
>> +++ b/drivers/leds/led-triggers.c
>> @@ -333,6 +333,40 @@ void led_trigger_blink_oneshot(struct led_trigger 
>> *trig,  }  EXPORT_SYMBOL_GPL(led_trigger_blink_oneshot);
>>  
>> +void led_trigger_suspend(struct led_trigger *trig) {
>> +	struct led_classdev *led_cdev;
>> +
>> +	if (!trig)
>> +		return;
>> +
>> +	read_lock(&trig->leddev_list_lock);
>> +	list_for_each_entry(led_cdev, &trig->led_cdevs, trig_list) {
>> +		if (led_cdev->trigger->suspend)
>> +			led_cdev->trigger->suspend(led_cdev);
>> +		led_sysfs_disable(led_cdev);
> 
> Could you share what kind of problem this call to led_syfs_disable() solves? Did you come across one?
> 
>> +	}
>> +	read_unlock(&trig->leddev_list_lock);
>> +}
>> +EXPORT_SYMBOL_GPL(led_trigger_suspend);
>> +
>> +void led_trigger_resume(struct led_trigger *trig) {
>> +	struct led_classdev *led_cdev;
>> +
>> +	if (!trig)
>> +		return;
>> +
>> +	read_lock(&trig->leddev_list_lock);
>> +	list_for_each_entry(led_cdev, &trig->led_cdevs, trig_list) {
>> +		if (led_cdev->trigger->resume)
>> +			led_cdev->trigger->resume(led_cdev);
>> +		led_sysfs_enable(led_cdev);
>> +	}
>> +	read_unlock(&trig->leddev_list_lock);
>> +}
>> +EXPORT_SYMBOL_GPL(led_trigger_resume);
>> +
>>  void led_trigger_register_simple(const char *name, struct led_trigger 
>> **tp)  {
>>  	struct led_trigger *trig;
>> diff --git a/drivers/leds/trigger/ledtrig-heartbeat.c 
>> b/drivers/leds/trigger/ledtrig-heartbeat.c
>> old mode 100644
>> new mode 100755
>> index afa3b40..8f779dd
>> --- a/drivers/leds/trigger/ledtrig-heartbeat.c
>> +++ b/drivers/leds/trigger/ledtrig-heartbeat.c
>> @@ -142,6 +142,7 @@ static void heartbeat_trig_activate(struct led_classdev *led_cdev)
>>  	led_heartbeat_function(heartbeat_data->timer.data);
>>  	set_bit(LED_BLINK_SW, &led_cdev->work_flags);
>>  	led_cdev->activated = true;
>> +	led_cdev->suspended = false;
>>  }
>>  
>>  static void heartbeat_trig_deactivate(struct led_classdev *led_cdev) 
>> @@ -154,6 +155,30 @@ static void heartbeat_trig_deactivate(struct led_classdev *led_cdev)
>>  		kfree(heartbeat_data);
>>  		clear_bit(LED_BLINK_SW, &led_cdev->work_flags);
>>  		led_cdev->activated = false;
>> +		led_cdev->suspended = false;
>> +	}
>> +}
>> +
>> +static void heartbeat_trig_resume(struct led_classdev *led_cdev) {
>> +	struct heartbeat_trig_data *heartbeat_data = led_cdev->trigger_data;
>> +
>> +	if (led_cdev->suspended) {
>> +		setup_timer(&heartbeat_data->timer,
>> +			    led_heartbeat_function, (unsigned long) led_cdev);
>> +		heartbeat_data->phase = 0;
>> +		led_heartbeat_function(heartbeat_data->timer.data);
>> +		led_cdev->suspended = false;
>> +	}
>> +}
>> +
>> +static void heartbeat_trig_suspend(struct led_classdev *led_cdev) {
>> +	struct heartbeat_trig_data *heartbeat_data = led_cdev->trigger_data;
>> +
>> +	if (led_cdev->activated && !led_cdev->suspended) {
>> +		del_timer_sync(&heartbeat_data->timer);
>> +		led_cdev->suspended = true;
>>  	}
>>  }
>>  
>> @@ -161,25 +186,23 @@ static void heartbeat_trig_deactivate(struct led_classdev *led_cdev)
>>  	.name     = "heartbeat",
>>  	.activate = heartbeat_trig_activate,
>>  	.deactivate = heartbeat_trig_deactivate,
>> +	.suspend = heartbeat_trig_suspend,
>> +	.resume = heartbeat_trig_resume,
>>  };
>>  
>>  static int heartbeat_pm_notifier(struct notifier_block *nb,
>>  				 unsigned long pm_event, void *unused)  {
>> -	int rc;
>> -
>>  	switch (pm_event) {
>>  	case PM_SUSPEND_PREPARE:
>>  	case PM_HIBERNATION_PREPARE:
>>  	case PM_RESTORE_PREPARE:
>> -		led_trigger_unregister(&heartbeat_led_trigger);
>> +		led_trigger_suspend(&heartbeat_led_trigger);
>>  		break;
>>  	case PM_POST_SUSPEND:
>>  	case PM_POST_HIBERNATION:
>>  	case PM_POST_RESTORE:
>> -		rc = led_trigger_register(&heartbeat_led_trigger);
>> -		if (rc)
>> -			pr_err("could not re-register heartbeat trigger\n");
>> +		led_trigger_resume(&heartbeat_led_trigger);
>>  		break;
>>  	default:
>>  		break;
>> diff --git a/include/linux/leds.h b/include/linux/leds.h old mode 
>> 100644 new mode 100755 index 64c56d4..b792950
>> --- a/include/linux/leds.h
>> +++ b/include/linux/leds.h
>> @@ -111,6 +111,7 @@ struct led_classdev {
>>  	void			*trigger_data;
>>  	/* true if activated - deactivate routine uses it to do cleanup */
>>  	bool			activated;
>> +	bool			suspended;
>>  #endif
>>  
>>  #ifdef CONFIG_LEDS_BRIGHTNESS_HW_CHANGED @@ -254,6 +255,8 @@ struct 
>> led_trigger {
>>  	const char	 *name;
>>  	void		(*activate)(struct led_classdev *led_cdev);
>>  	void		(*deactivate)(struct led_classdev *led_cdev);
>> +	void		(*suspend)(struct led_classdev *led_cdev);
>> +	void		(*resume)(struct led_classdev *led_cdev);
>>  
>>  	/* LEDs under control by this trigger (for simple triggers) */
>>  	rwlock_t	  leddev_list_lock;
>> @@ -291,6 +294,9 @@ extern void led_trigger_set(struct led_classdev *led_cdev,
>>  			struct led_trigger *trigger);
>>  extern void led_trigger_remove(struct led_classdev *led_cdev);
>>  
>> +extern void led_trigger_suspend(struct led_trigger *trig); extern 
>> +void led_trigger_resume(struct led_trigger *trig);
>> +
>>  static inline void *led_get_trigger_data(struct led_classdev 
>> *led_cdev)  {
>>  	return led_cdev->trigger_data;
>>
> 
> --
> Best regards,
> Jacek Anaszewski
> 

-- 
Best regards,
Jacek Anaszewski

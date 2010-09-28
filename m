From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 28 Sep 2010 11:57:42 +0200
Subject: [PATCH 1/7] pwm: Add pwm core driver
In-Reply-To: <F45880696056844FA6A73F415B568C69532DC2FB6B@EXDCVYMBSTM006.EQ1STM.local>
References: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com>
	<1285659648-21409-2-git-send-email-arun.murthy@stericsson.com>
	<4CA1AD2B.8000905@metafoo.de>
	<F45880696056844FA6A73F415B568C69532DC2FB6B@EXDCVYMBSTM006.EQ1STM.local>
Message-ID: <4CA1BC16.3020702@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arun MURTHY wrote:
>>> +menuconfig PWM_DEVICES
>>> +	bool "PWM devices"
>>> +	default y
>>> +	---help---
>>> +	  Say Y here to get to see options for device drivers from
>> various
>>> +	  different categories. This option alone does not add any kernel
>> code.
>>> +
>>> +	  If you say N, all options in this submenu will be skipped and
>> disabled.
>>> +
>> Shouldn't PWM_DEVICES select HAVE_PWM?
> 
> 
> No not required, the entire concept is to remove HAVE_PWM and use PWM_CORE.

Well in patch 4 you say that PWM_CORE is currently limited to ARM. Furthermore you
change the pwm-backlight and pwm-led Kconfig entries to depend on HAVE_PWM ||
PWM_CORE. Adding a select HAVE_PWM here would make those changes unnecessary.
HAVE_PWM should be set, when pwm_* functions are available. When your pwm-core driver
is selected they are available.

> 
>>> +struct pwm_dev_info {
>>> +	struct pwm_device *pwm_dev;
>>> +	struct list_head list;
>>> +};
>>> +static struct pwm_dev_info *di;
>> Why not embed the list head into pwm_device. That would certainly make
>> pwm_device_unregister much simpler.
> pwm_device will be passed to each and every pwm driver that are registered as client with pwm core.
> The list consists of the registered pwm drivers and is to be handled by pwm core.
> Why should each and every pwm driver get to know about the entire pwm driver list?
Declare the list field to be private, by saying that it should only be touched by the
core. Right now you allocate a rather small additional structure for each registered
device. This could be easily be avoided by embedding the list field into the
pwm_device struct.

> And also since the pwm_request/register/unregister are the one which require this list having this list inst in local/static device information structure seems to be right.
> 
>>> +	}
>>> +	pwm->pwm_dev = pwm_dev;
>>> +	list_add_tail(&pwm->list, &di->list);
>>> +	up_write(&pwm_list_lock);
>>> +
>> I guess you only need to lock the list when accessing the list and
>> adding the new
>> pwm_dev.
> 
> Oops, thanks for pointing out, will implement this in the v2 patch.
>>> +struct pwm_ops {
>>> +	int (*pwm_config)(struct pwm_device *pwm, int duty_ns, int
>> period_ns);
>>> +	int (*pwm_enable)(struct pwm_device *pwm);
>>> +	int (*pwm_disable)(struct pwm_device *pwm);
>>> +	char *name;
>>> +};
>>> +
>> Shouldn't name be part of the pwm_device? That would allow the ops to
>> be shared
>> between different devices.
> Good catch, the reason being that 2 or more devices can share the same ops and get registered to pwm core.
> But the catch lies while identifying the pwm device while the clients are requesting for.
> The pwm backlight will request the pwm driver by name. This is parameter that distinguishes among different pwm devices irrespective of same ops or not.
Yes. And thats why it should go into the pwm_device struct itself.

If an additional ops struct is allocated for each device anyway we would be better of
embedding it directly into the device struct instead of just holding a pointer to it.

> 
>>> +int pwm_device_register(struct pwm_device *pwm_dev);
>>> +int pwm_device_unregister(struct pwm_device *pwm_dev);
>>> +
>>>  #endif /* __LINUX_PWM_H */
>> It might be also a good idea to add a device class for pwm devices.
> Sure, but can you please explain with an example the use case.
>
Well, for one it helps to keep data structured.
And there would be functions to traverse all devices of a class, so you could get rid
of your "di" list.


> Thanks and Regards,
> Arun R Murthy
> -------------
> 

- Lars

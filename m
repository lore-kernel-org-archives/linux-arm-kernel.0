From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 28 Mar 2016 15:54:23 +0900
Subject: [PATCH v6 06/21] PM / devfreq: Add new passive governor
In-Reply-To: <1314094711.28841459134703593.JavaMail.weblogic@epmlwas02a>
References: <1314094711.28841459134703593.JavaMail.weblogic@epmlwas02a>
Message-ID: <56F8D51F.1030306@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016? 03? 28? 12:11, MyungJoo Ham wrote:
> []
>> Suggested-by: Myungjoo Ham <myungjoo.ham@samsung.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> [tjakobi: Reported RCU locking issue and cw00.choi fix it.]
>> Reported-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>> [m.reichl and linux.amoon: Tested it on exynos4412-odroidu3 board]
>> Tested-by: Markus Reichl <m.reichl@fivetechno.de>
>> Tested-by: Anand Moon <linux.amoon@gmail.com>
>> ---
>>  drivers/devfreq/Kconfig            |   7 ++
>>  drivers/devfreq/Makefile           |   1 +
>>  drivers/devfreq/devfreq.c          |  17 ++++
>>  drivers/devfreq/governor.h         |  15 +++
>>  drivers/devfreq/governor_passive.c | 192 +++++++++++++++++++++++++++++++++++++
>>  include/linux/devfreq.h            |   3 +
>>  6 files changed, 235 insertions(+)
>>  create mode 100644 drivers/devfreq/governor_passive.c
>>
>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> 
> []
> 
>> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
>> index 8af8aaf922a8..2633087d5c63 100644
>> --- a/drivers/devfreq/Makefile
>> +++ b/drivers/devfreq/Makefile
>> @@ -4,6 +4,7 @@ obj-$(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)	+= governor_simpleondemand.o
>>  obj-$(CONFIG_DEVFREQ_GOV_PERFORMANCE)	+= governor_performance.o
>>  obj-$(CONFIG_DEVFREQ_GOV_POWERSAVE)	+= governor_powersave.o
>>  obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+= governor_userspace.o
>> +obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
>>  
>>  # DEVFREQ Drivers
>>  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 1d6c803804d5..9f84bbc2994c 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -478,7 +478,13 @@ static void _remove_devfreq(struct devfreq *devfreq)
>>  		dev_warn(&devfreq->dev, "releasing devfreq which doesn't exist\n");
>>  		return;
>>  	}
>> +
>> +	if (devfreq->governor->type == DEVFREQ_GOV_PASSIVE)
>> +		devfreq_passive_unregister_notifier(devfreq);
>> +
>>  	list_del(&devfreq->node);
>> +	list_del_init(&devfreq->passive_node);
>> +
> 
> Let's do this inside governor_passive.c, you already have
> the DEVFREQ_GOV_STOP signal. This may be called more frequently
> because the START-STOP pair has wider usage than add-remove pair.
> However, still, it's ok to be detached during the "STOP"ed but not
> removed state.

I agree the code about passive governor to drivers/devfreq/governor_passive.c.
It makes the code clear.

> 
>>  	mutex_unlock(&devfreq_list_lock);
>>  
>>  	if (devfreq->governor)
>> @@ -598,6 +604,17 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>  		goto err_init;
>>  	}
>>  
>> +	if (devfreq->governor->type == DEVFREQ_GOV_PASSIVE) {
>> +		struct devfreq *parent_devfreq = (struct devfreq *)data;
>> +		list_add(&devfreq->passive_node, &parent_devfreq->passive_node);
>> +
>> +		err = devfreq_passive_register_notifier(devfreq);
>> +		if (err <0)
>> +			goto err_init;
>> +	} else {
>> +		INIT_LIST_HEAD(&devfreq->passive_node);
>> +	}
>> +
> 
> Same as above. We can reuse DEVFREQ_GOV_START for this.
> With DEVFREQ_GOV_START/STOP, we can entirely remove any modifications
> in the devfreq.c, governor.h, devfreq.h.

I agree. I'll modify it.

> 
> Besides, such an approach removed the need for the patch 05/21.
> We no longer (or yet) need "governor type".
> 
>>  	return devfreq;
>>  
>>  err_init:
>> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
>> index cf19b923c362..64d1dffcdb43 100644
>> --- a/drivers/devfreq/governor.h
>> +++ b/drivers/devfreq/governor.h
> 
> as mentioned above, we don't need to modify this file.

OK.

> 
>> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
>> new file mode 100644
>> index 000000000000..521e93b68c11
>> --- /dev/null
>> +++ b/drivers/devfreq/governor_passive.c
>> @@ -0,0 +1,192 @@
>> +/*
>> + * linux/drivers/devfreq/governor_passive.c
>> + *
>> + * Copyright (C) 2016 Samsung Electronics
>> + * Author: Chanwoo Choi <cw00.choi@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/devfreq.h>
>> +#include <linux/module.h>
>> +#include <linux/device.h>
>> +#include <linux/devfreq.h>
> 
> Doubly included

I'll fix it.

> 
>> +#include "governor.h"
>> +
> 
> []
> 
>> +static int devfreq_passive_event_handler(struct devfreq *devfreq,
>> +				unsigned int event, void *data)
>> +{
>> +	return 0;
> 
> Let's handle DEVFREQ_GOV_START/STOP event here.

OK. I'll register/unregister the DEVFREQ_TRANSITION_NOTIFIER by using
DEVFREQ_GOV_START/STOP event.

> 
>> +}
>> +
>> +static struct devfreq_governor devfreq_passive = {
>> +	.name = "passive",
>> +	.type = DEVFREQ_GOV_PASSIVE,
> 
> Let's not use .type enum, yet. We don't this this. At least for now.

OK. I'll remove it.

> 
>> +	.get_target_freq = devfreq_passive_get_target_freq,
>> +	.event_handler = devfreq_passive_event_handler,
>> +};
>> +
> 
> []
> 
>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h


When the devfreq device using passive governor registers the notifier
to DEVFREQ_TRANSITION_NOTIFIER, the devfreq device need the one notifier block field
as following:

struct devfreq {
	...
	...
	struct notifier_block passive_nb;
}

static int devfreq_passive_event_handler(struct devfreq *devfreq,
                               unsigned int event, void *data)
{
       struct device *dev = devfreq->dev.parent;
       struct devfreq *parent = (struct devfreq *)devfreq->data;
       struct notifier_block *nb = &devfreq->passive_nb;
       int ret = 0;

       if (!parent)
               return -EPROBE_DEFER;

       switch (event) {
       case DEVFREQ_GOV_START:
               nb->notifier_call = devfreq_passive_notifier_call;
               ret = devm_devfreq_register_notifier(dev, parent, nb,
                                       DEVFREQ_TRANSITION_NOTIFIER);
               break;
       case DEVFREQ_GOV_STOP:
               devm_devfreq_unregister_notifier(dev, parent, nb,
                                       DEVFREQ_TRANSITION_NOTIFIER);
               break;
       default:
               break;
       }

       return ret;
}

Best Regards,
Chanwoo Choi

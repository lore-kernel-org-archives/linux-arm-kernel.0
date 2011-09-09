From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Fri, 9 Sep 2011 18:02:33 +0530
Subject: [PATCH v6 17/25] gpio/omap: use pm-runtime framework
In-Reply-To: <87ehztxmcg.fsf@ti.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<1314798161-19523-18-git-send-email-tarun.kanti@ti.com>
	<87ehztxmcg.fsf@ti.com>
Message-ID: <CAC83ZvL3Y-4f+nAvFb023JTPcBb-joG8JonujCMJCNUmYrSZaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]
>>
>> +static const struct dev_pm_ops gpio_pm_ops = {
>> + ? ? .suspend ? ? ? ? ? ? ? ?= omap_gpio_suspend,
>> + ? ? .resume ? ? ? ? ? ? ? ? = omap_gpio_resume,
>> +};
>
> Please use SET_SYSTEM_SLEEP_PM_OPS(). ?See <linux/pm.h>
We can use following macro to initialize .suspend and .resume callbacks.
But how do we initialize .runtime_suspend and .runtime_resume callbacks?

#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
const struct dev_pm_ops name = { \
        SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
}

Do we have something similar to following where we can assign separate
pair of callbacks?
The following macro on the other hand assigns the same set of
callbacks to both and this not what I want!!!

#define UNIVERSAL_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
const struct dev_pm_ops name = { \
        SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
        SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
}
--
Tarun

>
>> ?static struct platform_driver omap_gpio_driver = {
>> ? ? ? .probe ? ? ? ? ?= omap_gpio_probe,
>> ? ? ? .driver ? ? ? ? = {
>> ? ? ? ? ? ? ? .name ? = "omap_gpio",
>> + ? ? ? ? ? ? .pm ? ? = &gpio_pm_ops,
>> ? ? ? },
>> ?};
[...]

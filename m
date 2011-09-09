From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Fri, 9 Sep 2011 18:24:18 +0530
Subject: [PATCH v6 17/25] gpio/omap: use pm-runtime framework
In-Reply-To: <CAC83ZvL3Y-4f+nAvFb023JTPcBb-joG8JonujCMJCNUmYrSZaA@mail.gmail.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<1314798161-19523-18-git-send-email-tarun.kanti@ti.com>
	<87ehztxmcg.fsf@ti.com>
	<CAC83ZvL3Y-4f+nAvFb023JTPcBb-joG8JonujCMJCNUmYrSZaA@mail.gmail.com>
Message-ID: <CAC83ZvJ1UDSKfzZR8Q9Bu-zwskVcS4GHo-5Cvti0MBx6ZcgUEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 9, 2011 at 6:02 PM, DebBarma, Tarun Kanti
<tarun.kanti@ti.com> wrote:
> [...]
>>>
>>> +static const struct dev_pm_ops gpio_pm_ops = {
>>> + ? ? .suspend ? ? ? ? ? ? ? ?= omap_gpio_suspend,
>>> + ? ? .resume ? ? ? ? ? ? ? ? = omap_gpio_resume,
>>> +};
>>
>> Please use SET_SYSTEM_SLEEP_PM_OPS(). ?See <linux/pm.h>
> We can use following macro to initialize .suspend and .resume callbacks.
> But how do we initialize .runtime_suspend and .runtime_resume callbacks?
>
> #define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> const struct dev_pm_ops name = { \
> ? ? ? ?SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> }
>
> Do we have something similar to following where we can assign separate
> pair of callbacks?
> The following macro on the other hand assigns the same set of
> callbacks to both and this not what I want!!!
>
> #define UNIVERSAL_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
> const struct dev_pm_ops name = { \
> ? ? ? ?SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> ? ? ? ?SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
> }
Ok, I saw an example... Thanks!!

> --
> Tarun
>
>>
>>> ?static struct platform_driver omap_gpio_driver = {
>>> ? ? ? .probe ? ? ? ? ?= omap_gpio_probe,
>>> ? ? ? .driver ? ? ? ? = {
>>> ? ? ? ? ? ? ? .name ? = "omap_gpio",
>>> + ? ? ? ? ? ? .pm ? ? = &gpio_pm_ops,
>>> ? ? ? },
>>> ?};
> [...]
>

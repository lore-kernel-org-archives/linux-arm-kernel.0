From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 10 Sep 2013 20:56:31 +0530
Subject: "cpufreq: fix serialization issues with freq change notifiers"
 breaks cpufreq too
In-Reply-To: <Pine.LNX.4.64.1309101656150.16010@axis700.grange>
References: <Pine.LNX.4.64.1309091656200.6602@axis700.grange>
 <CAKohponZ+FnzqXYMbBzbun0-1iQMi2fS4syrEBC_MdF41vLCeA@mail.gmail.com>
 <Pine.LNX.4.64.1309101656150.16010@axis700.grange>
Message-ID: <CAKohpomBBKLhNemVUpUHAftGhPJJe+ZB7T_9UYLD7LwpR1nK0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 September 2013 20:42, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> 4. reverted that commit, resolving a trivial conflict. Added a debug
> output in __cpufreq_driver_target() of
>
>
>         if (cpufreq_disabled())
>                 return -ENODEV;
> +       pr_info("%s() %d\n", __func__, policy->transition_ongoing);
>         if (policy->transition_ongoing)
>                 return -EBUSY;

Are you sure this diff is on linux-next and not after the revert that
you mentioned later in the mail? There is some locking introduced
by my patch which I can't see in you diff..

> Built and booted, got
>
> cpufreq: __cpufreq_driver_target(): 1
>
> printed out 4 times from the beginning.
>
> 5. tried
>
> echo powersave > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
>
> the above output appeared 2 more times - no frequency change resulted.
>
> 6. reverted commit dceff5ce18801dddc220d6238628619c93bc3cb6, built booted
> - cpufreq works again.
>
>> I am afraid you need to give us some more information on how it broke
>> your stuff.. :)
>
> Hope the above is enough.

A bit more would be helpful.. Can you add these debug prints to all the places
where transition_ongoing is getting modified? with %s, __func__ to distinguish
them better? That will make it a bit easy for me...

Also, what's the configuration of your system? How many CPUs? And are all
of them sharing clock? (I believe yes, as you are using cpufreq-cpu0)..

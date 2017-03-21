From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 21 Mar 2017 10:16:45 +0000
Subject: [v3 3/5] coresight: add support for debug module
In-Reply-To: <20170321025924.GA7429@leoy-linaro>
References: <20170309175915.GA964@leoy-linaro>
 <3f27efee-3b63-81fd-eb96-73fd7e6f5e92@arm.com>
 <20170313165600.GB32431@linaro.org>
 <516f8989-4dde-2686-d549-0761feb14d1b@arm.com>
 <CANLsYkzJsGvr4ZzNbTwcPu1Qki6=Szvu+bMjHZ_rza==DqFChw@mail.gmail.com>
 <20170317101328.GA19877@leoy-linaro> <20170317155007.GA20435@linaro.org>
 <20170317162836.GD2020@leoy-linaro>
 <5995f6a7-08b1-c868-fc88-a145d1748a33@arm.com>
 <CANLsYkyiAnSGW4Ujs6L-yBKK3no3zigbyBgOCWbm06ZdV-f2Hw@mail.gmail.com>
 <20170321025924.GA7429@leoy-linaro>
Message-ID: <7226bc83-24f5-f609-2f87-f0afc7657488@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/03/17 02:59, Leo Yan wrote:
> On Mon, Mar 20, 2017 at 10:40:00AM -0600, Mathieu Poirier wrote:
>
> [...]
>
>>>>> If we don't check for "nohlt" some platform may freeze, others may work.
>>>>> If we
>>>>> mandate that "nohlt" be present on the kernel cmd line it works in all
>>>>> cases.
>>>>> As such mandating that "nohlt" be present is a better way to go.
>>>>
>>>>
>>>> Sure, so I will add below checking code in the probe function, please
>>>> let me know if you have alter better way to implement this:
>>>>
>>>> +       if (IS_ENABLED(CONFIG_CPU_IDLE) &&
>>>> +                       !strstr(boot_command_line, "nohlt")) {
>>>> +               dev_err(dev, "May not be accessible in CPU power
>>>> domain.\n");
>>>> +               return -EPERM;
>>>> +       }
>>>>
>>>
>>> There is an API which kind of achieves what "nohlt" does at runtime :
>>>
>>>   cpu_idle_poll_ctrl(true)
>>>
>>> So may be we could use that instead of depending on "nohlt". The other side
>>> of the issues is "when do we decide to use the API". May be we could add
>>> something
>>> like : enable_debug, which could then trigger the panic notifier
>>> registrations
>>> and the above. That would still leave us with a case where the system
>>> crashes
>>> even before the user gets a terminal. May be the following is the best
>>> option :
>>>
>>> 1) Dedicated kernel command line parameter for enabling the CPU debug at
>>> boot/probe.
>>>
>>> and
>>>
>>> 2) Runtime enable method via sysfs.
>>>
>>> What do you think ?
>>
>> In my opinion booting with "nohlt" on the cmd line is sufficient to
>> determine if we should use the driver or not.  That way we also avoid
>> declaring yet another sysfs flag, something I really want to avoid.
>
> Agree.
>
> I did spend some time to implement coresight core framework to support
> debug module, you could see it on:http://termbin.com/k2fj; this also
> gives me more sense which is better choice. If declaring another sysfs
> flag to support debug module in coresight framework, this lets the
> codes and interfaces more complex. E.g. for best fit into coresight
> framework, finally we can get 8 sysfs nodes for 8 CPUs in system; so
> that means we need enable every CPU one by one.

Having a node for each debug area indeed doesn't look good. We could
as will stick a single node under /sys/kernel/debug/ which would enable/disable
the debug component.

I am OK with it being tied to nohlt. In that case we will have to add
a Kconfig dependency on GENERIC_IDLE_POLL_SETUP (though it is selected
by default on ARM/ARM64). Parsing the boot command line for nohlt doesn't
look like a good idea. We may have to figure out a way to do that. Also,
please could you add support for building this as a module ? Since it
doesn't depend on the coresight bus anyway, it should be pretty straight
forward.

Suzuki

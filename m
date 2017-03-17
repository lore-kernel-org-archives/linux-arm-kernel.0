From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 17 Mar 2017 16:47:54 +0000
Subject: [v3 3/5] coresight: add support for debug module
In-Reply-To: <20170317162836.GD2020@leoy-linaro>
References: <1488520809-31670-4-git-send-email-leo.yan@linaro.org>
 <011fdac0-59bf-b539-2de3-0b59a41bc922@arm.com>
 <20170309175915.GA964@leoy-linaro>
 <3f27efee-3b63-81fd-eb96-73fd7e6f5e92@arm.com>
 <20170313165600.GB32431@linaro.org>
 <516f8989-4dde-2686-d549-0761feb14d1b@arm.com>
 <CANLsYkzJsGvr4ZzNbTwcPu1Qki6=Szvu+bMjHZ_rza==DqFChw@mail.gmail.com>
 <20170317101328.GA19877@leoy-linaro> <20170317155007.GA20435@linaro.org>
 <20170317162836.GD2020@leoy-linaro>
Message-ID: <5995f6a7-08b1-c868-fc88-a145d1748a33@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/03/17 16:28, Leo Yan wrote:
> On Fri, Mar 17, 2017 at 09:50:07AM -0600, Mathieu Poirier wrote:
>
> [...]
>
>> If we don't check for "nohlt" some platform may freeze, others may work.  If we
>> mandate that "nohlt" be present on the kernel cmd line it works in all cases.
>> As such mandating that "nohlt" be present is a better way to go.
>
> Sure, so I will add below checking code in the probe function, please
> let me know if you have alter better way to implement this:
>
> +       if (IS_ENABLED(CONFIG_CPU_IDLE) &&
> +                       !strstr(boot_command_line, "nohlt")) {
> +               dev_err(dev, "May not be accessible in CPU power domain.\n");
> +               return -EPERM;
> +       }
>

There is an API which kind of achieves what "nohlt" does at runtime :

   cpu_idle_poll_ctrl(true)

So may be we could use that instead of depending on "nohlt". The other side
of the issues is "when do we decide to use the API". May be we could add something
like : enable_debug, which could then trigger the panic notifier registrations
and the above. That would still leave us with a case where the system crashes
even before the user gets a terminal. May be the following is the best option :

1) Dedicated kernel command line parameter for enabling the CPU debug at boot/probe.

and

2) Runtime enable method via sysfs.

What do you think ?

Suzuki

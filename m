From: leo.yan@linaro.org (Leo Yan)
Date: Mon, 20 Mar 2017 20:30:59 +0800
Subject: [v3 3/5] coresight: add support for debug module
In-Reply-To: <5995f6a7-08b1-c868-fc88-a145d1748a33@arm.com>
References: <011fdac0-59bf-b539-2de3-0b59a41bc922@arm.com>
 <20170309175915.GA964@leoy-linaro>
 <3f27efee-3b63-81fd-eb96-73fd7e6f5e92@arm.com>
 <20170313165600.GB32431@linaro.org>
 <516f8989-4dde-2686-d549-0761feb14d1b@arm.com>
 <CANLsYkzJsGvr4ZzNbTwcPu1Qki6=Szvu+bMjHZ_rza==DqFChw@mail.gmail.com>
 <20170317101328.GA19877@leoy-linaro>
 <20170317155007.GA20435@linaro.org>
 <20170317162836.GD2020@leoy-linaro>
 <5995f6a7-08b1-c868-fc88-a145d1748a33@arm.com>
Message-ID: <20170320123059.GA30276@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 17, 2017 at 04:47:54PM +0000, Suzuki K Poulose wrote:
> On 17/03/17 16:28, Leo Yan wrote:
> >On Fri, Mar 17, 2017 at 09:50:07AM -0600, Mathieu Poirier wrote:
> >
> >[...]
> >
> >>If we don't check for "nohlt" some platform may freeze, others may work.  If we
> >>mandate that "nohlt" be present on the kernel cmd line it works in all cases.
> >>As such mandating that "nohlt" be present is a better way to go.
> >
> >Sure, so I will add below checking code in the probe function, please
> >let me know if you have alter better way to implement this:
> >
> >+       if (IS_ENABLED(CONFIG_CPU_IDLE) &&
> >+                       !strstr(boot_command_line, "nohlt")) {
> >+               dev_err(dev, "May not be accessible in CPU power domain.\n");
> >+               return -EPERM;
> >+       }
> >
> 
> There is an API which kind of achieves what "nohlt" does at runtime :
> 
>   cpu_idle_poll_ctrl(true)
> 
> So may be we could use that instead of depending on "nohlt". The other side
> of the issues is "when do we decide to use the API". May be we could add something
> like : enable_debug, which could then trigger the panic notifier registrations
> and the above. That would still leave us with a case where the system crashes
> even before the user gets a terminal. May be the following is the best option :
> 
> 1) Dedicated kernel command line parameter for enabling the CPU debug at boot/probe.
> and
> 
> 2) Runtime enable method via sysfs.

For upper methods, I think the benefit is the user can use very
explict method to enable debug module and can easily aware this
will totally disable CPU low power states as sequential result..

For sysfs, we need send IPIs to all CPUs to ensure all CPUs will not
stay in low power state anymore.

Now I have one questions mainly related with how to registser sysfs
node. Should register sysfs node based on coresight API
coresight_register()? If so, we should extend coresight core
structures to support CPU debug module. Or directly register sysfs
node by using sysfs node like /sys/bus/coresight/devices/cpu_debug?

Thanks,
Leo Yan

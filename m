From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 21 Mar 2017 09:15:03 -0600
Subject: [v3 3/5] coresight: add support for debug module
In-Reply-To: <20170321114711.GA5886@leoy-linaro>
References: <516f8989-4dde-2686-d549-0761feb14d1b@arm.com>
 <CANLsYkzJsGvr4ZzNbTwcPu1Qki6=Szvu+bMjHZ_rza==DqFChw@mail.gmail.com>
 <20170317101328.GA19877@leoy-linaro>
 <20170317155007.GA20435@linaro.org>
 <20170317162836.GD2020@leoy-linaro>
 <5995f6a7-08b1-c868-fc88-a145d1748a33@arm.com>
 <CANLsYkyiAnSGW4Ujs6L-yBKK3no3zigbyBgOCWbm06ZdV-f2Hw@mail.gmail.com>
 <20170321025924.GA7429@leoy-linaro>
 <7226bc83-24f5-f609-2f87-f0afc7657488@arm.com>
 <20170321114711.GA5886@leoy-linaro>
Message-ID: <20170321151503.GA17413@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 07:47:11PM +0800, Leo Yan wrote:
> On Tue, Mar 21, 2017 at 10:16:45AM +0000, Suzuki K Poulose wrote:
> 
> [...]
> 
> > >>In my opinion booting with "nohlt" on the cmd line is sufficient to
> > >>determine if we should use the driver or not.  That way we also avoid
> > >>declaring yet another sysfs flag, something I really want to avoid.
> > >
> > >Agree.
> > >
> > >I did spend some time to implement coresight core framework to support
> > >debug module, you could see it on:http://termbin.com/k2fj; this also
> > >gives me more sense which is better choice. If declaring another sysfs
> > >flag to support debug module in coresight framework, this lets the
> > >codes and interfaces more complex. E.g. for best fit into coresight
> > >framework, finally we can get 8 sysfs nodes for 8 CPUs in system; so
> > >that means we need enable every CPU one by one.
> > 
> > Having a node for each debug area indeed doesn't look good. We could
> > as will stick a single node under /sys/kernel/debug/ which would enable/disable
> > the debug component.
> > 
> > I am OK with it being tied to nohlt. In that case we will have to add
> > a Kconfig dependency on GENERIC_IDLE_POLL_SETUP (though it is selected
> > by default on ARM/ARM64). Parsing the boot command line for nohlt doesn't
> > look like a good idea. We may have to figure out a way to do that.
> 
> I remembered that we can use QoS constraint for CPUIdle:
>         pm_qos_add_request(pm_qos_req, PM_QOS_CPU_DMA_LATENCY, 0);
> 
> Using this way we can disable all low power states and don't depend on
> nohlt anymore.

The idea is to use "nohlt" as a trigger option.  If it is set then we use this
driver - if it isn't then it is kept under wrap.

> 
> > Also, please could you add support for building this as a module ? Since it
> > doesn't depend on the coresight bus anyway, it should be pretty straight
> > forward.
> 
> Yeah. Will support module building.
> 
> Thanks,
> Leo Yan

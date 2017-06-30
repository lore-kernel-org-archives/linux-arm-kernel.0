From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 30 Jun 2017 08:46:48 +0530
Subject: [RFC 0/5] drivers: Add boot constraints core
In-Reply-To: <1522ae7b-fd5b-5403-62bf-b0140e116d65@gr13.net>
References: <cover.1498642745.git.viresh.kumar@linaro.org>
 <beab4875-8dd7-43d7-9ad2-6e38963d7d4c@gr13.net>
 <20170629144711.GO29665@vireshk-i7>
 <1522ae7b-fd5b-5403-62bf-b0140e116d65@gr13.net>
Message-ID: <20170630031648.GR29665@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29-06-17, 15:06, Enrico Weigelt, metux IT consult wrote:
> On 29.06.2017 14:47, Viresh Kumar wrote:
> 
> >No. Drivers are registered to the kernel (randomly, though we can know
> >their order) and devices are registered separately (platform/amba
> >devices get registered automatically with DT, hint:
> >drivers/of/platform.c). The device core checks while registering
> >devices/drivers if their drivers/devices are available or not. If
> >yes, then the devices are probed using the drivers. Now the drivers
> >must make sure all the dependencies are met at this point, else they
> >can return -EPROBE_DEFER and the kernel will try probing them again.
> 
> Could we somehow introduce an strict ordering ?

The problem I am trying to solve isn't really related to ordering.

Consider this for example:

A supply shared between LCD and I2C controller (Not sure if such
configurations are there in any of the hardware we have), where the
same I2C controller is used to access the LCD controller's registers.
Both are enabled at boot and the supply is configured to satisfy both.
If the voltage requirements of the I2C controller are below that of
LCD, then we can't decide on which one to probe first. We can't probe
LCD first as its bus isn't active yt and if we probe I2C first, then
it may take the supply down to a level that isn't acceptable for the
LCD (which was on from boot).

> Maybe by letting the device core know of the dependencies, before
> individual probe()'s explicitly ask for them ?

That's what we are sorting out in probe() and I am not sure if we need
any more intelligence on that. Though, you may want to look at the
"functional dependency" stuff, which can be of some help in such
cases. Its mentioned in cover-letter as well.

> >This should happen in probe, otherwise we are screwed.
> 
> Yes, but the probe result may be deferred, so it's tried again in the
> next round. Correct ?

Right.

> >But the kernel doesn't know how it is configured, there can be so many
> >configurable parameters. The kernel needs to do it again by itself.
> 
> Could it read back the config ?

First, it may not always be possible to do that. And even if the
kernel reads it all well, then it wouldn't know why things are
configured the way they are. And trying to read the config in drivers
is going to be so so hacky, that we wouldn't want to do it anyway. We
need a clean way of doing this, so that the kernel knows of what's
going on and that's what this series is targeting here.

> By the way: I've got a similar problem w/ gpmc right now: uboot already
> sets it up, but the kernel only knows about one CS (for the nand) and
> screwes up the others (eg. fpga), so it cant access the fpga . Until
> I've sorted out all the parameters for DT (unfortunately, only have the
> raw register values), I'll have to rely on an userland test program
> to set it all up ...
> 
> >Let me try with an example. A regulator is shared between LCD and DMA
> >controller.
> >
> >Operable ranges of the regulator: 1.8 - 3.0 V
> >Range required by LCD: 2.0 - 3.0 V
> >Range required by DMA: 1.8 - 2.5 V
> 
> Would a config readback help here ?
> 
> The regulator core then should know that we're already in proper
> range for DMA and no need to touch the regulator.

No body is going to allow that kind of hacky code to get merged :)

-- 
viresh

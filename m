From: enrico.weigelt@gr13.net (Enrico Weigelt, metux IT consult)
Date: Thu, 29 Jun 2017 15:06:01 +0000
Subject: [RFC 0/5] drivers: Add boot constraints core
In-Reply-To: <20170629144711.GO29665@vireshk-i7>
References: <cover.1498642745.git.viresh.kumar@linaro.org>
 <beab4875-8dd7-43d7-9ad2-6e38963d7d4c@gr13.net>
 <20170629144711.GO29665@vireshk-i7>
Message-ID: <1522ae7b-fd5b-5403-62bf-b0140e116d65@gr13.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.06.2017 14:47, Viresh Kumar wrote:

> No. Drivers are registered to the kernel (randomly, though we can know
> their order) and devices are registered separately (platform/amba
> devices get registered automatically with DT, hint:
> drivers/of/platform.c). The device core checks while registering
> devices/drivers if their drivers/devices are available or not. If
> yes, then the devices are probed using the drivers. Now the drivers
> must make sure all the dependencies are met at this point, else they
> can return -EPROBE_DEFER and the kernel will try probing them again.

Could we somehow introduce an strict ordering ?
Maybe by letting the device core know of the dependencies, before
individual probe()'s explicitly ask for them ?

>> Let's imagine a LCD panel driven by a regulator behind SPI. The panel
>> driver would ask the regulator framework to switch on, which would
>> call the regulator driver. This one now would talk to SPI framework,
>> which finally calls the SPI driver. If SPI isn't up yet, it would all
>> be deferred, leaving the panel driver uninitialized (tried again later).
>
> This should happen in probe, otherwise we are screwed.

Yes, but the probe result may be deferred, so it's tried again in the
next round. Correct ?

>> If the bootloader already switched on the panel (therefore already
>> enabled SPI), why does it matter that the panel driver isn't up yet ?
>
> But the kernel doesn't know how it is configured, there can be so many
> configurable parameters. The kernel needs to do it again by itself.

Could it read back the config ?

By the way: I've got a similar problem w/ gpmc right now: uboot already
sets it up, but the kernel only knows about one CS (for the nand) and
screwes up the others (eg. fpga), so it cant access the fpga . Until
I've sorted out all the parameters for DT (unfortunately, only have the
raw register values), I'll have to rely on an userland test program
to set it all up ...

> Let me try with an example. A regulator is shared between LCD and DMA
> controller.
>
> Operable ranges of the regulator: 1.8 - 3.0 V
> Range required by LCD: 2.0 - 3.0 V
> Range required by DMA: 1.8 - 2.5 V

Would a config readback help here ?

The regulator core then should know that we're already in proper
range for DMA and no need to touch the regulator.


--mtx

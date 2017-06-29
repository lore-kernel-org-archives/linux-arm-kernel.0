From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 29 Jun 2017 20:17:11 +0530
Subject: [RFC 0/5] drivers: Add boot constraints core
In-Reply-To: <beab4875-8dd7-43d7-9ad2-6e38963d7d4c@gr13.net>
References: <cover.1498642745.git.viresh.kumar@linaro.org>
 <beab4875-8dd7-43d7-9ad2-6e38963d7d4c@gr13.net>
Message-ID: <20170629144711.GO29665@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29-06-17, 12:40, Enrico Weigelt, metux IT consult wrote:
> Just curious: aren't the devices (at least w/ DT) only initialized after
> dependencies (eg. regulators) are already up ?

No. Drivers are registered to the kernel (randomly, though we can know
their order) and devices are registered separately (platform/amba
devices get registered automatically with DT, hint:
drivers/of/platform.c). The device core checks while registering
devices/drivers if their drivers/devices are available or not. If
yes, then the devices are probed using the drivers. Now the drivers
must make sure all the dependencies are met at this point, else they
can return -EPROBE_DEFER and the kernel will try probing them again.

> Let's imagine a LCD panel driven by a regulator behind SPI. The panel
> driver would ask the regulator framework to switch on, which would
> call the regulator driver. This one now would talk to SPI framework,
> which finally calls the SPI driver. If SPI isn't up yet, it would all
> be deferred, leaving the panel driver uninitialized (tried again later).

This should happen in probe, otherwise we are screwed.

> If the bootloader already switched on the panel (therefore already
> enabled SPI), why does it matter that the panel driver isn't up yet ?

But the kernel doesn't know how it is configured, there can be so many
configurable parameters. The kernel needs to do it again by itself.

> Is there anything that accidentially switches it off again (eg. by
> resetting the regulator) ?

It is not just about switching it off, but the configuration here.

Let me try with an example. A regulator is shared between LCD and DMA
controller.

Operable ranges of the regulator: 1.8 - 3.0 V
Range required by LCD: 2.0 - 3.0 V
Range required by DMA: 1.8 - 2.5 V

Of course the right range for both of them to work here is 2.0 - 2.5
V.

Now the LCD is already enabled by the bootloader and kernel doesn't
know the ranges. DMA requests for the regulator and we set its voltage
to 1.8 V. LCD is screwed while we are still booting.

This will go worse if we add more devices to this example that share
the same regulator.

-- 
viresh

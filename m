From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 2 Sep 2011 08:24:38 -0700
Subject: [PATCH 1/3] irq: If an IRQ is a GPIO, request and configure it
In-Reply-To: <alpine.LFD.2.02.1109021027360.2723@ionos>
References: <1312498820-2275-1-git-send-email-swarren@nvidia.com>
	<1312498820-2275-2-git-send-email-swarren@nvidia.com>
	<alpine.LFD.2.02.1109021027360.2723@ionos>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04B327A55C@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Gleixner wrote at Friday, September 02, 2011 2:37 AM:
> On Thu, 4 Aug 2011, Stephen Warren wrote:
> 
> > Many IRQs are associated with GPIO pins. When the pin is used as an IRQ,
> > it can't be used as anything else; it should be requested. Enhance the
> > core interrupt code to call gpio_request() and gpio_direction_input() for
> > any IRQ that is also a GPIO. This prevents duplication of these calls in
> > each driver that uses an IRQ.
> 
> This is very much the wrong approach. If you think it through then the
> irq setup code might end up with tons of other subsystem specific
> setup thingies, e.g. PCI .....
> 
> The right thing to do is to add a irq_configure() function pointer to
> the irq chip and provide a common function for gpios in gpiolib, which
> is then used by the particular GPIO irq chip implementation.

Sorry, could you expand on this some more.

The whole point of these patches is that it's impossible to convert from
IRQ number to GPIO number.

Some drivers use just an IRQ, and don't care if it's a GPIO. They work
fine currently.

Some drivers use just a GPIO; that's not relevant to these patches.

Some drivers use something that's both an IRQ and a GPIO. Historically,
this has worked by passing the IRQ to the driver, and then the driver
calling irq_to_gpio() to get the GPIO ID. Since irq_to_gpio() is being
removed, this is no longer possible. The whole point of the removal was
that it's not possible in general to convert from IRQ to GPIO, so I'm not
sure exactly what you're proposing irq_configure() or gpiolib do to
centralize this?

Thanks for any insight.

-- 
nvpublic

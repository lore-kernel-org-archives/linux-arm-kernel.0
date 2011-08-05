From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 5 Aug 2011 06:35:11 +0100
Subject: [PATCH 1/3] irq: If an IRQ is a GPIO, request and configure it
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF049F171EC1@HQMAIL01.nvidia.com>
References: <1312498820-2275-1-git-send-email-swarren@nvidia.com>
	<1312498820-2275-2-git-send-email-swarren@nvidia.com>
	<20110805000148.GB13321@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF049F171EC1@HQMAIL01.nvidia.com>
Message-ID: <20110805053510.GA16956@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2011 at 08:53:34PM -0700, Stephen Warren wrote:

> Well, things break. This is essentially the problem I was describing in
> the PATCH 0 email, just with a slightly different motivation.

There's a bunch of existing code using that idiom.

> I suppose that an alternative here would be to simply ignore any errors
> from gpio_request. This might have the benefit of removing the need for
> the other two patches I posted in the series. However, it seems a little
> dirty; one benefit of the IRQ code calling gpio_request and honoring
> errors would be to detect when some completely unrelated code had a bug
> and had called gpio_request on the GPIO before. Such detection would be
> non-existent if we don't error out on gpio_request. Perhaps some mechanism
> is needed to indicate that the driver has explicitly already called
> gpio_request for a legitimate shared purpose, and only then ignore
> errors?

But it's not a bug to use a GPIO as an IRQ source, otherwise we wouldn't
have gpio_to_irq() in the first place.  Feels like we need a backchannel
between gpiolib and the IRQ code to do this.  Or perhaps the drivers
that implement this should be taking care of setting up the GPIO mode?

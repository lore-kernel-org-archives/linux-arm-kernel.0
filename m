From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Jan 2013 13:54:38 +0000
Subject: arm NO_IRQ = -1 - zynq axi_ethernet driver
In-Reply-To: <CAHTX3d+dOm2AzK=g_UbEiJ2AQYJNJtfWHXGvrxK1TqM2nmEh7Q@mail.gmail.com>
References: <CAHTX3d+dOm2AzK=g_UbEiJ2AQYJNJtfWHXGvrxK1TqM2nmEh7Q@mail.gmail.com>
Message-ID: <20130103135438.GP2631@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 03, 2013 at 02:47:08PM +0100, Michal Simek wrote:
> Hi Grand, Russell, Arnd, Olof and Rob,
> 
> I am getting one problem with axi_ethernet driver because I want to remove
> NO_IRQ from axi_ethernet driver because NO_IRQ was setup to 0 and
> removed from microblaze long time ago.
> Some patches from reference.
> "microblaze: Change NO_IRQ to 0"
> sha1: 6c7a2676f594ca9a30203b4fd5dc26b53682cffe
> and
> "microblaze: Remove NO_IRQ from architecture"
> sha1: 18e3b1075b1bc4a6027a6612fe70a5c81c209ec7
> 
> but we can also use this driver on arm Zynq platform.
> It is easy to add
> #ifndef NO_IRQ
> #define NO_IRQ 0
> #endif
> to the driver to cover Microblaze case but it will be just workaround.
> 
> >From patches description NO_IRQ shouldn't be used by any driver
> + from Grant description
> 
> "As has been discussed many times[1], Using NO_IRQ set to anything other
> than 0 is bug waiting to happen since many drivers follow the pattern
> "if (!irq)" for testing whether or not an irq has been set."
> 
> + link
> [1] http://lkml.org/lkml/2005/11/21/221
> 
> Was there any attempt to remove NO_IRQ from ARM?

We have been removing it gradually over time.  Any new platform should
already be using 0 for no IRQ, and the only way to do this is to have
drivers using NO_IRQ test for irq <= 0.

Removing NO_IRQ=-1 on a single day is incredibly difficult.

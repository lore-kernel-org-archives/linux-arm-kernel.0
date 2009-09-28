From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Mon, 28 Sep 2009 11:58:13 +0200
Subject: [PATCH 1/2] n2100: support assigning XINT1 to UART
In-Reply-To: <19134.28977.5491.323804@pilspetsen.it.uu.se>
References: <19134.28977.5491.323804@pilspetsen.it.uu.se>
Message-ID: <20090928095813.GJ1773@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 26, 2009 at 09:53:21PM +0200, Mikael Pettersson wrote:

> The Thecus n2100 has a jumper which determines if the XINT1
> interrupt line is connected to the second UHCI controller
> (position J3) or the serial console UART (position J4).
> 
> In position J3 (default) the second UHCI controller is fully
> operational, allowing low-speed USB devices to be connected
> to any of the three USB ports. However, the UART has to be
> polled by a high-frequency timer, causing CPU overheads.
> 
> In position J4 the second UHCI controller is not operational,
> causing low-speed USB devices to only work when connected to
> the front USB port. On the other hand, the UART polling timer
> is eliminated, resulting in reduced CPU overheads. This is
> especially important for tickless systems.
> 
> This patch adds a compile-time option allowing the kernel to
> be configured appropriately for the J3 or J4 cases.
> 
> (This could possibly be handled by a kernel boot option instead,
> but I opted for a much simpler compile-time option for now.)

Making it a compile-time option will pretty much guarantee that
none of the standard ARM distros that run on the n2100 will turn it
on, and so in the end the option won't be available to most n2100
users (the majority of n2100 users runs distro kernels on their
devices as far as I can tell), which kind of reduces the usefulness
of doing this in the first place.

Can't you detect whether the 8250 IRQ is routed at boot?  E.g. cause
the UART to throw an interrupt, check the XINT, clear the interrupt,
and check the XINT again, and see if the 8250 interrupt status
corresponds to the XINT or not?  (And then printk the result of the
detection.)

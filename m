From: dk-arm-linux@gmx.de (Dieter Kiermaier)
Date: Thu, 12 Nov 2009 08:23:44 +0100
Subject: [PATCH] ARM: enable PCI bridges after assigning resources (was
	orion/kirkwood pcie issue still open with 2.6.32-rc6 (marvell
	stock 2.6.22.18 works!))
In-Reply-To: <1257989709.3918.8.camel@kero>
References: <200911090933.46240.dk-arm-linux@gmx.de>
	<20091111171916.GC22741@mail.wantstofly.org>
	<1257989709.3918.8.camel@kero>
Message-ID: <200911120823.46427.dk-arm-linux@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime, hi Lennert,

> 
> On Wed, 2009-11-11 at 18:19 +0100, Lennert Buytenhek wrote:
> 
> Hi Lennert & Dieter,
> 
> > It's the "Mem" one (surprise! :)).  The minus in "Mem-" indicates that
> > the bit is disabled in the Control register.
> 
> I sent this patch twice on arm mailing list but it went unnoticed. I
> think you're hitting the exact same problem.
> 
> 
> 
> When kernel is doing PCI resource assignment on ARM, nothing ever
> enables PCI bridges, preventing any device behind them from working. The
> following patch fixes this.
> 

You hit it :)
With your patch my FPGA works behind the bridge together with the marvell git u-boot.

@Lennert: now your debug printk's are shown during boot up!

To see things clear:
Is it possible that the marvell stock u-boot enables all devices before it starts the kernel
and that's the reason why it worked if I booted the kernel from stock u-boot and it didn't
work with the git u-boot?

Here is my:
Acked-by: Dieter Kiermaier <dk-arm-linux@gmx.de>

Additionally I will cook up a patch which clears the bit for M-Bus error reporting against most recent kernel
during the course of the day.

Many thanks to all for helping,
Dieter


> 
> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
> 
> --- linux-2.6.29/arch/arm/kernel/bios32.c.old	2009-04-16 22:43:18.000000000 +0200
> +++ linux-2.6.29/arch/arm/kernel/bios32.c	2009-04-16 22:43:25.000000000 +0200
> @@ -580,6 +580,7 @@
>  			 * Assign resources.
>  			 */
>  			pci_bus_assign_resources(bus);
> +			pci_enable_bridges(bus);
>  		}
>  
>  		/*
> 
> 
> 
> 

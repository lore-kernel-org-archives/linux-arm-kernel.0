From: mbizon@freebox.fr (Maxime Bizon)
Date: Thu, 12 Nov 2009 02:35:09 +0100
Subject: [PATCH] ARM: enable PCI bridges after assigning resources (was
	orion/kirkwood pcie issue still open with 2.6.32-rc6 (marvell stock
	2.6.22.18 works!))
In-Reply-To: <20091111171916.GC22741@mail.wantstofly.org>
References: <200911090933.46240.dk-arm-linux@gmx.de>
	<200911111750.35330.dk-arm-linux@gmx.de>
	<20091111165353.GA22741@mail.wantstofly.org>
	<200911111811.07413.dk-arm-linux@gmx.de>
	<20091111171916.GC22741@mail.wantstofly.org>
Message-ID: <1257989709.3918.8.camel@kero>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Wed, 2009-11-11 at 18:19 +0100, Lennert Buytenhek wrote:

Hi Lennert & Dieter,

> It's the "Mem" one (surprise! :)).  The minus in "Mem-" indicates that
> the bit is disabled in the Control register.

I sent this patch twice on arm mailing list but it went unnoticed. I
think you're hitting the exact same problem.



When kernel is doing PCI resource assignment on ARM, nothing ever
enables PCI bridges, preventing any device behind them from working. The
following patch fixes this.


Signed-off-by: Maxime Bizon <mbizon@freebox.fr>

--- linux-2.6.29/arch/arm/kernel/bios32.c.old	2009-04-16 22:43:18.000000000 +0200
+++ linux-2.6.29/arch/arm/kernel/bios32.c	2009-04-16 22:43:25.000000000 +0200
@@ -580,6 +580,7 @@
 			 * Assign resources.
 			 */
 			pci_bus_assign_resources(bus);
+			pci_enable_bridges(bus);
 		}
 
 		/*




-- 
Maxime

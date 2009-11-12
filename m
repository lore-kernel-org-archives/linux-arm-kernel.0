From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Thu, 12 Nov 2009 20:56:47 +0100
Subject: [PATCH] ARM: enable PCI bridges after assigning resources (was
	orion/kirkwood pcie issue still open with 2.6.32-rc6 (marvell
	stock 2.6.22.18 works!))
In-Reply-To: <1257989709.3918.8.camel@kero>
References: <200911090933.46240.dk-arm-linux@gmx.de>
	<200911111750.35330.dk-arm-linux@gmx.de>
	<20091111165353.GA22741@mail.wantstofly.org>
	<200911111811.07413.dk-arm-linux@gmx.de>
	<20091111171916.GC22741@mail.wantstofly.org>
	<1257989709.3918.8.camel@kero>
Message-ID: <20091112195647.GH22741@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2009 at 02:35:09AM +0100, Maxime Bizon wrote:

> Hi Lennert & Dieter,

Hi Maxime,


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

As normal devices aren't enabled (in the MEM/IO decoding sense) by
default on boot either, I wonder if we should just have pci_enable_device()
walk through the PCI tree up to the root, enabling each of the bridges
on its path?

(pci_disable_device() doesn't disable MEM/IO decoding (just the initiator
bit), so there's no symmetry problem with not disabling those bridges
in pci_disable_device() again.)

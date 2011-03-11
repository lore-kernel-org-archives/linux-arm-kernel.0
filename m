From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 Mar 2011 17:14:12 +0100
Subject: [RFC PATCHv1 1/2] Export SoC info through sysfs
In-Reply-To: <AANLkTin=Octa0BsxAh2QPsJXVCOKNrzELkcNJO88J+pN@mail.gmail.com>
References: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<201103101732.34127.arnd@arndb.de>
	<AANLkTin=Octa0BsxAh2QPsJXVCOKNrzELkcNJO88J+pN@mail.gmail.com>
Message-ID: <201103111714.12332.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 March 2011, Linus Walleij wrote:
> What I'm trying to get at is that the user of this
> info isn't really interested in any device tree structure,
> it just becomes an obstacle s/he has to overcome
> to get this info out.
> 
> But there may be a compromise: if we create the
> socinfo in one place in the device tree (possibly the
> top node, or a dedicated device) then class it?
> 
> /sys/class/soc/soc0 -> ../../devices/platform/top-node
> 
> Then you find your entries easily by opening
> /sys/class/soc/soc0/* ?

That would be one way of finding all soc nodes, in
case we want to have multiple ones. Similarly,
it could be done based on

1. the name under /sys/devices/platform:

/sys/devices/platform/soc0
/sys/devices/platform/soc1
/sys/devices/platform/soc2

2. a new bus_type for soc devices, with bus_attributes:

/sys/bus/soc/devices/foo0 -> ../../../devices/platform/foo0
/sys/bus/soc/devices/bar0 -> ../../../devices/platform/bar0
/sys/bus/soc/devices/bar1 -> ../../../devices/platform/bar1

3. A new top-level device besides /sys/devices/platform (like PCI):

/sys/devices/soc0
/sys/devices/soc1
/sys/devices/soc2

> If the socinfo interface is singleton (and why should
> it not be) then:
> 
> /sys/class/soc -> ../devices/platfom/top-node
> 
> Or is this thing too trivial to have it's own class?

In case of a singleton, I'd just use a fixed device as
the parent:

/sys/devices/platform/soc/

or

/sys/devices/soc/

And pass that as the parent for all devices under it.

	Arnd

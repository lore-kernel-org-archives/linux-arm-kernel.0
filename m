From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 May 2014 09:22:32 +0200
Subject: [PATCH 0/4] Introducing Exynos ChipId driver
In-Reply-To: <CAL_JsqJXE4uXKA6XU1=3zFjdcEXHyUat2dL6wDKiZBx8S-p+Xg@mail.gmail.com>
References: <1399097500-4052-1-git-send-email-pankaj.dubey@samsung.com>
 <13946837.RfnRDPQdge@wuerfel>
 <CAL_JsqJXE4uXKA6XU1=3zFjdcEXHyUat2dL6wDKiZBx8S-p+Xg@mail.gmail.com>
Message-ID: <10277248.fmjBNTktBZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 May 2014 10:34:02 Rob Herring wrote:
> 
> > Ideally this should be done by slightly restructuring the DT
> > source to make all on-chip devices appear below the soc node.
> > We'd have to think a bit about how to best do this while
> > preserving compatibility with existing dts files.
> 
> I don't agree. How is a block with chip ID info the parent of all the
> other devices?
> 
> In doing some work to move default of_platform_populate out of
> platforms, I noticed that most platforms using the soc device are
> making it the parent of platform devices. I think this is either wrong
> or all platforms should have a default soc device. It makes little
> sense for some platforms to have a devices under a soc sysfs directory
> while others do not. Or the location changes when a platform latter
> adds the soc device.

We had a long discussion about this when we introduced the drivers/soc
framework. The intention is that the /sys/devices/soc* node is meant to
describe the SoC in its entirety, the same way you have a pci0000:00 node
as the root of all PCI devices of the first pci host bridge on a PC
system. This also reflects the reality of a SoC, which normally has one
bus that the CPU is connected to and that has all the other devices as
children.

Having the chipid registers as part of the top-level bus should not
be interpreted as having the other devices as children of the chipid
device, but rather the chipid registers as a property of the soc itself
as opposed to a random device that happens to be part of the soc.

	Arnd

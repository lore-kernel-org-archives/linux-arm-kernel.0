From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Sep 2012 15:30:40 +0000
Subject: [PATCH v4 03/10] pinctrl: mvebu: kirkwood pinctrl driver
In-Reply-To: <CACRpkdY-Nyn73EJLvE1RsL4hgMRm6hALtnS-eKAXU7edot2V9A@mail.gmail.com>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <50559737.8000705@gmail.com>
 <CACRpkdY-Nyn73EJLvE1RsL4hgMRm6hALtnS-eKAXU7edot2V9A@mail.gmail.com>
Message-ID: <201209201530.40974.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 September 2012, Linus Walleij wrote:
> You found the weak spot between two consolidation tracks.
> 
> Getting rid of a broadcast autodetect functions from say
> <mach/foo-id-probe.h> is nominally done by passing the data
> to the driver as platform data instead, and only using
> these functions in the mach-foo folder when populating
> platform data, and thus it can be made into a local
> header, say mach-foo/foo-id-probe.h
> 
> So the machine/arch code reads these registers to
> populate the platform data and device drivers only
> look at the platform data, which has some enum or
> bool indicating what hardware it's running on, cool.
> 
> But according to the other consolidation track, platform
> data should go into device tree bindings.
> 
> So the conclusion is that the DT must contain the data
> about the platform, so it's not auto-probed by the kernel.
> (I.e. the kernel reads no registers to figure out what hardware
> this is, that stuff comes from the device tree.)
> 
> DT purists will say that the boot loader should ask the chipset
> what it is with the same register writes and populate the
> DT accordingly, instead of loading a precompiled blob.
> Some may even ponder the crazy concept of amending the
> DT in the kernel at early boot.
> 
> But in practice someone will give up, encode the stuff in
> the static device tree and autoprobing of the platform
> goes out the window.

In general, I would prefer probing hardware by asking the hardware itself
rather than duplicating the information in the device tree. We do this
whenever we can, e.g. on PCI or USB, but we cannot normally do the same
on embedded buses like AHB, I2C or SPI, so we have to use the device
tree to provide some or all of the information.

A corner case is the one where you have different versions of the same
IP block (e.g. the pinctrl) and the kernel cannot find out which one it
is by looking at registers inside it or on the parent bus, but only
by looking at other hardware (CPU core revision, or PCI device ID of
the root complex). We have a precedent of at91 doing this, but I don't
like it too much because that still means having to change the driver
again if you get a new SoC with the same IP block but a different version
register, or if the block gets reused in something (e.g. by a different
vendor) that doesn't even have the other block that's used for
identification. To avoid that, I'd prefer using separate "compatible"
values, at least if the hardware is already described in separate .dtsi
files.

	Arnd

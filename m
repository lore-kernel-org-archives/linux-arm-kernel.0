From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 19 Feb 2014 15:21:03 -0700
Subject: [PATCH v2 00/23] Move DT kirkwood into mach-mvebu
In-Reply-To: <20140218190212.GE7862@titan.lakedaemon.net>
References: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
 <20140218185703.GI29304@obsidianresearch.com>
 <20140218190212.GE7862@titan.lakedaemon.net>
Message-ID: <20140219222103.GB17826@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 02:02:12PM -0500, Jason Cooper wrote:
> On Tue, Feb 18, 2014 at 11:57:03AM -0700, Jason Gunthorpe wrote:
> > On Sat, Feb 15, 2014 at 11:19:58AM +0100, Andrew Lunn wrote:
> > > The process of making most kirkwood boards boot using DT is nearly
> > > complete. We can now move these boards into mach-mvebu, freeing them
> > > of the legacy code needed for none-DT systems. At the same time, they
> > > can become part of ARCH_MULTI_V5.
> > 
> > Do you have a GIT URL for this? I can test it if you make it easy :)
> 
> I believe this is it (web):
> 
>   https://github.com/lunn/linux/tree/v3.14-rc1-mvebu-v2

Thanks, I tested v3 of the patchset.

It boots, but I can't do very much because the watchdog driver doesn't
build and my system is configured to watchdog timeout if there is no
watchdog driver.

Presumably the watchdog patchset needs to be a dependency for this? Is
there a git URL for it?

Also, reviewing my 3.13 Kconfig vs the 3.14 Kconfig with the patch,
these options are now forced on, and I'd prefer them to be off:
 CONFIG_ARM_PATCH_PHYS_VIRT=y
 CONFIG_GENERIC_PHY=y
 CONFIG_PHY_MVEBU_SATA=y

And looking at the final kconfig directly a bit:

config ARCH_MVEBU
	bool "Marvell SOCs with Device Tree support" if (ARCH_MULTI_V7 || ARCH_MULTI_V5)
	select ARCH_SUPPORTS_BIG_ENDIAN
	select CLKSRC_MMIO
	select COMMON_CLK
	select GENERIC_CLOCKEVENTS
	select GENERIC_IRQ_CHIP
	select IRQ_DOMAIN
	select MULTI_IRQ_HANDLER
	select PINCTRL
	select PLAT_ORION
	select SPARSE_IRQ
	select CLKDEV_LOOKUP
	select MVEBU_MBUS
	select ZONE_DMA if ARM_LPAE
	select ARCH_REQUIRE_GPIOLIB
	select MIGHT_HAVE_PCI
	select PCI_QUIRKS if PCI
          ^^^^^^^^^^^^^^^^^^^
       This can go now, it was something I added to support the old
       non-dt kirkwood PCI-E driver. The new DT MVEBU driver does not
       require it.

config MACH_KIRKWOOD
	bool "Marvell Kirkwood boards" if ARCH_MULTI_V5
	select ARCH_HAS_CPUFREQ
	select ARCH_REQUIRE_GPIOLIB
	select CPU_FEROCEON
	select KIRKWOOD_CLK
	select OF_IRQ
	select ORION_IRQCHIP
	select ORION_TIMER

	select PCI
	select PCI_QUIRKS
          ^^^^^
      Also unecessary, see above
	select PINCTRL_KIRKWOOD
	select POWER_SUPPLY
	select POWER_RESET
	select POWER_RESET_GPIO
	select REGULATOR
	select REGULATOR_FIXED_VOLTAGE
	select USE_OF

And I feel PCI, POWER_SUPPLY, POWER_RESET, POWER_RESET_GPIO,
REGULATOR, REGULATOR_FIXED_VOLTAGE should not be forced in the master
KConfig as not all boards require them.

Maybe make them forced if !EMBEDDED or something?

Shouldn't USE_OF and OF_IRQ be in ARCH_MVEBU?

These options were also switched on, but I have no opinion on them.. :)
 CONFIG_SPARSE_IRQ is now mandatory
 CONFIG_ARCH_USE_BUILTIN_BSWAP is turned on
 CONFIG_HAVE_CC_STACKPROTECTOR and related are on
 CONFIG_NO_BOOTMEM=y
 CONFIG_AUTO_ZRELADDR=y

Jason

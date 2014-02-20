From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 20 Feb 2014 10:45:54 +0100
Subject: [PATCH v2 00/23] Move DT kirkwood into mach-mvebu
In-Reply-To: <20140219222103.GB17826@obsidianresearch.com>
References: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
 <20140218185703.GI29304@obsidianresearch.com>
 <20140218190212.GE7862@titan.lakedaemon.net>
 <20140219222103.GB17826@obsidianresearch.com>
Message-ID: <20140220094554.GI11878@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Thanks, I tested v3 of the patchset.

Great, thanks.
 
> It boots, but I can't do very much because the watchdog driver doesn't
> build and my system is configured to watchdog timeout if there is no
> watchdog driver.
> 
> Presumably the watchdog patchset needs to be a dependency for this? Is
> there a git URL for it?

I don't have a tree with both combined. I guess there is a branch in

https://github.com/MISL-EBU-System-SW/mainline-public.git

with it.
 
> Also, reviewing my 3.13 Kconfig vs the 3.14 Kconfig with the patch,
> these options are now forced on, and I'd prefer them to be off:
>  CONFIG_ARM_PATCH_PHYS_VIRT=y

I suspect that comes from multiplatform.

>  CONFIG_GENERIC_PHY=y
>  CONFIG_PHY_MVEBU_SATA=y

If you disable SATA, you can disable these two.  We have had so much
breakage with this, that i want to keep away from it for a while to
let it settle. I can then go back and see about making it truly
optional.

> And looking at the final kconfig directly a bit:
> 
> config ARCH_MVEBU
> 	bool "Marvell SOCs with Device Tree support" if (ARCH_MULTI_V7 || ARCH_MULTI_V5)
> 	select ARCH_SUPPORTS_BIG_ENDIAN
> 	select CLKSRC_MMIO
> 	select COMMON_CLK
> 	select GENERIC_CLOCKEVENTS
> 	select GENERIC_IRQ_CHIP
> 	select IRQ_DOMAIN
> 	select MULTI_IRQ_HANDLER
> 	select PINCTRL
> 	select PLAT_ORION
> 	select SPARSE_IRQ
> 	select CLKDEV_LOOKUP
> 	select MVEBU_MBUS
> 	select ZONE_DMA if ARM_LPAE
> 	select ARCH_REQUIRE_GPIOLIB
> 	select MIGHT_HAVE_PCI
> 	select PCI_QUIRKS if PCI
>           ^^^^^^^^^^^^^^^^^^^
>        This can go now, it was something I added to support the old
>        non-dt kirkwood PCI-E driver. The new DT MVEBU driver does not
>        require it.

This has nothing directly to do with this patchset. Please could you
supply a patch?
 
> config MACH_KIRKWOOD
> 	bool "Marvell Kirkwood boards" if ARCH_MULTI_V5
> 	select ARCH_HAS_CPUFREQ
> 	select ARCH_REQUIRE_GPIOLIB
> 	select CPU_FEROCEON
> 	select KIRKWOOD_CLK
> 	select OF_IRQ
> 	select ORION_IRQCHIP
> 	select ORION_TIMER
> 
> 	select PCI
> 	select PCI_QUIRKS
>           ^^^^^
>       Also unecessary, see above
> 	select PINCTRL_KIRKWOOD
> 	select POWER_SUPPLY
> 	select POWER_RESET
> 	select POWER_RESET_GPIO
> 	select REGULATOR
> 	select REGULATOR_FIXED_VOLTAGE
> 	select USE_OF
> 
> And I feel PCI, POWER_SUPPLY, POWER_RESET, POWER_RESET_GPIO,
> REGULATOR, REGULATOR_FIXED_VOLTAGE should not be forced in the master
> KConfig as not all boards require them.

At the moment, we need PCI in order to get the SoC ID. Gregory has a
patch which will help with this, only selecting the minimum
needed. However, ARCH_KIRKWOOD selected both PCI and PCI_QUIRKS, so i
think removing them should be in a separate cleanup patch, which can
follow once the series is accepted. I added the POWER_* and
REGULATOR_* options. I will move them into mvebu_v5_defconfig and
multi_v5_defconfig instead.
 
> Maybe make them forced if !EMBEDDED or something?

I think we first need to define what EMBEDDED means. For me a NAS is
an embedded system, and it is various NAS boxes which want these.
 
> Shouldn't USE_OF and OF_IRQ be in ARCH_MVEBU?

Probably. I'm guessing the others are getting these from
multi_v7_defconfig. I would say this again is something for a cleanup
patch once the series is merged. Dove is also not too far away from
moving in, so i think it makes sense to look at things like this once
we have the complete picture.

   Andrew

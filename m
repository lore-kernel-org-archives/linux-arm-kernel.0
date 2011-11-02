From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Nov 2011 19:21:12 +0000
Subject: [PATCH] arm/tegra: add support for tegra30 interrupts
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF173F9A47A7@HQMAIL01.nvidia.com>
References: <1320248292-22736-1-git-send-email-pdeschrijver@nvidia.com>
	<74CDBE0F657A3D45AFBB94109FB122FF173F9A46E5@HQMAIL01.nvidia.com>
	<74CDBE0F657A3D45AFBB94109FB122FF173F9A4758@HQMAIL01.nvidia.com>
	<74CDBE0F657A3D45AFBB94109FB122FF173F9A47A7@HQMAIL01.nvidia.com>
Message-ID: <20111102192112.GC12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2011 at 12:09:36PM -0700, Stephen Warren wrote:
> To solve this, I recommend definining ARCH_NR_GPIOs for Tegra, to something
> large; I see that arch/arm/mach-shmobile defines it to 1024. Failing any
> disadvantage of using a number that large, I'd go for that...

I'd suggest that we immediately start solving the ARCH_NR_GPIO
definition a single zImage friendly way - rather than throwing a
definition into mach/gpio.h, add this into asm/gpio.h:

#if CONFIG_ARCH_NR_GPIO > 0
#define ARCH_NR_GPIO CONFIG_ARCH_NR_GPIO
#endif

and in arch/arm/Kconfig:

config ARCH_NR_GPIO
	int
	default 1024 if ARCH_SHMOBILE || ARCH_TEGRA
	... etc ...
	default 0

The list should be sorted in numeric order, largest first.

This then gives us a path to eliminate the ARCH_NR_GPIO definitions
from mach/gpio.h - and should allow more mach/gpio.h to become empty.

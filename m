From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Mon,  8 Feb 2010 16:11:21 -0800
Subject: LPC32XX architecture files (updated v3)
Message-ID: <1265674295-23996-1-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is the third release of the LPC32xx arch files
with many applicable review comments incorporated. Thank you
everyone that helped review and improve this release.

Changes from previous release to v3 (02/08/2010)

Removed __initdata tag from clock lookup array.
Removed <mach/irqs.h> include from irq entry macro.
Added LPC32XX identifier to device specific names for register
	addresses, bitfields, and other macros
Added LPC32XX identifier to device specific IRQ names
Changes to suspend.S to make it more readable
Changed register addresses and macros to return a virtual address
	via io_p2v of void __iomem * type. Previous types in the
	code that uses a different type now use void __iomem *.
	This makes the code less busy and fixes many sparse
	warnings. Most io_p2v() use in the code has been removed.
_readl/_writel functions use the correct type now without the use
	of __force.
_readl/_writel function arguments all use the direct virtual
	address or an indiced address (for devices that share
	register sets such as timers and UARTs).
Some minor tweaks for sparse warnings
Remove GENERIC_GPIO from arch/arm/Kconfig for mach-LPC32xx
Updated phy3250_defconfig file
The platform Kconfig.plat file was removed.
Arch Kconfig was reduced just the serial port selections.
Added mutex instead of local_irq..() for clock locks.
Revised clock_get_rate code. All clock functions have a get_rate
	callback now instead of just LCD and MCI. Changed the way
	the rate fetch loop was handled.
Switches to abs() and removed clkpwr_abs for clock driver
	functions.
Simplified clock PLL rate config logic.
Fixed USB PLL enable with correct timeout.
Global fixes for all GPL license headers - remove wrong address.
Changed I2C naming to start at '1' instead of '0' to match
	hardware convention.
Added IRAM size autodetect function.
Removed printascii() use in arch file.
Fixed multi-line comments.
Moved some register macros used just in GPIO driver to the
	GPIO driver from platform.h
Added GPIO pin to bit mapping macros
Fixed some names "na" in GPIO name array to NULL.
Expanded a few GPIO driver comments to help explain the more
	wierd mappings better.
Revised debug and uncompress macros to just use the serial port
	UART5 for the output (used on Phytec board).
Revised interrupt handler and entry macro to use chained
	interrupt handlers for SIC1 and SIC2.
Fixed several CLKPWR bit and IRQ macro names that could cause
	confusion with GPI names and the LPC32XX User's guide
Changed VMALLOC_END to 0xF0000000 from PAGE_OFFSET+0x10000000
Added support for set_irq_wake in the interrupt driver with the
	supported wakeup sources. Activation level for GPIO
	events is inherited from the GPIO interrupt config.
The level handlers are used for hardware based level and edge
	interrupts. Thsi is ok for this controller.
Interrupt driver edge/level type logic reduction
FIQ interrupts are no longer enabled by default in the MIC
Changed all readl/writel calls to __raw_readl/__raw_writel.
Removed support for Phytec board variations. This will only
	effect very eaarly LCD based boards. Due to the very
	limited number of boards out there, this really is
	not needed.
Remove board specific code and associated config option for
	setting IRAM as the video frame buffer
Moved IRDA enable/disable from the serial setup code to the
	board specific init code.
Removed event setup code in board init, replaced with
	set_irq_wake functionality now
CPU suspend removed, mem suspend only supported
Allocation and dealloc of temporary storage for IRAM data used
	for suspend is no longer GFP_ATOMIC. Code will only
	alloc when needed and free on completion.
Removed the pm_event driver, replaced (in part) with the
	set_irq_wake support. Events not supported by the
	set_irq_wake functionality need to be configured in the
	board specific init code.
Changed some config names and descriptions for serial port
	setup in KConfig and the serial init code.
Const modifier added to GPIO names

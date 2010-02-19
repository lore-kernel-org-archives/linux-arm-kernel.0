From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Fri, 19 Feb 2010 15:25:56 -0800
Subject: LPC32XX architecture files (updated v4)
Message-ID: <1266621969-28847-1-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Thanks again for the review comments. This patchset is the 4rth
release with many review comments incorporated.

Changes from previous release to v4 (02/19/2010)

Review comment changes...
Removed the include/mach/board.h file until it is actually needed
Changed IRQ macros for SIC1 and SIC2 and handling in SIC1/SIC2
	chained handlers
Size macros in platform.h changed to numeric values
Changed uncompress macros to use __raw_readl/writel instead of
	direct register access using volatile unsigned long *
Removed unused LPC32XX_CLKPWR_SET_PLL_USBPDIV macro
printascii debug macro assembly optimized
Fixed an issue with macros using _REG being doubled casted. After
	looking at this, _REG isn't really needed at all. The
	macros that rely on it can use io_p2v() directly.
_REG macro removed in platform.h. Other macros that use it now
	use io_p2v directly
Grammar and typo fixes
DEFINE_MUTEX used instead of init_mutex()
PLL397 and main osc clock rates hardcoded (0 rate not needed for a
	disabled clock)
clock structure usecount type changes to u32
Added WARN_ON for clock disable when usecount <= 0
Clock functions pointers no longer have the address of(&) prefix
	for function names, not needed
IRAM size computation algorithm changed
arch specific name changes on global platform structs specific to
	the lpc32xx
LPC32xx gpiolib macro change for GPIO3 to hide pin gap details
Made pll_postdivs static in clock.c. Moved support function
	(clk_get_pllrate_from_reg) from common.c that used that
	function into clock.c. Prototype for support function
	left in common.h (used in timer.c).
Used ffs() instead of a case block for a support function in the
	clock driver
Changed clock enable/disable logic to fix an issue with clock
	usecount accumulators and disable logic on failure. Clocks
	are now enabled from the bottom up. This is ok on the 32xx
	and makes the logic much simpler.
generic_handle_irq() used instead of handle_level_irq() for
	chained handlers
SUBIRQs initially left masked, chained handler init enables them
	now
suspend_valid_only_mem used instead of local variant
Small tweaks to suspend.S
icache invalidation added after SRAM copy and cache flush placed
	in the correct place
Removed the ARCH specific register swap in include/amba/clcd.h
	(compiles fine, but requires RK PL111 patch to work)
Montavista copyright and original GPLv2 licensing terms to pm.c
	and suspend.S. INAL either, but if they get involved,
	it would be easier to completely rewrite them than try
	to sort out the aftermath.

Additional changes...
Added missing LPC32XX_CLKPWR_USBPDIV_PLL_MASK mask macros to USB
	PCLK div computation (clock.c)

Unchanged from review comments...
IO_ADDRESS macro name unchanged. Macro is used in an existing
	driver (WDT) and provides support for assembly code
	that can't use the typecasts for sparse
I liked the idea of using functions for adding platform drivers
	specific to different device variants, but didn't want to
	do this...yet. (It makes good sense though.)

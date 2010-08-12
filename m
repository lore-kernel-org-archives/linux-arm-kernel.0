From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Thu, 12 Aug 2010 14:57:23 -0700
Subject: RTC: LPC32xx: Introduce RTC driver for the LPC32xx (v3)
Message-ID: <1281650244-9889-1-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for the LPC32xx built-in RTC. This is
a persistent RTC with alarm on it's own power domain and a
dedicated oscillator. UIE emulation is used for *_UIE_* ioctls.

The patch can be pulled from:
	git://git.lpclinux.com/linux-2.6-lpc rtc-lpc32xx_v3

v3 includes updates from the initial review of the RTC driver
and updates from v2. ...Fingers crossed...

Changes since v2:
	RTC register macros now prefixed with LPC32XX_
	Changed alarm_enable type to unsigned char to match
		the type in the struct rtc_wkalrm (enable)
	Set pending flag to correct state in read-alarm
		function
	Change the alarm read failure message to a warning
	Regardless of the state of the alarm enable flag
		passed into set_alarm, the alarm fire value
		is updated. Previously, this was only updated
		when the alarm enable flag was set
	Added braces for else clauses with a single statement
		if the previous if clause had them
	Cleared platform data pointer in rtc structure on
		error and remove

Changes since v1:
	Fixed spaces/tabbing in lpc32xx entry in Kconfig/Makefile
	Remove improper enable for rtc->alarm_enabled
	Removed typecast on rtc structure in irq handler
	Switch to resource managed (devm_) variants of kzalloc
		and other functions in probe. Updated remove
		based on these changes.
	Disabled alarm on probe instead of keeping current register
		settings. No changes for suspend.
	Allowed driver to continue operation without wakeup or
		alarm irq if the rtc irq request failed.
	Relocated module_init and _exit macros to just after it's
		associated function
	Passed a NULL pointer to .driver.pm in platform driver
		structure instead of a list of NULL functions.
	Added MODULE_ALIAS

From: michael.williamson@criticallink.com (Michael Williamson)
Date: Fri, 31 Dec 2010 20:11:56 -0500
Subject: [PATCH 1/2] davinci: Support disabling modem status interrupts on SOC
	UARTS
Message-ID: <1293844317-11757-1-git-send-email-michael.williamson@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the da850/omap-l138/am18x family of SoCs, up to three on chip UARTS may be
configured.  These peripherals support the standard Tx/Rx signals as well as
CTS/RTS hardware flow control signals.  The pins on these SOC's associated with
these signals are multiplexed; e.g., the pin providing UART0_TXD capability
also provides SPI0 chip select line 5 output capability.  The configuration of
the pin multiplexing occurs during platform initialization (or by earlier
bootloader operations).

There is a problem with the multiplexing implementation on these SOCs.  Only
the output and output enable portions of the I/O section of the pin are
multiplexed.  All peripheral input functions remain connected to a given pin
regardless of configuration.

In many configurations of these parts, providing a UART with Tx/Rx capability
is needed, but the HW flow control capability is not.  Furthermore, the pins
associated with the CTS inputs on these UARTS are often configured to support
a different peripheral, and they may be active/toggling during runtime.  This
can result in false modem status (CTS) interrupts being asserted to the 8250
driver controlling the associated Tx/Rx pins, and can impact system
performance.  This is especially true if the CTS pin is shared with something
like a clock line as is the case with UART1 CTS and the McASP AHCLKX.

The 8250 serial driver platform data does not provide a direct mechanism to
tell the driver to disable modem status (i.e., CTS) interrupts for a given
port.  As a work-around, allow davinci platforms to override set_termios for
configured UARTS that do not provide a true CTS input and ensure any request
does not enable HW flow control.

This patch was tested using a MityDSP-L138 SOM having UART1 enabled with the
associated CTS pin connected to a clock (configured for the AHCLKX function).

Background / problem reports related to this issue are captured in the links
below:
http://e2e.ti.com/support/dsp/omap_applications_processors/f/42/t/36701.aspx
http://www.mail-archive.com/davinci-linux-open-source at linux.davincidsp.com/msg19524.html

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
Tested-by: Michael Williamson <michael.williamson@criticallink.com>
---
This patch is against davinci-linux.

I'm open to suggestions for reducing the patch description.

I'm open to alternatives to the solution below, outside of disabling the
UARTs in question as is done on the DA850 evm and the hawkboard (both
of which might be able to use this patch?).

 arch/arm/mach-davinci/include/mach/serial.h |    2 ++
 arch/arm/mach-davinci/serial.c              |   19 +++++++++++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/serial.h b/arch/arm/mach-davinci/include/mach/serial.h
index 8051110..db1d208 100644
--- a/arch/arm/mach-davinci/include/mach/serial.h
+++ b/arch/arm/mach-davinci/include/mach/serial.h
@@ -49,6 +49,8 @@
 struct davinci_uart_config {
 	/* Bit field of UARTs present; bit 0 --> UART1 */
 	unsigned int enabled_uarts;
+	/* Bit field of RTS/CTS disable; bit 0 --> UART1 */
+	unsigned int disable_rtscts;
 };
 
 extern int davinci_serial_init(struct davinci_uart_config *);
diff --git a/arch/arm/mach-davinci/serial.c b/arch/arm/mach-davinci/serial.c
index 1875740..738048e 100644
--- a/arch/arm/mach-davinci/serial.c
+++ b/arch/arm/mach-davinci/serial.c
@@ -31,6 +31,22 @@
 #include <mach/serial.h>
 #include <mach/cputype.h>
 
+static void davinci_set_termios_noms(struct uart_port *up,
+				     struct ktermios *new,
+				     struct ktermios *old)
+{
+	/*
+	 * disabling CLOCAL, or enabling CRTSCTS, will enable the modem status
+	 * interrupts.  If this routine is being called, the port in question
+	 * does not have valid CTS/RTS pins (they are pinmuxed to some other
+	 * function).  Override any requested operation that may enable the
+	 * interrupts.
+	 */
+	new->c_cflag &= ~CRTSCTS;
+	new->c_cflag |= CLOCAL;
+	serial8250_do_set_termios(up, new, old);
+}
+
 static inline unsigned int serial_read_reg(struct plat_serial8250_port *up,
 					   int offset)
 {
@@ -109,6 +125,9 @@ int __init davinci_serial_init(struct davinci_uart_config *info)
 
 		if (p->membase && p->type != PORT_AR7)
 			davinci_serial_reset(p);
+
+		if (info->disable_rtscts & (1 << i))
+			p->set_termios = davinci_set_termios_noms;
 	}
 
 	return platform_device_register(soc_info->serial_dev);
-- 
1.7.0.4

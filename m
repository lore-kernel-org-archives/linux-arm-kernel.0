From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 11 May 2010 17:12:06 +0100
Subject: PXA/8250 UART Conflicts
In-Reply-To: <3117D78B-5443-48B5-88BC-83EEB8F709F9@prograde.net>
References: <3117D78B-5443-48B5-88BC-83EEB8F709F9@prograde.net>
Message-ID: <20100511161206.GB32186@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 11, 2010 at 11:00:36AM -0400, Michael Cashwell wrote:
> I'd like the tty layer to just assign the minor numbers in sequence,
> first come first served. But I don't see how to get that. Or is there
> some platform way to influence the tty range requested?

It's just plain not supported.  You can't have two different tty drivers
using the same namespace and have it work.

Unfortunately, earlier on it was the opinion that "ttyS" means "serial
driver" and therefore "we shall use the ttyS namespace for our SoC
driver".  And this is the resulting mess that it causes.

There were insane patches around to hack all the serial drivers up to
be able to use the "ttyS" space, by making the 8250 driver "special".

The other solution, which projects which wanted PCMCIA serial-like
cards to work with PXA chips is to patch the PXA serial driver to use
a different major/minor/namespace - it reuses the SA1100 serial port
space since you'll never end up with both SA1100 and PXA together.

commit 2fdedac721107de791da77f6ed5600a092cd06b1
Author: Russell King <rmk@dyn-67.arm.linux.org.uk>
Date:   Sun Aug 24 23:12:59 2008 +0100

    [SERIAL] pxa: Allow alternate major/minor numbers for PXA serial
    
    LX needs to use both the PXA driver, and the 8250 driver for modems/
    GPRS and the like.  Allow the PXA serial driver to exist using the
    StrongARM major/minor number space.
    
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index e522572..9187256 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -648,6 +648,15 @@ config SERIAL_PXA
 	  If you have a machine based on an Intel XScale PXA2xx CPU you
 	  can enable its onboard serial ports by enabling this option.
 
+config SERIAL_PXA_ALTMAJOR
+	bool "PXA serial port uses ttySA instead of ttyS"
+	depends on ARM && ARCH_PXA && SERIAL_PXA
+	help
+	  Moves the PXA serial ports to ttySA to allow the 8250 driver
+	  to register the serial ports it wants as ttySx. If you do not
+	  do this, then the serial_cs driver and others than rely on
+	  8250 support will not work.
+
 config SERIAL_PXA_CONSOLE
 	bool "Console on PXA serial port"
 	depends on SERIAL_PXA
diff --git a/drivers/serial/pxa.c b/drivers/serial/pxa.c
index b8629d7..6af59a0 100644
--- a/drivers/serial/pxa.c
+++ b/drivers/serial/pxa.c
@@ -682,7 +682,11 @@ serial_pxa_console_setup(struct console *co, char *options)
 }
 
 static struct console serial_pxa_console = {
+#ifdef CONFIG_SERIAL_PXA_ALTMAJOR
+	.name		= "ttySA",
+#else
 	.name		= "ttyS",
+#endif
 	.write		= serial_pxa_console_write,
 	.device		= uart_console_device,
 	.setup		= serial_pxa_console_setup,
@@ -719,9 +723,15 @@ struct uart_ops serial_pxa_pops = {
 static struct uart_driver serial_pxa_reg = {
 	.owner		= THIS_MODULE,
 	.driver_name	= "PXA serial",
+#ifdef CONFIG_SERIAL_PXA_ALTMAJOR
+	.dev_name	= "ttySA",
+	.major		= 204,
+	.minor		= 5,
+#else
 	.dev_name	= "ttyS",
 	.major		= TTY_MAJOR,
 	.minor		= 64,
+#endif
 	.nr		= 4,
 	.cons		= PXA_CONSOLE,
 };

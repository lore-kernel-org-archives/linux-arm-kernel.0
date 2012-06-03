From: adam@baker-net.org.uk (Adam Baker)
Date: Sun, 03 Jun 2012 17:59:04 +0100
Subject: Kernel 3.4 on Dreamplug: no serial console
In-Reply-To: <loom.20120603T172511-816@post.gmane.org>
References: <loom.20120602T135715-548@post.gmane.org>
 <loom.20120603T172511-816@post.gmane.org>
Message-ID: <1475115.7BtuQWbDGm@gromit>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 03 Jun 2012 15:26:14 Hans Kr?ner wrote:
> Hi again,
> 
> Many thanks to the both of you. CONFIG_SERIAL_OF_PLATFORM was exactly what
> I was missing in my .config
> 

As there are now two of us who have been tripped up by this does anyone think 
the untested patch below is

a) worthwhile
b) likely to be acceptable
c) likely to work

It feels wrong to be putting something arch specific in such general code but 
setting it as a default is cleaner than trying to select it from 
ARCH_KIRKWOOD_DT because default respects depends lines.

--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1021,6 +1021,7 @@ config SERIAL_OF_PLATFORM
        tristate "Serial port on Open Firmware platform bus"
        depends on OF
        depends on SERIAL_8250 || SERIAL_OF_PLATFORM_NWPSERIAL
+        default y if ARCH_KIRKWOOD_DT
        help
          If you have a PowerPC based system that has serial ports
          on a platform specific bus, you should enable this option.

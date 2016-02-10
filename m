From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Feb 2016 20:52:11 +0100
Subject: [PATCH 1/2] serial: 8250: fix building mediatek with SERIAL_8250=m
In-Reply-To: <56BB7C23.5070600@gmail.com>
References: <1454935947-2743255-1-git-send-email-arnd@arndb.de>
 <56BB7C23.5070600@gmail.com>
Message-ID: <7590955.HIrRGSSVmH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 February 2016 19:06:27 Matthias Brugger wrote:
> > ---
> 
> I tried this with:
> commit 2178cbc68f3602dc0b5949b9be2c8383ad3d93ef
> 
> $ grep 8250 .config
> CONFIG_SERIAL_8250=m
> # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
> CONFIG_SERIAL_8250_PCI=m
> CONFIG_SERIAL_8250_NR_UARTS=4
> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> # CONFIG_SERIAL_8250_EXTENDED is not set
> # CONFIG_SERIAL_8250_DW is not set
> # CONFIG_SERIAL_8250_RT288X is not set
> CONFIG_SERIAL_8250_MT6577=y
> # CONFIG_SERIAL_8250_INGENIC is not set
> # CONFIG_SERIAL_8250_MID is not set
> 
> $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- drivers/tty/
> 
> compiles just fine.
> 
> Do I missing something?
> 

I was simplifying the situation in the patch description: When CONFIG_SERIAL_8250=m,
Kbuild does not actually descend into drivers/tty/serial/8250/ while building
built-in code, so none of the built-in subdrivers actually get built.

After spotting the problem, I was building with this patch that I considered
submitting:

diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index ceba33c4ebb4..28121885e78e 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -18,7 +18,7 @@ obj-$(CONFIG_SERIAL_SUNSU) += sunsu.o
 obj-$(CONFIG_SERIAL_SUNSAB) += sunsab.o
 
 # Now bring in any enabled 8250/16450/16550 type drivers.
-obj-$(CONFIG_SERIAL_8250) += 8250/
+obj-y += 8250/
 
 obj-$(CONFIG_SERIAL_AMBA_PL010) += amba-pl010.o
 obj-$(CONFIG_SERIAL_AMBA_PL011) += amba-pl011.o

However, after the other problems are fixed, it's not actually needed
any more, so I did not submit it.

	Arnd

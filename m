From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Sat, 16 Feb 2013 19:18:04 -0300
Subject: [PATCH 01/11] ARM: disable virt_to_bus/virt_to_bus almost
 everywhere
In-Reply-To: <1360849767-1463135-2-git-send-email-arnd@arndb.de>
References: <1360849767-1463135-1-git-send-email-arnd@arndb.de>
 <1360849767-1463135-2-git-send-email-arnd@arndb.de>
Message-ID: <BLU0-SMTP3204E8218EA90D50AB340558A0D0@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

El 14/02/13 10:49, Arnd Bergmann escribi?:
> We are getting a number of warnings about the use of the deprecated
> bus_to_virt function in drivers using the ARM ISA DMA API:
> 
> drivers/parport/parport_pc.c: In function 'parport_pc_fifo_write_block_dma':
> drivers/parport/parport_pc.c:622:3: warning: 'bus_to_virt' is deprecated
> (declared at arch/arm/include/asm/memory.h:253) [-Wdeprecated-declarations]
> 
> This is only because that function gets used by the inline
> set_dma_addr() helper. We know that any driver for the ISA DMA API
> is correctly using the DMA addresses, so we can change this
> to use the __bus_to_virt() function instead, which does not warn.
> 
> After this, there are no remaining drivers that are used on
> any defconfigs on ARM using virt_to_bus or bus_to_virt, with
> the exception of the OSS sound driver. That driver is only used
> on RiscPC, NetWinder and Shark, so we can set ARCH_NO_VIRT_TO_BUS
> on all other platforms and hide the deprecated functions, which
> is far more effective than marking them as deprecated, in order
> to avoid any new users of that code.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Russell King <linux@arm.linux.org.uk>

Small nitpick: Please have a look at the patch subject, I suppose you
meant something like "virt_to_bus/bus_to_virt" instead of
"virt_to_bus/virt_to_bus".

Thanks,

Emilio

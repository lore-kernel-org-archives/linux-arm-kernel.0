From: daniel@caiaq.de (Daniel Mack)
Date: Fri, 5 Feb 2010 05:26:55 +0100
Subject: [PXA320] How to find  I/O registers, base address of ASIX
	ethernet chip?
In-Reply-To: <19621265275300@webmail108.yandex.ru>
References: <19621265275300@webmail108.yandex.ru>
Message-ID: <20100205042655.GR28972@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2010 at 12:21:40PM +0300, Dennis Semakin wrote:
> Configuration:
> Computer module is Toradex Colibri PXA320.
> Board is Colibri Evaluation Board.
> 
> Obviously, to access the I/O register of network card, we need to map them into memory, using the ioremap() function.
> To do this driver (ax88796.c) use platform_get_resource() function to get the physical address of the I/O registers from the board definition (arch/arm/mach-pxa/colibri-pxa320.c). This function returns a pointer to a struct resource, which contains two interesting fields : start and end (both are physical address).
> Then call ioremap function to remap the memory area returned by platform_get_resource.
> Right?
> 
> Ok. When I start kernel on my board, kernel loading stops on network initialization during call to the address resource.start.
> So, what could I do if the address (field start in resource structure) is not valid?
> Can I find it? (I mean address) Maybe I should ask something: where are ethernet chip I/O registers mapped in the memory?

The addresses passed to the driver is the I/O area of the chip select
signal used for the Ethernet chip. This setting should be alright, as it
worked well for me.

If your kernel hangs when accessing this area, you most probably haven't
set up your static bus correctly. The bootloader is in charge of doing
this, and the correct value for CSADRCFG2 is 0x0032C809.

Also see http://openpxa.sourceforge.net/ for patches to U-Boot and more
information about replacing the native bootloader the modules ships
with.

Daniel

From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Fri, 21 Jul 2017 14:21:53 +0200
Subject: [PATCH 01/12] ARM: ixp4xx: fix ioport_unmap definition
In-Reply-To: <20170720154616.3250481-2-arnd@arndb.de> (Arnd Bergmann's message
 of "Thu, 20 Jul 2017 17:45:55 +0200")
References: <20170720154616.3250481-1-arnd@arndb.de>
 <20170720154616.3250481-2-arnd@arndb.de>
Message-ID: <m3lgnif09q.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> An empty macro definition can cause unexpected behavior, in
> case of the ixp4xx ioport_unmap, we get two warnings:
>
> drivers/net/wireless/marvell/libertas/if_cs.c: In function 'if_cs_release':
> drivers/net/wireless/marvell/libertas/if_cs.c:826:3: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
>    ioport_unmap(card->iobase);
> drivers/vfio/pci/vfio_pci_rdwr.c: In function 'vfio_pci_vga_rw':
> drivers/vfio/pci/vfio_pci_rdwr.c:230:15: error: the omitted middle operand in ?: will always be 'true', suggest explicit middle operand [-Werror=parentheses]
>    is_ioport ? ioport_unmap(iomem) : iounmap(iomem);
>
> This uses an inline function to define the macro in a safer way.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-ixp4xx/include/mach/io.h | 11 +++++++++--

Acked-by: Krzysztof Halasa <khalasa@piap.pl>

In fact, the old code contained another bug (missing parentheses):

> --- a/arch/arm/mach-ixp4xx/include/mach/io.h
>  
> -#define	ioport_map(port, nr)		((void __iomem*)(port + PIO_OFFSET))
                                                                 ^^^^
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland

From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Mar 2011 13:44:45 +0200
Subject: [PATCH V5 3/4] ARM: Xilinx: base header files and assembly macros
In-Reply-To: <9ceff117-ad43-4513-bee0-153a93c379ce@VA3EHSMHS008.ehs.local>
References: <1301444651-18008-1-git-send-email-john.linn@xilinx.com>
	<1301444651-18008-3-git-send-email-john.linn@xilinx.com>
	<9ceff117-ad43-4513-bee0-153a93c379ce@VA3EHSMHS008.ehs.local>
Message-ID: <201103301344.45307.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

I looked over the latest version of your patches, everything looks
good to me, but I found one problem that you have probably copied
from other platforms:

On Wednesday 30 March 2011, John Linn wrote:
> +
> +/* Allow IO space to be anywhere in the memory */
> +
> +#define IO_SPACE_LIMIT 0xffff
> +
> +/* IO address mapping macros, nothing special at this time but required */
> +
> +#ifdef __ASSEMBLER__
> +#define IOMEM(x)               (x)
> +#else
> +#define IOMEM(x)               ((void __force __iomem *)(x))
> +#endif
> +
> +#define __io(a)                        __typesafe_io(a)
> +#define __mem_pci(a)           (a)

The definition of __io() looks wrong, so any call to inb()/outb()
will be a wild pointer access when you add PCI support.

If you don't plan to support PCI in the future, there should
be no problem.

	Arnd

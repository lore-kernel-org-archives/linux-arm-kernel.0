From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Nov 2014 22:32:47 +0100
Subject: [RFC PATCH 1/2] asm-generic: io: Add exec versions of ioremap
In-Reply-To: <cb5e9dd7bd71b13551cd3f32f28feb405ea9fcdd.1417029918.git.d-gerlach@ti.com>
References: <cover.1417029918.git.d-gerlach@ti.com>
 <cb5e9dd7bd71b13551cd3f32f28feb405ea9fcdd.1417029918.git.d-gerlach@ti.com>
Message-ID: <2060921.TrTof4X6qj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 November 2014 15:14:00 Dave Gerlach wrote:
> @@ -66,6 +66,11 @@ extern void ioport_unmap(void __iomem *);
>  #define ioremap_wc ioremap_nocache
>  #endif
>  
> +#ifndef ARCH_HAS_IOREMAP_EXEC
> +#define ioremap_exec ioremap
> +#define ioremap_exec_nocache ioremap_nocache
> +#endif
> +
>  #ifdef CONFIG_PCI
>  /* Destroy a virtual mapping cookie for a PCI BAR (memory or IO) */
>  struct pci_dev;
> 

ioremap and ioremap_nocache are the same, and there is no
architecture-independent interface to map an MMIO range as
cached because a lot of architectures can't do that.

Also, I think there are architectures that cannot execute
from uncached memory, so I think adding this as a generic
API is not a good idea.

	Arnd

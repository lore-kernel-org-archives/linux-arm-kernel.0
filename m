From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 Oct 2011 20:22:24 +0100
Subject: [PATCH 1/5 v4] ARM Realview PCIX map include file changes
In-Reply-To: <20111007142723.19554.88566.stgit@e102602-lin.cambridge.arm.com>
References: <20111007142310.19554.17204.stgit@e102602-lin.cambridge.arm.com>
	<20111007142723.19554.88566.stgit@e102602-lin.cambridge.arm.com>
Message-ID: <20111007192224.GB25689@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 07, 2011 at 03:27:47PM +0100, Colin Tuckley wrote:
> -#define IO_SPACE_LIMIT 0xffffffff
> +#include <asm/mach-types.h>
> +#include <mach/hardware.h>
> +
> +#define IO_SPACE_LIMIT 0x0000ffff

Does this in asm/io.h:

#ifndef IO_SPACE_LIMIT
#if defined(CONFIG_PCMCIA_SOC_COMMON) || defined(CONFIG_PCMCIA_SOC_COMMON_MODULE)
#define IO_SPACE_LIMIT ((resource_size_t)0xffffffff)
#elif defined(CONFIG_PCI) || defined(CONFIG_ISA) || defined(CONFIG_PCCARD)
#define IO_SPACE_LIMIT ((resource_size_t)0xffff)
#else
#define IO_SPACE_LIMIT ((resource_size_t)0)
#endif
#endif

not work here for some reason?  I think as PCMCIA_SOC_COMMON would not be
defined, but CONFIG_PCI would be, it'd give the correct answer.  Please
confirm.

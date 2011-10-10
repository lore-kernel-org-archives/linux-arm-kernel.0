From: colin.tuckley@arm.com (Colin Tuckley)
Date: Mon, 10 Oct 2011 10:27:08 +0100
Subject: [PATCH 1/5 v4] ARM Realview PCIX map include file changes
In-Reply-To: <20111007192224.GB25689@n2100.arm.linux.org.uk>
References: <20111007142310.19554.17204.stgit@e102602-lin.cambridge.arm.com>
	<20111007142723.19554.88566.stgit@e102602-lin.cambridge.arm.com>
	<20111007192224.GB25689@n2100.arm.linux.org.uk>
Message-ID: <000001cc872e$d1aaf870$7500e950$@tuckley@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Subject: Re: [PATCH 1/5 v4] ARM Realview PCIX map include file changes

> > +#define IO_SPACE_LIMIT 0x0000ffff
> 
> Does this in asm/io.h:
> 
> #ifndef IO_SPACE_LIMIT
> #if defined(CONFIG_PCMCIA_SOC_COMMON) ||
> defined(CONFIG_PCMCIA_SOC_COMMON_MODULE)
> #define IO_SPACE_LIMIT ((resource_size_t)0xffffffff)
> #elif defined(CONFIG_PCI) || defined(CONFIG_ISA) ||
> defined(CONFIG_PCCARD)
> #define IO_SPACE_LIMIT ((resource_size_t)0xffff)
> #else
> #define IO_SPACE_LIMIT ((resource_size_t)0)
> #endif
> #endif
> 
> not work here for some reason?  I think as PCMCIA_SOC_COMMON would not
> be
> defined, but CONFIG_PCI would be, it'd give the correct answer.  Please
> confirm.

Ah, I wasn't aware of that. However when I include asm/io.h and remove the
explicit definition of IO_SPACE_LIMIT I get compilation errors in
arch/arm/kernel/bios32.c and arch/arm/mm/iomap.c for " 'IO_SPACE_LIMIT'
undeclared.

A quick check shows that the piece of code you quote above does not exist in
my (3.1.0-rc9) source tree.

Colin

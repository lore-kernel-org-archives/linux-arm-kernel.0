From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 May 2010 14:25:18 +0100
Subject: [PATCH 1/4] ARM: Remove the domain switching on ARMv6k/v7 CPUs
In-Reply-To: <20100524114546.GB21117@n2100.arm.linux.org.uk>
References: <20100520142715.22202.33516.stgit@e102109-lin.cambridge.arm.com>
	<20100520143004.22202.71701.stgit@e102109-lin.cambridge.arm.com>
	<20100524114546.GB21117@n2100.arm.linux.org.uk>
Message-ID: <1274707518.4720.53.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-05-24 at 12:45 +0100, Russell King - ARM Linux wrote:
> On Thu, May 20, 2010 at 03:30:04PM +0100, Catalin Marinas wrote:
> > The user pages access rights are also modified for kernel read-only
> > access rather than read/write so that the copy-on-write mechanism still
> > works. CPU_USE_DOMAINS gets disabled only if HAS_TLS_REG is defined
> > since writing the TLS value to the high vectors page isn't possible.
> 
> When FIQ handlers are installed/removed, the vector page is also written,
> so the above restriction is incompatible with FIQ support.
> 
> Do we want to tell people that they can't use FIQs without domain support?

They could still be used (with an additional patch). At first, I thought
that we could do something similar to early_trap_init() but
set_fiq_handler() could be called from a module at run-time and it may
temporarily enable write access to the vectors page (without an
additional L_PTE_ bit we can't make the vectors page user RO, kernel R/W
and I wouldn't do this anyway, for other reasons).

What about making a global vectors_page variable (initialised in
devicemaps_init) that can be written directly when !CPU_USE_DOMAINS? On
such CPUs, we have a non-aliasing VIPT cache anyway.

-- 
Catalin

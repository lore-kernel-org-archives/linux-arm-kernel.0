From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 09 Jun 2010 15:10:16 -0400 (EDT)
Subject: [PATCH v2 1/4] ARM: Remove the domain switching on ARMv6k/v7 CPUs
In-Reply-To: <20100602164841.17783.94825.stgit@e102109-lin.cambridge.arm.com>
References: <20100602164459.17783.9741.stgit@e102109-lin.cambridge.arm.com>
	<20100602164841.17783.94825.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.00.1006091447460.30664@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for the delay... I'm just starting to seriously look at this.

On Wed, 2 Jun 2010, Catalin Marinas wrote:

> This patch removes the domain switching functionality via the set_fs and
> __switch_to functions on cores that have a TLS register.
[...]
> The user pages access rights are also modified for kernel read-only
> access rather than read/write so that the copy-on-write mechanism still
> works. CPU_USE_DOMAINS gets disabled only if HAS_TLS_REG is defined
> since writing the TLS value to the high vectors page isn't possible.

I don't like this limitation much.

Since the vector page has to be accessed somehow for FIQs anyway, and 
the current solution for that involves accesses through the direct 
mapping of the vector page, then this patch could be made to work on 
pre-ARMv6 systems too simply by adding the necessary cache ops around 
the TLS and FIQ updates.

Or even better: on those VIVT systems, the domain switching could be 
used _only_ when direct modifications to the vector page is performed.

This way, this patch could get a wider base for test coverage.  And this 
could even remove the need for the uaccess_with_memcpy.c hack at some 
point.


Nicolas

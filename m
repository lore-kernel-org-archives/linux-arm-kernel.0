From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 09 Jun 2010 23:26:45 +0100
Subject: [PATCH v2 1/4] ARM: Remove the domain switching on ARMv6k/v7 CPUs
In-Reply-To: <alpine.LFD.2.00.1006091447460.30664@xanadu.home>
References: <20100602164459.17783.9741.stgit@e102109-lin.cambridge.arm.com>
	<20100602164841.17783.94825.stgit@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1006091447460.30664@xanadu.home>
Message-ID: <1276122405.17056.47.camel@toshiba-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-06-09 at 20:10 +0100, Nicolas Pitre wrote:
> Sorry for the delay... I'm just starting to seriously look at this.
> 
> On Wed, 2 Jun 2010, Catalin Marinas wrote:
> 
> > This patch removes the domain switching functionality via the set_fs and
> > __switch_to functions on cores that have a TLS register.
> [...]
> > The user pages access rights are also modified for kernel read-only
> > access rather than read/write so that the copy-on-write mechanism still
> > works. CPU_USE_DOMAINS gets disabled only if HAS_TLS_REG is defined
> > since writing the TLS value to the high vectors page isn't possible.
> 
> I don't like this limitation much.
> 
> Since the vector page has to be accessed somehow for FIQs anyway, and
> the current solution for that involves accesses through the direct
> mapping of the vector page, then this patch could be made to work on
> pre-ARMv6 systems too simply by adding the necessary cache ops around
> the TLS and FIQ updates.

Getting rid of domains in Linux requires that several functions no
longer use LDRT/STRT but LDR/STR. This implies that RO user pages should
also have RO permissions for the kernel. I don't have the old ARM ARM at
hand now but I recall there were some issues with user RO kernel RO
permission on pre-ARMv6 processors (there is an R bit in the CP15
control register which may help, I need to check the documentation).

-- 
Catalin

From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 18 Dec 2009 10:06:23 +0000
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors
In-Reply-To: <20091217193210.GD362@shareable.org>
References: <20091217193210.GD362@shareable.org>
Message-ID: <1261130783.13520.5.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2009-12-17 at 19:32 +0000, Jamie Lokier wrote:
> Leif Lindholm wrote:
> > To correctly deal with copy-on-write, it also modifies
> > cpu_v7_set_pte_ext to change the mappings to priviliged RO when user RO.
> 
> Does this break ptrace writing to RO pages or anything else?
> If it doesn't break anything, seems to me it should always be done
> like that, not conditional on CONFIG_SWP_EMULATE.

ptrace does COW otherwise it would affect other tasks sharing the RO
pages. The only thing  user RO, kernel RW is needed in the kernel is for
the vectors page when a TLS register is not available. This is not the
case for ARMv7, so we can make it unconditional.

BTW, the patches I posted for the revised page table format with
SCTLR.AFE do this already (but I'm not sure when/if they'll go in).

-- 
Catalin

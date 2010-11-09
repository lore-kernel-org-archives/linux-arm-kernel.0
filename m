From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 09 Nov 2010 17:05:16 +0000
Subject: Using non-Global mappings for kernel address space
In-Reply-To: <AANLkTikA2QOaxpc_m3n4aeESno-E63=522=QevTJtCCM@mail.gmail.com>
References: <AANLkTi=f+s4GAKLSESK=WSjxmUDCCvog21z1XxW73nU3@mail.gmail.com>
	<1289236418.3541.117.camel@e102109-lin.cambridge.arm.com>
	<AANLkTi=JDTvMgJZWLiE31=PhOS0D+m+SAFU5mxAR6ZJV@mail.gmail.com>
	<1289252283.26399.45.camel@e102109-lin.cambridge.arm.com>
	<AANLkTikA2QOaxpc_m3n4aeESno-E63=522=QevTJtCCM@mail.gmail.com>
Message-ID: <1289322316.11461.33.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-11-08 at 22:39 +0000, Christoffer Dall wrote:
> On Mon, Nov 8, 2010 at 10:38 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > C-A15 has several features that help with getting full virtualisation.
> > Access to several system registers is trapped in the hypervisor and you
> > can even emulate several CPUs on a single one (or more). There are
> > virtual timers as well.
> 
> Nice. On an SMP system, the virtualization features would be supported
> for each core?

Yes, each core has virtualisation features but the hypervisor needs to
be SMP-aware.

> > At every context switch, Linux checks the ASID of the newly switched in
> > context. If it is from an older generation (top 24 bits of context.id),
> > it allocates a new ASID from the global cpu_last_asid variable. When
> > Linux runs out of ASIDs (bottom 8 bits of cpu_last_asid become 0), it
> > sends an IPI to all the CPUs to reset the ASID counting and flushes the
> > full TLB.
> 
> I still don't see the need for the reserved ASID. Isn't all of this
> taking place in global mappings anyway (without any of my hacks of
> course)? If this is only an SMP issue, I will probably find out once I
> start playing with that. So far my work is based strictly on UP.

On UP, the reserved ASID is used during context switching (switch_mm)
because you cannot set the ASID and TTBR0 at the same time. There is a
small risk of speculative TLB loads and assigning the wrong ASID to
TTBR0. That's why we set the ASID to 0, change TTBR0 and then set the
new ASID.

On SMP, we have a few more reserved ASIDs, one for each CPU. But these
are used only during roll-over event when resetting the ASIDs on all the
active CPUs. We use some reserved number to avoid extra locking on the
global ASID variable.

On C-A15 (with LPAE), the ASID is stored in TTBR0 so we wouldn't need a
reserved ASID for the first case above.

Catalin

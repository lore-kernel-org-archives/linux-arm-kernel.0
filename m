From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 26 Sep 2016 12:01:59 +0100
Subject: [PATCH 5/5] arm64: Add uprobe support
In-Reply-To: <CAHB_GupuUYPNFoYQeX8EhAcesvqKVVuphuxneudZ5kL2cxm-7g@mail.gmail.com>
References: <cover.1470114993.git.panand@redhat.com>
 <abaac6ebaa5dd63889803ec568663bc8c8c65b02.1470114993.git.panand@redhat.com>
 <20160920165946.GA19353@e104818-lin.cambridge.arm.com>
 <20160921110047.GA29470@localhost.localdomain>
 <20160921170403.GE12180@e104818-lin.cambridge.arm.com>
 <20160922032328.GB29470@localhost.localdomain>
 <20160922165030.GA27704@e104818-lin.cambridge.arm.com>
 <20160923041230.GC29470@localhost.localdomain>
 <20160923130528.GE2161@e104818-lin.cambridge.arm.com>
 <CAHB_GupuUYPNFoYQeX8EhAcesvqKVVuphuxneudZ5kL2cxm-7g@mail.gmail.com>
Message-ID: <20160926110159.GB27498@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 25, 2016 at 10:32:28PM +0530, Pratyush Anand wrote:
> On Fri, Sep 23, 2016 at 6:35 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Fri, Sep 23, 2016 at 09:42:30AM +0530, Pratyush Anand wrote:
> >> On 22/09/2016:05:50:30 PM, Catalin Marinas wrote:
> >> > On Thu, Sep 22, 2016 at 08:53:28AM +0530, Pratyush Anand wrote:
> >> > > On 21/09/2016:06:04:04 PM, Catalin Marinas wrote:
> 
> >> > As a quick workaround you could check mm->task_size > TASK_SIZE_32 in
> >> > the arch_uprobe_analyze_insn() function.
> >>
> >> It would be doable. TASK_SIZE_32 is defined only for COMPAT. So, may be I can
> >> return -EINVAL when mm->task_size < TASK_SIZE_64.
> >
> > That's just a temporary workaround. If we ever merge ILP32, this test
> > would no longer be enough (as the ISA is AArch64 but with TASK_SIZE_32).
> 
> OK.. So what about doing something similar what x86 is doing.
> We can have a flag for task Type in arch specific mm_context_t. We
> also set this flag in COMPAT_SET_PERSONALITY() along with setting
> thread_info flag, and we clear them in SET_PERSONALITY().

This looks like a better approach.

> > Looking at prepare_uprobe(), we have a weak is_trap_insn() function.
> > This check is meaningless without knowing which instruction set we
> > target. A false positive here, however, is not that bad as we wouldn't
> > end up inserting the wrong breakpoint in the executable. But it looks to
> > me like the core uprobe code needs to pass some additional information
> > like the type of task or ELF format to the arch code to make a useful
> > choice of breakpoint type.
> 
> It seems that 'strtle r0, [r0], #160' would have the closest matching
> aarch32 instruction wrt BRK64_OPCODE_UPROBES(0xd42000A0). But that too
> seems a bad instruction. So, may be we can use still weak
> is_trap_insn().

Even if the is_trap_insn() check passes, we would reject the probe in
arch_uprobe_analyze_insn() immediately after based on the mm type check,
so not too bad.

If we add support for probing 32-bit tasks, I would rather have
is_trap_insn() take the mm_struct as argument so that a non-weak
implementation can check for the correct encoding.

-- 
Catalin

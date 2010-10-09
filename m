From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 Oct 2010 20:37:57 +0100
Subject: [PATCH 2/2] ftrace - add ftrace function_graph support on ARM
In-Reply-To: <AANLkTi=apGYBSSr4RK+ZZievacJRcOxrwW_o_hz85P0h@mail.gmail.com>
References: <4B91A39F.8050502@am.sony.com>
	<20100306201849.GD13262@n2100.arm.linux.org.uk>
	<AANLkTi=apGYBSSr4RK+ZZievacJRcOxrwW_o_hz85P0h@mail.gmail.com>
Message-ID: <20101009193757.GB28183@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 09, 2010 at 11:20:50PM +0530, Rabin Vincent wrote:
> On Sun, Mar 7, 2010 at 1:48 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Mar 05, 2010 at 04:36:47PM -0800, Tim Bird wrote:
> >> IRQENTRY_TEXT was added to vmlinux.lds.S (to eliminate
> >> a compiler error on kernel/trace/trace_functions_graph.c),
> >> although no routines were marked as __irq_entry.
> >
> > Well, ARM already places the assembly exception text in its own separate
> > section for other reasons. ?We can't place it in two sections.
> >
> > What is __irq_entry used for? ?Just the low level assembly or C functions?
> 
> It's used just for the C entry functions for interrupts: asm_do_IRQ()
> and the IPI and local timer functions.
> 
> AFAICS __exception seems to be used only for is_exception_text().  If
> that's the case, would it be OK to just place those functions in
> __irq_entry if ftrace is built and have is_exception_text() check that
> section too?

No.  is_exception_text() is used to detect those functions which have
a specific stack layout - which is that there's a pt_regs struct on the
stack.  Grouping other functions into that violates the expectation.

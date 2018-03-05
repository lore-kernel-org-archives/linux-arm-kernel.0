From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 5 Mar 2018 11:01:44 +0000
Subject: [PATCH] arm64/debug: Fix registers on sleeping tasks
In-Reply-To: <CAD=FV=U5QFqn3PU_H1rU0KMJBD9yt1FCLJd=E0afGVPg19wgWA@mail.gmail.com>
References: <20180301193803.129195-1-dianders@chromium.org>
 <20180302180131.GA20579@arm.com>
 <20180302181636.a2nqgm4ezrbcdxkc@lakrids.cambridge.arm.com>
 <CAD=FV=U5QFqn3PU_H1rU0KMJBD9yt1FCLJd=E0afGVPg19wgWA@mail.gmail.com>
Message-ID: <20180305110143.nfffbftqplrba7wu@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2018 at 10:45:25AM -0800, Doug Anderson wrote:
> Hi,
> 
> On Fri, Mar 2, 2018 at 10:16 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Fri, Mar 02, 2018 at 06:01:31PM +0000, Will Deacon wrote:
> >> On Thu, Mar 01, 2018 at 11:38:03AM -0800, Douglas Anderson wrote:

> >> >     /* Initialize to zero */
> >> >     memset((char *)gdb_regs, 0, NUMREGBYTES);
> >> > -   thread_regs = task_pt_regs(task);
> >> > -   memcpy((void *)gdb_regs, (void *)thread_regs->regs, GP_REG_BYTES);
> >> > -   /* Special case for PSTATE (check comments in asm/kgdb.h for details) */
> >> > -   dbg_get_reg(33, gdb_regs + GP_REG_BYTES, thread_regs);
> >> > +
> >> > +   gdb_regs[19] = cpu_context->x19;
> >> > +   gdb_regs[20] = cpu_context->x20;
> >> > +   gdb_regs[21] = cpu_context->x21;
> >> > +   gdb_regs[22] = cpu_context->x22;
> >> > +   gdb_regs[23] = cpu_context->x23;
> >> > +   gdb_regs[24] = cpu_context->x24;
> >> > +   gdb_regs[25] = cpu_context->x25;
> >> > +   gdb_regs[26] = cpu_context->x26;
> >> > +   gdb_regs[27] = cpu_context->x27;
> >> > +   gdb_regs[28] = cpu_context->x28;
> >> > +   gdb_regs[29] = cpu_context->fp;
> >> > +
> >> > +   gdb_regs[31] = cpu_context->sp;
> >> > +   gdb_regs[32] = cpu_context->pc;
> >
> > Are the other reg fields initialised elsewhere?
> >
> > We might want to zero them here.
> 
> Isn't that covered by the the "/* Initialize to zero */" comment and
> and "memset((char *)gdb_regs, 0, NUMREGBYTES);"

I'd misread the patch and thought that was part of the deleted lines.

That looks fine, then.

Mark.

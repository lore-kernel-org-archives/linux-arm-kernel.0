From: will.deacon@arm.com (Will Deacon)
Date: Thu, 3 Dec 2015 11:48:24 +0000
Subject: [PATCH] arm64: ftrace: stop using kstop_machine to
 enable/disable tracing
In-Reply-To: <56600DEC.7050703@huawei.com>
References: <1448697009-17211-1-git-send-email-huawei.libin@huawei.com>
 <20151202123654.GC4523@arm.com> <20151202131659.GA5621@arm.com>
 <56600DEC.7050703@huawei.com>
Message-ID: <20151203114823.GC11337@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2015 at 05:39:56PM +0800, libin wrote:
> on 2015/12/2 21:16, Will Deacon wrote:
> > On Wed, Dec 02, 2015 at 12:36:54PM +0000, Will Deacon wrote:
> >> On Sat, Nov 28, 2015 at 03:50:09PM +0800, Li Bin wrote:
> >>> On arm64, kstop_machine which is hugely disruptive to a running
> >>> system is not needed to convert nops to ftrace calls or back,
> >>> because that modifed code is a single 32bit instructions which
> >>> is impossible to cross cache (or page) boundaries, and the used str
> >>> instruction is single-copy atomic.
> >> This commit message is misleading, since the single-copy atomicity
> >> guarantees don't apply to the instruction-side. Instead, the architecture
> >> calls out a handful of safe instructions in "Concurrent modification and
> >> execution of instructions".
> >>
> >> Now, those safe instructions *do* include NOP, B and BL, so that should
> >> be sufficient for ftrace provided that we don't patch condition codes
> >> (and I don't think we do).
> > Thinking about this some more, you also need to fix the validate=1 case
> > in ftrace_modify_code so that it can run outside of stop_machine. We
> > currently rely on that to deal with concurrent modifications (e.g.
> > module unloading).
> 
> I'm not sure it is really a problem, but on x86, which using breakpoints method,
> add_break() that run outside of stop_machine also has similar code.

Yeah, having now read through that, I also can't see any locking issues.
We should remove the comment suggesting otherwise.

> static int add_break(unsigned long ip, const char *old)
> {
>         unsigned char replaced[MCOUNT_INSN_SIZE];
>         unsigned char brk = BREAKPOINT_INSTRUCTION;
> 
>         if (probe_kernel_read(replaced, (void *)ip, MCOUNT_INSN_SIZE))
>                 return -EFAULT;
> 
>         /* Make sure it is what we expect it to be */
>         if (memcmp(replaced, old, MCOUNT_INSN_SIZE) != 0)
>                 return -EINVAL;
> 
>         return ftrace_write(ip, &brk, 1);
> }
> 
> Or I misunderstand what you mean?

Hmm, so this should all be fine if we exclusively use the probe_kernel_*
functions and handle the -EFAULT gracefully. Now, that leaves an
interesting scenario with the flush_icache_range call in
aarch64_insn_patch_text_nosync, since that's not run with
KERNEL_DS/pagefault_disable() and so we'll panic if the text disappears
underneath us.

So we probably need to add that code and call __flush_cache_user_range
instead.

What do you think?

Will

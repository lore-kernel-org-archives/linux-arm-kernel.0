From: will.deacon@arm.com (Will Deacon)
Date: Thu, 16 Aug 2012 11:47:48 +0100
Subject: [PATCH v2 23/31] arm64: Debugging support
In-Reply-To: <201208151507.36174.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-24-git-send-email-catalin.marinas@arm.com>
 <201208151507.36174.arnd@arndb.de>
Message-ID: <20120816104748.GI31784@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2012 at 04:07:36PM +0100, Arnd Bergmann wrote:
> On Tuesday 14 August 2012, Catalin Marinas wrote:
> 
> > +const struct user_regset_view *task_user_regset_view(struct task_struct *task)
> > +{
> > +#ifdef CONFIG_AARCH32_EMULATION
> > +	if (test_tsk_thread_flag(task, TIF_32BIT))
> > +		return &user_aarch32_view;
> > +#endif
> > +	return &user_aarch64_view;
> > +}
> 
> Ah, nice. So you support 64 bit debuggers debugging 32 bit processes, right?

That should work if the debugger can deal with it, yes.

> From what I can tell, there is no support for 32 bit processes debugging
> 64 bit ones. Is that something you plan to add in the future, or do you
> consider that out of scope? In either case, a comment would be helpful.

That can't really work because the debugger won't be able to manipulate
child pointers properly without us adding a new ptrace interface (and then,
I still wonder about how feasible it really is). I can add a comment.

> > +long arch_ptrace(struct task_struct *child, long request,
> > +		 unsigned long addr, unsigned long data)
> > +{
> > +	int ret;
> > +	unsigned long *datap = (unsigned long __user *)data;
> > +
> > +	switch (request) {
> > +		case PTRACE_GET_THREAD_AREA:
> > +			ret = put_user(child->thread.tp_value, datap);
> > +			break;
> > +
> > +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> > +		case PTRACE_GETHBPREGS:
> > +			ret = ptrace_gethbpregs(child, addr, datap);
> > +			break;
> > +
> > +		case PTRACE_SETHBPREGS:
> > +			ret = ptrace_sethbpregs(child, addr, datap);
> > +			break;
> > +#endif
> > +
> > +		default:
> > +			ret = ptrace_request(child, request, addr, data);
> > +			break;
> > +	}
> > +
> > +	return ret;
> > +}
> 
> Is there a reaons why these are not regsets but have their own ptrace
> commands? I believe new architectures should generally not add ptrace
> commands any more.

I could probably add some regset wrappers about the hbp accessors (which we
have to keep for the compat ptrace interface). I'll have a think as it might
even make sense to have different regsets for breakpoints and watchpoints.

As for the the tls, is it worth having a regset with only one register?

Will

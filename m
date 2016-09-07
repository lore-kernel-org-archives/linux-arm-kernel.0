From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 7 Sep 2016 14:41:21 +0100
Subject: [PATCH 3/5] arm64: Handle TRAP_HWBRKPT for user mode as well
In-Reply-To: <57CF36D2.4010404@linaro.org>
References: <cover.1470114993.git.panand@redhat.com>
 <ebc25cc4a2ea95cace064aa1c3a2407885623d16.1470114993.git.panand@redhat.com>
 <20160906161139.GG19605@e104818-lin.cambridge.arm.com>
 <57CF36D2.4010404@linaro.org>
Message-ID: <20160907134120.7bjzgk3f2ntvl3qy@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 05:36:18PM -0400, David Long wrote:
> On 09/06/2016 12:11 PM, Catalin Marinas wrote:
> > On Tue, Aug 02, 2016 at 11:00:07AM +0530, Pratyush Anand wrote:
> > > --- a/arch/arm64/kernel/debug-monitors.c
> > > +++ b/arch/arm64/kernel/debug-monitors.c
> > > @@ -246,6 +246,8 @@ static void send_user_sigtrap(int si_code)
> > >   static int single_step_handler(unsigned long addr, unsigned int esr,
> > >   			       struct pt_regs *regs)
> > >   {
> > > +	bool handler_found = false;
> > > +
> > >   	/*
> > >   	 * If we are stepping a pending breakpoint, call the hw_breakpoint
> > >   	 * handler first.
> > > @@ -253,7 +255,14 @@ static int single_step_handler(unsigned long addr, unsigned int esr,
> > >   	if (!reinstall_suspended_bps(regs))
> > >   		return 0;
> > > 
> > > -	if (user_mode(regs)) {
> > > +#ifdef	CONFIG_KPROBES
> > > +	if (kprobe_single_step_handler(regs, esr) == DBG_HOOK_HANDLED)
> > > +		handler_found = true;
> > > +#endif
> > > +	if (!handler_found && call_step_hook(regs, esr) == DBG_HOOK_HANDLED)
> > > +		handler_found = true;
> > > +
> > > +	if (!handler_found && user_mode(regs)) {
> > >   		send_user_sigtrap(TRAP_HWBKPT);
> > 
> > Could we register kprobe_single_step_handler() via register_set_hook()
> > and only invoke call_step_hook() above?
> 
> I seem to recall a criticism of doing that in a much earlier kprobes64 patch
> of mine.  The concern was that it would cause unnecessarily more kernel
> functions to be kprobes-blacklisted.  Hence the hardcoded check and call.

Ah, ok. I missed this aspect.

-- 
Catalin

From: will.deacon@arm.com (Will Deacon)
Date: Tue, 11 Jun 2013 19:29:27 +0100
Subject: [PATCH] ARM: decouple CPU offlining from reboot/shutdown
In-Reply-To: <51B767A8.7000506@wwwdotorg.org>
References: <1370887961-31569-1-git-send-email-swarren@wwwdotorg.org>
 <20130611172342.GJ3439@mudshark.cambridge.arm.com>
 <51B767A8.7000506@wwwdotorg.org>
Message-ID: <20130611182927.GP3439@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 07:08:40PM +0100, Stephen Warren wrote:
> On 06/11/2013 11:23 AM, Will Deacon wrote:
> > On Mon, Jun 10, 2013 at 07:12:41PM +0100, Stephen Warren wrote:
> >> From: Stephen Warren <swarren@nvidia.com>
> >>
> >> machine_shutdown() is a hook for kexec. Add a comment saying so, since
> >> it isn't obvious from the function name.
> > 
> > I'd go as far as saying that some of this commit log could be included in
> > the comment too, since this comes up time and time again and it's never
> > clear!
> 
> OK, I'll add some expanded comments to each of the functions.

Great, cheers.

> >> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> 
> >> @@ -97,13 +97,14 @@ void soft_restart(unsigned long addr)
> >>  {
> >>  	u64 *stack = soft_restart_stack + ARRAY_SIZE(soft_restart_stack);
> >>  
> >> +	BUG_ON(num_online_cpus() > 1);
> > 
> > I think this is overkill, and we could actually scream and try to return an
> > error here (we've not yet switched stack, and the upper layers of kexec look
> > like they can do something with an error code).
> 
> Hmmm. The function returns void, although I suppose I could look into
> changing that too?

Yes. Usually this is a path of no return, but if we detect an error before
we've changed stack then I think we should at least try to propogate the
error.

> >> +/* For kexec */
> >>  void machine_shutdown(void)
> >>  {
> >> -#ifdef CONFIG_SMP
> >> -	smp_send_stop();
> >> +#ifdef CONFIG_PM_SLEEP_SMP
> >> +	disable_nonboot_cpus();
> >>  #endif
> > 
> > You can lose the #ifdef here.
> 
> The implementation of disable_nonboot_cpus() is #ifdef
> CONFIG_PM_SLEEP_SMP, so I think I need that to avoid build errors.

Hmm, my include/linux/cpu.h has a dummy definition in an #else block, which
simply returns 0. What kernel are you using?

> >> +	BUG_ON(num_online_cpus() > 1);
> > 
> > Maybe redefine machine_shutdown if !kexec and lose this BUG?
> 
> IIUC, machine_shutdown() is only used for kexec now, so I don't think an
> alternative implementation is required in the !kexec case?

Yes, you're right. In fact, since we don't support KEXEC_JUMP on ARM, we
could dispense with machine_shutdown altogether (just make it do nothing)
and move the code into machine_kexec, which has a much better name.

What do you think?

Will

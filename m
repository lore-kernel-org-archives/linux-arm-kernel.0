From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Mar 2017 13:44:56 +0000
Subject: [PATCH v2 1/4] syscalls: Restore address limit after a syscall
In-Reply-To: <20170309120955.GA6320@leverpostej>
References: <20170309012456.5631-1-thgarnie@google.com>
 <20170309120955.GA6320@leverpostej>
Message-ID: <20170309134456.GI21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 09, 2017 at 12:09:55PM +0000, Mark Rutland wrote:
> Hi,
> 
> On Wed, Mar 08, 2017 at 05:24:53PM -0800, Thomas Garnier wrote:
> > This patch ensures a syscall does not return to user-mode with a kernel
> > address limit. If that happened, a process can corrupt kernel-mode
> > memory and elevate privileges.
> > 
> > For example, it would mitigation this bug:
> > 
> > - https://bugs.chromium.org/p/project-zero/issues/detail?id=990
> > 
> > If the CONFIG_BUG_ON_DATA_CORRUPTION option is enabled, an incorrect
> > state will result in a BUG_ON.
> > 
> > The CONFIG_ARCH_NO_SYSCALL_VERIFY_PRE_USERMODE_STATE option is also
> > added so each architecture can optimize this change.
> 
> > +#ifndef CONFIG_ARCH_NO_SYSCALL_VERIFY_PRE_USERMODE_STATE
> > +static inline bool has_user_ds(void) {
> > +	bool ret = segment_eq(get_fs(), USER_DS);
> > +	// Prevent re-ordering the call
> > +	barrier();
> 
> What ordering are we trying to ensure, that isn't otherwise given?
> 
> We expect get_fs() and set_fs() to be ordered w.r.t. each other and
> w.r.t. uaccess uses, or we'd need barriers all over the place.
> 
> Given that, I can't see why we need a barrier here. So this needs a
> better comment, at least.
> 
> > +	return ret;
> > +}
> > +#else
> > +static inline bool has_user_ds(void) {
> > +	return false;
> > +}
> > +#endif
> 
> It would be simpler to wrap the call entirely, e.g. have:
> 
> #ifdef CONFIG_WHATEVER
> static inline void verify_pre_usermode_state(void)
> {
> 	if (segment_eq(get_fs(), USER_DS))
> 		__verify_pre_usermode_state();
> }
> #else
> static inline void verify_pre_usermode_state(void) { }
> #endif

That's utterly pointless - you've missed a detail.

> > @@ -199,7 +215,10 @@ extern struct trace_event_functions exit_syscall_print_funcs;
> >  	asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
> >  	asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
> >  	{								\
> > +		bool user_caller = has_user_ds();			\
> >  		long ret = SYSC##name(__MAP(x,__SC_CAST,__VA_ARGS__));	\
> > +		if (user_caller)					\
> > +			verify_pre_usermode_state();			\
> 
> ... then we can unconditionally use verify_pre_usermode_state() here ... 

Look at this closely.  has_user_ds() is called _before_ the syscall code
is invoked.  It's checking what conditions the syscall was entered from.
If the syscall was entered with the user segment selected, then we run
a check on the system state _after_ the syscall code has returned.

Putting both after the syscall code has returned is completely pointless -
it turns it into this code:

	if (segment_eq(get_fs(), USER_DS))
		if (CHECK_DATA_CORRUPTION(!segment_eq(get_fs(), USER_DS),
					  "incorrect get_fs() on user-mode return"))
			set_fs(USER_DS);

which is obviously bogus (it'll never fire.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

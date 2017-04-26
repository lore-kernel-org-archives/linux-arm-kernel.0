From: mingo@kernel.org (Ingo Molnar)
Date: Wed, 26 Apr 2017 10:12:29 +0200
Subject: [PATCH v7 1/4] syscalls: Restore address limit after a syscall
In-Reply-To: <CAJcbSZH7Y6iBy3T3iWyh_AaFJ+TidP7E9iQEuCbShQrcTKGoyw@mail.gmail.com>
References: <20170410164420.64003-1-thgarnie@google.com>
 <20170425063305.hwjuxupa37rwe6zj@gmail.com>
 <CAJcbSZH7Y6iBy3T3iWyh_AaFJ+TidP7E9iQEuCbShQrcTKGoyw@mail.gmail.com>
Message-ID: <20170426081229.6wnugrs7w3at4xry@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Thomas Garnier <thgarnie@google.com> wrote:

> >> +#ifdef CONFIG_ARCH_NO_SYSCALL_VERIFY_PRE_USERMODE_STATE
> >> +/*
> >> + * This function is called when an architecture specific implementation detected
> >> + * an invalid address limit. The generic user-mode state checker will finish on
> >> + * the appropriate BUG_ON.
> >> + */
> >> +asmlinkage void address_limit_check_failed(void)
> >> +{
> >> +     verify_pre_usermode_state();
> >> +     panic("address_limit_check_failed called with a valid user-mode state");
> >
> > It's very unconstructive to unconditionally panic the system, just because some
> > kernel code leaked the address limit! Do a warn-once printout and kill the current
> > task (i.e. don't continue execution), but don't crash everything else!
> 
> The original change did not crash the kernel for this exact reason.
> Through reviews, there was an overall agreement that the kernel should
> not continue in this state.

Ok, I guess we can try that - but the panic message is still pretty misleading:

	panic("address_limit_check_failed called with a valid user-mode state");

... so it was called with a _valid_ user-mode state, and we crash due to something 
valid? Huh?

( Also, the style rule applies to kernel messages as well: function names should 
  be referred to as "function_name()". )

Thanks,

	Ingo

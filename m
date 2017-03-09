From: thgarnie@google.com (Thomas Garnier)
Date: Thu, 9 Mar 2017 07:54:40 -0800
Subject: [PATCH v2 1/4] syscalls: Restore address limit after a syscall
In-Reply-To: <20170309152144.GA11966@leverpostej>
References: <20170309012456.5631-1-thgarnie@google.com>
 <20170309120955.GA6320@leverpostej>
 <20170309134456.GI21222@n2100.armlinux.org.uk>
 <20170309152144.GA11966@leverpostej>
Message-ID: <CAJcbSZHQnS+THRy3B+OmZAotjC4CW-giv+i+YJKF36wOgSZtYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 9, 2017 at 7:21 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Mar 09, 2017 at 01:44:56PM +0000, Russell King - ARM Linux wrote:
>> On Thu, Mar 09, 2017 at 12:09:55PM +0000, Mark Rutland wrote:
>> > On Wed, Mar 08, 2017 at 05:24:53PM -0800, Thomas Garnier wrote:
>
>> > It would be simpler to wrap the call entirely, e.g. have:
>> >
>> > #ifdef CONFIG_WHATEVER
>> > static inline void verify_pre_usermode_state(void)
>> > {
>> >     if (segment_eq(get_fs(), USER_DS))
>> >             __verify_pre_usermode_state();
>> > }
>> > #else
>> > static inline void verify_pre_usermode_state(void) { }
>> > #endif
>>
>> That's utterly pointless - you've missed a detail.
>>
>> > > @@ -199,7 +215,10 @@ extern struct trace_event_functions exit_syscall_print_funcs;
>> > >   asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__));      \
>> > >   asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))       \
>> > >   {                                                               \
>> > > +         bool user_caller = has_user_ds();                       \
>> > >           long ret = SYSC##name(__MAP(x,__SC_CAST,__VA_ARGS__));  \
>> > > +         if (user_caller)                                        \
>> > > +                 verify_pre_usermode_state();                    \
>> >
>> > ... then we can unconditionally use verify_pre_usermode_state() here ...
>>
>> Look at this closely.  has_user_ds() is called _before_ the syscall code
>> is invoked.  It's checking what conditions the syscall was entered from.
>> If the syscall was entered with the user segment selected, then we run
>> a check on the system state _after_ the syscall code has returned.
>
> Indeed; I clearly did not consider this correctly.
>
> Sorry for the noise.
>

No problem, I missed that reply so discard my question on the email
few seconds ago.

> Thanks,
> Mark.



-- 
Thomas

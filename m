From: wade_farnsworth@mentor.com (Wade Farnsworth)
Date: Mon, 20 Feb 2012 11:08:57 -0700
Subject: ARM tracehook support
In-Reply-To: <20120220154748.GG25462@mudshark.cambridge.arm.com>
References: <4F4268D5.7070103@mentor.com>
 <20120220154748.GG25462@mudshark.cambridge.arm.com>
Message-ID: <4F428C39.40906@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon wrote:
> On Mon, Feb 20, 2012 at 03:37:57PM +0000, Wade Farnsworth wrote:
>> Hi all,
>
> Hello Wade,
>
>> A few months back, Steven Walter posted some patches that implemement
>> syscall tracing support for ARM:
>>
>> http://lists.arm.linux.org.uk/lurker/message/20111129.162812.bd17d9b5.en.html#linux-arm-kernel
>>
>> I've been working on SystemTap support for ARM, and the tracehook patch
>> in particular is interesting in that respect.  With that patch applied,
>> it would allow utrace to be supported on ARM, which is necessary for
>> userspace stap probes to function properly.
>>
>>   From what testing I've done, the patches don't appear to be harmful.
>> So, I'm wondering what's preventing this from being pushed into
>> mainline?  Are there still outstanding issues that need to be addressed?
>
> Yup, I posted some questions here:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-December/074802.html

OK, so to continue that conversation:

Will Deacon wrote:
 > On Wed, Nov 30, 2011 at 02:46:20PM +0000, Steven Walter wrote:
 >> +static inline void syscall_get_arguments(struct task_struct *task,
 >> +					 struct pt_regs *regs,
 >> +					 unsigned int i, unsigned int n,
 >> +					 unsigned long *args)
 >> +{
 >> +	BUG_ON(i + n > 6);
 >
 > So I guess 6 is the maximum number of registers that are used for
 > syscall passing. That sounds about right to me, but I wondered how
 > you worked it out (and whether or not it should be defined
 > somewhere?).

I believe the 6 argument constraint is a specific to 
syscall_get_arguments().  Notice the comment in 
include/asm-generic/syscall.h:

/*
[...]
  *
  * It's only valid to call this when @task is stopped for tracing on
  * entry to a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
  * It's invalid to call this with @i + @n > 6; we only support system calls
  * taking up to 6 arguments.
  */

Additionally, if you'll look at the other architectures' implementations 
you'll see similar code.

 > In fact, how are these things supposed to deal with 64-bit arguments
 > that straddle two registers? I think we always pack arguments such
 > that we don't get holes in the register layout, but it might be worth 
 > checking (EABI requires 64-bit arguments to be passed in even
 > registers).

Hmm, I do believe that 32-bit powerpc has similar alignment issues 
(64-bit args must be passed in odd/even pairs), but I don't see any 
special handling of this in that architecture's 
syscall_get/set_arguments().  So I'm wondering if the handling of this 
is or should be handled elsewhere.  I'll keep digging on this.

>
> but I haven't heard anything from Steven since then, so it's all stalled at
> the moment. They'll also obviously need rebasing onto latest mainline,
> although that shouldn't be too hard since they're still fairly recent.
>

Yes, it does not appear to be too difficult.  I've already made some 
progress here, and will post my patches once the other issues have been 
resolved.

Thanks again,

-Wade

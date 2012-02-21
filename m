From: wade_farnsworth@mentor.com (Wade Farnsworth)
Date: Tue, 21 Feb 2012 11:08:46 -0700
Subject: ARM tracehook support
In-Reply-To: <20120221172750.GA1774@n2100.arm.linux.org.uk>
References: <4F4268D5.7070103@mentor.com>
 <20120220154748.GG25462@mudshark.cambridge.arm.com>
 <4F428C39.40906@mentor.com> <20120221172750.GA1774@n2100.arm.linux.org.uk>
Message-ID: <4F43DDAE.2080800@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Mon, Feb 20, 2012 at 11:08:57AM -0700, Wade Farnsworth wrote:
>> Will Deacon wrote:
>>> On Wed, Nov 30, 2011 at 02:46:20PM +0000, Steven Walter wrote:
>>>> +static inline void syscall_get_arguments(struct task_struct *task,
>>>> +					 struct pt_regs *regs,
>>>> +					 unsigned int i, unsigned int n,
>>>> +					 unsigned long *args)
>>>> +{
>>>> +	BUG_ON(i + n>  6);
>>>
>>> So I guess 6 is the maximum number of registers that are used for
>>> syscall passing. That sounds about right to me, but I wondered how
>>> you worked it out (and whether or not it should be defined
>>> somewhere?).
>>
>> I believe the 6 argument constraint is a specific to
>> syscall_get_arguments().  Notice the comment in
>> include/asm-generic/syscall.h:
>
> Well, there's two things here.  Is a BUG_ON() really suitable here?
> What controls how many arguments are fetched?  Userspace?

Yeah, it could be userspace, or a kernel tracer such as ftrace.

> If so, that's
> a nice way to oops the kernel.

I agree that a BUG_ON is probably not ideal, though I note that the 
other arch's tend to BUG as well.  Since there's no way to return an 
error from this function, what if we just used a pr_warning() and 
backfill the bogus elements of args[] with zero?

>
> Secondly, there is a 7 argument syscall - sys_syscall, which we use on
> OABI to deal with calling a syscall by number.  That really does show
> up as a unique syscall there, so if you want to parse the last argument
> to such a syscall you need to be able to read up to and including ARM
> register 7.

I think we can change it to allow up to 7 arguments in this function 
easily enough.  I think changing the tracers to support an additional 
argument should be done separatels from this patchset, however.

>
>> /*
>> [...]
>>   *
>>   * It's only valid to call this when @task is stopped for tracing on
>>   * entry to a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
>>   * It's invalid to call this with @i + @n>  6; we only support system calls
>>   * taking up to 6 arguments.
>>   */
>>
>> Additionally, if you'll look at the other architectures' implementations
>> you'll see similar code.
>>
>>> In fact, how are these things supposed to deal with 64-bit arguments
>>> that straddle two registers? I think we always pack arguments such
>>> that we don't get holes in the register layout, but it might be worth
>>> checking (EABI requires 64-bit arguments to be passed in even
>>> registers).
>>
>> Hmm, I do believe that 32-bit powerpc has similar alignment issues
>> (64-bit args must be passed in odd/even pairs), but I don't see any
>> special handling of this in that architecture's
>> syscall_get/set_arguments().  So I'm wondering if the handling of this
>> is or should be handled elsewhere.  I'll keep digging on this.
>
> I did point that issue out when it first came up, and I think Roland had
> an answer for it, though I forget what it was.

Yes, see my other mail for a link to Roland's answer.

>
> The big stumbling block to this is OABI, and as I continue to be wholely
> OABI based here, it's extremely important that nothing in OABI land gets
> broken.  I don't see there's any chance of me ever getting off OABI given
> the range of platforms I have, and the restriction that EABI was designed
> to be impossible on ARMv4 architectures.

Right, I think most if not all of the issues w.r.t. OABI that were 
present in Steven's original patches have been ironed out.

I'll post the patches once I've addressed the current crop of concerns.

Thanks, Russell and Will, for the comments.

-Wade

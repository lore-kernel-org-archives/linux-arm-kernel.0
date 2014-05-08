From: anurag19aggarwal@gmail.com (Anurag Aggarwal)
Date: Thu, 8 May 2014 08:57:39 +0530
Subject: [PATCH v2] ARM: unwinder: Fix handling of 'fp' in thumb2 mode
In-Reply-To: <5368a5a3.4115e00a.3773.ffffd789SMTPIN_ADDED_BROKEN@mx.google.com>
References: <1399045056-26751-1-git-send-email-Nikolay.Borisov@arm.com>
 <CAPoNrtvm18NVj7SKJBs01g2wWggC13Gd2eOoTJOKoOQqQCE7hA@mail.gmail.com>
 <5368a5a3.4115e00a.3773.ffffd789SMTPIN_ADDED_BROKEN@mx.google.com>
Message-ID: <CAPoNrtu-zKhJhtQdJ1KYf_wh8faBv7piSZ3aULVoKH0sj4mTzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The test cases seems good, although I haven't been able to verify them myself.
Other than that everything seems good.

On Tue, May 6, 2014 at 2:32 PM, Nikolay Borisov <nikolay.borisov@arm.com> wrote:
> Hi,
>> -----Original Message-----
>> From: Anurag Aggarwal [mailto:anurag19aggarwal at gmail.com]
>> Sent: 03 May 2014 07:57
>> To: Nikolay Borisov
>> Cc: linux-arm-kernel at lists.infradead.org; Dave P Martin; Catalin
>> Marinas
>> Subject: Re: [PATCH v2] ARM: unwinder: Fix handling of 'fp' in thumb2
>> mode
>>
>> Seems good.
>>
>> I would like to know what kind of testing you have done that for this,
>> Other than that you can add my review statement
>>
>
> Without this patch if you use the magic sysrq to print backtrace of all
> the running tasks in the system those that are sleeping would not print
> a backtrace. With the patch this works correctly. Another case where you
> can observe the change is in the invocation of the "ps -Al" which shows
> (among other things) which function the sleeping task is blocked in.
>
>> On Fri, May 2, 2014 at 9:07 PM, Nikolay Borisov
>> <Nikolay.Borisov@arm.com> wrote:
>> > The thread_save_fp macro has been defined so that it always reads the
>> fp member
>> > of the cpu_context_save struct. However, in the case of THUMB2 the fp
>> is saved
>> > not in the fp (r11) member but rather in r7.
>> >
>> > This patch changes the way the macro is defined such that FP is read
>> from the
>> > correct place depending on whether we are a THUMB2 kernel or not.
>> This enables
>> > the backtrace in sitaution such as "echo t > /proc/sysrq-trigger" or
>> the
>> > function in which a process sleeping when "ps -Al" is invoked.
>> >
>> > Another place where similar change is requried is when working with
>> pt_reg.
>> > regs->ARM_fp is defined such that r11 is always referenced as the
>> frame pointer,
>> > so the definition of ARM_fp needs to change depending on the type of
>> kernel we
>> > are running.
>> >
>> > Changes since v1:
>> > * Added changes for the pt_reg structure.
>> >
>> > Signed-off-by: Nikolay Borisov <Nikolay.Borisov@arm.com>
>>
>> Reviewed-by: Anurag Aggarwal <anurag19aggarwal@gmail.com>
>>
>> >
>> > handle the case when we've got regs present
>> > ---
>> >  arch/arm/include/asm/thread_info.h | 6 ++++++
>> >  arch/arm/include/uapi/asm/ptrace.h | 4 ++++
>> >  2 files changed, 10 insertions(+)
>> >
>> > diff --git a/arch/arm/include/asm/thread_info.h
>> b/arch/arm/include/asm/thread_info.h
>> > index f989d7c..e4e4208 100644
>> > --- a/arch/arm/include/asm/thread_info.h
>> > +++ b/arch/arm/include/asm/thread_info.h
>> > @@ -114,8 +114,14 @@ static inline struct thread_info
>> *current_thread_info(void)
>> >         ((unsigned long)(task_thread_info(tsk)->cpu_context.pc))
>> >  #define thread_saved_sp(tsk)   \
>> >         ((unsigned long)(task_thread_info(tsk)->cpu_context.sp))
>> > +
>> > +#ifndef CONFIG_THUMB2_KERNEL
>> >  #define thread_saved_fp(tsk)   \
>> >         ((unsigned long)(task_thread_info(tsk)->cpu_context.fp))
>> > +#else
>> > +#define thread_saved_fp(tsk)   \
>> > +       ((unsigned long)(task_thread_info(tsk)->cpu_context.r7))
>> > +#endif
>> >
>> >  extern void crunch_task_disable(struct thread_info *);
>> >  extern void crunch_task_copy(struct thread_info *, void *);
>> > diff --git a/arch/arm/include/uapi/asm/ptrace.h
>> b/arch/arm/include/uapi/asm/ptrace.h
>> > index 5af0ed1..92e1bae 100644
>> > --- a/arch/arm/include/uapi/asm/ptrace.h
>> > +++ b/arch/arm/include/uapi/asm/ptrace.h
>> > @@ -131,7 +131,11 @@ struct pt_regs {
>> >  #define ARM_lr         uregs[14]
>> >  #define ARM_sp         uregs[13]
>> >  #define ARM_ip         uregs[12]
>> > +#ifndef CONFIG_THUMB2_KERNEL
>> >  #define ARM_fp         uregs[11]
>> > +#else
>> > +#define ARM_fp         uregs[7]
>> > +#endif
>> >  #define ARM_r10                uregs[10]
>> >  #define ARM_r9         uregs[9]
>> >  #define ARM_r8         uregs[8]
>> > --
>> > 1.8.1.5
>> >
>> >
>
>
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Anurag Aggarwal

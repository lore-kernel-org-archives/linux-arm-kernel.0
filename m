From: nalajala.murali@gmail.com (Murali N)
Date: Mon, 6 Jan 2014 01:18:28 +0530
Subject: [PATCH] arm: vfp: always clear vfp_current_hw_state when forcing
 reload
In-Reply-To: <CAFUV4K3tB4zD-J+-JKLckoTAJpYUqGmZ6zxEJa3wn=yzLEJZjA@mail.gmail.com>
References: <1380751187-11257-1-git-send-email-zyy@motorola.com>
 <20131002221123.GC12758@n2100.arm.linux.org.uk>
 <CAFUV4K3dsVDtHhQtuZ6yEQHxxHXaa9LODBZuGFipjAKumF4abQ@mail.gmail.com>
 <CAFUV4K1CkzGZVEwkXGX38jG0HxerqQq--d-qFiqF9J6wi88xYQ@mail.gmail.com>
 <20131011120729.GW25034@n2100.arm.linux.org.uk>
 <CAFUV4K3de3p9jP1Oo=cafEuu64YmEzBXrAiiRWUauy0VeCEQ5w@mail.gmail.com>
 <20131011162650.GX25034@n2100.arm.linux.org.uk>
 <CAFUV4K3ANiEftwRhqT+WXfeTnLPgGvjqQP3OYgDAxMa6qVup3A@mail.gmail.com>
 <CAFUV4K3tB4zD-J+-JKLckoTAJpYUqGmZ6zxEJa3wn=yzLEJZjA@mail.gmail.com>
Message-ID: <CAF0TxbqoqEWmyn4jO=a7fbkcSzU1NZ4yyY5qBT2Mp4rg144_6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 13, 2013 at 11:02 AM, Yuanyuan ZHONG <zyy@motorola.com> wrote:
> On Fri, Oct 11, 2013 at 1:08 PM, Yuanyuan ZHONG <zyy@motorola.com> wrote:
>> On Fri, Oct 11, 2013 at 11:26 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>> On Fri, Oct 11, 2013 at 11:12:19AM -0500, Yuanyuan ZHONG wrote:
>>>> On Fri, Oct 11, 2013 at 7:07 AM, Russell King - ARM Linux
>>>> <linux@arm.linux.org.uk> wrote:
>>>> > On Thu, Oct 10, 2013 at 11:00:18AM -0500, Yuanyuan ZHONG wrote:
>>>> >> Hi Russell, et al
>>>> >>
>>>> >> If there is no further comments, I'll submit it to patch system.
>>>> >> Thanks.
>>>> >
>>>> > No, I still don't agree with your patch as being the correct fix.  Look
>>>> > at the code that you're creating:
>>>> >
>>>> >         if (vfp_state_in_hw(cpu, thread)) {
>>>> >                 fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
>>>> >                 vfp_current_hw_state[cpu] = NULL;
>>>> >         }
>>>> > #ifdef CONFIG_SMP
>>>> >         thread->vfpstate.hard.cpu = NR_CPUS;
>>>> >         vfp_current_hw_state[cpu] = NULL;
>>>> > #endif
>>>> >
>>>> > So when SMP is enabled we unconditionally blat out the vfp_current_hw_state
>>>> > pointer for this CPU?
>>>>
>>>> I think ensuring local vfp_current_hw_state is invalidated is what
>>>> vfp_force_reload() need to do when SMP is enabled.
>>>
>>> vfp_force_reload() is about asking for the state S on CPU N to be
>>> reloaded.  It is not about merely asking for the state on CPU N to
>>> be reloaded.
>>
>> Then this function cannot do what we need for cpu hotplug. At that
>> time we don't know if the state S on CPU N is valid, we can only ask
>> for the state on CPU N to be reloaded. How about this:
>>
>> diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
>> index 52b8f40..efdd9e0 100644
>> --- a/arch/arm/vfp/vfpmodule.c
>> +++ b/arch/arm/vfp/vfpmodule.c
>> @@ -644,6 +644,7 @@ static int vfp_hotplug(struct notifier_block *b,
>> unsigned long action,
>>  {
>>         if (action == CPU_DYING || action == CPU_DYING_FROZEN) {
>>                 vfp_force_reload((long)hcpu, current_thread_info());
>> +               vfp_current_hw_state[(long)hcpu] = NULL;
>>         } else if (action == CPU_STARTING || action == CPU_STARTING_FROZEN)
>>                 vfp_enable(NULL);
>>         return NOTIFY_OK;
>
> The vfp_force_reload() here does nothing. We can remove it and this this becomes
>
> static int vfp_hotplug(struct notifier_block *b, unsigned long action,
>         void *hcpu)
> {
>         if (action == CPU_DYING || action == CPU_DYING_FROZEN)
>                 vfp_current_hw_state[(long)hcpu] = NULL;
>         else if (action == CPU_STARTING || action == CPU_STARTING_FROZEN)
>                 vfp_enable(NULL);
>         return NOTIFY_OK;
> }
>

What is the final path going to be?
As per Russell it seems setting the "vfp_current_hw_state[cpu] =
NULL;" unconditionaly in "vfp_force_reload()" is wrong.

-- 
Regards,
Murali N

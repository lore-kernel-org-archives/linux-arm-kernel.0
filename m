From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 11 Jun 2013 12:38:17 -0600
Subject: [PATCH] ARM: decouple CPU offlining from reboot/shutdown
In-Reply-To: <20130611182927.GP3439@mudshark.cambridge.arm.com>
References: <1370887961-31569-1-git-send-email-swarren@wwwdotorg.org>
 <20130611172342.GJ3439@mudshark.cambridge.arm.com>
 <51B767A8.7000506@wwwdotorg.org>
 <20130611182927.GP3439@mudshark.cambridge.arm.com>
Message-ID: <51B76E99.3090001@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2013 12:29 PM, Will Deacon wrote:
> On Tue, Jun 11, 2013 at 07:08:40PM +0100, Stephen Warren wrote:
>> On 06/11/2013 11:23 AM, Will Deacon wrote:
>>> On Mon, Jun 10, 2013 at 07:12:41PM +0100, Stephen Warren wrote:
>>>> From: Stephen Warren <swarren@nvidia.com>
>>>>
>>>> machine_shutdown() is a hook for kexec. Add a comment saying so, since
>>>> it isn't obvious from the function name.

>>>> +/* For kexec */
>>>>  void machine_shutdown(void)
>>>>  {
>>>> -#ifdef CONFIG_SMP
>>>> -	smp_send_stop();
>>>> +#ifdef CONFIG_PM_SLEEP_SMP
>>>> +	disable_nonboot_cpus();
>>>>  #endif
>>>
>>> You can lose the #ifdef here.
>>
>> The implementation of disable_nonboot_cpus() is #ifdef
>> CONFIG_PM_SLEEP_SMP, so I think I need that to avoid build errors.
> 
> Hmm, my include/linux/cpu.h has a dummy definition in an #else block, which
> simply returns 0. What kernel are you using?

Ah right. I keep forgetting about those static inlines:-(

>>>> +	BUG_ON(num_online_cpus() > 1);
>>>
>>> Maybe redefine machine_shutdown if !kexec and lose this BUG?
>>
>> IIUC, machine_shutdown() is only used for kexec now, so I don't think an
>> alternative implementation is required in the !kexec case?
> 
> Yes, you're right. In fact, since we don't support KEXEC_JUMP on ARM, we
> could dispense with machine_shutdown altogether (just make it do nothing)
> and move the code into machine_kexec, which has a much better name.
> 
> What do you think?

That seems fine to me. Or, if I'm changing the prototype of
machine_shutdown(), I could just rename it to e.g.
machine_kexec_shutdown() while I'm at it?

Actually, I was wondering if ARM's implementation wasn't already
KEXEC_JUMP; after all, it uses soft_restart(), which simply jumps to the
new kernel rather than doing any kind of HW reset, right? I must admit
though, the Kconfig for KEXEC_JUMP doesn't really help me understand
what the difference is supposed to be.

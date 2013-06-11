From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 11 Jun 2013 12:08:40 -0600
Subject: [PATCH] ARM: decouple CPU offlining from reboot/shutdown
In-Reply-To: <20130611172342.GJ3439@mudshark.cambridge.arm.com>
References: <1370887961-31569-1-git-send-email-swarren@wwwdotorg.org>
 <20130611172342.GJ3439@mudshark.cambridge.arm.com>
Message-ID: <51B767A8.7000506@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2013 11:23 AM, Will Deacon wrote:
> Hi Stephen,
> 
> On Mon, Jun 10, 2013 at 07:12:41PM +0100, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> machine_shutdown() is a hook for kexec. Add a comment saying so, since
>> it isn't obvious from the function name.
> 
> I'd go as far as saying that some of this commit log could be included in
> the comment too, since this comes up time and time again and it's never
> clear!

OK, I'll add some expanded comments to each of the functions.

>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 42d6ea2..d7b3d2e 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -2028,7 +2028,7 @@ config XIP_PHYS_ADDR
>>  
>>  config KEXEC
>>  	bool "Kexec system call (EXPERIMENTAL)"
>> -	depends on (!SMP || HOTPLUG_CPU)
>> +	depends on (!SMP || (HOTPLUG_CPU && PM_SLEEP_SMP))
> 
> PM_SLEEP_SMP selects HOTPLUG_CPU.

Ah, that makes more sense; it explains how code under /just/ #ifdef
PM_SLEEP_SMP can interact with hotplug-related code.

I guess I just checked HOTPLUG for a select/depends and not the other
way around.

>> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c

>> @@ -97,13 +97,14 @@ void soft_restart(unsigned long addr)
>>  {
>>  	u64 *stack = soft_restart_stack + ARRAY_SIZE(soft_restart_stack);
>>  
>> +	BUG_ON(num_online_cpus() > 1);
> 
> I think this is overkill, and we could actually scream and try to return an
> error here (we've not yet switched stack, and the upper layers of kexec look
> like they can do something with an error code).

Hmmm. The function returns void, although I suppose I could look into
changing that too?

>> +/* For kexec */
>>  void machine_shutdown(void)
>>  {
>> -#ifdef CONFIG_SMP
>> -	smp_send_stop();
>> +#ifdef CONFIG_PM_SLEEP_SMP
>> +	disable_nonboot_cpus();
>>  #endif
> 
> You can lose the #ifdef here.

The implementation of disable_nonboot_cpus() is #ifdef
CONFIG_PM_SLEEP_SMP, so I think I need that to avoid build errors.

>> +	BUG_ON(num_online_cpus() > 1);
> 
> Maybe redefine machine_shutdown if !kexec and lose this BUG?

IIUC, machine_shutdown() is only used for kexec now, so I don't think an
alternative implementation is required in the !kexec case?

>>  void machine_halt(void)
>>  {
>> -	machine_shutdown();
>> +#ifdef CONFIG_SMP
>> +	smp_send_stop();
>> +#endif
> 
> Don't need the #ifdef.

Oh right; I hadn't noticed the inline in smp.h.

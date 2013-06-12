From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 12 Jun 2013 12:40:24 -0600
Subject: [PATCH] ARM: decouple CPU offlining from reboot/shutdown
In-Reply-To: <20130612170143.GK2563@mudshark.cambridge.arm.com>
References: <1370887961-31569-1-git-send-email-swarren@wwwdotorg.org>
 <20130611172342.GJ3439@mudshark.cambridge.arm.com>
 <51B76F42.2020704@wwwdotorg.org>
 <20130612170143.GK2563@mudshark.cambridge.arm.com>
Message-ID: <51B8C098.1000008@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2013 11:01 AM, Will Deacon wrote:
> On Tue, Jun 11, 2013 at 07:41:06PM +0100, Stephen Warren wrote:
>> On 06/11/2013 11:23 AM, Will Deacon wrote:
>>> Hi Stephen,
>>>
>>> On Mon, Jun 10, 2013 at 07:12:41PM +0100, Stephen Warren wrote:
>>>> From: Stephen Warren <swarren@nvidia.com>
>>>>
>>>> machine_shutdown() is a hook for kexec. Add a comment saying so, since
>>>> it isn't obvious from the function name.
>>
>>>> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
>>>> index 282de48..dbe1692 100644
>>>> --- a/arch/arm/kernel/process.c
>>>> +++ b/arch/arm/kernel/process.c
>>>> @@ -97,13 +97,14 @@ void soft_restart(unsigned long addr)
>>>>  {
>>>>  	u64 *stack = soft_restart_stack + ARRAY_SIZE(soft_restart_stack);
>>>>  
>>>> +	BUG_ON(num_online_cpus() > 1);
>>>
>>> I think this is overkill, and we could actually scream and try to return an
>>> error here (we've not yet switched stack, and the upper layers of kexec look
>>> like they can do something with an error code).
>>
>> Oh, that's the BUG_ON I added to soft_restart() not the one I added into
>> machine_shutdown().
>>
>> I added this one to make sure nobody was using soft_restart() on an SMP
>> machine; Russell had asked to validate that all SMP systems provided a
>> HW restart implementation.
>>
>> I assume your comments re: aborting the kexec by returning an error code
>> apply more to machine_shutdown() which happens a bunch earlier.
> 
> No, I did mean soft_restart! For kexec, this hangs off machine_kexec, which
> seems to propogate errors correctly.

I've confirmed that simply returning from soft_restart() and hence
machine_kexec() works fine. The only issue in doing so without modifying
machine_kexec() to return an error-code is that kernel_kexec() doesn't
set variable "error" (which it later returns) and it defaults to 0, so
you see the following in user-space:

> ./keroot at localhost:~# ./kexec.sh 
> mount: / is busy
> [   23.065901] Starting new kernel
> [   23.073486] Bye!
> [   23.080596] soft_restart() called with multiple CPUs online
> kexec failed: Success
> root at localhost:~# 

So, at least kernel_kexec() needs fixing to return an error in this
case, and possibly to propagate one returned by machine_kexec() I suppose.

> For invocations via the machine
> descriptor (i.e. arm_pm_restart), we'll print out `reboot failed' and go
> into a while(1) loop.

So, there's one problem...

> void machine_restart(char *cmd)
> {
> 	smp_send_stop();
> 
> 	arm_pm_restart(reboot_mode, cmd);

Inside smp_send_stop(), all CPUs get set to offline, even though they
aren't really, they're just pinned.

So, if I make:

> void soft_restart(unsigned long addr)
> {
> 	u64 *stack = soft_restart_stack + ARRAY_SIZE(soft_restart_stack);
> 
> 	if (num_online_cpus() > 1) {
> 		pr_err("soft_restart() called with multiple CPUs online\n");
> 		return;
> 	}

Then the check never fires, so the message printed by the balance of
machine_restart() doesn't print.

Maybe I shouldn't try to solve the
soft_restart()-used-as-.restart-on-an-SMP-machine issue in this patch: I
should remove the if() I quoted above from soft_restart(), and put it
directly into machine_kexec(). That wouldn't change any of the
machine_restart() behaviour that we have today, but would correctly
error-check the kexec case. Does that sound reasonable?

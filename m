From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 20 Dec 2012 13:15:30 -0700
Subject: [PATCH] kexec: disable non-boot CPUs
In-Reply-To: <50D35214.4090008@wwwdotorg.org>
References: <1355960681-32015-1-git-send-email-swarren@wwwdotorg.org>
 <20121220104945.GC16887@mudshark.cambridge.arm.com>
 <50D34934.9070106@wwwdotorg.org>
 <20121220173611.GC5387@mudshark.cambridge.arm.com>
 <50D35214.4090008@wwwdotorg.org>
Message-ID: <50D371E2.1030807@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20/2012 10:59 AM, Stephen Warren wrote:
> On 12/20/2012 10:36 AM, Will Deacon wrote:
>> On Thu, Dec 20, 2012 at 05:21:56PM +0000, Stephen Warren wrote:
>>> On 12/20/2012 03:49 AM, Will Deacon wrote:
>>>> If you do manage to get this merged, please can you follow up with a patch
>>>> to remove the smp_kill_cpus bits from arch/arm/kernel/smp.c please? It only
>>>> exists as a hook to do exactly this and currently nobody is using it afaict.
>>>
>>> I originally implemented this in
>>> arch/arm/kernel/process.c:machine_shutdown(), which currently is:
>>>
>>> void machine_shutdown(void)
>>> {
>>> #ifdef CONFIG_SMP
>>> 	smp_send_stop();
>>> #endif
>>> }
>>>
>>> and I changed it to something like:
>>>
>>> void machine_shutdown(void)
>>> {
>>> #ifdef CONFIG_HOTPLUG_CPU
>>>  	disable_nonboot_cpus();
>>> #elifdef CONFIG_SMP
>>> 	smp_send_stop();
>>> #endif
>>> }
>>>
>>> ... but then figured that moving it up into the core kexec code would be
>>> better, so that everything always worked the same way.
>>
>> Hmmm, isn't this racy: requiring the secondaries to hit idle and notice
>> they're offline and call cpu_die before the primary has replace the kernel
>> image?
> 
> Isn't disable_nonboot_cpus() synchronous? If not, I imagine my original
> patch wasn't any better in this respect, except that the hotunplug
> happened earlier, and hence reduced the likelihood of actually seeing
> any such issues.
> 
>>> Anyway, the change above addresses Eric's concern about isolating the
>>> change to ARM. Does that seem like a reasonable thing for the ARM code
>>> to do?
>>
>> I think you're better off using what we currently have and hanging your code
>> off platform_cpu_kill.
> 
> OK, I'll look into that. Joseph Lo just posted patches to implement
> cpu_kill() on Tegra, which was needed to fix some issues in our hotplug
> code anyway. Perhaps that will remove the need for any other changes...

Will,

I just remembered one other advantage of disable_nonboot_cpus(); it
always makes the kexec happen on the boot CPU. Without this, I believe
it's random whether CPU0 or CPU1 performs the kexec. I suspect it's most
likely to work if we can always kexec on the boot CPU rather than a
random CPU?

Joseph, Peter,

As you know, I've been looking into kexec[2] on Tegra. Here's a summary
of a few tests I did:

linux-next plus nothing in particular, SMP enabled:
* Hangs/crashes during kexec

linux-next + SMP disabled: kexec works

linux-next + hotunplug CPUs other than CPU0 before kexec: kexec works

Will Deacon suggested this was due to a missing implementation of struct
smp_operations .cpu_kill on Tegra, which means that when CPUn are
present, they're simply spinning executing code, and kexec will
eventually overwrite that code, causing all manner of problems. So,
since I noticed that Joseph posted an implementation of .cpu_kill for
Tegra, I tried that out[1]. It certainly doesn't solve the problem, and
in fact actually causes the kernel performing the kexec (rather than the
kexec'd kernel) to hang:

> [   26.291903] Starting new kernel
> [   47.309571] INFO: rcu_preempt detected stalls on CPUs/tasks: { 1} (detected by 0, t=2102 jiffies, g=211, c=210, q=37)
> [   47.323410] Task dump for CPU 1:
> [   47.329763] dd              R running      0   401      1 0x00000000
> [   47.339343] [<c0521690>] (__schedule+0x360/0x600) from [<c002d9b0>] (do_syslog+0x2b4/0x478)
> [   47.350952] [<c002d9b0>] (do_syslog+0x2b4/0x478) from [<ed86bb08>] (0xed86bb08)

Manually hotunplugging the CPUs first still works OK with those patches
applied though.

I /think/ kexec calls .cpu_kill() without having caused the CPU itself
to call .cpu_die() first? Did you allow for that possibility inside the
implementation you posted?

[1]
http://patchwork.ozlabs.org/patch/207601/
http://patchwork.ozlabs.org/patch/207602/

[2]
http://en.wikipedia.org/wiki/Kexec

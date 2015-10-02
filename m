From: slash.tmp@free.fr (Mason)
Date: Fri, 2 Oct 2015 15:24:20 +0200
Subject: Dropping "depends on SMP" for HAVE_ARM_TWD -- take 2
In-Reply-To: <560E53E3.7070207@free.fr>
References: <560E53E3.7070207@free.fr>
Message-ID: <560E8584.8000207@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ Adding original reporter ]

On 02/10/2015 11:52, Mason wrote:

> [ take 1 was sent on 2015-03-26 ]
> 
> Hello everyone,
> 
> In http://thread.gmane.org/gmane.linux.ports.arm.kernel/389931/focus=392348
> Stephen Boyd wrote:
> 
>> I don't see any problem with the TWD dropping the dependency on SMP.
>> The code should work the same on a UP configuration [...]
> 
> And Arnd recently said:
> 
>> I think this has come up before and should be fixed. Could you
>> send a patch that allows using TWD in uniprocessor configurations?
> 
> Basically, this means reverting Shawn Guo's 904464b91eca patch.
> and removing "depends on SMP" for HAVE_ARM_TWD.
> 
> However, Shawn's patch fixed an issue, therefore it seems likely
> that simply reverting is not the proper solution?
> 
> What should I do?

For reference, the warning used to be:

    ------------[ cut here ]------------
    WARNING: at arch/arm/kernel/smp_twd.c:345
    twd_local_timer_of_register+0x7c/0x90()
    twd_local_timer_of_register failed (-6)
    Modules linked in:
    Backtrace:
    [<80011f14>] (dump_backtrace+0x0/0x10c) from [<8044dd30>]
    (dump_stack+0x18/0x1c)
     r7:805e9f58 r6:805ba84c r5:80539331 r4:00000159
    [<8044dd18>] (dump_stack+0x0/0x1c) from [<80020fbc>]
    (warn_slowpath_common+0x54/0x6c)
    [<80020f68>] (warn_slowpath_common+0x0/0x6c) from [<80021078>]
    (warn_slowpath_fmt+0x38/0x40)
     r9:412fc09a r8:8fffffff r7:ffffffff r6:00000001 r5:80633b8c
    r4:80b32da8
    [<80021040>] (warn_slowpath_fmt+0x0/0x40) from [<805ba84]
    (twd_local_timer_of_register+0x7c/0x90)
     r3:fffffffa r2:8053934b
    [<805ba7d0>] (twd_local_timer_of_register+0x0/0x90) from [<805c0bec>]
    (imx6q_timer_init+0x18/0x4c)
     r5:80633800 r4:8053b701
    [<805c0bd4>] (imx6q_timer_init+0x0/0x4c) from [<805ba4e8>]
    (time_init+0x28/0x38)
     r5:80633800 r4:805dc0f4
    [<805ba4c0>] (time_init+0x0/0x38) from [<805b6854>]
    (start_kernel+0x1a0/0x310)
    [<805b66b4>] (start_kernel+0x0/0x310) from [<10008044>] (0x10008044)
     r8:1000406a r7:805f3f8c r6:805dc0c4 r5:805f0518 r4:10c5387d
    ---[ end trace 1b75b31a2719ed1c ]---


I cannot reproduce on v4.2 + my platform...

Booting with the following command line:
ip=dhcp root=/dev/nfs rdinit=/none console=ttyS0,115200 mem=640M debug nosmp

produces the attached boot log (no run-time warning).

Perhaps CONFIG_SMP_ON_UP matters? (I have it enabled.)
Nope, I don't get any warning with CONFIG_SMP_ON_UP disabled.

Running out of ideas...

What does nosmp actually do?

static int __init nosmp(char *str)
{
	setup_max_cpus = 0;
	arch_disable_smp_support();

	return 0;
}

I don't think arch/arm overrides arch_disable_smp_support, so it's
just a NOP. So we're just setting setup_max_cpus to 0...

There have been several updates to arch/arm/kernel/smp_twd.c since
Shawn's patch, perhaps one of them unknowingly fixed the problem?

$ git ls arch/arm/kernel/smp_twd.c 
4ed89f222806 ARM: convert printk(KERN_* to pr_*
06b96c8beb94 arm: Replace __this_cpu_ptr with raw_cpu_ptr
0b443ead714f cpufreq: remove unused notifier: CPUFREQ_{SUSPENDCHANGE|RESUMECHANGE}
2e874ea34214 ARM: twd: data endian fix
47dcd3563e45 Merge tag 'remove-local-timers' of git://git.kernel.org/pub/scm/linux/kernel/git/davidb/linux-msm into next/cleanup
8bd26e3a7e49 arm: delete __cpuinit/__CPUINIT usage from all ARM users
cbbe6f82b489 ARM: 7778/1: smp_twd: twd_update_frequency need be run on all online CPUs
a894fcc2d01a ARM: smp_twd: Divorce smp_twd from local timer API
da4a686a2cfb ARM: smp_twd: convert to use CLKSRC_OF init
904464b91eca ARM: 7655/1: smp_twd: make twd_local_timer_of_register() no-op for nosmp

"smp_twd: Divorce smp_twd from local timer API" might be a likely candidate.
(What do you think, Stephen?)

Regards.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: boot.log
Type: text/x-log
Size: 7666 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151002/85eb1a49/attachment-0001.bin>

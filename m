From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Fri, 26 Feb 2016 17:00:50 +0300
Subject: [PATCH] arm64: kasan: clear stale stack poison
In-Reply-To: <1455816458-19485-1-git-send-email-mark.rutland@arm.com>
References: <1455816458-19485-1-git-send-email-mark.rutland@arm.com>
Message-ID: <56D05A92.7070802@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18/2016 08:27 PM, Mark Rutland wrote:
> This patch is a followup to the discussion in [1].
> 
> When using KASAN and CPU idle and/or CPU hotplug, KASAN leaves the stack shadow
> poisoned on exit from the kernel, and this poison is later hit when a CPU is
> brought online and reuses that portion of the stack. Hitting the poison depends
> on stackframe layout, so the bug only manifests in some configurations.
> 
> I think that the hotplug issue is generic, and x86 is affected. I couldn't spot
> magic around idle, so x86 may be fine there. It would be great if someone
> familiar with the x86 code could prove/disprove either of those assertions.
> 
> If x86 is affected, it likely makes sense to unpoison the stack in common code
> prior to bringing a CPU online to avoid that.
> 

I think x86 need that unpoisoning. do_boot_cpu() resets stack for secondary cpu,
so it could be possible to hit stale shadow.

static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle)
{
....
	idle->thread.sp = (unsigned long) (((struct pt_regs *)
			  (THREAD_SIZE +  task_stack_page(idle))) - 1);

	early_gdt_descr.address = (unsigned long)get_cpu_gdt_table(cpu);
	initial_code = (unsigned long)start_secondary;
	stack_start  = idle->thread.sp;




> For idle I'm not keen on having to perform a memset of THREAD_SIZE/8 every time
> a CPU re-enters the kernel. I don't yet have numbers for how bad that is, but
> it doesn't sound good.
> 
> Thanks,
> Mark.
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/408961.html
> 

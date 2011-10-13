From: tixy@yxit.co.uk (Tixy)
Date: Thu, 13 Oct 2011 08:55:15 +0100
Subject: [PATCH] ARM: kprobes: only patch instructions on one CPU
In-Reply-To: <1318435944-21855-1-git-send-email-rabin@rab.in>
References: <1318435944-21855-1-git-send-email-rabin@rab.in>
Message-ID: <1318492515.2265.51.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-10-12 at 21:42 +0530, Rabin Vincent wrote:
> The text patching needs to be done only once, instead of once on each
> CPU.  The other CPUs will busy wait inside the stop machine code until
> the patching is done.

Where in the stop machine code do the other CPU's busy wait?

How I read the code is that __stop_cpus() calls queue_stop_cpus_work()
which queues the work on each of the specified CPU's work list and wakes
that CPU's stopper thread to process it. __stop_cpus() then calls
wait_for_completion() to wait for these CPUs to finish the work.

I don't see how the execution path of CPUs not specified in cpumask is
interrupted in any way.

-- 
Tixy

> 
> Cc: Jon Medhurst <tixy@yxit.co.uk>
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Signed-off-by: Rabin Vincent <rabin@rab.in>
> ---
>  arch/arm/kernel/kprobes.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/kprobes.c b/arch/arm/kernel/kprobes.c
> index 129c116..e9f95300 100644
> --- a/arch/arm/kernel/kprobes.c
> +++ b/arch/arm/kernel/kprobes.c
> @@ -127,7 +127,7 @@ void __kprobes arch_arm_kprobe(struct kprobe *p)
>  		flush_insns(addr, sizeof(u16));
>  	} else if (addr & 2) {
>  		/* A 32-bit instruction spanning two words needs special care */
> -		stop_machine(set_t32_breakpoint, (void *)addr, &cpu_online_map);
> +		stop_machine(set_t32_breakpoint, (void *)addr, NULL);
>  	} else {
>  		/* Word aligned 32-bit instruction can be written atomically */
>  		u32 bkp = KPROBE_THUMB32_BREAKPOINT_INSTRUCTION;
> @@ -190,7 +190,7 @@ int __kprobes __arch_disarm_kprobe(void *p)
>  
>  void __kprobes arch_disarm_kprobe(struct kprobe *p)
>  {
> -	stop_machine(__arch_disarm_kprobe, p, &cpu_online_map);
> +	stop_machine(__arch_disarm_kprobe, p, NULL);
>  }
>  
>  void __kprobes arch_remove_kprobe(struct kprobe *p)

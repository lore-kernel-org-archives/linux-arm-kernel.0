From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 20 Jul 2018 07:31:56 +0100
Subject: [PATCH] ARM64: smp: BUG() if smp_send_reschedule() is called for
 an offline cpu
In-Reply-To: <1532038369-5159-1-git-send-email-vnkgutta@codeaurora.org>
References: <1532038369-5159-1-git-send-email-vnkgutta@codeaurora.org>
Message-ID: <20180720063156.ico2wsqc3lr2pesa@salmiak>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2018 at 03:12:49PM -0700, Venkata Narendra Kumar Gutta wrote:
> Based on the 'commit <8b775be35e41b9f> ("ARM: smp:
> BUG() if smp_send_reschedule() is called for an offline cpu")'

This commit does not appear to exist in mainline. Which tree is it in?

> Sending an IPI_RESCHEDULE to an offline CPU is incorrect and potentially
> bad for both power and stability. On some sub-architectures such as MSM,
> if a power-collapsed CPU is unexpectedly woken up by an IPI, it will be
> begin executing without the preparations that would normally happen as
> part of CPU_UP_PREPARE. If clocks, voltage regulators, or other hardware
> configuration are not performed, the booting CPU may cause general
> instability or (at best) poor power performance since the CPU would be
> powered up but not utilized.
> 
> One common cause for such issues is misuse of add_timer_on() or APIs
> such as queue_work_on() which call it. If proper precautions are not
> taken to block hotplug while these APIs are called then a race may
> result in IPIs being sent to CPUs that are already offline.
> 
> This same argument could be applied to other IPIs (with the exception
> of IPI_WAKEUP), but the others are already restricted to only online
> CPUs by existing mechanisms, so an explicit assertion is not useful.
> 
> Signed-off-by: Matt Wagantall <mattw@codeaurora.org>
> Signed-off-by: Trilok Soni <tsoni@codeaurora.org>
> Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> ---
>  arch/arm64/kernel/smp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 2faa986..5e39030 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -898,6 +898,7 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
>  
>  void smp_send_reschedule(int cpu)
>  {
> +	BUG_ON(cpu_is_offline(cpu));
>  	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
>  }

Is BUG_ON() appropriate?

Why not WARN_ON() and return?

AFAICT, arm doesn't have this logic today either.

Thanks,
Mark.

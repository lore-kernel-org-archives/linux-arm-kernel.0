From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 29 Nov 2016 17:22:06 +0000
Subject: [PATCH 15/22] arm64/cpuinfo: Make hotplug notifier symmetric
In-Reply-To: <20161126231350.10321-16-bigeasy@linutronix.de>
References: <20161126231350.10321-1-bigeasy@linutronix.de>
 <20161126231350.10321-16-bigeasy@linutronix.de>
Message-ID: <758dd144-6634-a8ad-2af0-abe7478dd94f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/11/16 23:13, Sebastian Andrzej Siewior wrote:
> From: Anna-Maria Gleixner <anna-maria@linutronix.de>
>
> There is no requirement to keep the sysfs files around until the CPU is
> completely dead. Remove them during the DOWN_PREPARE notification. This is
> a preparatory patch for converting to the hotplug state machine.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/arm64/kernel/cpuinfo.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index b3d5b3e8fbcb..19aad7041e14 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -272,9 +272,10 @@ static int cpuid_callback(struct notifier_block *nb,
>
>  	switch (action & ~CPU_TASKS_FROZEN) {
>  	case CPU_ONLINE:
> +	case CPU_DOWN_FAILED:
>  		rc = cpuid_add_regs(cpu);
>  		break;
> -	case CPU_DEAD:
> +	case CPU_DOWN_PREPARE:
>  		rc = cpuid_remove_regs(cpu);
>  		break;
>  	}

Looks reasonable to me:

Reviewed-by : Suzuki K Poulose <suzuki.poulose@arm.com>

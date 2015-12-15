From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 15 Dec 2015 11:37:43 +0000
Subject: [RFC PATCH v3 4/8] arm64: Handle early CPU boot failures
In-Reply-To: <1449655039-22022-5-git-send-email-suzuki.poulose@arm.com>
References: <1449655039-22022-1-git-send-email-suzuki.poulose@arm.com>
 <1449655039-22022-5-git-send-email-suzuki.poulose@arm.com>
Message-ID: <566FFB87.9030208@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/15 09:57, Suzuki K. Poulose wrote:
> A secondary CPU could fail to come online due to insufficient
> capabilities and could simply die or loop in the kernel.
> e.g, a CPU with no support for the selected kernel PAGE_SIZE
> loops in kernel with MMU turned off.
> or a hotplugged CPU which doesn't have one of the advertised
> system capability will die during the activation.


>   #ifdef CONFIG_HOTPLUG_CPU
> +     update_cpu_boot_status(CPU_KILL_ME);
>       /* Check if we can park ourselves */
>       if (cpu_ops[cpu] && cpu_ops[cpu]->cpu_die)
>               cpu_ops[cpu]->cpu_die(cpu);
>   #endif
> +     update_cpu_boot_status(CPU_STUCK_IN_KERNEL);
> +     __flush_dcache_area(&secondary_data, sizeof(secondary_data));

James pointed out that we don't need the explicit ___flush_dcache_area (which is a left over
from previous version). I have fixed this locally.


Thanks
Suzuki
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

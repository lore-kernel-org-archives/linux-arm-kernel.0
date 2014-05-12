From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 12 May 2014 16:30:42 +0100
Subject: [PATCH] arm64: use cpu_online_mask when using forced
 irq_set_affinity
In-Reply-To: <1399653464-21410-1-git-send-email-sudeep.holla@arm.com>
References: <1399653464-21410-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <20140512153042.GE31633@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 05:37:44PM +0100, Sudeep Holla wrote:
> From: Sudeep Holla <sudeep.holla@arm.com>
> 
> Commit 01f8fa4f01d8("genirq: Allow forcing cpu affinity of interrupts")
> enabled the forced irq_set_affinity which previously refused to route an
> interrupt to an offline cpu.
> 
> Commit ffde1de64012("irqchip: Gic: Support forced affinity setting")
> implements this force logic and disables the cpu online check for GIC
> interrupt controller.
> 
> When __cpu_disable calls migrate_irqs, it disables the current cpu in
> cpu_online_mask and uses forced irq_set_affinity to migrate the IRQs
> away from the cpu but passes affinity mask with the cpu being offlined
> also included in it.
> 
> When calling irq_set_affinity with force == true in a cpu hotplug path,
> the caller must ensure that the cpu being offlined is not present in the
> affinity mask or it may be selected as the target CPU, leading to the
> interrupt not being migrated.
> 
> This patch uses cpu_online_mask when using forced irq_set_affinity so
> that the IRQs are properly migrated away.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Applied, thanks.

-- 
Catalin

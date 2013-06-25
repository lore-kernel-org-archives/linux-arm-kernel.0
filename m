From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 25 Jun 2013 17:02:11 -0600
Subject: [PATCH V3 1/3] ARM: tegra114: Reprogram GIC CPU interface to
 bypass IRQ on CPU PM entry
In-Reply-To: <1372152242-16373-2-git-send-email-josephl@nvidia.com>
References: <1372152242-16373-1-git-send-email-josephl@nvidia.com>
 <1372152242-16373-2-git-send-email-josephl@nvidia.com>
Message-ID: <51CA2173.7060407@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2013 03:23 AM, Joseph Lo wrote:
> There is a difference between GICv1 and v2 when CPU in power management
> mode (aka CPU power down on Tegra). For GICv1, IRQ/FIQ interrupt lines
> going to CPU are same lines which are also used for wake-interrupt.
> Therefore, we cannot disable the GIC CPU interface if we need to use same
> interrupts for CPU wake purpose. This creates a race condition for CPU
> power off entry. Also, in GICv1, disabling GICv1 CPU interface puts GICv1
> into bypass mode such that incoming legacy IRQ/FIQ are sent to CPU, which
> means disabling GIC CPU interface doesn't really disable IRQ/FIQ to CPU.
> 
> GICv2 provides a wake IRQ/FIQ (for wake-event purpose), which are not
> disabled by GIC CPU interface. This is done by adding a bypass override
> capability when the interrupts are disabled at the CPU interface. To
> support this, there are four bits about IRQ/FIQ BypassDisable in CPU
> interface Control Register. When the IRQ/FIQ not being driver by the
> CPU interface, each interrupt output signal can be deasserted rather
> than being driven by the legacy interrupt input.
> 
...
> diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c

> +static int tegra_gic_notifier(struct notifier_block *self,
> +			      unsigned long cmd, void *v)
> +{
> +	switch (cmd) {
> +	case CPU_PM_ENTER:
> +		writel_relaxed(0x1E0, tegra_gic_cpu_base + GIC_CPU_CTRL);

I assume that 0x1e0 is the "four bits" for IRQ/FIQ bypass disable that
are mentioned in the commit description. are there #defines that can be
used instead of literal 0x1e0 here?

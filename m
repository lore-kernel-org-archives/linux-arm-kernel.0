From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Mon, 10 Jun 2013 18:01:38 +0100
Subject: [PATCH 1/2] ARM: vexpress/TC2: basic PM support
In-Reply-To: <1370587152-4630-2-git-send-email-nicolas.pitre@linaro.org>
References: <1370587152-4630-1-git-send-email-nicolas.pitre@linaro.org>
 <1370587152-4630-2-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <51B60672.8050809@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/13 07:39, Nicolas Pitre wrote:
> This is the MCPM backend for the Virtual Express A15x2 A7x3 CoreTile
> aka TC2.  This provides cluster management for SMP secondary boot and
> CPU hotplug.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
>  arch/arm/mach-vexpress/Kconfig  |   9 ++
>  arch/arm/mach-vexpress/Makefile |   1 +
>  arch/arm/mach-vexpress/tc2_pm.c | 243 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 253 insertions(+)
>  create mode 100644 arch/arm/mach-vexpress/tc2_pm.c
> 
[...]
> +/*
> + * Enable cluster-level coherency, in preparation for turning on the MMU.
> + */
> +static void __naked tc2_pm_power_up_setup(unsigned int affinity_level)
> +{
> +	asm volatile (" \n"
> +"	cmp	r0, #1 \n"
You may need Thumb2 if-then(IT) instruction to support longer branch
range here when compiled in THUMB2 mode.
"       it      eq \n"

> +"	beq	cci_enable_port_for_self \n"
> +"	bx	lr ");
> +}
> +

Regards,
Sudeep

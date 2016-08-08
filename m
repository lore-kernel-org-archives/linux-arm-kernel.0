From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 8 Aug 2016 14:39:35 +0100
Subject: [PATCH 1/1] irqchip: irq-gic: forward SGI to itself for
 cortex-a7 single core
In-Reply-To: <1470642594-30455-1-git-send-email-peter.chen@nxp.com>
References: <1470642594-30455-1-git-send-email-peter.chen@nxp.com>
Message-ID: <20160808143935.2d946210@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 8 Aug 2016 15:49:54 +0800
Peter Chen <peter.chen@nxp.com> wrote:

+Tony

> According to Cortex-A7 MPCore TRM, ch8.3.1, Distributor register summary,
> GICD_ITARGETSRn:
> 
> 	The register that contains the SGI and PPI interrupts is
>        	read-only and the value is implementation defined. For
>        	Cortex-A7 configurations with only one processor, these
>        	registers are RAZ/WI.
> 
> So, the GICD_ITARGETSR[0..7] is read-only, and the value is 0 for
> cortex-a7 single core platform if the SoC is cortex-a7 mpcore version.
> So the cupmask from gic_get_cpumask is 0.
> 
> At ARM Generic Interrupt Controller Architecture version 2.0,
> ch4.3.15 Software Generated Interrupt Register, GICD_SGIR,
> The distributor will process the requested SGI according to
> register TargetListFilter and CPUTargetList. At current gic code,
> it takes TargetListFilter as 0b00, and forward the interrupt to
> cpumask (variable map at gic_raise_softirq) getting from gic_get_cpumask.
> but cpumask is 0 according to above explanation for cortex-a7 single core
> platform, so, both TargetListFilter and CPUTargetList are 0, and the
> distributor does not forward the interrupt to any CPU interface according
> to gic documentation, then the SGI can't be occurred.
> 
> We have found this problem at nxp imx6ul platform, which is a cortex-a7
> single core platform, the irq work (triggered by SGI at ARM) can't be
> occurred which is needed for cpufreq, then the system has failed to boot
> and reboot [1].

I'm really not keep on this, as even if we paper over the problem for
platforms using a GIC, we still leave behind all the platform that are
not capable of self-IPI (which is the vast majority of ARM UP systems).

Can you please provide a backtrace of the failing use case? Have you
tried this patch [1], which did solve the issue for OMAP?

Also, if we're going to mandate a self-IPI mechanism for all UP
systems, we do need way to do this in a generic way, as a fallback for
systems that are not SMP aware.

Thanks,

	M.

[1]: https://patchwork.kernel.org/patch/8318231/
-- 
Jazz is not dead. It just smells funny.

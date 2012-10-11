From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 11 Oct 2012 15:08:35 +0800
Subject: [PATCH 2/7] ARM: tegra: cpuidle: add LP2 resume function
In-Reply-To: <5074A559.8030206@wwwdotorg.org>
References: <1349691981-31038-1-git-send-email-josephl@nvidia.com>
 <1349691981-31038-3-git-send-email-josephl@nvidia.com>
 <5074A559.8030206@wwwdotorg.org>
Message-ID: <1349939315.19413.81.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-10-10 at 06:29 +0800, Stephen Warren wrote:
> On 10/08/2012 04:26 AM, Joseph Lo wrote:
> > LP2 is one of the Tegra low power states that supports power gating both
> > CPU cores and GICs. Adding a resume function for taking care the CPUs that
> > resume from LP2. This function was been hooked to reset handler. We take
> > care everything here before go into kernel.
> 
> > diff --git a/arch/arm/mach-tegra/headsmp.S b/arch/arm/mach-tegra/headsmp.S
> 
> > +ENTRY(tegra_resume)
> ...
> > +	/* Are we on Tegra20? */
> > +	mov32	r6, TEGRA_APB_MISC_BASE
> > +	ldr	r0, [r6, #APB_MISC_GP_HIDREV]
> > +	and	r0, r0, #0xff00
> > +	cmp	r0, #(0x20 << 8)
> > +	beq	1f
> > +#ifdef CONFIG_ARCH_TEGRA_3x_SOC
> > +	/* Clear the flow controller flags for this CPU. */
> > +	mov32	r2, TEGRA_FLOW_CTRL_BASE + FLOW_CTRL_CPU0_CSR	@ CPU0 CSR
> > +	ldr	r1, [r2]
> > +	/* Clear event & intr flag */
> > +	orr	r1, r1, \
> > +		#FLOW_CTRL_CSR_INTR_FLAG | FLOW_CTRL_CSR_EVENT_FLAG
> > +	movw	r0, #0x0FFD	@ enable, cluster_switch, immed, & bitmaps
> > +	bic	r1, r1, r0
> > +	str	r1, [r2]
> > +#endif
> > +1:
> 
> couldn't that entire quoted chunk go inside the ifdef; all of reading
> the HIDREV register and the 1: label?

Ah. Yes, it's OK. Will do.

Thanks,
Joseph

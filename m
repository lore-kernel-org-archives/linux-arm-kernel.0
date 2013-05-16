From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 16 May 2013 18:35:33 +0800
Subject: [PATCH 3/6] ARM: tegra: make tegra_resume can work for Tegra114
In-Reply-To: <519412E9.2080905@wwwdotorg.org>
References: <1368613644-11863-1-git-send-email-josephl@nvidia.com>
 <1368613644-11863-4-git-send-email-josephl@nvidia.com>
 <519412E9.2080905@wwwdotorg.org>
Message-ID: <1368700533.7403.47.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-05-16 at 06:57 +0800, Stephen Warren wrote:
> On 05/15/2013 04:27 AM, Joseph Lo wrote:
> > Tegra114 is an ARM Cortex-A15 based SoC and some of the flow controller
> 
> I don't think the CPU type is the issue here. The issue is simply that
> Tegra114's flow controller is different. Mentioning the CPU type seems
> misleading.
> 
> > hardware behavior and configurations are different with other Tegra series.
> > We fix the common resume function of tegra_resume to make it can work on
> > Tegra114 by checking SoC ID. And also checking CPU primary part number to
> > isolate the support code for Cortex A9 and A15.
> 
> > diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
> 
> > -#ifdef CONFIG_ARCH_TEGRA_3x_SOC
> > +#ifndef CONFIG_ARCH_TEGRA_2x_SOC
> >  	/* Are we on Tegra20? */
> >  	tegra_check_soc_id TEGRA20, TEGRA_APB_MISC_BASE, r6, r7
> >  	beq	1f				@ Yes
> >  	/* Clear the flow controller flags for this CPU. */
> > -	mov32	r2, TEGRA_FLOW_CTRL_BASE + FLOW_CTRL_CPU0_CSR	@ CPU0 CSR
> > -	ldr	r1, [r2]
> > +	cpu_to_csr_req r1, r0
> 
> Where is cpu_to_csr_req defined? grep can't find it in next-20130513,
> and I don't see it added in this series.
> 
The cpu_to_csr_reg macro was defined in "sleep.h". I was used to
translate the bit offset of CPU number in CSR register. The code here
was used for CPU0 on Tegra30 only before. Because the Tegra114 had more
advance CPU power control. Each Core need run through here when power
gate resume.

> This presumably changes behaviour on Tegra30; will this cause problems?
> 
No, I had verified on Tegra20, Tegra30 and Tegra114 of this series.

> > +	mov32	r2, TEGRA_FLOW_CTRL_BASE
> > +	ldr	r1, [r2, r1]
> >  	/* Clear event & intr flag */
> >  	orr	r1, r1, \
> >  		#FLOW_CTRL_CSR_INTR_FLAG | FLOW_CTRL_CSR_EVENT_FLAG
> > -	movw	r0, #0x0FFD	@ enable, cluster_switch, immed, & bitmaps
> > +	movw	r0, #0x3FFD	@ enable, cluster_switch, immed, & bitmaps
> 
> What does this change do; does the commend need updating to describe the
> new bits that are set?
It clear the some extensions for CPU power control on Tegra114.

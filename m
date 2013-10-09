From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 9 Oct 2013 11:11:35 +0800
Subject: [PATCH 3/4] ARM: tegra: make tegra_resume can work with current
 and later chips
In-Reply-To: <52543A24.3020108@wwwdotorg.org>
References: <1381220587-29697-1-git-send-email-josephl@nvidia.com>
 <1381220587-29697-4-git-send-email-josephl@nvidia.com>
 <52543A24.3020108@wwwdotorg.org>
Message-ID: <1381288295.10638.23.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-10-09 at 01:00 +0800, Stephen Warren wrote:
> On 10/08/2013 02:23 AM, Joseph Lo wrote:
> > Because the CPU0 was the first up and the last down core when cluster
> > power up/down or platform suspend. So only CPU0 needs the rest of the
> > functions to reset flow controller and re-enable SCU and L2. We also
> > move the L2 init function for Cortex-A15 to there. The secondery CPU
> > can just call cpu_resume.
> 
> Is that really true? I thought that starting with Tegra114, all the CPUs
> were independent, so that any CPU could be the last CPU to be
> power-gated. Isn't that exactly why we don't need coupled cpuidle or
> anything similar on Tegra114
> 
Yes, it's true. I realize the role of CPU0 is the same across all
current Tegra chips. Although we can support independent power gate for
CPU0 in Tegra114/124, for cluster power control it still needs to be set
up by CPU0 (last down and first up). So I send this patch for tunning
the code that only need for CPU0.

> > diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
> 
> >  not_ca9:
> > +	mov32	r9, 0xc0f
> > +	cmp	r8, r9
> > +	bleq	tegra_init_l2_for_a15
> 
> That's checking whether the CPU type is a Cortex-A15, isn't it? The only
> CPUs that exist NVIDIA SoCs are Cortex-A9 and Cortex-A15, so I don't see
> why we need to check whether the CPU is a Cortex-A15, given this label
> is jumped to only when the CPU isn't a Cortex-A9.

Good catch. Will fix.

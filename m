From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 30 Oct 2012 16:27:25 -0600
Subject: [PATCH 3/7] ARM: tegra30: cpuidle: add LP2 driver for secondary
 CPUs
In-Reply-To: <87sj8vr517.fsf@amiettinen-lnx.nvidia.com>
References: <1349691981-31038-1-git-send-email-josephl@nvidia.com>
 <1349691981-31038-4-git-send-email-josephl@nvidia.com>
 <5074A74A.8010803@wwwdotorg.org>
 <1349946918.19413.130.camel@jlo-ubuntu-64.nvidia.com>
 <5076F2AE.6030509@wwwdotorg.org>
 <1350012099.20241.10.camel@jlo-ubuntu-64.nvidia.com>
 <87sj8vr517.fsf@amiettinen-lnx.nvidia.com>
Message-ID: <5090544D.3020408@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/2012 04:03 PM, Antti P Miettinen wrote:
> Joseph Lo <josephl@nvidia.com> writes:
>>>>>> +	writel(tegra_in_lp2.bits[0], tegra_cpu_lp2_mask);
> 
> BTW, writel_relaxed() would probably be more than enough? IRAM is mapped
> stronly ordered, isn't it? And there's an explicit dsb(). And the mask
> is observed and written only by CPUs. If there are coherence issues,
> they would be in the fabric? And then neither CPU barriers nor L2 sync
> would help, you'd need a readback, right?

I expect there are many places where we simply default to using
readl/writel (e.g. due to cut/paste, their prevalence, etc.) rather than
explicitly using the _relaxed variants if we can. Perhaps we should do a
pass through all the Tegra code and clean that up sometime.

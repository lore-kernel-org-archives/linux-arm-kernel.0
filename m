From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 31 Oct 2012 09:26:41 +0800
Subject: [PATCH 3/7] ARM: tegra30: cpuidle: add LP2 driver for
 secondary CPUs
In-Reply-To: <5090544D.3020408@wwwdotorg.org>
References: <1349691981-31038-1-git-send-email-josephl@nvidia.com>
 <1349691981-31038-4-git-send-email-josephl@nvidia.com>
 <5074A74A.8010803@wwwdotorg.org>
 <1349946918.19413.130.camel@jlo-ubuntu-64.nvidia.com>
 <5076F2AE.6030509@wwwdotorg.org>
 <1350012099.20241.10.camel@jlo-ubuntu-64.nvidia.com>
 <87sj8vr517.fsf@amiettinen-lnx.nvidia.com> <5090544D.3020408@wwwdotorg.org>
Message-ID: <1351646801.5410.32.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-10-31 at 06:27 +0800, Stephen Warren wrote:
> On 10/30/2012 04:03 PM, Antti P Miettinen wrote:
> > Joseph Lo <josephl@nvidia.com> writes:
> >>>>>> +	writel(tegra_in_lp2.bits[0], tegra_cpu_lp2_mask);
> > 
> > BTW, writel_relaxed() would probably be more than enough? IRAM is mapped
> > stronly ordered, isn't it? And there's an explicit dsb(). And the mask
> > is observed and written only by CPUs. If there are coherence issues,
> > they would be in the fabric? And then neither CPU barriers nor L2 sync
> > would help, you'd need a readback, right?
> 
> I expect there are many places where we simply default to using
> readl/writel (e.g. due to cut/paste, their prevalence, etc.) rather than
> explicitly using the _relaxed variants if we can. Perhaps we should do a
> pass through all the Tegra code and clean that up sometime.

Hi Antti,

Thanks for review.
I had updated this code from V2. The code looks like below right now.
It's similar to "writel_relaxed" function. And I had verified this code
in SMP environment it can sync the status of "cpu_in_lp2". I don't see
any coherency issue in IRAM memory space right now. I knew some IO
registers that under PPSB bus (peripheral bus) needed a readback as a
barrier. Because PPSB queues write transactions.

I had verified this on Tegra20 & Tegra30. It's reliable.

*cpu_in_lp2 |= BIT(phy_cpu_id);
or
*cpu_in_lp2 &= ~BIT(phy_cpu_id);

Thanks,
Joseph

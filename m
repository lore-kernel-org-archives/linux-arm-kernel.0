From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 10 Jun 2018 11:40:57 +0100
Subject: [PATCH v2] irqchip/gic-v3-its: fix ITS queue timeout
In-Reply-To: <fc0393df-22d4-0334-91ce-8ddcdbf5ec21@huawei.com>
References: <1528252824-15144-1-git-send-email-yangyingliang@huawei.com>
 <86a7s89t13.wl-marc.zyngier@arm.com>
 <fc0393df-22d4-0334-91ce-8ddcdbf5ec21@huawei.com>
Message-ID: <86muw29b5y.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Hanjun,

On Thu, 07 Jun 2018 13:25:26 +0100,
Hanjun Guo wrote:
> 
> Hi Marc,
> 
> On 2018/6/6 17:13, Marc Zyngier wrote:
> [...]
> > 
> > Wouldn't it be better to just return that the affinity setting request
> > is impossible to satisfy? And more to the point, how comes we end-up
> > in such a case?
> 
> The system is booted with a NUMA node has no memory attaching to it
> (memory-less NUMA node), also with NR_CPUS less than CPUs presented
> in MADT, so CPUs on this memory-less node are not brought up, and
> this NUMA node will not be online too. But the ITS attaching to this NUMA
> domain is still valid and represented via SRAT to ITS driver.
> 
> This is really the corner case which is triggered by the boot testing
> when enabling our D06 boards, but it's a bug :)

I'm not debating the bringing up (or lack thereof) of the secondary
CPUs. I'm questioning the affinity setting to unavailable CPUs, and I
really wonder what the semantic of such a thing is (and how we end-up
there).

Anyway, I'll plug the "SYNC to unmapped collection" issue (which
definitely needs fixing), but I'd like to understand the above.

Thanks,

	M.

-- 
Jazz is not dead, it just smell funny.

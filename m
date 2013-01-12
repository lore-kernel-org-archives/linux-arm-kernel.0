From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 12 Jan 2013 12:22:20 +0530
Subject: [PATCH 10/16] ARM: vexpress: introduce DCSCB support
In-Reply-To: <alpine.LFD.2.02.1301111408330.6300@xanadu.home>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-11-git-send-email-nicolas.pitre@linaro.org>
 <50F05606.9060703@ti.com> <alpine.LFD.2.02.1301111408330.6300@xanadu.home>
Message-ID: <50F10824.2010904@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 12 January 2013 12:43 AM, Nicolas Pitre wrote:
> On Fri, 11 Jan 2013, Santosh Shilimkar wrote:
>
>> On Thursday 10 January 2013 05:50 AM, Nicolas Pitre wrote:
>>> This adds basic CPU and cluster reset controls on RTSM for the
>>> A15x4-A7x4 model configuration using the Dual Cluster System
>>> Configuration Block (DCSCB).
>>>
>>> The cache coherency interconnect (CCI) is not handled yet.
>>>
>>> Signed-off-by: Nicolas Pitre <nico@linaro.org>
>>> ---
>>>    arch/arm/mach-vexpress/Kconfig  |   8 ++
>>>    arch/arm/mach-vexpress/Makefile |   1 +
>>>    arch/arm/mach-vexpress/dcscb.c  | 160
>>> ++++++++++++++++++++++++++++++++++++++++
>>>    3 files changed, 169 insertions(+)
>>>    create mode 100644 arch/arm/mach-vexpress/dcscb.c
>>>
[..]

>>> diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-vexpress/dcscb.c
>>> new file mode 100644
>>> index 0000000000..cccd943cd4
>>> --- /dev/null
>>> +++ b/arch/arm/mach-vexpress/dcscb.c
[..]

>>> +static void dcscb_power_down(void)
>>> +{
>>> +	unsigned int mpidr, cpu, cluster, rst_hold, cpumask, last_man;
>>> +
>>> +	asm ("mrc p15, 0, %0, c0, c0, 5" : "=r" (mpidr));
>>> +	cpu = mpidr & 0xff;
>>> +	cluster = (mpidr >> 8) & 0xff;
>>> +	cpumask = (1 << cpu);
>>> +
>>> +	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
>>> +	BUG_ON(cpu >= 4 || cluster >= 2);
>>> +
>>> +	arch_spin_lock(&dcscb_lock);
>>> +	rst_hold = readl_relaxed(dcscb_base + RST_HOLD0 + cluster * 4);
>>> +	rst_hold |= cpumask;
>>> +	if (((rst_hold | (rst_hold >> 4)) & 0xf) == 0xf)
>>> +		rst_hold |= (1 << 8);
>>> +	writel(rst_hold, dcscb_base + RST_HOLD0 + cluster * 4);
>>> +	arch_spin_unlock(&dcscb_lock);
>>> +	last_man = (rst_hold & (1 << 8));
>>> +
>>> +	/*
>>> +	 * Now let's clean our L1 cache and shut ourself down.
>>> +	 * If we're the last CPU in this cluster then clean L2 too.
>>> +	 */
>>> +
>> Do you wanted to have C bit clear code here ?
>
> cpu_proc_fin() does it.
>
Yep. I noticed that in next patch when read the comment.

>>> +	/*
>>> +	 * A15/A7 can hit in the cache with SCTLR.C=0, so we don't need
>>> +	 * a preliminary flush here for those CPUs.  At least, that's
>>> +	 * the theory -- without the extra flush, Linux explodes on
>>> +	 * RTSM (maybe not needed anymore, to be investigated)..
>>> +	 */
>>> +	flush_cache_louis();
>>> +	cpu_proc_fin();
>>> +
>>> +	if (!last_man) {
>>> +		flush_cache_louis();
>>> +	} else {
>>> +		flush_cache_all();
>>> +		outer_flush_all();
>>> +	}
>>> +
>>> +	/* Disable local coherency by clearing the ACTLR "SMP" bit: */
>>> +	asm volatile (
>>> +		"mrc	p15, 0, ip, c1, c0, 1 \n\t"
>>> +		"bic	ip, ip, #(1 << 6) @ clear SMP bit \n\t"
>>> +		"mcr	p15, 0, ip, c1, c0, 1"
>>> +		: : : "ip" );
>>> +
>>> +	/* Now we are prepared for power-down, do it: */
>> You need dsb here, right ?
>
> Probably.  However this code is being refactored significantly with
> subsequent patches.  This intermediate step was kept not to introduce
> too many concepts at once.
>
Yes. I do see updates in subsequent patch.

Regards
Santosh

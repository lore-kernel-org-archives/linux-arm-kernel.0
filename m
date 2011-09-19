From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 19 Sep 2011 16:24:05 +0100
Subject: [RFC PATCH 1/3] genirq: add support for per-cpu dev_id interrupts
In-Reply-To: <20110919150526.GV16381@n2100.arm.linux.org.uk>
References: <1316105551-17505-1-git-send-email-marc.zyngier@arm.com>
	<1316105551-17505-2-git-send-email-marc.zyngier@arm.com>
	<4E767CD6.6090208@codeaurora.org> <4E770B3E.9040401@arm.com>
	<4E775912.3060502@arm.com>
	<20110919150526.GV16381@n2100.arm.linux.org.uk>
Message-ID: <4E775E95.2020806@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/09/11 16:05, Russell King - ARM Linux wrote:
> On Mon, Sep 19, 2011 at 04:00:34PM +0100, Marc Zyngier wrote:
>> Replying to myself after a quick investigation... Looks like the Qualcomm
>> implementation does exactly what is mentioned above:
>>
>> arch/arm/mach-msm/platsmp.c:
>> void __cpuinit platform_secondary_init(unsigned int cpu)
>> {
>> 	/* Configure edge-triggered PPIs */
>> 	writel(GIC_PPI_EDGE_MASK, MSM_QGIC_DIST_BASE + GIC_DIST_CONFIG + 4);
>> 	[...]
>>
>> The way I understand it, this "MSM_QGIC_DIST_BASE + GIC_DIST_CONFIG + 4"
>> is a banked register (otherwise we would not do it in platform_secondary_init(),
>> right?) So doing a set_type() from __setup_irq() would be just wrong. It really
>> needs to be done on a per-CPU basis.
> 
> All the registers to do with the first 32 interrupts in the distributer
> are banked - the enable, configuration, and priority registers are all
> only accessible to the specific CPU which owns the PPIs and SGIs.

Indeed. The major difference is that the configuration registers for the
PPIs seem to be writable on MSM (11MP and A9 have them RO).

	M.
-- 
Jazz is not dead. It just smells funny...

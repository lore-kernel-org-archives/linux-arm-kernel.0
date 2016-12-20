From: ddaney@caviumnetworks.com (David Daney)
Date: Tue, 20 Dec 2016 09:52:38 -0800
Subject: [PATCH v3] arm64: SMMU-v2: Workaround for Cavium ThunderX erratum
 28168
In-Reply-To: <20161220115630.GD10132@arm.com>
References: <1482231993-27571-1-git-send-email-gakula@caviumnetworks.com>
 <bd950765-8c1f-14d5-2be8-efa76f2d6b6b@arm.com>
 <20161220115630.GD10132@arm.com>
Message-ID: <d8aed795-f4ce-609e-ccd2-0daf628b0376@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20/2016 03:56 AM, Will Deacon wrote:
> On Tue, Dec 20, 2016 at 11:52:58AM +0000, Marc Zyngier wrote:
>> On 20/12/16 11:06, Geetha sowjanya wrote:
>>> From: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
>>> +#ifdef CONFIG_CAVIUM_ERRATUM_28168
>>> +/*
>>> + * Cavium ThunderX erratum 28168
>>> + *
>>> + * Due to erratum #28168 PCI-inbound MSI-X store to the interrupt
>>> + * controller are delivered to the interrupt controller before older
>>> + * PCI-inbound memory stores are committed. Doing a sync on SMMU
>>> + * will make sure all prior data transfers are completed before
>>> + * invoking ISR.
>>> + *
>>> + */
>>> +void dev_smmu_tlb_sync(struct device *dev)
>>> +{
>>> +	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
>>> +	struct arm_smmu_device *smmu = fwspec_smmu(fwspec);
>>> +
>>> +	if (smmu)
>>> +		__arm_smmu_tlb_sync(smmu);
>>> +}
>>> +#endif
>>
>> I'll let Robin and Will comment on this, but it strikes be as rather odd
>> that nothing will happen if the SMMU is in bypass or simply compiled
>> out. So this workaround is at best incomplete.
>
> Agreed. Unless the SMMU is the cause of the issue, relying on it to
> implement the workaround is fragile and unnecessarily introduces a linkage
> between SMMU driver internals and the interrupt handling code.


The SMMU is not the cause of the problem, it is the solution, and as 
such is required.

Perhaps we should have a Kconfig "select" for the SMMU driver if 
CAVIUM_ERRATUM_28168 is selected.


>
> Not a fan.

In general, I don't think anybody is a big fan of errata and their 
workarounds.


>
> Will
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

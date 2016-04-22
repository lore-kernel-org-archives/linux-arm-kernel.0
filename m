From: eric.auger@linaro.org (Eric Auger)
Date: Fri, 22 Apr 2016 14:25:57 +0200
Subject: [PATCH v7 1/8] genirq/msi: Add a new MSI_FLAG_IRQ_REMAPPING flag
In-Reply-To: <571A04A9.1010104@arm.com>
References: <1461085990-2547-1-git-send-email-eric.auger@linaro.org>
 <1461085990-2547-2-git-send-email-eric.auger@linaro.org>
 <571A04A9.1010104@arm.com>
Message-ID: <571A1855.5020008@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robin,
On 04/22/2016 01:02 PM, Robin Murphy wrote:
> Hi Eric,
> 
> On 19/04/16 18:13, Eric Auger wrote:
>> Let's introduce a new msi_domain_info flag value, MSI_FLAG_IRQ_REMAPPING
>> meant to tell the domain supports IRQ REMAPPING, also known as Interrupt
>> Translation Service. On Intel HW this IRQ remapping capability is
>> abstracted on IOMMU side while on ARM it is abstracted on MSI controller
>> side. This flag will be used to know whether the MSI passthrough is
>> safe.
> 
> Perhaps a nitpick, but given the earlier confusion about what the IOMMU
> flag actually meant this prompts me to wonder if it's worth adjusting
> the general terminology before we propagate it further. What I think we
> actually care about is that one thing or the other "provides MSI
> isolation" rather than "supports MSI remapping", since the latter is all
> to easy to misinterpret the way we did in the SMMU drivers.

The only concern I have is https://lkml.org/lkml/2016/4/18/283 attempts
to define a PCI bus flag dubbed PCI_BUS_FLAGS_MSI_REMAP combining the
iommu & msi layer info. In that sense x86 people may not be keen of
having different terminaologies. Anyway I will follow the consensus, if any.

Best Regards

Eric


> 
> Robin.
> 
>> Signed-off-by: Eric Auger <eric.auger@linaro.org>
>>
>> ---
>>
>> v4 -> v5:
>> - seperate flag introduction from first user addition (ITS)
>> ---
>>   include/linux/msi.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/include/linux/msi.h b/include/linux/msi.h
>> index 8b425c6..08441b1 100644
>> --- a/include/linux/msi.h
>> +++ b/include/linux/msi.h
>> @@ -270,6 +270,8 @@ enum {
>>       MSI_FLAG_MULTI_PCI_MSI        = (1 << 3),
>>       /* Support PCI MSIX interrupts */
>>       MSI_FLAG_PCI_MSIX        = (1 << 4),
>> +    /* Support MSI IRQ remapping service */
>> +    MSI_FLAG_IRQ_REMAPPING        = (1 << 5),
>>   };
>>
>>   int msi_domain_set_affinity(struct irq_data *data, const struct
>> cpumask *mask,
>>
> 

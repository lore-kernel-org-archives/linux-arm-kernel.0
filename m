From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 10 Mar 2015 17:34:59 +0800
Subject: [PATCH v9 08/21] ARM64 / ACPI: Introduce PCI stub functions for
 ACPI
In-Reply-To: <20150309150119.GG16268@e106497-lin.cambridge.arm.com>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <1424853601-6675-9-git-send-email-hanjun.guo@linaro.org>
 <20150309150119.GG16268@e106497-lin.cambridge.arm.com>
Message-ID: <54FEBAC3.9050804@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?03?09? 23:01, Liviu Dudau wrote:
> On Wed, Feb 25, 2015 at 08:39:48AM +0000, Hanjun Guo wrote:
>> CONFIG_ACPI depends CONFIG_PCI on x86 and ia64, in ARM64 server
>> world we will have PCIe in most cases, but some of them may not,
>> make CONFIG_ACPI depend CONFIG_PCI on ARM64 will satisfy both.
>>
>> With that case, we need some arch dependent PCI functions to
>> access the config space before the PCI root bridge is created, and
>> pci_acpi_scan_root() to create the PCI root bus. So introduce
>> some stub function here to make ACPI core compile and revisit
>> them later when implemented on ARM64.
>>
>> CC: Liviu Dudau <Liviu.Dudau@arm.com>
>> CC: Catalin Marinas <catalin.marinas@arm.com>
>> CC: Will Deacon <will.deacon@arm.com>
>> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> Tested-by: Yijing Wang <wangyijing@huawei.com>
>> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
>> Tested-by: Jon Masters <jcm@redhat.com>
>> Tested-by: Timur Tabi <timur@codeaurora.org>
>> Tested-by: Robert Richter <rrichter@cavium.com>
>> Acked-by: Robert Richter <rrichter@cavium.com>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   arch/arm64/include/asm/pci.h |  6 ++++++
>>   arch/arm64/kernel/pci.c      | 25 +++++++++++++++++++++++++
>>   2 files changed, 31 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
>> index 872ba93..fded096 100644
>> --- a/arch/arm64/include/asm/pci.h
>> +++ b/arch/arm64/include/asm/pci.h
>> @@ -24,6 +24,12 @@
>>    */
>>   #define PCI_DMA_BUS_IS_PHYS	(0)
>
> Hanjun,

Hi Liviu,

>
>>
>> +static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
>> +{
>> +	/* no legacy IRQ on arm64 */
>> +	return -ENODEV;
>> +}
>> +
>
> Could you explain to me what situation you encountered where you needed
> to define this? I'm trying to figure out when this would be needed and the
> only thing I can come up with would be for drivers/pnp/resource.c, but that
> is guarded by #ifdef CONFIG_PCI, which would mean that you should move this
> a bit further down in the file,

Agreed, will move it to #ifdef CONFIG_PCI .. #endif.

> but also contradicts the last comment on
> this patch (i.e. PCI on ACPI is not really implemented, so presumably
> CONFIG_PCI is not enabled?)

CONFIG_ACPI depends on CONFIG_PCI in the Kconfig, so CONFIG_PCI will be
enabled even PCI on ACPI is not really implemented now, did I
understand your question correctly?

Thanks
Hanjun

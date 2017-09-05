From: wangzhou1@hisilicon.com (Zhou Wang)
Date: Tue, 5 Sep 2017 20:47:15 +0800
Subject: [Question] PCI ACS is broken for ARM SMMU v3?
In-Reply-To: <20170904155948.GA20601@red-moon>
References: <59A81B4C.3020402@hisilicon.com> <59AD4812.3020602@hisilicon.com>
 <20170904155948.GA20601@red-moon>
Message-ID: <59AE9CD3.1020700@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/9/4 23:59, Lorenzo Pieralisi wrote:
> On Mon, Sep 04, 2017 at 08:33:22PM +0800, Zhou Wang wrote:
>> +to: Lorenzo
>>
>> On 2017/8/31 22:21, Zhou Wang wrote:
>>> Hi Will and Alex,
>>>
>>> pci_request_acs is called in drivers/iommu/arm-smmu-v3.c to set pci_acs_enable.
>>>
>>> PCI subsystem tries to enable ACS as below:
>>>
>>> 	pci_device_add
>>> 		--> pci_init_capabilities
>>> 			--> pci_enable_acs
>>>
>>> in ACPI PCI driver. However, ACPI PCI driver will be called before SMMU v3 driver,
>>> which will lead pci_enable_acs to return directly as pci_acs_enable is not set
>>> before SMMU v3 driver loading.
>>>
>>> I think this is a bug, what do you think about this problem?
> 
> I think that it is a bug that affects OF/ACPI alike. One way of solving

Yes, DT also has this problem.

> it is requesting ACS at IORT init following appropriate checks (ie
> mappings PCI->IOMMU - that would not solve the OF path though). I can
> put together a quick fix, the overall problem needs some thinking
> though.

I am not familiar with IORT init, but can we do it like:

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index a3215ee..a6f1a21 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1131,6 +1131,7 @@ static void __init iort_init_platform_devices(void)
				acpi_free_fwnode_static(fwnode);
				return;
			}
+ 			pci_request_acs();
		}

		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,

Best,
Zhou

> 
> Lorenzo
> 
> .
> 

From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Tue, 29 May 2018 11:27:33 +0100
Subject: [PATCH v2 39/40] iommu/arm-smmu-v3: Add support for PRI
In-Reply-To: <BLUPR0201MB150513BBAA161355DE9B3A48A5690@BLUPR0201MB1505.namprd02.prod.outlook.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-40-jean-philippe.brucker@arm.com>
 <BLUPR0201MB150513BBAA161355DE9B3A48A5690@BLUPR0201MB1505.namprd02.prod.outlook.com>
Message-ID: <4e36ddb0-f1c3-f434-d330-be2dc9b88bb8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/05/18 15:08, Bharat Kumar Gogada wrote:
>> +	master->can_fault = true;
>> +	master->ste.prg_resp_needs_ssid =
>> pci_prg_resp_requires_prefix(pdev);
> 
> Any reason why this is not cleared in arm_smmu_disable_pri ?

Actually, setting it here is wrong. Since we now call enable_pri()
lazily, prg_resp_needs_ssid isn't initialized when writing the STE. That
bit is read by the SMMU when the PRIQ is full and it needs to
auto-respond. Fortunately the PRI doesn't need to be enabled in order to
read this bit, so we can move pci_prg_resp_requires_prefix() to
add_device() and clear the bit in remove_device(). Thanks for catching this.

Jean

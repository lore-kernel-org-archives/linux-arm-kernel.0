From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 12 Apr 2017 14:03:25 -0400
Subject: [PATCH 2/2] arm64: acpi/pci: invoke _DSM whether to preserve
 firmware PCI setup
In-Reply-To: <20170412172623.GA11570@red-moon>
References: <20170411163313.18577-1-ard.biesheuvel@linaro.org>
 <20170411163313.18577-3-ard.biesheuvel@linaro.org>
 <20170412172623.GA11570@red-moon>
Message-ID: <0b453fdf-8f25-8ee8-678d-996dbf2f3e48@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/12/2017 1:26 PM, Lorenzo Pieralisi wrote:
>> +	if (obj && obj->type == ACPI_TYPE_INTEGER && obj->integer.value == 0) {
>> +		/* preserve existing resource assignment */
>> +		pci_bus_claim_resources(bus);
> Ok. By the PCI FW specs, we should also assign unassigned resources here
> (ie resources that can't be claimed). Furthermore, by the PCI FW spec,
> if !obj this is the path we should be taking (PCI firmware specification
> Rev 3.1, 4.6.5, Description: 0:)
> 
> "...This situation is the same as the legacy situation where this
> _DSM is not provided."
> 
> which makes me think that the PCI FW specification expects FW set-up
> to be claimed on boot, it is my interpretation.
> 
> I wonder how many UEFI developers know this _DSM even exists. If we
> want to enforce it at least we should mandate its usage at SBSA level,
> it is a major change and I want to understand the reasons behind it,
> so far, as I said, I may see why this was needed on x86 but on ARM64
> I really don't.

IMO, DSMs are always considered optional to enable additional features
in the operating system that otherwise are not required or are not defined
in any of the PCI specs. 

I think we are abusing the DSM here. We want to require the presence of
a DSM but we want to require it to be 0 in order to have a UEFI
compatible behavior. 

I think we need to turn it the other way around by having a UEFI compatible
behavior and do reassign only if this DSM is 1.

I understand that you are worried about regressions. We can try to fix
it however time it takes before merging this.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

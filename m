From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 22 Nov 2017 00:55:48 -0500
Subject: [PATCH 30/30] PCI: remove pci_get_bus_and_slot() function
In-Reply-To: <c0df99c9-9170-be3a-3789-6b25be30936f@codeaurora.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
 <1511328675-21981-31-git-send-email-okaya@codeaurora.org>
 <c0df99c9-9170-be3a-3789-6b25be30936f@codeaurora.org>
Message-ID: <6a78596e-720a-80a2-9d96-dcc79a32f677@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/22/2017 12:45 AM, Timur Tabi wrote:
> On 11/21/17 11:31 PM, Sinan Kaya wrote:
>> Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
>> extract the domain number. Other places, use the actual domain number from
>> the device.
>>
>> Now that all users of pci_get_bus_and_slot() switched to
>> pci_get_domain_bus_and_slot(), it is now safe to remove this function.
> 
> This doesn't really eliminate pci_get_bus_and_slot(), because it doesn't force developers to support non-zero domains.? What's to stop a driver developer from doing this?
> 
> #define pci_get_bus_and_slot(b, d) pci_get_domain_bus_and_slot(0, b, d)
> 
> thereby completely ignoring what you're trying to do?
> 

Surely, the goal is not to eliminate all domain 0 users/assumptions but open the
path for flexibility over time. 

There are patches in this series where I hard-coded a value of 0 because domain
information was not available.

For places where domain number information is available, I extracted domain number
and added into pci_get_domain_bus_and_slot() call such as xen or bn drivers.

This will allow these drivers to be used with non-zero segment numbers. These
issues were missed until this refactoring took place.

pci_get_domain_bus_and_slot() function makes the developer think about where to
find the domain number as it is mandatory. 

I also double checked that all current users of pci_get_domain_bus_and_slot()
are actually extracting the domain number correctly along with the bus, device,
function.

The assumption at this point is for pci_get_bus_and_slot() usages to be caught
in code-review.

This is a best-effort approach towards flexibility.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

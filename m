From: ddaney@caviumnetworks.com (David Daney)
Date: Fri, 18 Sep 2015 10:00:32 -0700
Subject: [PATCH 2/3] PCI: Add quirks for devices found on Cavium ThunderX
 SoCs.
In-Reply-To: <3066583.BWDZlYWxXU@wuerfel>
References: <1442529694-1792-1-git-send-email-ddaney.cavm@gmail.com>
 <1442529694-1792-3-git-send-email-ddaney.cavm@gmail.com>
 <3066583.BWDZlYWxXU@wuerfel>
Message-ID: <55FC4330.10302@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2015 12:19 AM, Arnd Bergmann wrote:
> On Thursday 17 September 2015 15:41:33 David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> The on-chip devices all have fixed bars.  So, fix them up.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>>
>
> You should be able to just mark the BARs as fixed in DT

In the case of ACPI, there is no DT.  So we would need a different 
solution for ACPI.  What would you recommend for ACPI?

Also, can you point me to the OF device tree specification where it 
tells how to specify PCI BAR addresses, I would especially be interested 
in knowing how to specify fixed SRIOV BAR addresses in the device tree.

Thanks,
David Daney

> and not need
> this hack.

Yes, it is a bit of a hack.  That is why I put it in its own file, and 
only try to hack up PCI devices that exactly match the vendor and device 
ids that need fixing.

IMHO, putting infrastructure into drivers/pci/probe.c, et al. to handle 
this would be much more intrusive.

For the record:  The PCI Enhanced Allocation (EA) capability (approved 
by PCI SIG on 23 October 2014) is the proper way to handle this going 
forward.  However, this is not yet implemented in the SoCs that this 
patch addresses.  Our plan is to implement the EA capability in the core 
PCI code, so that we do not need to keep adding devices to this fixup code.

David Daney

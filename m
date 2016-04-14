From: jchandra@broadcom.com (Jayachandran C)
Date: Thu, 14 Apr 2016 21:10:00 +0530
Subject: [PATCH v2 2/4] PCI: Provide common functions for ECAM mapping
In-Reply-To: <570C4034.20105@caviumnetworks.com>
References: <1460414707-19153-1-git-send-email-jchandra@broadcom.com>
 <1460414707-19153-3-git-send-email-jchandra@broadcom.com>
 <570C4034.20105@caviumnetworks.com>
Message-ID: <CAKc_7PWp-NJz52KJyHnqSFMW4gsyS17yb01v_p02XWmdUkeTdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2016 at 5:54 AM, David Daney <ddaney@caviumnetworks.com> wrote:
> On 04/11/2016 03:45 PM, Jayachandran C wrote:
>>
>> Add config option PCI_GENERIC_ECAM and file drivers/pci/ecam.c to
>> provide generic functions for accessing memory mapped PCI config space.
>>
>> The API is defined in drivers/pci/ecam.h and is written to replace the
>> API in drivers/pci/host/pci-host-common.h. The file defines a new
>> 'struct pci_config_window' to hold the information related to a PCI
>> config area and its mapping. This structure is expected to be used as
>> sysdata for controllers that have ECAM based mapping.
>>
>> Helper functions are provided to setup the mapping, free the mapping
>> and to implement the map_bus method in 'struct pci_ops'
>>
>> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
>
> Tested-by: David Daney <david.daney@cavium.com>

I have updated the git tree (https://github.com/jchandra-brcm/linux/)
with a branch arm64-acpi-pci-v3 . The branch has a new patch to use
thunder ECAM ops in case of Cavium ThunderX platform when doing
generic ACPI PCI initialization.

I am hoping that the controllers that have "ECAM with quirks" can
use this mechanism for sharing the quirks between OF and ACPI.

If you have some time to review the patch and see it works for you,
then I can post it with the v3 of this patchset.

>> ---
>>   drivers/pci/Kconfig  |   3 ++
>>   drivers/pci/Makefile |   2 +
>>   drivers/pci/ecam.c   | 130
>> +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/pci/ecam.h   |  58 +++++++++++++++++++++++
>
>
> I wonder if these files should go in drivers/pci/host ...  I understand that
> you still have to use them from drivers/pci/acpi though.
>
> I will let others opine on this, but could you put the contents of ecam.h
> into include/linux/pci.h along with the  pci_generic_config_*()
> declarations?
>
> If you did that, the contents of ecam.c could  go into
> drivers/pci/access.c...

Earlier discussion seems to indicated that separate ecam.c/h was
preferred. But I agree that it may be small enough to be merged.

Thanks,
JC.

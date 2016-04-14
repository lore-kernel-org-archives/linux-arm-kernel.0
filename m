From: jchandra@broadcom.com (Jayachandran C)
Date: Thu, 14 Apr 2016 19:45:43 +0530
Subject: [PATCH v2 3/4] PCI: generic,
 thunder: update to use generic ECAM API
In-Reply-To: <570C429A.6090006@caviumnetworks.com>
References: <1460414707-19153-1-git-send-email-jchandra@broadcom.com>
 <1460414707-19153-4-git-send-email-jchandra@broadcom.com>
 <570C429A.6090006@caviumnetworks.com>
Message-ID: <CAKc_7PXdVYmm5LEUzCttagf9b4O9R--3OO1+u1CXTjGgi-K_rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Tue, Apr 12, 2016 at 6:04 AM, David Daney <ddaney@caviumnetworks.com> wrote:
> On 04/11/2016 03:45 PM, Jayachandran C wrote:
>>
>> Use functions provided by drivers/pci/ecam.h for mapping the config
>> space in drivers/pci/host/pci-host-common.c, and update its users to
>> use 'struct pci_config_window' and 'struct pci_generic_ecam_ops'
>>
>> The changes are mostly to use 'struct pci_config_window' in place of
>> 'struct gen_pci'. Some of the fields of gen_pci were only used
>> temporarily and can be eliminated by using local variables or function
>> arguments, these are not carried over to struct pci_config_window.
>>
>> pci-thunder-ecam.c and pci-thunder-pem.c are the only users of the
>> pci_host_common_probe function and the gen_pci structure, these have
>> been updated to use the new API as well.
>>
>> The patch does not introduce any functional changes other than a very
>> minor one: with the new code, on 64-bit platforms, we do just a single
>> ioremap for the whole config space.
>>
>> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
>
>
> Tested-by: David Daney <david.daney@cavium.com>

Thanks.

> However, ...
>
>> ---
>>   drivers/pci/ecam.h                  |   5 ++
>>   drivers/pci/host/Kconfig            |   1 +
>>   drivers/pci/host/pci-host-common.c  | 121
>> ++++++++++++++++--------------------
>>   drivers/pci/host/pci-host-common.h  |  47 --------------
>>   drivers/pci/host/pci-host-generic.c |  50 +++------------
>>   drivers/pci/host/pci-thunder-ecam.c |  37 +++--------
>>   drivers/pci/host/pci-thunder-pem.c  |  53 +++++-----------
>
>
> ... The patch conflicts with a bug-fix patch I just sent to
> pci-thunder-pem.c, so there will be a race to see who gets in first.

I would expect this patchset to take more time than the bugfix.
I will update the patches when the fix is queued to -next.

> Also, I don't know if it would make sense to split out the pci-thunder-*
> changes to a separate patch.

In this case, I think splitting the pci-thunder-* will make it more
complex than just switching everything to ecam.h in one go.

If the patch needs to be split, I can move some of the simplification
that was done to gen_pci structure and pci-host-common to a separate
patch.

JC.

From: julien.grall@citrix.com (Julien Grall)
Date: Mon, 28 Sep 2015 15:01:47 +0100
Subject: [PATCH] xen/pci: Don't build Xen pci code for ARM and ARM64
In-Reply-To: <alpine.DEB.2.02.1509281447010.2672@kaball.uk.xensource.com>
References: <1443447044-24985-1-git-send-email-julien.grall@citrix.com>
 <alpine.DEB.2.02.1509281447010.2672@kaball.uk.xensource.com>
Message-ID: <5609484B.8090605@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/09/15 14:48, Stefano Stabellini wrote:
> On Mon, 28 Sep 2015, Julien Grall wrote:
>> The PCI support for Xen doesn't compile on ARM/ARM64 when
>> CONFIG_PCI_MMCONFIG=y:
>>
>> drivers/xen/pci.c:31:25: fatal error: asm/pci_x86.h: No such file or
>> directory
>>  #include <asm/pci_x86.h>
>>
>> Although, Xen is not currently involved in PCI management for ARM/ARM64.
>> There is plan to support it, but it would require some changes in Linux
>> side.
>>
>> For now, introduce a new config options XEN_PCI which will be turned off
>> for ARM platform.
>>
>> Reported-by: Robert Richter <robert.richter@caviumnetworks.com>
>> Signed-off-by: Julien Grall <julien.grall@citrix.com>
>>
>> ---
>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Cc: David Vrabel <david.vrabel@citrix.com>
>> ---
>>  drivers/xen/Kconfig  | 6 +++++-
>>  drivers/xen/Makefile | 2 +-
>>  2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
>> index 73708ac..6bcc8b0 100644
>> --- a/drivers/xen/Kconfig
>> +++ b/drivers/xen/Kconfig
>> @@ -168,7 +168,7 @@ config XEN_TMEM
>>  
>>  config XEN_PCIDEV_BACKEND
>>  	tristate "Xen PCI-device backend driver"
>> -	depends on PCI && X86 && XEN
>> +	depends on XEN_PCI
>>  	depends on XEN_BACKEND
>>  	default m
>>  	help
>> @@ -189,6 +189,10 @@ config XEN_PCIDEV_BACKEND
>>  
>>  	  If in doubt, say m.
>>  
>> +config XEN_PCI
>> +	def_bool y
>> +	depends on PCI && !ARM && !ARM64
> 
> This is confusing because x86 already has PCI_XEN, see arch/x86/Kconfig.
> Just move PCI_XEN from arch/x86/Kconfig to here and disable it for ARM?

PCI_XEN enables SWIOTLB. Do we really want the same dependencies for any
architecture?

Regards,



-- 
Julien Grall

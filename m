From: xuwei5@hisilicon.com (Wei Xu)
Date: Thu, 30 Mar 2017 09:32:57 +0100
Subject: [PATCH v9 10/15] ACPI: platform-msi: retrieve dev id from IORT
In-Reply-To: <58DC7674.8020301@linaro.org>
References: <1488890410-15503-1-git-send-email-guohanjun@huawei.com>
 <1488890410-15503-11-git-send-email-guohanjun@huawei.com>
 <20170329101400.GA10807@red-moon> <58DBA010.1020002@linaro.org>
 <20170329123821.GA10988@red-moon> <58DBAFD6.7070300@linaro.org>
 <d620f35e-f335-bab5-49e0-a92375e00ea5@arm.com>
 <20170329161354.GC11297@red-moon> <20170329173243.GA6091@red-moon>
 <58DC7674.8020301@linaro.org>
Message-ID: <58DCC2B9.9020109@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

On 2017/3/30 4:07, Hanjun Guo wrote:
> On 03/30/2017 01:32 AM, Lorenzo Pieralisi wrote:
>> On Wed, Mar 29, 2017 at 05:13:54PM +0100, Lorenzo Pieralisi wrote:
>>> On Wed, Mar 29, 2017 at 03:52:47PM +0100, Marc Zyngier wrote:
>>>> On 29/03/17 14:00, Hanjun Guo wrote:
>>>>> On 03/29/2017 08:38 PM, Lorenzo Pieralisi wrote:
>>>>>> On Wed, Mar 29, 2017 at 07:52:48PM +0800, Hanjun Guo wrote:
>>>>>>> Hi Lorenzo,
>>>>>>>
>>>>>>> On 03/29/2017 06:14 PM, Lorenzo Pieralisi wrote:
>>>>>>>> Hi Hanjun, Marc,
>>>>>>>>
>>>>>>>> On Tue, Mar 07, 2017 at 08:40:05PM +0800, Hanjun Guo wrote:
> [...]
>>>>>>>>>    drivers/acpi/arm64/iort.c                     | 24 ++++++++++++++++++++++++
>>>>>>>>>    drivers/irqchip/irq-gic-v3-its-platform-msi.c |  3 ++-
>>>>>>>>>    include/linux/acpi_iort.h                     |  5 +++++
>>>>>>>>>    3 files changed, 31 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> To simplify merging ACPI/IRQCHIP changes via different trees it
>>>>>>>> would be good to split this patch; I am not sure what's the best
>>>>>>>> way of handling it though given that we would end up in a merge
>>>>>>>> ordering dependency anyway (ie we can create an empty stub
>>>>>>>> for iort_pmsi_get_dev_id() but that would create a dependency
>>>>>>>> between ARM64 and irqchip trees anyway).
>>>>>>>
>>>>>>> The first 12 patches for ACPI platform MSI and later 3 patches
>>>>>>> for mbigen have no "physical" dependency, which means they can
>>>>>>> be merged and compiled independently, they only have functional
>>>>>>> dependency only.
>>>>>>>
>>>>>>> We already had SAS, XGE, USB and even UART drivers depend on
>>>>>>> the mbigen ACPI support, so I don't think the dependency of ACPI
>>>>>>> platform MSI and mbigen patches cares much if those two parts are
>>>>>>> merged in one merge window, even they are merged independently via
>>>>>>> different tree.
>>>>>>>
>>>>>>>>
>>>>>>>> Please let me know what's your preferred way of handling this.
>>>>>>>
>>>>>>> So in my opinion, they can be merged independently via ARM64 and
>>>>>>> irqchip tree with no ordering dependency, is it OK?
>>>>>>
>>>>>> I am speaking about merging MBIgen AND ITS patches via IRQCHIP and
>>>>>> ACPI/IORT for ARM64, that's why I replied to this patch. I do not
>>>>>> think that's feasible to split patches in two separate branches
>>>>>> without having a dependency between them.
>>>>>>
>>>>>> Sure, the last three patches can go via IRQCHIP but that was not
>>>>>> my question :)
>>>>>
>>>>> Sorry, I misunderstood that :(
>>>>>
>>>>> Since it's not feasible to split patches, the best way I got is that
>>>>> we get Marc's ack then merge it.
>>>>
>>>> I believe there is a way to make this work without too much hassle. I
>>>> suggest we drop the ITS change from this patch entirely, and I instead
>>>> queue this patch:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/irqchip-4.12&id=e6db07d0f3b6da1f8cfd485776bfefa4fcdbfc45
>>>>
>>>> That way, no dependency between the two trees. Lorenzo takes all the
>>>> patches flagged "ACPI", I take all those flagged "irqchip" or "msi", and
>>>> everything should be perfectly standalone.
>>>>
>>>> Thoughts?
>>>
>>> Perfect for me. Hanjun, I can cherry pick Marc's patch above, rework
>>> this patch and post the resulting branch for everyone to have a final
>>> test.
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git acpi/arm64-acpi-4.12
>>
>> Please have a look and let me know if that's ok, I planned to send
>> a PR to Catalin by the end of the week (first 7 patches up to
>> 7fc3061df075 ("ACPI: platform: setup MSI domain for ACPI based platform
>> device")).
> 
> Perfect for me too, Lorenzo, Marc, Thank you very much.
> 
> I'm currently in paternity leave and can't reach the machine,
> I had a detail review with the patches, they looks good to me,
> Ma Jun and Wei Xu will test on Hisilicon machines and give the
> feedback.

Thanks to all of you!
Tested on D05 board with this branch, the SAS disks and XGE port are working fine.
The log is as below:

	estuary:/$ dmesg
	[    0.000000] Booting Linux on physical CPU 0x10000
	[    0.000000] Linux version 4.11.0-rc3-14418-gea60d0a (xuwei at EstBuildSvr1) (gcc version 4.9.2 20140904 (prerelease) (crosstool-NG linaro-1.13.1-4.9-2014.09 - Linaro GCC 4.9-2014.09) ) #28 SMP PREEMPT Thu Mar 30 16:15:42 CST 2017
	[    0.000000] Boot CPU: AArch64 Processor [410fd082]
	[    0.000000] efi: Getting EFI parameters from FDT:
	[    0.000000] efi: EFI v2.60 by EDK II
	[    0.000000] efi:  SMBIOS=0x3f040000  SMBIOS 3.0=0x39af0000 ACPI=0x39bc0000  ACPI 2.0=0x39bc0014  MEMATTR=0x3ccb0098
	[    0.000000] cma: Reserved 16 MiB at 0x000000003e000000


	estuary:/$ ping 192.168.1.107
	PING 192.168.1.107 (192.168.1.107): 56 data bytes
	64 bytes from 192.168.1.107: seq=0 ttl=64 time=0.273 ms
	64 bytes from 192.168.1.107: seq=1 ttl=64 time=0.102 ms
	64 bytes from 192.168.1.107: seq=2 ttl=64 time=0.103 ms
	64 bytes from 192.168.1.107: seq=3 ttl=64 time=0.098 ms
	^C
	--- 192.168.1.107 ping statistics ---
	4 packets transmitted, 4 packets received, 0% packet loss
	round-trip min/avg/max = 0.098/0.144/0.273 ms

	estuary:/$ lspci -mk
	30:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
	91:00.0 "Class 0300" "19e5" "1711" "0000" "0000"
	90:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
	20:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
	10:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
	80:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
	00:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
	c0:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
	88:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
	
	estuary:/$ cat /dev/sd
	sda   sdb   sdc   sdd   sde   sdf   sdg   sdh   sdi   sdj   sdk sdl
	sda1  sdb1  sdc1  sdd1  sde1  sdf1  sdg1  sdh1  sdi1  sdj1  sdk1 sdl1

Best Regards,
Wei

> 
> Thanks
> Hanjun
> 
> .
> 

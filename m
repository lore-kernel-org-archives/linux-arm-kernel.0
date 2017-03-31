From: majun258@huawei.com (majun (Euler7))
Date: Fri, 31 Mar 2017 10:41:26 +0800
Subject: [PATCH v9 10/15] ACPI: platform-msi: retrieve dev id from IORT
In-Reply-To: <20170330165401.GA16741@red-moon>
References: <58DBA010.1020002@linaro.org> <20170329123821.GA10988@red-moon>
 <58DBAFD6.7070300@linaro.org> <d620f35e-f335-bab5-49e0-a92375e00ea5@arm.com>
 <20170329161354.GC11297@red-moon> <20170329173243.GA6091@red-moon>
 <58DC7674.8020301@linaro.org> <58DCC2B9.9020109@hisilicon.com>
 <20170330142820.GA6865@red-moon>
 <71ff43b9-788d-ee38-f223-bda4750444d4@huawei.com>
 <20170330165401.GA16741@red-moon>
Message-ID: <58DDC1D6.6070203@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo:

? 2017/3/31 0:54, Lorenzo Pieralisi ??:
> On Thu, Mar 30, 2017 at 05:14:34PM +0100, John Garry wrote:
>>
>>>>>>>
>>>>>>> Perfect for me. Hanjun, I can cherry pick Marc's patch above, rework
>>>>>>> this patch and post the resulting branch for everyone to have a final
>>>>>>> test.
[...]
>>>>
>>>> Thanks to all of you!
>>>> Tested on D05 board with this branch, the SAS disks and XGE port are working fine.
>>>
>>> Ma Jun and Wei Xu, I pushed out a signed tag in preparation for a pull
>>> request to Catalin tomorrow, please carry out last few checks before
>>> I send it:
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git tags/acpi-arm64-for-v4.12
>>>
>>> You should try to merge it with Marc's branch:
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/irqchip-4.12
>>>
>>> and test the resulting branch, that's how they will go upstream.
>>>
>>> Please let me know, thank you for your help !
>>>
>>
>> Hi Lorenzo,
>>
>> xuwei is away now, and it is night time with majun, so I tested.
>> majun can retest tomorrow again to triple-check. I did not touch the
>> ITS patch Marc made which had the weak version of
>> iort_pmis_get_dev_id(), but it should not affect anything in my
>> test.
>>
>> After merging your tag to Marc's branch, here is the git log:
>> git log --oneline
>> 8b6f3f8 Merge tag 'acpi-arm64-for-v4.12' into irq/irqchip-4.12
>> d4f54a1 ACPI: platform: setup MSI domain for ACPI based platform device
>> ae7c183 ACPI: platform-msi: retrieve devid from IORT
>> e6db07d irqchip/gic-v3-its: Add IORT hook for platform MSI support
>> 8ca4f1d ACPI/IORT: Introduce iort_node_map_platform_id() to retrieve dev id
>> 697f609 ACPI/IORT: Rename iort_node_map_rid() to make it generic
>> d11349c irqchip: mbigen: Add ACPI support
>> aa15f11 irqchip: mbigen: introduce mbigen_of_create_domain()
>> 964bac1 irqchip: mbigen: drop module owner
>> b8302fe msi: platform: make platform_msi_create_device_domain() ACPI aware
>> d264edb irqchip: gicv3-its: platform-msi: scan MADT to create
>> platform msi domain
>> baf1168 irqchip: gicv3-its: platform-msi: refactor its_pmsi_init()
>> to prepare for ACPI
>> fbdda90 irqchip: gicv3-its: platform-msi: refactor its_pmsi_prepare()
>> cc9eb0d irqchip: gic-v3-its: keep the include header files in
>> alphabetic order
>> ff3eeb4 irqchip: mtk-sysirq: prevent unnecessary visibility when set_type
>> ea04362 irqchip: mtk-sysirq: extend intpol base to arbitrary number
>> 3382357 dt-bindings: mediatek: multiple bases support for sysirq
>> 4015616 irqchip: replace moxa with ftintc010
>> 532278c irqchip: faraday: fix the trigger types
>> 923fa67 irqchip: refactor Gemini driver to reflect Faraday origin
>> 44d64ce irqchip: augment Gemini bindings to reflect Faraday origin
>> c02ed2e Linux 4.11-rc4
>>
>> And some testing:
>>
[...]
>>
>> Disk /dev/sdf: 186.3 GiB, 200049647616 bytes, 390721968 sectors
>> Units: sectors of 1 * 512 = 512 bytes
>> Sector size (logical/physical): 512 bytes / 512 bytes
>> I/O size (minimum/optimal): 512 bytes / 131072 bytes
>>
>> root@(none)$
>>
>> Looks ok
> 
> Great, thanks !
> 
>> @majun, please test as well.
> 
> Yes, final test, PR is ready to be sent, I reviewed Hanjun patches
> but I just want to avoid breaking them given that we had to carry
> out changes for the split PR.
> 
I tested these patches again as you suggested, all of the related devices?
xge/sas/usb/uart, are working fine on my hisilicon board just like before.

The git log is:
565fdf3 Merge tag 'acpi-arm64-for-v4.12' into marc-irq-4.12
d4f54a1 ACPI: platform: setup MSI domain for ACPI based platform device
ae7c183 ACPI: platform-msi: retrieve devid from IORT
e6db07d irqchip/gic-v3-its: Add IORT hook for platform MSI support
8ca4f1d ACPI/IORT: Introduce iort_node_map_platform_id() to retrieve dev id
697f609 ACPI/IORT: Rename iort_node_map_rid() to make it generic
d11349c irqchip: mbigen: Add ACPI support
aa15f11 irqchip: mbigen: introduce mbigen_of_create_domain()
964bac1 irqchip: mbigen: drop module owner
b8302fe msi: platform: make platform_msi_create_device_domain() ACPI aware
d264edb irqchip: gicv3-its: platform-msi: scan MADT to create platform msi domain
baf1168 irqchip: gicv3-its: platform-msi: refactor its_pmsi_init() to prepare for ACPI
fbdda90 irqchip: gicv3-its: platform-msi: refactor its_pmsi_prepare()
cc9eb0d irqchip: gic-v3-its: keep the include header files in alphabetic order
ff3eeb4 irqchip: mtk-sysirq: prevent unnecessary visibility when set_type
ea04362 irqchip: mtk-sysirq: extend intpol base to arbitrary number
3382357 dt-bindings: mediatek: multiple bases support for sysirq
4015616 irqchip: replace moxa with ftintc010
532278c irqchip: faraday: fix the trigger types
923fa67 irqchip: refactor Gemini driver to reflect Faraday origin
44d64ce irqchip: augment Gemini bindings to reflect Faraday origin
c02ed2e Linux 4.11-rc4

Thanks
Ma Jun

> Thanks,
> Lorenzo
> 
>>
>> Thanks,
>> John
>>
>>> Lorenzo
>>>
>>>> The log is as below:
>>>>
>>>> 	estuary:/$ dmesg
>>>> 	[    0.000000] Booting Linux on physical CPU 0x10000
>>>> 	[    0.000000] Linux version 4.11.0-rc3-14418-gea60d0a (xuwei at EstBuildSvr1) (gcc version 4.9.2 20140904 (prerelease) (crosstool-NG linaro-1.13.1-4.9-2014.09 - Linaro GCC 4.9-2014.09) ) #28 SMP PREEMPT Thu Mar 30 16:15:42 CST 2017
>>>> 	[    0.000000] Boot CPU: AArch64 Processor [410fd082]
>>>> 	[    0.000000] efi: Getting EFI parameters from FDT:
>>>> 	[    0.000000] efi: EFI v2.60 by EDK II
>>>> 	[    0.000000] efi:  SMBIOS=0x3f040000  SMBIOS 3.0=0x39af0000 ACPI=0x39bc0000  ACPI 2.0=0x39bc0014  MEMATTR=0x3ccb0098
>>>> 	[    0.000000] cma: Reserved 16 MiB at 0x000000003e000000
>>>>
>>>>
>>>> 	estuary:/$ ping 192.168.1.107
>>>> 	PING 192.168.1.107 (192.168.1.107): 56 data bytes
>>>> 	64 bytes from 192.168.1.107: seq=0 ttl=64 time=0.273 ms
>>>> 	64 bytes from 192.168.1.107: seq=1 ttl=64 time=0.102 ms
>>>> 	64 bytes from 192.168.1.107: seq=2 ttl=64 time=0.103 ms
>>>> 	64 bytes from 192.168.1.107: seq=3 ttl=64 time=0.098 ms
>>>> 	^C
>>>> 	--- 192.168.1.107 ping statistics ---
>>>> 	4 packets transmitted, 4 packets received, 0% packet loss
>>>> 	round-trip min/avg/max = 0.098/0.144/0.273 ms
>>>>
>>>> 	estuary:/$ lspci -mk
>>>> 	30:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
>>>> 	91:00.0 "Class 0300" "19e5" "1711" "0000" "0000"
>>>> 	90:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
>>>> 	20:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
>>>> 	10:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
>>>> 	80:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
>>>> 	00:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
>>>> 	c0:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
>>>> 	88:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
>>>> 	
>>>> 	estuary:/$ cat /dev/sd
>>>> 	sda   sdb   sdc   sdd   sde   sdf   sdg   sdh   sdi   sdj   sdk sdl
>>>> 	sda1  sdb1  sdc1  sdd1  sde1  sdf1  sdg1  sdh1  sdi1  sdj1  sdk1 sdl1
>>>>
>>>> Best Regards,
>>>> Wei
>>>>
>>>>>
>>>>> Thanks
>>>>> Hanjun
>>>>>
>>>>> .
>>>>>
>>>>
>>> _______________________________________________
>>> linuxarm mailing list
>>> linuxarm at huawei.com
>>> http://rnd-openeuler.huawei.com/mailman/listinfo/linuxarm
>>>
>>> .
>>>
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 

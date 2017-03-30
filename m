From: john.garry@huawei.com (John Garry)
Date: Thu, 30 Mar 2017 17:14:34 +0100
Subject: [PATCH v9 10/15] ACPI: platform-msi: retrieve dev id from IORT
In-Reply-To: <20170330142820.GA6865@red-moon>
References: <1488890410-15503-11-git-send-email-guohanjun@huawei.com>
 <20170329101400.GA10807@red-moon> <58DBA010.1020002@linaro.org>
 <20170329123821.GA10988@red-moon> <58DBAFD6.7070300@linaro.org>
 <d620f35e-f335-bab5-49e0-a92375e00ea5@arm.com>
 <20170329161354.GC11297@red-moon> <20170329173243.GA6091@red-moon>
 <58DC7674.8020301@linaro.org> <58DCC2B9.9020109@hisilicon.com>
 <20170330142820.GA6865@red-moon>
Message-ID: <71ff43b9-788d-ee38-f223-bda4750444d4@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>>>>>
>>>>> Perfect for me. Hanjun, I can cherry pick Marc's patch above, rework
>>>>> this patch and post the resulting branch for everyone to have a final
>>>>> test.
>>>>
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git acpi/arm64-acpi-4.12
>>>>
>>>> Please have a look and let me know if that's ok, I planned to send
>>>> a PR to Catalin by the end of the week (first 7 patches up to
>>>> 7fc3061df075 ("ACPI: platform: setup MSI domain for ACPI based platform
>>>> device")).
>>>
>>> Perfect for me too, Lorenzo, Marc, Thank you very much.
>>>
>>> I'm currently in paternity leave and can't reach the machine,
>>> I had a detail review with the patches, they looks good to me,
>>> Ma Jun and Wei Xu will test on Hisilicon machines and give the
>>> feedback.
>>
>> Thanks to all of you!
>> Tested on D05 board with this branch, the SAS disks and XGE port are working fine.
>
> Ma Jun and Wei Xu, I pushed out a signed tag in preparation for a pull
> request to Catalin tomorrow, please carry out last few checks before
> I send it:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git tags/acpi-arm64-for-v4.12
>
> You should try to merge it with Marc's branch:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/irqchip-4.12
>
> and test the resulting branch, that's how they will go upstream.
>
> Please let me know, thank you for your help !
>

Hi Lorenzo,

xuwei is away now, and it is night time with majun, so I tested. majun 
can retest tomorrow again to triple-check. I did not touch the ITS patch 
Marc made which had the weak version of iort_pmis_get_dev_id(), but it 
should not affect anything in my test.

After merging your tag to Marc's branch, here is the git log:
git log --oneline
8b6f3f8 Merge tag 'acpi-arm64-for-v4.12' into irq/irqchip-4.12
d4f54a1 ACPI: platform: setup MSI domain for ACPI based platform device
ae7c183 ACPI: platform-msi: retrieve devid from IORT
e6db07d irqchip/gic-v3-its: Add IORT hook for platform MSI support
8ca4f1d ACPI/IORT: Introduce iort_node_map_platform_id() to retrieve dev id
697f609 ACPI/IORT: Rename iort_node_map_rid() to make it generic
d11349c irqchip: mbigen: Add ACPI support
aa15f11 irqchip: mbigen: introduce mbigen_of_create_domain()
964bac1 irqchip: mbigen: drop module owner
b8302fe msi: platform: make platform_msi_create_device_domain() ACPI aware
d264edb irqchip: gicv3-its: platform-msi: scan MADT to create platform 
msi domain
baf1168 irqchip: gicv3-its: platform-msi: refactor its_pmsi_init() to 
prepare for ACPI
fbdda90 irqchip: gicv3-its: platform-msi: refactor its_pmsi_prepare()
cc9eb0d irqchip: gic-v3-its: keep the include header files in alphabetic 
order
ff3eeb4 irqchip: mtk-sysirq: prevent unnecessary visibility when set_type
ea04362 irqchip: mtk-sysirq: extend intpol base to arbitrary number
3382357 dt-bindings: mediatek: multiple bases support for sysirq
4015616 irqchip: replace moxa with ftintc010
532278c irqchip: faraday: fix the trigger types
923fa67 irqchip: refactor Gemini driver to reflect Faraday origin
44d64ce irqchip: augment Gemini bindings to reflect Faraday origin
c02ed2e Linux 4.11-rc4

And some testing:

dmesg snippet:
[    0.000000] Booting Linux on physical CPU 0x10000
[    0.000000] Linux version 4.11.0-rc4-00420-g8b6f3f8 
(johnpgarry at johnpgarry-ThinkCentre-M93p) (gcc version 4.8.5 (Linaro GCC 
4.8-2015.06) ) #4 SMP PREEMPT Thu Mar 30 16:40:36 BST 2017
[    0.000000] Boot CPU: AArch64 Processor [410fd082]
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.60 by EDK II
[    0.000000] efi:  SMBIOS=0x3f040000  SMBIOS 3.0=0x39af0000 
ACPI=0x39bc0000  ACPI 2.0=0x39bc0014  MEMATTR=0x3cc86018
[    0.000000] cma: Reserved 16 MiB at 0x000000003e000000
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x0000000039BC0014 000024 (v02 HISI  )
[    0.000000] ACPI: XSDT 0x0000000039BB00E8 00006C (v01 HISI   HIP07 
00000000      01000013)
[    0.000000] ACPI: FACP 0x0000000039A80000 00010C (v05 HISI   HIP07 
00000000 INTL 20151124)
[    0.000000] ACPI: DSDT 0x0000000039A40000 0074E2 (v02 HISI   HIP07 
00000000 INTL 20151218)
[    0.000000] ACPI: MCFG 0x0000000039AD0000 0000AC (v01 HISI   HIP07 
00000000 INTL 20151124)
[    0.000000] ACPI: SLIT 0x0000000039AC0000 00003C (v01 HISI   HIP07 
00000000 INTL 20151124)
[    0.000000] ACPI: SPCR 0x0000000039AB0000 000050 (v02 HISI   HIP07 
00000000 INTL 20151124)
[    0.000000] ACPI: SRAT 0x0000000039AA0000 000500 (v03 HISI   HIP07 
00000000 INTL 20151124)
[    0.000000] ACPI: GTDT 0x0000000039A70000 000098 (v02 HISI   HIP07 
00000000 INTL 20151124)
[    0.000000] ACPI: APIC 0x0000000039A60000 0013E4 (v01 HISI   HIP07 
00000000 INTL 20151124)
[    0.000000] ACPI: IORT 0x0000000039A50000 000514 (v00 HISI   HIP07 
00000000 INTL 20151218)
[    0.000000] ACPI: iBFT 0x0000000031870000 000800 (v01 HISI   HIP07 
00000000      00000000)

PCI:
root@(none)$ lspci -mk
30:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
91:00.0 "Class 0300" "19e5" "1711" "0000" "0000"
90:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
20:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
10:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
80:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
00:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
c0:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
88:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"

Integrated NIC:
root@(none)$ ifconfig eth1 172.18.45.80 up
root@(none)$ [  345.449591] hns-nic HISI00C2:01 eth1: link up
root@(none)$ ping 172.18.45.23
PING 172.18.45.23 (172.18.45.23): 56 data bytes
64 bytes from 172.18.45.23: seq=0 ttl=64 time=2026.837 ms
64 bytes from 172.18.45.23: seq=1 ttl=64 time=1026.843 ms
64 bytes from 172.18.45.23: seq=2 ttl=64 time=26.834 ms
64 bytes from 172.18.45.23: seq=3 ttl=64 time=0.075 ms
64 bytes from 172.18.45.23: seq=4 ttl=64 time=0.079 ms
^C
--- 172.18.45.23 ping statistics ---
5 packets transmitted, 5 packets received, 0% packet loss
round-trip min/avg/max = 0.075/616.133/2026.837 ms



Integrated Storage controller:
root@(none)$ fdisk -l
Disk /dev/sdb: 3.7 TiB, 4000787030016 bytes, 7814037168 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xdb9f5cd0

Device    Boot     Start       End    Blocks  Id System
/dev/sdb1           2048 209717247 104857600  83 Linux
/dev/sdb2      209717248 419432447 104857600  83 Linux


Disk /dev/sda: 186.3 GiB, 200049647616 bytes, 390721968 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 131072 bytes

Disk /dev/sdc: 186.3 GiB, 200049647616 bytes, 390721968 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 131072 bytes

Disk /dev/sdd: 186.3 GiB, 200049647616 bytes, 390721968 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 131072 bytes

Disk /dev/sde: 186.3 GiB, 200049647616 bytes, 390721968 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 131072 bytes

Disk /dev/sdf: 186.3 GiB, 200049647616 bytes, 390721968 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 131072 bytes

root@(none)$

Looks ok

@majun, please test as well.

Thanks,
John

> Lorenzo
>
>> The log is as below:
>>
>> 	estuary:/$ dmesg
>> 	[    0.000000] Booting Linux on physical CPU 0x10000
>> 	[    0.000000] Linux version 4.11.0-rc3-14418-gea60d0a (xuwei at EstBuildSvr1) (gcc version 4.9.2 20140904 (prerelease) (crosstool-NG linaro-1.13.1-4.9-2014.09 - Linaro GCC 4.9-2014.09) ) #28 SMP PREEMPT Thu Mar 30 16:15:42 CST 2017
>> 	[    0.000000] Boot CPU: AArch64 Processor [410fd082]
>> 	[    0.000000] efi: Getting EFI parameters from FDT:
>> 	[    0.000000] efi: EFI v2.60 by EDK II
>> 	[    0.000000] efi:  SMBIOS=0x3f040000  SMBIOS 3.0=0x39af0000 ACPI=0x39bc0000  ACPI 2.0=0x39bc0014  MEMATTR=0x3ccb0098
>> 	[    0.000000] cma: Reserved 16 MiB at 0x000000003e000000
>>
>>
>> 	estuary:/$ ping 192.168.1.107
>> 	PING 192.168.1.107 (192.168.1.107): 56 data bytes
>> 	64 bytes from 192.168.1.107: seq=0 ttl=64 time=0.273 ms
>> 	64 bytes from 192.168.1.107: seq=1 ttl=64 time=0.102 ms
>> 	64 bytes from 192.168.1.107: seq=2 ttl=64 time=0.103 ms
>> 	64 bytes from 192.168.1.107: seq=3 ttl=64 time=0.098 ms
>> 	^C
>> 	--- 192.168.1.107 ping statistics ---
>> 	4 packets transmitted, 4 packets received, 0% packet loss
>> 	round-trip min/avg/max = 0.098/0.144/0.273 ms
>>
>> 	estuary:/$ lspci -mk
>> 	30:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
>> 	91:00.0 "Class 0300" "19e5" "1711" "0000" "0000"
>> 	90:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
>> 	20:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
>> 	10:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
>> 	80:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
>> 	00:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
>> 	c0:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
>> 	88:00.0 "Class 0604" "19e5" "1610" "0000" "0000" "pcieport"
>> 	
>> 	estuary:/$ cat /dev/sd
>> 	sda   sdb   sdc   sdd   sde   sdf   sdg   sdh   sdi   sdj   sdk sdl
>> 	sda1  sdb1  sdc1  sdd1  sde1  sdf1  sdg1  sdh1  sdi1  sdj1  sdk1 sdl1
>>
>> Best Regards,
>> Wei
>>
>>>
>>> Thanks
>>> Hanjun
>>>
>>> .
>>>
>>
> _______________________________________________
> linuxarm mailing list
> linuxarm at huawei.com
> http://rnd-openeuler.huawei.com/mailman/listinfo/linuxarm
>
> .
>

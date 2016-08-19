From: rogerq@ti.com (Roger Quadros)
Date: Fri, 19 Aug 2016 10:30:35 +0300
Subject: [PATCH 1/1] ARM: dma: fix dma_max_pfn()
In-Reply-To: <f8a05c02-df36-a0cf-6433-c67eb4a0f5b6@oracle.com>
References: <1471435517-7840-1-git-send-email-rogerq@ti.com>
 <1471435517-7840-2-git-send-email-rogerq@ti.com>
 <20160818142459.GX1041@n2100.armlinux.org.uk>
 <8003b6ed-6071-9384-1b88-0b84604bdce8@oracle.com>
 <20160818230754.GE1041@n2100.armlinux.org.uk>
 <f8a05c02-df36-a0cf-6433-c67eb4a0f5b6@oracle.com>
Message-ID: <9c38663b-1867-213d-21ba-f1dec7edfb6a@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

On 19/08/16 05:01, Santosh Shilimkar wrote:
> On 8/18/2016 4:07 PM, Russell King - ARM Linux wrote:
>> On Thu, Aug 18, 2016 at 09:55:55AM -0700, Santosh Shilimkar wrote:
>>> Hi Russell,
>>>
>>> On 8/18/2016 7:24 AM, Russell King - ARM Linux wrote:
>>>> On Wed, Aug 17, 2016 at 03:05:17PM +0300, Roger Quadros wrote:
>>>>> Since commit 6ce0d2001692 ("ARM: dma: Use dma_pfn_offset for dma address translation"),
>>>>> dma_to_pfn() already returns the PFN with the physical memory start offset
>>>>> so we don't need to add it again.
>>>>>
>>>>> This fixes USB mass storage lock-up problem on systems that can't do DMA
>>>>> over the entire physical memory range (e.g.) Keystone 2 systems with 4GB RAM
>>>>> can only do DMA over the first 2GB. [K2E-EVM].
>>>>>
>>>>> What happens there is that without this patch SCSI layer sets a wrong
>>>>> bounce buffer limit in scsi_calculate_bounce_limit() for the USB mass
>>>>> storage device. dma_max_pfn() evaluates to 0x8fffff and bounce_limit
>>>>> is set to 0x8fffff000 whereas maximum DMA'ble physical memory on Keystone 2
>>>>> is 0x87fffffff. This results in non DMA'ble pages being given to the
>>>>> USB controller and hence the lock-up.
>>>>>
>>>>> NOTE: in the above case, USB-SCSI-device's dma_pfn_offset was showing as 0.
>>>>> This should have really been 0x780000 as on K2e, LOWMEM_START is 0x80000000
>>>>> and HIGHMEM_START is 0x800000000. DMA zone is 2GB so dma_max_pfn should be
>>>>> 0x87ffff. The incorrect dma_pfn_offset for the USB storage device is because
>>>>> USB devices are not correctly inheriting the dma_pfn_offset from the
>>>>> USB host controller. This will be fixed by a separate patch.
>>>>
>>>> I'd like to hear from Santosh, as the author of the original change.
>>>> The original commit doesn't mention which platform it was intended for
>>>> or what the problem was, which would've been helpful.
>>>>
>>> From what I recollect, we did these changes to make the max pfn behave
>>> same on ARM arch as other archs. This patch was evolved as part of
>>> fixing the max*pfn assumption.
>>
>> To me, the proposed patch _looks_ correct, because...
>>
>>>>> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
>>>>> index d009f79..bf02dbd 100644
>>>>> --- a/arch/arm/include/asm/dma-mapping.h
>>>>> +++ b/arch/arm/include/asm/dma-mapping.h
>>>>> @@ -111,7 +111,7 @@ static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
>>>>> /* The ARM override for dma_max_pfn() */
>>>>> static inline unsigned long dma_max_pfn(struct device *dev)
>>>>> {
>>>>> -    return PHYS_PFN_OFFSET + dma_to_pfn(dev, *dev->dma_mask);
>>>>> +    return dma_to_pfn(dev, *dev->dma_mask);
>>>>> }
>>>>> #define dma_max_pfn(dev) dma_max_pfn(dev)
>>> By doing this change I hope we don't break other drivers on Keystone so
>>> am not sure about the change.
>>
>> dma_to_pfn() returns the page frame number referenced from physical
>> address zero - the default implementation of dma_to_pfn() is
>> bus_to_pfn(), which is __phys_to_pfn(x), which is just x >> PAGE_SHIFT.
>> The other thing about dma_to_pfn() is that it should return a
>> zero-referenced PFN number, where PFN 0 = physical address 0.
>>
>> If there is some offset for keystone2, that should be taken care of
>> via "dev->dma_pfn_offset", and not offsetting the return value from
>> dma_to_pfn().
>>
>> So I'm 99.9% convinced that the proposed change is correct.
>>
> I will got with that then :-) and take my objection back. Just
> saying that if there other breakages which I can't recollect now,
> those drivers needs to be patched as well.
> 
I was able to boot the Keystone2 Edison EVM over NFS with the $subject patch.
Boot log is below. Do you see anything suspicious?

---

U-Boot SPL 2016.05-00100-g052f3bf-dirty (Aug 10 2016 - 12:28:40)
Trying to boot from SPI


U-Boot 2016.05-00100-g052f3bf-dirty (Aug 10 2016 - 12:28:40 +0300)

CPU: 66AK2Ex SR1.0
I2C:   ready
DRAM:  DDR3A Speed will be configured for 1600 Operation.
Detected SO-DIMM [18KSF51272HZ-1G6K2]
DDR3 speed 1600
DRAM: 4 GiB

Clear entire DDR3 memory to enable ECC
2 GiB
NAND:  512 MiB
Net:   eth0: netcp at 24000000
Hit any key to stop autoboot:  0 

netcp at 24000000 Waiting for SGMII auto negotiation to complete. done
Using netcp at 24000000 device
TFTP from server 192.168.1.36; our IP address is 192.168.1.90
Filename '/tftpboot/k2-fw-initrd.cpio.gz'.
Load address: 0x88080000
Loading: ##########
         958 KiB/s
done
Bytes transferred = 48117 (bbf5 hex)

netcp at 24000000 Waiting for SGMII auto negotiation to complete. done
Using netcp at 24000000 device
TFTP from server 192.168.1.36; our IP address is 192.168.1.90
Filename 'keystone-k2e-evm.dtb'.
Load address: 0x88000000
Loading: #####
         884.8 KiB/s
done
Bytes transferred = 22660 (5884 hex)

netcp at 24000000 Waiting for SGMII auto negotiation to complete. done
Using netcp at 24000000 device
TFTP from server 192.168.1.36; our IP address is 192.168.1.90
Filename '/tftpboot/skern-k2e.bin'.
Load address: 0xc140000
Loading: #########
         956.1 KiB/s
done
Bytes transferred = 45056 (b000 hex)

netcp at 24000000 Waiting for SGMII auto negotiation to complete. done
Using netcp at 24000000 device
TFTP from server 192.168.1.36; our IP address is 192.168.1.90
Filename 'zImage'.
Load address: 0x82000000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         ####################
         1 MiB/s
done
Bytes transferred = 4427600 (438f50 hex)
K2_BM_15.07-39-g035329c SoC:k2e built:10:59:38, Jul 28 2016

## installed monitor, freq [208333333], status 0
Kernel image @ 0x82000000 [ 0x000000 - 0x438f50 ]
## Flattened Device Tree blob at 88000000
   Booting using the fdt blob at 0x88000000
   Using Device Tree in place at 88000000, end 88008883
80000000 800000000
800000000:80000000 880000000:80000000

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.8.0-rc2-00003-ga0a0676 (roger at lta0400828d) (gcc version 4.7.3 20130226 (prerelease) (crosstool-NG linaro-1.13.1-4.7-2013.03-20130313 - Linaro GCC 2013.03) ) #974 SMP PREEMPT Fri A6
[    0.000000] CPU: ARMv7 Processor [412fc0f4] revision 4 (ARMv7), cr=30c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
[    0.000000] OF: fdt:Machine model: Texas Instruments Keystone 2 Edison EVM
[    0.000000] Switching physical address space to 0x800000000
[    0.000000] cma: Reserved 16 MiB at 0x000000087ec00000
[    0.000000] Forcing write-allocate cache policy for SMP
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: Using PSCI v0.1 Function IDs from DT
[    0.000000] percpu: Embedded 14 pages/cpu @edf9f000 s27648 r8192 d21504 u57344
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1047040
[    0.000000] Kernel command line: console=ttyS0,115200n8 rootwait=1 rootfstype=nfs root=/dev/nfs rw nfsroot=192.168.1.36:/srv/nfsroot ip=dhcp
[    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 12288 bytes
[    0.000000] log_buf_len min size: 16384 bytes
[    0.000000] log_buf_len: 32768 bytes
[    0.000000] early log buf free: 14444(88%)
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 4131012K/4194304K available (6144K kernel code, 366K rwdata, 2008K rodata, 2048K init, 202K bss, 46908K reserved, 16384K cma-reserved, 3391488K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0800000   (8160 kB)
[    0.000000]       .init : 0xc0c00000 - 0xc0e00000   (2048 kB)
[    0.000000]       .data : 0xc0e00000 - 0xc0e5bbf0   ( 367 kB)
[    0.000000]        .bss : 0xc0e5d000 - 0xc0e8f9e0   ( 203 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 32.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] arm_arch_timer: Architected cp15 timer(s) running at 208.33MHz (virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x300c4cdf1c, max_idle_ns: 440795202901 ns
[    0.000003] sched_clock: 56 bits at 208MHz, resolution 4ns, wraps every 4398046511101ns
[    0.000011] Switching to timer-based delay loop, resolution 4ns
[    0.000129] keystone timer clock @208333333 Hz
[    0.000238] Console: colour dummy device 80x30
[    0.000257] Calibrating delay loop (skipped), value calculated using timer frequency.. 416.66 BogoMIPS (lpj=2083333)
[    0.000267] pid_max: default: 4096 minimum: 301
[    0.000328] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000336] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000761] CPU: Testing write buffer coherency: ok
[    0.000918] /cpus/cpu at 0 missing clock-frequency property
[    0.000934] /cpus/cpu at 1 missing clock-frequency property
[    0.000950] /cpus/cpu at 2 missing clock-frequency property
[    0.000967] /cpus/cpu at 3 missing clock-frequency property
[    0.000975] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.000987] Setting up static identity map for 0x80200000 - 0x80200130
[    0.114753] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.154800] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.194844] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.194930] Brought up 4 CPUs
[    0.194946] SMP: Total of 4 processors activated (1666.66 BogoMIPS).
[    0.194952] CPU: All CPU(s) started in SVC mode.
[    0.195471] devtmpfs: initialized
[    0.200375] VFP support v0.3: implementor 41 architecture 4 part 30 variant f rev 0
[    0.200642] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.200897] pinctrl core: initialized pinctrl subsystem
[    0.201164] NET: Registered protocol family 16
[    0.201903] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.202737] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
[    0.202744] hw-breakpoint: maximum watchpoint size is 8 bytes.
[    0.218300] vgaarb: loaded
[    0.218565] SCSI subsystem initialized
[    0.218936] usbcore: registered new interface driver usbfs
[    0.219019] usbcore: registered new interface driver hub
[    0.219112] usbcore: registered new device driver usb
[    0.220983] clocksource: Switched to clocksource arch_sys_counter
[    0.249890] NET: Registered protocol family 2
[    0.250312] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.250369] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.250474] TCP: Hash tables configured (established 8192 bind 8192)
[    0.250514] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.250539] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.250661] NET: Registered protocol family 1
[    0.250872] RPC: Registered named UNIX socket transport module.
[    0.250879] RPC: Registered udp transport module.
[    0.250885] RPC: Registered tcp transport module.
[    0.250890] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.251053] Unpacking initramfs...
[    0.252978] Initramfs unpacking failed: read error
[    0.253002] Freeing initrd memory: 32K (c8080000 - c8088000)
[    0.253146] hw perfevents: enabled with armv7_cortex_a15 PMU driver, 7 counters available
[    0.253718] platform alarmtimer: set dma_pfn_offset00780000
[    0.254334] futex hash table entries: 16 (order: -2, 1024 bytes)
[    0.255083] workingset: timestamp_bits=30 max_order=20 bucket_order=0
[    0.266086] Installing knfsd (copyright (C) 1996 okir at monad.swb.de).
[    0.266169] ntfs: driver 2.1.32 [Flags: R/O].
[    0.266501] jffs2: version 2.2. (NAND) ?? 2001-2006 Red Hat, Inc.
[    0.269063] NET: Registered protocol family 38
[    0.269102] bounce: pool size: 64 pages
[    0.269315] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    0.269324] io scheduler noop registered
[    0.269330] io scheduler deadline registered
[    0.269497] io scheduler cfq registered (default)
[    0.269642] keystone_irq soc:keystone_irq at 26202a0: irqchip registered, nr_irqs 28
[    0.270665] keystone-navigator-qmss soc:qmss at 2a40000: qmgr start queue 0, number of queues 8192
[    0.270771] keystone-navigator-qmss soc:qmss at 2a40000: added qmgr start queue 0, num of queues 8192, reg_peek f0940000, reg_status f0938000, reg_config f093a000, reg_region f093c000, reg_push f0980000, reg_po0
[    0.270891] keystone-navigator-qmss soc:qmss at 2a40000: loading /lib/firmware/ks2_qmss_pdsp_acc48.bin failed with error -26
[    0.270900] keystone-navigator-qmss soc:qmss at 2a40000: failed to get firmware for pdsp
[    0.271650] keystone-navigator-qmss soc:qmss at 2a40000: pdsp id 0 not started for range acc-low-0
[    0.272395] keystone-navigator-dma soc:knav_dmas at 0: DMA dma_gbe registered 149 logical channels, flows 128, tx chans: 21, rx chans: 91
[    0.334684] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.334763] platform serial8250: set dma_pfn_offset00780000
[    0.336304] console [ttyS0] disabled
[    0.336362] 2530c00.serial: ttyS0 at MMIO 0x2530c00 (irq = 26, base_baud = 13020833) is a 16550A
[    1.054186] console [ttyS0] enabled
[    1.058371] 2531000.serial: ttyS1 at MMIO 0x2531000 (irq = 27, base_baud = 13020833) is a 16550A
[    1.072642] loop: module loaded
[    1.076059] at24 0-0050: 131072 byte 24c1024 EEPROM, writable, 1 bytes/write
[    1.084006] spi_davinci 21000400.spi: DMA is not supported (-19)
[    1.090629] m25p80 spi0.0: n25q128a11 (16384 Kbytes)
[    1.095618] 2 ofpart partitions found on MTD device spi0.0
[    1.101129] Creating 2 MTD partitions on "spi0.0":
[    1.105913] 0x000000000000-0x000000080000 : "u-boot-spl"
[    1.112168] 0x000000080000-0x000001000000 : "misc"
[    1.117833] spi_davinci 21000400.spi: Controller at 0xf097a400
[    1.123826] spi_davinci 21000600.spi: DMA is not supported (-19)
[    1.130167] spi_davinci 21000600.spi: Controller at 0xf097c600
[    1.136138] spi_davinci 21000800.spi: DMA is not supported (-19)
[    1.142504] spi_davinci 21000800.spi: Controller at 0xf097e800
[    1.149201] platform Fixed MDIO bus.0: set dma_pfn_offset00780000
[    1.155461] libphy: Fixed MDIO Bus: probed
[    1.211007] davinci_mdio 24200f00.mdio: davinci mdio revision 1.7
[    1.217093] libphy: 24200f00.mdio: probed
[    1.221761] davinci_mdio 24200f00.mdio: phy[0]: device 24200f00.mdio:00, driver Marvell 88E1510
[    1.230451] davinci_mdio 24200f00.mdio: phy[1]: device 24200f00.mdio:01, driver Marvell 88E1510
[    4.252103] netcp-1.0 2620110.netcp: module(netcp-xgbe) not used for device
[    4.259980] platform xhci-hcd.0.auto: set dma_pfn_offset00780000
[    4.266566] platform xhci-hcd.1.auto: set dma_pfn_offset00780000
[    4.273224] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
[    4.278865] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 1
[    4.286767] xhci-hcd xhci-hcd.0.auto: hcc params 0x0298f06d hci version 0x100 quirks 0x00010010
[    4.295481] xhci-hcd xhci-hcd.0.auto: irq 34, io mem 0x02690000
[    4.301549] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    4.308329] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.315557] usb usb1: Product: xHCI Host Controller
[    4.320428] usb usb1: Manufacturer: Linux 4.8.0-rc2-00003-ga0a0676 xhci-hcd
[    4.327409] usb usb1: SerialNumber: xhci-hcd.0.auto
[    4.332755] hub 1-0:1.0: USB hub found
[    4.336521] hub 1-0:1.0: 1 port detected
[    4.340702] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
[    4.346376] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 2
[    4.354094] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    4.362297] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[    4.369077] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.376303] usb usb2: Product: xHCI Host Controller
[    4.381199] usb usb2: Manufacturer: Linux 4.8.0-rc2-00003-ga0a0676 xhci-hcd
[    4.388151] usb usb2: SerialNumber: xhci-hcd.0.auto
[    4.393481] hub 2-0:1.0: USB hub found
[    4.397244] hub 2-0:1.0: 1 port detected
[    4.401485] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[    4.407122] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 3
[    4.415007] xhci-hcd xhci-hcd.1.auto: hcc params 0x0298f06d hci version 0x100 quirks 0x00010010
[    4.423738] xhci-hcd xhci-hcd.1.auto: irq 68, io mem 0x25010000
[    4.429766] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    4.436561] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.443871] usb usb3: Product: xHCI Host Controller
[    4.448741] usb usb3: Manufacturer: Linux 4.8.0-rc2-00003-ga0a0676 xhci-hcd
[    4.455706] usb usb3: SerialNumber: xhci-hcd.1.auto
[    4.461032] hub 3-0:1.0: USB hub found
[    4.464796] hub 3-0:1.0: 1 port detected
[    4.468965] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[    4.474617] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 4
[    4.482347] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    4.490522] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003
[    4.497317] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.504555] usb usb4: Product: xHCI Host Controller
[    4.509424] usb usb4: Manufacturer: Linux 4.8.0-rc2-00003-ga0a0676 xhci-hcd
[    4.516480] usb usb4: SerialNumber: xhci-hcd.1.auto
[    4.521814] hub 4-0:1.0: USB hub found
[    4.525577] hub 4-0:1.0: 1 port detected
[    4.529927] usbcore: registered new interface driver usb-storage
[    4.536231] mousedev: PS/2 mouse device common for all mice
[    4.542036] i2c /dev entries driver
[    4.546204] davinci-wdt 22f0080.wdt: heartbeat 60 sec
[    4.551956] usbcore: registered new interface driver usbhid
[    4.557520] usbhid: USB HID core driver
[    4.562252] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xac
[    4.568597] nand: Micron MT29F4G08ABBDAHC
[    4.572702] nand: 512 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
[    4.580549] Bad block table found at page 262080, version 0x01
[    4.586896] Bad block table found at page 262016, version 0x01
[    4.593059] 3 ofpart partitions found on MTD device 30000000.nand
[    4.599143] Creating 3 MTD partitions on "30000000.nand":
[    4.604550] 0x000000000000-0x000000100000 : "u-boot"
[    4.610415] 0x000000100000-0x000000180000 : "params"
[    4.616256] 0x000000180000-0x000020000000 : "ubifs"
[    4.625578] davinci_nand 30000000.nand: controller rev. 2.5
[    4.631478] platform oprofile-perf.0: set dma_pfn_offset00780000
[    4.637710] oprofile: using timer interrupt.
[    4.642025] Netfilter messages via NETLINK v0.30.
[    4.646933] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
[    4.653307] ctnetlink v0.93: registering with nfnetlink.
[    4.658856] ipip: IPv4 and MPLS over IPv4 tunneling driver
[    4.664820] gre: GRE over IPv4 demultiplexor driver
[    4.669690] ip_gre: GRE over IPv4 tunneling driver
[    4.675526] ip_tables: (C) 2000-2006 Netfilter Core Team
[    4.680898] ipt_CLUSTERIP: ClusterIP Version 0.8 loaded successfully
[    4.687272] arp_tables: arp_tables: (C) 2002 David S. Miller
[    4.692979] Initializing XFRM netlink socket
[    4.698180] NET: Registered protocol family 10
[    4.703401] NET: Registered protocol family 17
[    4.707848] NET: Registered protocol family 15
[    4.712316] 8021q: 802.1Q VLAN Support v1.8
[    4.716535] sctp: Hash tables configured (bind 512/512)
[    4.722069] Registering SWP/SWPB emulation handler
[    4.832242] netcp-1.0 2620110.netcp eth0: Link is Down
[    4.839687] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    4.845527] 8021q: adding VLAN 0 to HW filter on device eth0
[    4.972238] netcp-1.0 2620110.netcp eth1: Link is Down
[    4.978292] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
[    4.984131] 8021q: adding VLAN 0 to HW filter on device eth1
[    4.989824] IP-Config: Failed to open gretap0
[    5.020995] Sending DHCP requests .
[    7.991361] netcp-1.0 2620110.netcp eth0: Link is Up - 100Mbps/Full - flow control off
[    7.999451] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[    8.520991] ., OK
[    8.841123] IP-Config: Got DHCP answer from 192.168.1.1, my address is 192.168.1.38
[    9.081896] IP-Config: Complete:
[    9.085120]      device=eth0, hwaddr=76:34:13:00:7c:66, ipaddr=192.168.1.38, mask=255.255.255.0, gw=192.168.1.1
[    9.095273]      host=192.168.1.38, domain=Home, nis-domain=(none)
[    9.101459]      bootserver=0.0.0.0, rootserver=192.168.1.36, rootpath=     nameserver0=192.168.1.1
[    9.160413] VFS: Mounted root (nfs filesystem) on device 0:14.
[    9.166843] devtmpfs: mounted
[    9.170868] Freeing unused kernel memory: 2048K (c0c00000 - c0e00000)
[    9.202908] random: fast init done
INIT: version 2.88 booting
[info] Using makefile-style concurrent boot in runlevel S.
[....] Starting the hotplug events dispatcher: udevd[   10.314986] udevd[1309]: starting version 175
. ok 
[....] Synthesizing the initial hotplug events...done.
[....] Waiting for /dev to be fully populated...done.
[....] Setting parameters of disc: (none). ok 
[....] Activating swap...done.
[....] Cleaning up temporary files... /tmp. ok 
[   12.160599] random: crng init done
[....] Activating lvm and md swap...done.
[....] Checking file systems...fsck from util-linux 2.20.1
done.
[....] Mounting local filesystems...done.
[....] Activating swapfile swap...done.
[....] Cleaning up temporary files.... ok 
[....] Setting kernel variables ...done.
[....] Configuring network interfaces...done.
[....] Cleaning up temporary files.... ok 
[....] Setting up ALSA...done (none loaded).
[....] Setting up X socket directories... /tmp/.X11-unix /tmp/.ICE-unix. ok 
INIT: Entering runlevel: 2
[info] Using makefile-style concurrent boot in runlevel 2.
[....] Starting advanced IEEE 802.11 management: hostapdioctl(SIOCGIFINDEX): No such device
 failed!
[....] Starting enhanced syslogd: rsyslogd. ok 
[....] Starting periodic command scheduler: cron. ok 
[....] Starting system message bus: dbus. ok 
[....] Starting OpenBSD Secure Shell server: sshd. ok 
[....] Starting Avahi mDNS/DNS-SD Daemon: avahi-daemon. ok 

Last login: Thu Jan  1 00:00:17 UTC 1970 on ttyS0
Linux rockdesk 4.8.0-rc2-00003-ga0a0676 #974 SMP PREEMPT Fri Aug 19 10:26:47 EEST 2016 armv7l

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
root at rockdesk:~# [   21.941001] usb 1-1: new high-speed USB device number 2 using xhci-hcd
[   22.111469] usb 1-1: New USB device found, idVendor=0781, idProduct=5539
[   22.118166] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   22.125359] usb 1-1: Product: Cruzer Micro
[   22.129449] usb 1-1: Manufacturer: SanDisk
[   22.133606] usb 1-1: SerialNumber: 173733160C524A8E
[   22.139581] usb-storage 1-1:1.0: USB Mass Storage device detected
[   22.145949] scsi host0: usb-storage 1-1:1.0
[   22.150210] scsi host0: runtime PM trying to activate child device host0 but parent (1-1:1.0) is not active
[   23.191374] scsi 0:0:0:0: Direct-Access     SanDisk  Cruzer Micro     8.02 PQ: 0 ANSI: 0 CCS
[   23.200473] sd 0:0:0:0: [sda] 15695871 512-byte logical blocks: (8.04 GB/7.48 GiB)
[   23.208341] sd 0:0:0:0: [sda] Write Protect is off
[   23.213490] sd 0:0:0:0: [sda] No Caching mode page found
[   23.218993] sd 0:0:0:0: [sda] Assuming drive cache: write through
[   23.229000]  sda:
[   23.232085] sd 0:0:0:0: [sda] Attached SCSI removable disk

root at rockdesk:~# ./usbmsctest.sh 
[   29.678847] FAT-fs (sda): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
Mounted /org/freedesktop/UDisks/devices/sda at /media/PENDRIVE
copying file
syncing
removing file
speed test
10+0 records in
10+0 records out
10485760 bytes (10 MB) copied, 2.7477 s, 3.8 MB/s
done
root at rockdesk:~# 

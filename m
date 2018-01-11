From: aford173@gmail.com (Adam Ford)
Date: Thu, 11 Jan 2018 12:09:42 -0600
Subject: [PATCH v5 01/44] dt-bindings: clock: Add new bindings for TI
 Davinci PLL clocks
In-Reply-To: <40501635-6f5b-20c9-f8bc-d17e26b58426@lechnology.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
 <1515377863-20358-2-git-send-email-david@lechnology.com>
 <ebd677dc-44a4-5053-2509-e3ee948ccf98@ti.com>
 <22409e49-5c14-4068-b137-7535afaf90d7@lechnology.com>
 <0f90b5f7-f21e-5f81-1154-9a815bbb786d@ti.com>
 <ba7fa842-cfc5-6f6f-f9bf-09c74ab08ec2@lechnology.com>
 <5aacc350-6236-2e4f-35bb-a681fc9d47e7@ti.com>
 <CAHCN7x+ZYezmEU_0mF=6_gF14DZxKnuDp1Cx=aC2=eN_QLNdJQ@mail.gmail.com>
 <fd162516-cddc-e857-ce60-2cd89303971e@lechnology.com>
 <CAHCN7xKORFriQ2Gjx85OsCUzHO-mavCQXLOzh5D3n4kEG=i-Yg@mail.gmail.com>
 <40501635-6f5b-20c9-f8bc-d17e26b58426@lechnology.com>
Message-ID: <CAHCN7xL=h_g6HK2ey82r_w5qRbXg9+68Og+84YUYuePsjYd-Vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 11, 2018 at 11:22 AM, David Lechner <david@lechnology.com> wrote:
> On 01/11/2018 06:45 AM, Adam Ford wrote:
>>
>> On Wed, Jan 10, 2018 at 8:50 PM, David Lechner <david@lechnology.com>
>> wrote:
>>>
>>> On 01/10/2018 04:24 PM, Adam Ford wrote:
>>>>
>>>>
>>>>
>>>> I am available tomorrow to build and test patches against the
>>>> da850-evm.  I just need to know which version(s) to test.
>>>
>>>
>>>
>>> Great. As per the cover letter:
>>>
>>> You can find a working branch with everything included in the
>>> "common-clk-v5"
>>> branch of https://github.com/dlech/ev3dev-kernel.git.
>>
>>
>> I wasn't sure if things had changed after some of the dialog about the
>> bindings and device tree.
>
>
> Not yet. ;-)
>
>>
>> Here is my log with DEBUG_LL and CONFIG_EARLY_PRINTK set :
>>
>> Starting kernel ...
>>
>> Uncompressing Linux... done, booting the kernel.
>> Booting Linux on physical CPU 0x0
>> Linux version 4.15.0-rc4-g8564e0f (aford at ubuntu16) (gcc version 7.2.0
>> (Buildroot 2017.11.1-00021-g7b43660)) #2 PREEMPT Thu Jan 11 06:35:29
>> CST 2018
>> CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=0005317f
>> CPU: VIVT data cache, VIVT instruction cache
>> OF: fdt: Machine model: DA850/AM1808/OMAP-L138 EVM
>
>
> OK, using device tree...

Sorry, I thought I was supposed to. I retested using the board file,
but it also resulted in a hang.

>
>
[snip]
>
>
> If you are getting to this point, you probably don't need DEBUG_LL.
> It looks like "earlyprint" is not being passed to the command line
> anyway, so CONFIG_EARLY_PRINTK is not actually doing anything.
>
>> brd: module loaded
>> libphy: Fixed MDIO Bus: probed
>> davinci_mdio 1e24000.mdio: failed to get device clock
>> davinci_mdio: probe of 1e24000.mdio failed with error -2
>
>
> It looks like this needs a clock-names property in the device tree.
> Please make this change and try again:
>
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index 08a9817..fd3e316 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -713,6 +713,7 @@
>                         #size-cells = <0>;
>                         reg = <0x224000 0x1000>;
>                         clocks = <&psc1 5>;
> +                       clock-names = "fck";
>                         status = "disabled";
>                 };
>                 eth0: ethernet at 220000 {
>
>
[snip]

I added your copy-names entry to my device tree and we get a login prompt.  :-)

> I'm not sure why there is an error here. I'm using I2C0 on my board,
> so I am fairly confident that it is not a problem introduced by this
> series.
>
>> console [netcon0] enabled
>> netconsole: network logging started
>> davinci_emac 1e20000.ethernet: incompatible machine/device type for
>> reading mac address
>> hctosys: unable to open rtc device (rtc0)
>>
>
> What is normally the next line after this in a working boot?
>
> Also please try passing "clk_ignore_unused" to the kernel command line.

Here is the log.  There seems to be some garbled characters that don't
seem to appear.  I'm going to double check those against the stock
kernel.


Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0x0
Linux version 4.15.0-rc4-g8564e0f (aford at ubuntu16) (gcc version 7.2.0
(Buildroot 2017.11.1-00021-g7b43660)) #2 PREEMPT Thu Jan 11 06:35:29
CST 2018
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=0005317f
CPU: VIVT data cache, VIVT instruction cache
OF: fdt: Machine model: DA850/AM1808/OMAP-L138 EVM
debug: ignoring loglevel setting.
bootconsole [earlycon0] enabled
Memory policy: Data cache writethrough
cma: Reserved 16 MiB at 0xc2c00000
DaVinci da850/omap-l138 variant 0x0
On node 0 totalpages: 16384
  DMA zone: 128 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 16384 pages, LIFO batch:3
random: fast init done
pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
pcpu-alloc: [0] 0
Built 1 zonelists, mobility grouping on.  Total pages: 16256
Kernel command line: console=ttyS2,115200n8 root=/dev/mmcblk0p2 rw
rootfstype=ext4 rootwait ignore_loglevel earlyprintk clk_ignore_unused
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 42164K/65536K available (4548K kernel code, 280K rwdata, 1044K
rodata, 232K init, 143K bss, 6988K reserved, 16384K cma-reserved)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
    vmalloc : 0xc4800000 - 0xff800000   ( 944 MB)
    lowmem  : 0xc0000000 - 0xc4000000   (  64 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .text : 0x(ptrval) - 0x(ptrval)   (4550 kB)
      .init : 0x(ptrval) - 0x(ptrval)   ( 232 kB)
      .data : 0x(ptrval) -&?p`? rval)   Qm^?`} b ?      $\????  ?! ?
 "V    ? ???@ B- d?????}bf ?f? i?console [ttyS2] enabled
console [ttyS2] enabled??F 0x(ptrval)   ( 144 kB)
bootconsole [earlycon0] disabledObjects=0, CP&?p^?-?Mdes=1
bootconsole [earlycon0] disabledb ?f? i?a ?F    $\????
brd: module loaded??}  ??B
libphy: Fixed MDIO Bus: probed               &?p^?-?I
davinci_mdio 1e24000.mdio: davinci mdio revision 1.5, bus freq 2200000
  a- R? /^???? ???v at a??.???? ^\?`&?`l??f ?????M??? ?E ??????)?)!  ?}?y
ya bK?????  ???
davinci_mdio 1e24000.mdio: detected phy mask
fffffffe ??I  ")=M??-?)!iD????mi-??I  ?k??
???)? r??.????i2? ?v? ?k$^????-?-!mD??q} ] ?K???? 6m?R?`? q)?M  ???^??
??
libphy: 1e24000.mdio:
probed&?????a I?j?`?a?I???} 2/?p? bv VK,?q? 6M?- ? ??? ?I ??f??a?I???}
2 A-!?a-? ?K????!aMq- ")=I??-?-!mD??} 2 A-!?a-? ?K -? &-=M??-?-!mD?
davinci_mdio 1e24000.mdio: phy[0]: device 1e24000.mdio:00, driver SMSC
LAN8710/LAN8720??? I?Sm??aM?-! &??P-4RhR?
??-? ?K?^t@?
i2c /dev entries driver
davinci_mmc 1c40000.mmc: Using DMA, 4-bit mode
NET: Registered protocol family 10
Segment Routing with IPv6
sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
NET: Registered protocol family 17
Loading compiled-in X.509 certificates
mmc0: host does not support reading read-only switch, assuming write-enable
mmc0: new high speed SDHC card at address b368
mmcblk0: mmc0:b368 00000 3.75 GiB
 mmcblk0: p1 p2
pca953x 0-0020: 0-0020 supply vcc not found, using dummy regulator
pca953x 0-0020: failed reading register
pca953x: probe of 0-0020 failed with error -121
console [netcon0] enabled
netconsole: network logging started
davinci_emac 1e20000.ethernet: incompatible machine/device type for
reading mac address
hctosys: unable to open rtc device (rtc0)
clk: Not disabling unused clocks
vbat: disabling
EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts: (null)
VFS: Mounted root (ext4 filesystem) on device 179:2.
devtmpfs: mounted
Freeing unused kernel memory: 232K
This architecture does not have kernel memory protection.
EXT4-fs (mmcblk0p2): re-mounted. Opts: data=ordered
Starting logging: OK
Initializing random number generator... done.
Starting network: OK

Welcome to Buildroot
buildroot login:


>

However, I get a reboot failure:

umount: devtmpfs busy - remounted read-only
EXT4-fs (mmcblk0p2): re-mounted. Opts: (null)
The system is going down NOW!
Sent SIGTERM to all processes
Sent SIGKILL to all processes
Requesting system reboot

reboot: Restarting system
Reboot failed -- System halted

I'll run more tests on a stock kernel to look at the reboot failure
and the uart noise.

adam

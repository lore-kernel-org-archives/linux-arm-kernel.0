From: matthew_minter@xyratex.com (Matthew Minter)
Date: Tue, 8 Apr 2014 17:02:49 +0100
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <20140408175545.1b4d55a5@skate>
References: <20140325202249.GA10378@obsidianresearch.com>
 <20140325213638.5aba54b6@skate>
 <CAAfodu3RmoN9MYNahwv2kLz5=GvZvK6G9fJorsyVgU8C0J-NEg@mail.gmail.com>
 <20140325222404.GC14718@obsidianresearch.com>
 <20140325223510.GD14718@obsidianresearch.com>
 <CAAfodu3HuzBCAc3r=PPufjrFhEKUQK2b_WRow=GJuC6hSqiuKw@mail.gmail.com>
 <20140326201243.GA1536@obsidianresearch.com>
 <CAAfodu0xZ0V8ikJMT1Z+0JSLeD+nezWAcGNF2_ryvad5tsVDWA@mail.gmail.com>
 <20140326214259.GA12330@obsidianresearch.com>
 <alpine.DEB.2.10.1403270025160.1545@vroombuntu>
 <20140327044054.GA22681@obsidianresearch.com>
 <alpine.DEB.2.10.1403280056250.4521@vroombuntu>
 <alpine.DEB.2.10.1404041408280.8617@vroombuntu>
 <20140405193435.50d8dd81@skate>
 <54BB31A2B04145E8908E0183FAB6B61B@fatboyfat.co.uk>
 <alpine.DEB.2.10.1404061631130.4683@vroombuntu>
 <20140408171309.09bbf968@skate> <20140408174034.79df403e@skate>
 <20140408175545.1b4d55a5@skate>
Message-ID: <CAFJTrDsqH33XT7rVasN0d9BfDzrL0gotFuFy5d+2augvsa3NkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

I have found on the GP dev board largely the problem does not show
unless hot plugging devices are added. It is difficult for me to say
why but my guess is that the layout of the hardware on that board
causes it to work by chance. However in short I can confirm I have
never had the problem with the dev board except by connecting more
than 3 devices by using a PCI bridge.

On 8 April 2014 16:55, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Hello all,
>
> On Tue, 8 Apr 2014 17:40:34 +0200, Thomas Petazzoni wrote:
>> Hello all,
>>
>> On Tue, 8 Apr 2014 17:13:09 +0200, Thomas Petazzoni wrote:
>>
>> > Unfortunately here your patch is not sufficient to solve the problem
>> > apparently. I've fixed another problem where the return value of
>> > armada_370_xp_alloc_msi() (which is signed) is casted into an unsigned
>> > irq_hw_number_t in armada_370_xp_setup_msi_irq(), but I'm still seeing
>> > many MSIs allocated, then some freed, and finally a kernel panic.
>> >
>> >  * Log: https://gist.github.com/tpetazzoni/10140012
>> >
>> >  * Diff against v3.14: https://gist.github.com/tpetazzoni/10140121
>> >
>> > Ideas? If some of you are interested in discussing this live, I'm on
>> > #mvlinux on Freenode.
>>
>> Please find attached the 3 patches I'm currently using on the
>> irq-armada-370-xp. They make the situation a bit better (the igb driver
>> no longer believes we support MSI-X), but it still crashes in the igb
>> driver (see https://gist.github.com/tpetazzoni/10144886).
>
> Ok, this panic, and another one that comes after, are fixed in mainline
> by:
>
>   http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/net/ethernet/intel/igb/igb_main.c?id=cb06d102327eadcd1bdc480bfd9f8876251d1007
>   http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/net/ethernet/intel/igb/igb_main.c?id=b709323d2477614823a38c2f2a9a206e087e28fc
>
> With the 3 patches I've sent in my previous e-mail, and those two ones,
> I'm able to use the two ports of the igb NIC on my Armada XP DB board
> on v3.14. I can ping remote machines, using either of the two
> interfaces of the igb NIC that Willy gave me.
>
> lspci output:
>
> 01:00.0 Ethernet controller: Intel Corporation 82575EB Gigabit Network Connection (rev 02)
>         Subsystem: Intel Corporation 82575EB Gigabit Network Connection
>         Flags: bus master, fast devsel, latency 0, IRQ 118
>         Memory at e0800000 (32-bit, non-prefetchable) [size=128K]
>         Memory at e0000000 (32-bit, non-prefetchable) [size=2M]
>         I/O ports at 10000 [disabled] [size=32]
>         Memory at e0840000 (32-bit, non-prefetchable) [size=16K]
>         [virtual] Expansion ROM at e0200000 [disabled] [size=2M]
>         Capabilities: [40] Power Management version 2
>         Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Capabilities: [60] MSI-X: Enable- Count=10 Masked-
>         Capabilities: [a0] Express Endpoint, MSI 00
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [140] Device Serial Number 00-08-60-ff-ff-00-53-96
>         Kernel driver in use: igb
>
> 01:00.1 Ethernet controller: Intel Corporation 82575EB Gigabit Network Connection (rev 02)
>         Subsystem: Intel Corporation 82575EB Gigabit Network Connection
>         Flags: bus master, fast devsel, latency 0, IRQ 119
>         Memory at e0820000 (32-bit, non-prefetchable) [size=128K]
>         Memory at e0400000 (32-bit, non-prefetchable) [size=2M]
>         I/O ports at 10020 [disabled] [size=32]
>         Memory at e0844000 (32-bit, non-prefetchable) [size=16K]
>         [virtual] Expansion ROM at e0600000 [disabled] [size=2M]
>         Capabilities: [40] Power Management version 2
>         Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Capabilities: [60] MSI-X: Enable- Count=10 Masked-
>         Capabilities: [a0] Express Endpoint, MSI 00
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [140] Device Serial Number 00-08-60-ff-ff-00-53-96
>         Kernel driver in use: igb
>
> mvebu-mbus/devices output:
>
> # cat /sys/kernel/debug/mvebu-mbus/devices
> [00] 00000000e8010000 - 00000000e8020000 : 0004:00e0 (remap 0000000000010000)
> [01] disabled
> [02] disabled
> [03] disabled
> [04] disabled
> [05] disabled
> [06] disabled
> [07] disabled
> [08] 00000000fff00000 - 0000000100000000 : 0001:001d
> [09] 00000000f0000000 - 00000000f1000000 : 0001:002f
> [10] 00000000e0000000 - 00000000e0900000 : 0004:00e8
> [11] disabled
> [12] disabled
> [13] disabled
> [14] disabled
> [15] disabled
> [16] disabled
> [17] disabled
> [18] disabled
> [19] disabled
>
> I'm not sure why I don't have the non-power-of-two problem for the MBus
> windows.
>
> Thomas
> --
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com

-- 


------------------------------
For additional information including the registered office and the treatment of Xyratex confidential information please visit www.xyratex.com

------------------------------

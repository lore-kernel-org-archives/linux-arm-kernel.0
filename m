From: neil@fatboyfat.co.uk (Neil Greatorex)
Date: Mon, 7 Apr 2014 20:41:52 +0100
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <20140407174106.GD9952@obsidianresearch.com>
References: <CAAfodu3HuzBCAc3r=PPufjrFhEKUQK2b_WRow=GJuC6hSqiuKw@mail.gmail.com>
 <20140326201243.GA1536@obsidianresearch.com>
 <CAAfodu0xZ0V8ikJMT1Z+0JSLeD+nezWAcGNF2_ryvad5tsVDWA@mail.gmail.com>
 <20140326214259.GA12330@obsidianresearch.com>
 <alpine.DEB.2.10.1403270025160.1545@vroombuntu>
 <20140327044054.GA22681@obsidianresearch.com>
 <alpine.DEB.2.10.1403280056250.4521@vroombuntu>
 <alpine.DEB.2.10.1404041408280.8617@vroombuntu>
 <20140406185833.GI29787@1wt.eu>
 <alpine.DEB.2.10.1404062253500.16719@vroombuntu>
 <20140407174106.GD9952@obsidianresearch.com>
Message-ID: <CAAfodu0kbTspq2QQf0dh3U7LB-q+ECaX9FJ35fCc25UmgPJZSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason, Thomas,

On Mon, Apr 7, 2014 at 6:41 PM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
>>
>> First port:
>> [ 1809.452878] igb 0000:01:00.0: enabling bus mastering
>> [ 1809.453098] igb 0000:01:00.0 (unregistered net_device): hw_addr
>> is f1000000, start=e0000000, len=80000, flags=40200
>> [ 1809.453109] igb 0000:01:00.0 (unregistered net_device): About to
>> read from offset 18
>> [ 1809.453120] igb 0000:01:00.0 (unregistered net_device): Read from
>> 18 returned 1400c0
>>
>> Second port:
>> [ 1809.459445] igb 0000:01:00.1: enabling bus mastering
>> [ 1809.459563] igb 0000:01:00.1 (unregistered net_device): hw_addr is
>> f1100000, start=e0100000, len=80000, flags=40200
>> [ 1809.459573] igb 0000:01:00.1 (unregistered net_device): About to read
>> from offset 18
>> [ 1809.459581] Unhandled fault: external abort on non-linefetch
>> (0x1008) at 0xf1100018
>>
>> In the output above, the start= part shows the physical address and
>> hw_addr shows the mapped address.
>
> This is very similar to what Matthew Minter
> <matthew_minter@xyratex.com> is seeing on Hot Plug with AHCI. (See
> 'Armada XP (mvebu) PCIe memory (BAR/window) re-allocation' thread)
>
> That probably says it is somehow mbus related - dumping the mbus
> registers when the fault happens should clarify that point. The size
> would a good place to check first.
>
>> The physical addresses match those given in the lspci -vvv output
>> (see https://gist.github.com/ngreatorex/9772195). I don't know
>> enough about PCIe, the SoC *or* the Intel card to know if these
>> addresses look correct or even sane! I did wonder if there was some
>> issue due to the fact that the resources for 01:00.0 and 01:00.1
>> overlap, but I would guess(!?) that it's common in hardware that
>> presents multiple devices.
>
> Which overlap?
>
> To be very clear, PCI BARs, should never overlap.
>

I realise that overlap was probably the wrong word. I meant that the
resources for 01:00.0 and 01:00.1 are not contiguous but are mixed
together. If you sort by address you get:

e0000000-e007ffff : 0000:01:00.0
e0080000-e00fffff : 0000:01:00.0
e0100000-e017ffff : 0000:01:00.1
e0180000-e01fffff : 0000:01:00.1
e0200000-e0203fff : 0000:01:00.0
e0204000-e0223fff : 0000:01:00.0
e0224000-e0243fff : 0000:01:00.0
e0244000-e0247fff : 0000:01:00.1
e0248000-e0267fff : 0000:01:00.1
e0268000-e0287fff : 0000:01:00.1

> The bridge windows should fully contain downstream bars:
>
> 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01) (prog-if 00 [Normal decode])
>         Bus: primary=00, secondary=01, subordinate=02, sec-latency=0
>         Memory behind bridge: e0000000-e02fffff
> 01:00.0 Ethernet controller: Intel Corporation I350 Gigabit Network Connection (rev 01)
>         Region 0: Memory at e0000000 (32-bit, non-prefetchable) [disabled] [size=512K]
> 01:00.1 Ethernet controller: Intel Corporation I350 Gigabit Network Connection (rev 01)
>         Region 0: Memory at e0100000 (32-bit, non-prefetchable) [disabled] [size=512K]
>
> Looks good to me.
>
> HOWEVER, looking now very closely:
>
> 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01) (prog-if 00 [Normal decode])
>    Memory behind bridge: e0000000-e02fffff
> 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01) (prog-if 00 [Normal decode])
>    Memory behind bridge: e0300000-e03fffff
>
> This is certainly wrong, MBUS requires special alignment and sizing.
> 0x300000 is not a size which is a power of two, and the next window
> starts right after.
>

Interesting. Does the PCI code provide a way to specify that the sizes
much be a power of 2? I don't fully understand the implications but
would it be possible to assign just one MBUS window for the whole of
the PCIe memory instead?

> We need to see the first bridge use e0000000-e03fffff
>
> Just to confirm, what does something like the below say for you guys?

See https://gist.github.com/ngreatorex/10025253 for the dmesg output.
I have also included the contents of
/sys/kernel/debug/mvebu-mbus/devices both before and after the
modprobe / oops. As you can see I get a total of 3 WARNINGs - one at
boot for the xHCI controller, and two when inserting igb.ko. Note that
this time I did this with both ports enabled.

Cheers,
Neil

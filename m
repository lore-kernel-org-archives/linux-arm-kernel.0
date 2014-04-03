From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 3 Apr 2014 12:23:22 -0600
Subject: Armada XP (mvebu) PCIe memory (BAR/window) re-allocation
In-Reply-To: <CAFJTrDu1=Hoa6NS3DaFphMUXgJYunybbdCoGiBVe1qKNQ4s3MA@mail.gmail.com>
References: <CAFJTrDt7OrtE4B52419F2KGbmXeLR9NEcgF6yMTMUBe5vdKwfg@mail.gmail.com>
 <20140326180634.4ac266b2@skate>
 <20140326171828.GA31887@obsidianresearch.com>
 <CAFJTrDvb7gcLkv8-HqbJSLEj7V2Zg=5+pXFR2r3AZxG7waT6WA@mail.gmail.com>
 <20140401164110.GA26093@obsidianresearch.com>
 <CAFJTrDu1=Hoa6NS3DaFphMUXgJYunybbdCoGiBVe1qKNQ4s3MA@mail.gmail.com>
Message-ID: <20140403182322.GA9509@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 02, 2014 at 05:32:04PM +0100, Matthew Minter wrote:

> Ok, I have managed to gather some more info. The problem of the lost
> line was with my serial console acting and losing lines of data
> oddly around the time of the the oops and I have indeed gained some
> extra info (I logged dmesg to a file while the issue was happening
> and pulled the full transcript from there).

Your oops seem to suggest that the very first MMIO read from the AHCI
is causing this:

> [? 191.654496] Unhandled fault: external abort on non-linefetch
> (0x1008) at 0xf0460004

And the address 0xf0460004 is certainly funny - that doesn't look like
it is valid at all, but prehaps it is a bogus report (?) 

On the other hand, the low bits are right:

drivers/ata/ahci.h:     HOST_CTL                = 0x04, /* global host control */

If you belive the Unhandled fault report - the driver is accessing
the wrong memory region (0xf0460000, instead of 0xe0200000)

You may want to double check that the mmio pointer in the ahci is
actually being mapped to 0xe0200000...

>> Second guess, something went wrong during the hot plug, and the
>> PLX is not forwarding TLPs.. lpsci -v might give a clue.

The lspci -vv looks OK for the AHCI:

04:00.0 Class 0106: Device 144d:a800 (rev 01) (prog-if 01)
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
                    ^^^^^^^
        Region 5: Memory at e0200000 (32-bit, non-prefetchable) [size=8K]

MMIO is enabled, address looks OK

The PLX upstream bridge looks OK:

02:02.0 Class 0604: Device 10b5:8617 (rev ba)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
        Memory behind bridge: e0200000-e03fffff
        Prefetchable memory behind bridge: 00000000e0800000-00000000e09fffff

The mvebu bridge looks OK:

00:01.0 Class 0604: Device 11ab:7826 (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
        Bus: primary=00, secondary=01, subordinate=05, sec-latency=0
        I/O behind bridge: 00010000-00013fff
        Memory behind bridge: e0000000-e0cfffff

Matches the mbus debug:
[09] 00000000e0000000 - 00000000e0d00000 : 0004:00e8

Jason

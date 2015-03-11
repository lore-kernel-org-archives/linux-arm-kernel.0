From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 Mar 2015 12:47:30 +0000
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid crash
 on armada-xp
In-Reply-To: <55003569.1010200@list.ru>
References: <54FF21BE.2040506@list.ru>
 <20150310171751.GD13687@e104818-lin.cambridge.arm.com>
 <54FF2986.6020503@list.ru>
 <20150310173807.GU8656@n2100.arm.linux.org.uk>
 <55003569.1010200@list.ru>
Message-ID: <20150311124730.GZ8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 11, 2015 at 03:30:33PM +0300, Stas Sergeev wrote:
> OK, here we go.
> 
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 4.0.0-rc2-00137-gb672c98-dirty
> (root at host-010-117) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) )
> #60 SMP5
> [    0.000000] CPU: ARMv7 Processor [562f5842] revision 2 (ARMv7),
> cr=10c5387d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction
> cache
> [    0.000000] Machine model: Marvell Armada XP Development Board
> DB-MV784MP-GP
> [    0.000000] Ignoring memory block 0x100000000 - 0x200000000
...
> [    0.000000] MEMBLOCK configuration:
> [    0.000000]  memory size = 0xf0000000 reserved size = 0xa32442
> [    0.000000]  memory.cnt  = 0x1
> [    0.000000]  memory[0x0]     [0x00000000000000-0x000000efffffff],
> 0xf0000000 bytes flags: 0x0

So this says you have memory covering that entire range, and actually
beyond to 8GB.

> [    6.772534] vmalloc: mapping page ef7f13c0 (0x000efc1e000) at 0xf00ca000
> [    6.772537] vmalloc: mapping page ef7f13a0 (0x000efc1d000) at 0xf00cb000
> [    6.772540] vmalloc: mapping page ef7f1380 (0x000efc1c000) at 0xf00cc000
> [    6.772542] vmalloc: mapping page ef7f1360 (0x000efc1b000) at 0xf00cd000
> [    6.772544] vmalloc: mapping page ef7f1340 (0x000efc1a000) at 0xf00ce000
> [    6.772546] vmalloc: mapping page ef7f1320 (0x000efc19000) at 0xf00cf000
> [    6.772548] vmalloc: mapping page ef7f1300 (0x000efc18000) at 0xf00d0000
> [    6.772551] vmalloc: mapping page ef7f12e0 (0x000efc17000) at 0xf00d1000
> [    6.822102] ata2: SATA link down (SStatus 0 SControl F300)
> [    6.850381] vmalloc: mapping page ef7f0420 (0x000efba1000) at 0xf00d3000

Here, we set up the mapping, which looks fine - it's apparently in the
range of physical addresses we expect for system memory.

> [    6.857113] vmalloc: mapping page ef7f12c0 (0x000efc16000) at 0xf00d4000
> [    6.863845] vmalloc: mapping page ef7f12a0 (0x000efc15000) at 0xf00d5000
> [    6.870567] Unhandled fault: external abort on non-linefetch (0x808)
> at 0xf00d3018

Yet it causes this.  I wonder if there's a conflict between DRAM and
some other devices causing this, or maybe a stale TLB entry.

The thing which makes me consider a stale TLB entry is that the mapping
we're adding is for a WBWA cacheable mapping, which should cause line
fetches.  The abort which is being raised is for a non-linefetch, a
type of access which a WBWA cacheable mapping should never create.

We can check whether it's a stale TLB entry - if you add a call to
flush_tlb_all() after the call to vmalloc() in n_tty_open().  You
may need to include <asm/tlbflush.h> to make that work - can you try
that please.

Sorry it's needing soo much back-n-forth between us, I don't have 
any Armada platforms which approach the size you have there. :(

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Mar 2015 12:59:11 +0000
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid crash
 on armada-xp
In-Reply-To: <550187A4.8010704@hurleysoftware.com>
References: <54FF21BE.2040506@list.ru>
 <20150310171751.GD13687@e104818-lin.cambridge.arm.com>
 <54FF2986.6020503@list.ru>
 <20150310173807.GU8656@n2100.arm.linux.org.uk>
 <55003569.1010200@list.ru>
 <20150311124730.GZ8656@n2100.arm.linux.org.uk>
 <5500502A.5060905@list.ru> <550187A4.8010704@hurleysoftware.com>
Message-ID: <20150312125910.GN8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 12, 2015 at 08:33:40AM -0400, Peter Hurley wrote:
> On 03/11/2015 10:24 AM, Stas Sergeev wrote:
> > However, while testing, I've suddenly got another crash happened
> > a bit earlier than the previous one used to happen: (OOM? How??)
> > ---
> > [    0.000000] Booting Linux on physical CPU 0x0
> > [    0.000000] Linux version 4.0.0-rc2-00137-gb672c98-dirty
> > (root at host-010-117) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) )
> > #2 SMP 5
> > [    0.000000] CPU: ARMv7 Processor [562f5842] revision 2 (ARMv7),
> > cr=10c5387d
> > [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction
> > cache
> > [    0.000000] Machine model: Marvell Armada XP Development Board
> > DB-MV784MP-GP
> > [    0.000000] Ignoring memory block 0x100000000 - 0x200000000
> 
> Once you patch your bootloader, you'll want to configure your kernel
> for CONFIG_ARM_LPAE=y to enable the high 4GB of memory you have, as
> it's being ignored in this config right now (as shown above and in
> the oom message below).

The OOM is happening during boot.  During boot, there is 760MB of lowmem
free initially, along with a few gigabytes of highmem.

If we look at the buddy state:

[    7.220815] Normal: 2*4kB (UR) 17*8kB (UR) 0*16kB 0*32kB 0*64kB
0*128kB 1*256kB (R) 0*512kB 1*1024kB (R) 1*2048kB (R) 0*4096kB = 3472kB
[    7.233210] HighMem: 0*4kB 1*8kB (M) 0*16kB 0*32kB 0*64kB 0*128kB
2*256kB (UM) 1*512kB (M) 1*1024kB (M) 1*2048kB (M) 767*4096kB (MR) = 3B

we can see that most of lowmem is in the reserve migration type, and
some is also in the unmovable type.  3MB of reserved lowmem for atomic
allocations is about what I'd expect given the memory sizes.

Highmem has some memory in the movable migratation type, but the bulk
is in the reserve migration type - but this is irrelevant as you'll
see from the next bit of information:

[    6.818183] swapper/0 invoked oom-killer: gfp_mask=0x2040d0, order=0,
oom_score_adj=0

Let's decode that gfp_mask.

	___GFP_NOTRACK | ___GFP_COMP | ___GFP_FS | ___GFP_IO | ___GFP_WAIT

This does not give the allocator permission to allocate from highmem -
for that, it needs ___GFP_HIGH to be in there, but it isn't.

The kernel should _not_ consume 760MB of lowmem during boot, but according
to the accounting, it looks like it has.

If the memory allocation structures are ending up in the problem region
of physical RAM, then that could be responsible for this OOM - but that
won't happen, because we don't place that stuff into highmem.

In short, I don't have a clue what would cause 760MB of lowmem to be
gobbled up, but one thing I'm absolutely certain of is that adding more
highmem won't solve this - if anything, it'll probably make things worse
due to more lowmem being consumed to track the additional highmem pages.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

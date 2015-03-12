From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Mar 2015 13:04:45 +0000
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid crash
 on armada-xp
In-Reply-To: <55018AE7.4070207@list.ru>
References: <54FF21BE.2040506@list.ru>
 <20150310171751.GD13687@e104818-lin.cambridge.arm.com>
 <54FF2986.6020503@list.ru>
 <20150310173807.GU8656@n2100.arm.linux.org.uk>
 <55003569.1010200@list.ru>
 <20150311124730.GZ8656@n2100.arm.linux.org.uk>
 <5500502A.5060905@list.ru> <550187A4.8010704@hurleysoftware.com>
 <55018AE7.4070207@list.ru>
Message-ID: <20150312130445.GO8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 12, 2015 at 03:47:35PM +0300, Stas Sergeev wrote:
> 12.03.2015 15:33, Peter Hurley ?????:
> > On 03/11/2015 10:24 AM, Stas Sergeev wrote:
> >> However, while testing, I've suddenly got another crash happened
> >> a bit earlier than the previous one used to happen: (OOM? How??)
> >> ---
> >> [    0.000000] Booting Linux on physical CPU 0x0
> >> [    0.000000] Linux version 4.0.0-rc2-00137-gb672c98-dirty
> >> (root at host-010-117) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) )
> >> #2 SMP 5
> >> [    0.000000] CPU: ARMv7 Processor [562f5842] revision 2 (ARMv7),
> >> cr=10c5387d
> >> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction
> >> cache
> >> [    0.000000] Machine model: Marvell Armada XP Development Board
> >> DB-MV784MP-GP
> >> [    0.000000] Ignoring memory block 0x100000000 - 0x200000000
> > Once you patch your bootloader, you'll want to configure your kernel
> > for CONFIG_ARM_LPAE=y to enable the high 4GB of memory you have, as
> > it's being ignored in this config right now (as shown above and in
> > the oom message below).
> Hi Peter, thanks for this hint.
> I actually already tried with lpae, and, except for the missing
> 256Mb, everything works properly. :)

How reproducable is the OOM?  Have you tested LPAE as much as you did
without LPAE?

As I just said to Peter, I don't see adding more highmem would solve
your problem - I think there's something quite bad going on here,
possibly resulting in some form of memory corruption which is changing
the kernels ability to properly track memory usage.

I don't see how 760MB of lowmem could be gobbled up soo early in boot.

Enabling LPAE and allowing an additional 4GB of highmem should mean
that an additional 32MB of lowmem is consumed in the struct page array
needed to track that additional 4GB of memory alone - that should
increase the lowmem pressure further, and cause an OOM earlier in the
boot.  (32MB = 4GB / 4K * sizeof(struct page) = 4GB / 4K * 32).

I think you still have problems somewhere.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

From: will.deacon@arm.com (Will Deacon)
Date: Thu, 13 Feb 2014 19:29:09 +0000
Subject: [BISECTED] ssh - Received disconnect from x.x.x.x: 2: Bad packet
 length 3149594624
In-Reply-To: <52FD1243.9040706@gmail.com>
References: <52FD08D1.3030405@gmail.com>
 <20140213182105.GN13576@mudshark.cambridge.arm.com>
 <52FD1243.9040706@gmail.com>
Message-ID: <20140213192909.GO13576@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 13, 2014 at 06:43:15PM +0000, Ivaylo Dimitrov wrote:
> 
> 
> On 13.02.2014 20:21, Will Deacon wrote:
> >
> > That's certainly unexpected. The n900 has (iirc) a Cortex-A8, which as an
> > ARMv7 core, can perform unaligned accesses to normal, cacheable memory in
> > hardware.
> >
> 
> Yep, Cortex-A8 and it has no problem to do unaligned memory accesses 
> AFAIK. I suspect it is a driver issue, not CPU.
> 
> > Can you provide your .config and/or any information about your network chip
> > please? There's a chance that the driver is doing something odd.
> 
> The chip is TI wl1251, you can find the config file here(actually this 
> is the tree I am using to boot 3.14-rc1 on N900) - 
> https://gitorious.org/linux-n900/freemangordons-linux-n900/source/1434dbd7fbc5ec257b6cd6c547689b79177d1937:arch/arm/configs/rx51_defconfig

Ok, so based on that config I think we can narrow down the unaligned use to
the following files:


# Crypto
crypto/memneq.c:#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
crypto/memneq.c:#endif /* CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS */
crypto/memneq.c:#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
crypto/memneq.c:#endif /* CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS */

# Network
include/linux/etherdevice.h:#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
include/linux/etherdevice.h:#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
include/linux/etherdevice.h:#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
include/linux/etherdevice.h:#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
include/linux/etherdevice.h:#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
net/mac80211/rx.c:#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
net/ipv4/netfilter/arp_tables.c:#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS

# Probably not relevant
kernel/printk/printk.c:#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
kernel/taskstats.c:#if defined(CONFIG_64BIT) && !defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
lib/lz4/lz4defs.h:#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)		\
lib/lz4/lz4defs.h:#else /* CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS */
lib/lzo/lzo1x_compress.c:#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && defined(LZO_USE_CTZ64)
lib/lzo/lzo1x_compress.c:#elif defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && defined(LZO_USE_CTZ32)
lib/lzo/lzo1x_decompress_safe.c:#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
lib/lzo/lzo1x_decompress_safe.c:#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
lib/lzo/lzo1x_decompress_safe.c:#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
lib/strncpy_from_user.c:#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
lib/zlib_inflate/inffast.c:#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS


Can you try hacking crypto/memneq.c so that it doesn't use
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS please? That would at least point the
finger at net/mac80211/rx.c or similar.

Cheers,

Will

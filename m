From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 May 2015 23:32:47 +0100
Subject: [PATCH] ARM: v7 setup function should invalidate L1 cache
In-Reply-To: <8164344.VcU8v2tIF5@wuerfel>
References: <E1Yuk8W-0001tC-IK@rmk-PC.arm.linux.org.uk>
 <2080993.BUNZpO9uLL@wuerfel>
 <20150519220721.GK2067@n2100.arm.linux.org.uk>
 <8164344.VcU8v2tIF5@wuerfel>
Message-ID: <20150519223247.GN2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 12:18:43AM +0200, Arnd Bergmann wrote:
> On Tuesday 19 May 2015 23:07:21 Russell King - ARM Linux wrote:
> > The /simplest/ change which would fix this problem is to just change
> > proc-v7.S.  The remainder is effectively a cleanup removing redundant
> > code.
> 
> Fair enough. I wasn't sure if we're confident enough about that
> change already to put it into stable backports. If the risk is low
> enough, that's fine.

When the kernel is entered from the decompressor, the last steps just
before calling the kernel is to clean and invalidate the caches, then
turn them off, and then jump to the kernel.

So, there _should_ be no dirty cache lines which we rely upon at this
point - if there was dirty data in the cache, then it hasn't been flushed
to memory, and we're potentially going to crash because some part of
the decompressed kernel image hasn't been flushed out to memory.

So I'll put a confidence value of 99.999% on this.

The case which might bite people is if they bypass the decompressor.
Even then, leaving bits of the kernel image in the caches is really
dodgy.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

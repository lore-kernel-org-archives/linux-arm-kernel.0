From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Oct 2014 14:47:08 +0100
Subject: [PATCH] arm: fix flush_pfn_alias
In-Reply-To: <2144086.KBLsLT82pe@wuerfel>
References: <1413809642-12931-1-git-send-email-js07.lee@gmail.com>
 <2144086.KBLsLT82pe@wuerfel>
Message-ID: <20141020134708.GU27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 20, 2014 at 03:39:44PM +0200, Arnd Bergmann wrote:
> On Monday 20 October 2014 21:54:02 Jungseung Lee wrote:
> > L1_CACHE_BYTES could be larger than real L1 cache line size.
> > In that case, flush_pfn_alias function would omit to flush last bytes
> > as much as L1_CACHE_BYTES - real cache line size.
> 
> Can you list an example on what CPU this would happen in the
> patch description? Isn't the L1 cache line size always 32 bytes on ARM?

No, there are 64-byte cache lines in some v7 CPUs.

> Is this needed in stable backports?

The MCRR instruction is deprecated (presumably because, as I discovered
in the early days, it can prevent the system making progress under high
interrupt load), but is only used on ARMv6 CPUs with aliasing cachces -
which have a cache line size of 32.  However, when built alongside ARMv7,
it is possible that L1_CACHE_SIZE could be 64.

The patch seems sane on the face of it.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.

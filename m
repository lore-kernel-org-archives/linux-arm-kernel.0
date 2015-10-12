From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Oct 2015 11:27:42 +0200
Subject: [PATCH] ARM:mm: fix kmap_atomic_to_page
In-Reply-To: <561B457F.5090104@lge.com>
References: <1444129773-12632-1-git-send-email-chanho.min@lge.com>
 <20151007090121.GC21513@n2100.arm.linux.org.uk> <561B457F.5090104@lge.com>
Message-ID: <5778996.I0Vmityi0g@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 October 2015 14:30:39 Jongsung Kim wrote:
> We tried to utilize a HW compressor as a zram backend. Current zram uses
> kmap_atomic to map a page, and the HW DMAes. So we needed to use
> kmap_atomic_to_page to get the page to be dma-mapped.

How about changing the zcomp code to pass the page pointer instead of
the kernel space pointer? That would avoid having to do the kmap_atomic,
which can itself be expensive on 32-bit machines and should not
be needed here if you have a HW DMA engine doing the compression.

	Arnd

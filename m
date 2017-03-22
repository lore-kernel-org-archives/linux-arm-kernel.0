From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Mar 2017 11:10:20 +0000
Subject: [PATCH] ARM: dma-mapping: Fix dma_get_sgtable() for regions
 without struct page
In-Reply-To: <1487682998-2564-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20170221131655eucas1p2f2ca6e3c819aeae227c5e5c5f2bc7d3f@eucas1p2.samsung.com>
 <1487682998-2564-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20170322111020.GD21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2017 at 02:16:38PM +0100, Marek Szyprowski wrote:
> Some DMA regions, for example those created by dma_declare_coherent_memory,
> might not be possible to be represented by struct page pointers. Getting
> scatterlist for the buffer allocated from such region is not possible.
> This patch adds a simple check in arm_dma_get_sgtable() function if the
> exported struct page pointer is valid.

I really don't like this - the "validation" here looks like total crap,
especially when you analyse what these macros expand to.

I also don't like the way dma_get_sgtable() appeared without any
documentation about (a) what it's for (b) what the expectations for its
arguments are and (c) what it's supposed to be doing.  There are no
comments in include/linux/dma-mapping.h describing the interface, nor
are there any comments about it in Documentation/DMA*.

So, I'm really not applying this patch until the purpose of this
function gets documented.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

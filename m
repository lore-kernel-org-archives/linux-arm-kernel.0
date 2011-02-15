From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Feb 2011 14:27:30 +0000
Subject: [PATCH v4 16/19] ARM: LPAE: Use generic dma_addr_t type definition
In-Reply-To: <1297688490.31111.38.camel@e102109-lin.cambridge.arm.com>
References: <1295891761-18366-1-git-send-email-catalin.marinas@arm.com>
	<1295891761-18366-17-git-send-email-catalin.marinas@arm.com>
	<20110212103413.GD15616@n2100.arm.linux.org.uk>
	<1297688490.31111.38.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20110215142730.GM4152@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 14, 2011 at 01:01:30PM +0000, Catalin Marinas wrote:
> Maybe we could make the dma_addr_t size configurable (and disabled by
> default) since I expect there'll be platforms capable of >32-bit DMA.

It would be far better to fix the dma_addr_t abuses.  I've already fixed
those in the pl08x driver:

struct lli {
        dma_addr_t src;
        dma_addr_t dst;
        dma_addr_t next;
        u32 cctl;
};

became:

struct pl08x_lli {
        u32 src;
        u32 dst;
        u32 lli;
        u32 cctl;
};

and similar needs to be done elsewhere in ARM specific drivers.
dma_addr_t has no business being in structures that describe data which
hardware accesses.

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 28 Feb 2010 14:20:46 +0000
Subject: [RFC PATCH v2 4/9] add generic dmabounce support
In-Reply-To: <1267366082-15248-5-git-send-email-albert_herranz@yahoo.es>
References: <1267366082-15248-1-git-send-email-albert_herranz@yahoo.es>
	<1267366082-15248-5-git-send-email-albert_herranz@yahoo.es>
Message-ID: <20100228142046.GA16745@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 28, 2010 at 03:07:57PM +0100, Albert Herranz wrote:
> This patch makes part of the ARM dmabounce code available to other
> architectures as a generic API.

There is already a generic dma bounce implementation - it's called
swiotlb - lib/swiotlb.c.  We should eventually switch the ARM
dmabounce stuff over to that instead of keeping dmabounce around.

The only problem I forsee is that on ARM, we have devices which can
only address the least significant N bits of RAM, but there may be
an offset on the base address of RAM on the bus which isn't included
in these N bits.

Even more fun is where we have a DMA controller which can address
N bits of RAM, except for bit M which must be zero... (where N > M).

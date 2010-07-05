From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Jul 2010 15:17:19 +0100
Subject: About cachetype on ARMv7
In-Reply-To: <004c01cb1c34$49773f60$dc65be20$%kim@samsung.com>
References: <004c01cb1c34$49773f60$dc65be20$%kim@samsung.com>
Message-ID: <20100705141719.GA23556@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 05, 2010 at 08:21:56PM +0900, Kukjin Kim wrote:
> If every ARMv7 SoCs have VIPT non-aliasing d-cache and i-cache, then no
> problem. But actually, Samsung S5PV310(cortex-A9) has PIPT d-cache and VIPT
> non-aliasing i-cache. I think PIPT does not mean VIPT non-aliasing even
> though their functionality is similar.

There is no visible difference between a non-aliasing VIPT cache and a
PIPT cache.  Address bit allocation for a 32-byte cache line VIPT
non-aliasing cache with 4K page size:

[0:1] = byte offset into word
[4:2] = word offset
[N-1:5] = virtual index
[31:N] = physical tag

where N <= PAGE_SHIFT, otherwise it would be an aliasing VIPT cache.

For a PIPT non-aliasing cache:

[0:1] = byte offset into word
[4:2] = word offset
[M-1:5] = physical index
[31:M] = physical tag

where M doesn't matter as it can never alias with itself.

The requirements for N is such the CPU visible conditions which qualify a
cache as being VIPT non-aliasing also satisfy PIPT - and a non-aliasing
VIPT cache has the same properties as a PIPT cache.

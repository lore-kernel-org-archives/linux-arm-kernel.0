From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Nov 2015 16:45:23 +0100
Subject: [PATCH] mmc: dw_mmc: use resource_size_t to store physical address
In-Reply-To: <CAHp75VfE2DWYB5GwSe1WLPb+gTnhNpYz5qo7jNfMK4tXbEWioQ@mail.gmail.com>
References: <28102387.ALpaBHpim0@wuerfel> <5141236.CHnzdS7Lto@wuerfel>
 <CAHp75VfE2DWYB5GwSe1WLPb+gTnhNpYz5qo7jNfMK4tXbEWioQ@mail.gmail.com>
Message-ID: <7083277.bjzG62aVmx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 November 2015 17:29:19 Andy Shevchenko wrote:
> 
> I understand most of the things here, what I don't is how a platform
> is supposed to work if you have the following:
> a) HW, that uses register space let's say higher than 32-bit;
> b) DMA engine, which should provide a DMA capability for above HW block;
> c) dma_addr_t which does not cover the HW register space.

On this platform, the current code is obviously broken, because the pointer
is 32-bit wide and cannot reach the registers. I assume you agree on that
part.

With my patch, the 64-bit resource_size_t in dw_mci helps get the
correct FIFO address to this line:

	cfg.dst_addr = host->phy_regs + fifo_offset;

There, it remains broken because of the dma_addr_t being too short, and
we also need Linus' patch from https://lkml.org/lkml/2013/4/26/120 in
addition to mine.


> For me it clearly looks like a platform (HW / SW) configuration issue.

I think some people have argued in the past that we should always use
the same type for dma_addr_t, resource_size_t and phys_addr_t. That
would certainly fix the problem you describe as well. In practice,
everyone has that already, and my patch by itself fixes all the
cases where the FIFO is at a high address and dma_addr_t is already
64-bit wide.

> In case of bounce buffers I can't understand how it helps there.

Right, bounce buffers are irrelevant here, because the FIFO address
is never translated and never bounced.

	Arnd

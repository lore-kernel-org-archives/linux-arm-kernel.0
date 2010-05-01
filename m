From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sun, 2 May 2010 01:04:37 +0200
Subject: [PATCH 00/11] ARM: PrimeCell DMA Interface v5
In-Reply-To: <20100501224429.GA17693@n2100.arm.linux.org.uk>
References: <1270681920-4461-1-git-send-email-linus.walleij@stericsson.com>
	<v2se9c3a7c21004071645u8180f4d7p3b4b1f96de11303e@mail.gmail.com>
	<CEE6BB42CAD6E947908279175AF8470A03A50F78@EXDCVYMBSTM006.EQ1STM.local>
	<t2qe9c3a7c21004141815x70ecf123p4364802681417da9@mail.gmail.com>
	<q2o63386a3d1004162158v296379fat2b376d5c4c087378@mail.gmail.com>
	<20100422110025.GC20008@n2100.arm.linux.org.uk>
	<g2qe9c3a7c21005011500l11511d43i12d971775b139c3b@mail.gmail.com>
	<20100501224429.GA17693@n2100.arm.linux.org.uk>
Message-ID: <x2u63386a3d1005011604kaee33364l880e90a4e2453e0f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/5/2 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> Versatile has some MUXing on three of the DMA signals, so (eg) we
> really don't want UARTs claiming DMAs just because they're in existence
> and not in use - that would prevent DMAs from being used for (eg) AACI
> or MMC.

As long as Versatile doesn't specify any filter function or
data for the channel allocation function (it currently doesn't and defaults
to NULL) it won't even try to call the DMA engine to allocate a channel
for say the UART.

There is nothing blocking some other peripheral from grabbing a
muxed channel in that case.

But the implementation of the DMA engine would be better of
handling the muxing dynamically I believe, so when the PL011
driver (say) requests a DMA channel, it doesn't mean it requests the
*physical* channel and holds it (unless the driver is very na?vely
implemented) it nominally means it reserves a placeholder in the
DMA engine.

When the driver issues a request to perform a DMA transfer, it will pull
out a physical channel and use that, then return it. If there is too
much combat about the physical channels, you configure out DMA
for the least wanted PrimeCells.

Yours,
Linus Walleij

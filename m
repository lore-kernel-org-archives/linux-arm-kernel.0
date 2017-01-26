From: scott.wood@nxp.com (Scott Wood)
Date: Thu, 26 Jan 2017 05:08:43 +0000
Subject: [PATCH 06/10] soc/qbman: Add ARM equivalent for
 flush_dcache_range()
References: <1484779180-1344-1-git-send-email-roy.pledge@nxp.com>
 <VI1PR0401MB2430DA6BD2F857C30EC86A50917F0@VI1PR0401MB2430.eurprd04.prod.outlook.com>
 <HE1PR0401MB263638F320470CA216990BCC86720@HE1PR0401MB2636.eurprd04.prod.outlook.com>
 <5414359.8GMja3pNrI@wuerfel>
Message-ID: <VI1PR0401MB24303C4A5C0042005E17F1A391770@VI1PR0401MB2430.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/25/2017 03:20 PM, Arnd Bergmann wrote:
> On Monday, January 23, 2017 7:24:59 PM CET Roy Pledge wrote:
>>> Is there a non-"under the covers" way to say "flush this region" without
>>> the arch second-guessing whether it really needs to be flushed?
>> Any advice on how to resolve this? I looked into trying to do a
>> non-cacheable mapping of the
>> memory so that the flush wouldn't be required but the ioremap code
>> prevents mapping normal
>> memory in this way.  The QMan device requiresthis memory to be zeroed at
>> startup. Because the device
>> does non coherent reads and writes to the memory we must ensure that any
>> cache in the CPU cluster(s)
>> is flushed in order to prevent a future castout from overwriting data.
>> This happened before on PPC
>> platforms and made for some very unfun debug session trying to
>> understand what was causing the failure.
> 
> If this is normal RAM, you should be able to just write zeroes, and then
> do a dma_map_single() for initialization.

The DMA API on PPC currently has no way of knowing that the device
accesses this memory incoherently.

If that were somehow fixed, we still couldn't use dma_map_single() as it
doesn't accept virtual addresses that come from memremap() or similar
dynamic mappings.  We'd have to convert the physical address to an array
of struct pages and pass each one to dma_map_page().

And even if we did all that, there would still be other manual cache
manipulation left in this driver, to deal with its cacheable register
interface.

> Are there any other requirements
> what to do with the memory later, is it used for communication at all,
> or just required to be zero?

It just needs to be zeroed before the device begins using it for
internal storage.

-Scott

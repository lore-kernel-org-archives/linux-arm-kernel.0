From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Jan 2017 17:41:10 +0100
Subject: [PATCH 06/10] soc/qbman: Add ARM equivalent for
 flush_dcache_range()
In-Reply-To: <VI1PR0401MB24303C4A5C0042005E17F1A391770@VI1PR0401MB2430.eurprd04.prod.outlook.com>
References: <1484779180-1344-1-git-send-email-roy.pledge@nxp.com>
 <VI1PR0401MB2430DA6BD2F857C30EC86A50917F0@VI1PR0401MB2430.eurprd04.prod.outlook.com>
 <HE1PR0401MB263638F320470CA216990BCC86720@HE1PR0401MB2636.eurprd04.prod.outlook.com>
 <5414359.8GMja3pNrI@wuerfel>
 <VI1PR0401MB24303C4A5C0042005E17F1A391770@VI1PR0401MB2430.eurprd04.prod.outlook.com>
Message-ID: <CAK8P3a1Gd4bd7GjEp_a9WXc_mTPk0XmP7DH8aPWhbn2K3MMuDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 6:08 AM, Scott Wood <scott.wood@nxp.com> wrote:
> On 01/25/2017 03:20 PM, Arnd Bergmann wrote:
>> On Monday, January 23, 2017 7:24:59 PM CET Roy Pledge wrote:

>> If this is normal RAM, you should be able to just write zeroes, and then
>> do a dma_map_single() for initialization.
>
> The DMA API on PPC currently has no way of knowing that the device
> accesses this memory incoherently.

Ah, this is because PPC doesn't use the 'dma-coherent' property on devices
but just assumes that coherency is a global property of the platform,right?

> If that were somehow fixed, we still couldn't use dma_map_single() as it
> doesn't accept virtual addresses that come from memremap() or similar
> dynamic mappings.  We'd have to convert the physical address to an array
> of struct pages and pass each one to dma_map_page().

Sorry for my ignorance, but where does the memory come from to start
with? Is this in the normal linearly mapped RAM, in a carveout outside
of the linear mapping but the same memory, or in some on-chip buffer?

> And even if we did all that, there would still be other manual cache
> manipulation left in this driver, to deal with its cacheable register
> interface.

I thought we had concluded that "cacheable register" is something
that cannot work reliably on ARM at all when this came up before.
Any updates on that?

>> Are there any other requirements
>> what to do with the memory later, is it used for communication at all,
>> or just required to be zero?
>
> It just needs to be zeroed before the device begins using it for
> internal storage.

Ok.

    Arnd

From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 7 Feb 2017 18:25:53 +0000
Subject: [PATCH 06/10] soc/qbman: Add ARM equivalent for
 flush_dcache_range()
In-Reply-To: <HE1PR0401MB26362EA8D498B77755DE63A286430@HE1PR0401MB2636.eurprd04.prod.outlook.com>
References: <VI1PR0401MB2430DA6BD2F857C30EC86A50917F0@VI1PR0401MB2430.eurprd04.prod.outlook.com>
 <HE1PR0401MB263638F320470CA216990BCC86720@HE1PR0401MB2636.eurprd04.prod.outlook.com>
 <5414359.8GMja3pNrI@wuerfel>
 <VI1PR0401MB24303C4A5C0042005E17F1A391770@VI1PR0401MB2430.eurprd04.prod.outlook.com>
 <CAK8P3a1Gd4bd7GjEp_a9WXc_mTPk0XmP7DH8aPWhbn2K3MMuDQ@mail.gmail.com>
 <1485570872.9266.22.camel@buserror.net>
 <d5ca6bcd-1d1a-2a61-1f5c-9086a67f629a@arm.com>
 <HE1PR0401MB2636FF4D977DDA6888616A26864B0@HE1PR0401MB2636.eurprd04.prod.outlook.com>
 <3cc42823-0fc9-ed3e-1738-bf6e314dd569@arm.com>
 <HE1PR0401MB2636B14B4F1637A5A7D5432386400@HE1PR0401MB2636.eurprd04.prod.outlook.com>
 <20170206223721.GN27312@n2100.armlinux.org.uk>
 <HE1PR0401MB26362EA8D498B77755DE63A286430@HE1PR0401MB2636.eurprd04.prod.outlook.com>
Message-ID: <e15f6ce7-be92-9200-c6b4-2b2dd83f078f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/17 16:44, Roy Pledge wrote:
> On 2/6/2017 5:37 PM, Russell King - ARM Linux wrote:
>> On Mon, Feb 06, 2017 at 10:26:26PM +0000, Roy Pledge wrote:
>>> Why don't I simplify this and use dma_sync_single_for_device() to flush
>>> the cache?
>> ... which can only be used on direct-mapped memory.
>>
> Then I don't see another (or understand) any other option. There is no
> way I can add a large area of physical memory carved out by
> of_reserve_mem to a DMA allocator since both ioremap and memremap throw
> an error if I try to do so. I appreciate the suggestions from people to
> resolve this but so far there isn't a workable solution to the problem.
> As far as I can tell other users of dma_declare_coherent_memory() are
> using it for device backed memory, not DDR.  It sounds like a solution
> on the surface but when you dig into the details it just doesn't work. 
> Please let me know if I'm missing something, I really want to close this
> issue so we can get upstream support for this device on ARM.

Apologies, having found time to take a proper look, it transpires I was
somewhat misremembering things. You're right that
dma_declare_coherent_memory() is for resources owned by the device, and
a DT reservation doesn't really count as such. What I had mixed up is
that a reserved-memory node has its own way of getting tied into CMA
automatically: ensure it has the "shared-dma-pool" compatible, point a
memory-region property at it from your device's node, then have the
driver call of_reserved_mem_device_init() - at that point, your DMA
allocations should be coming out of the given region so you should be
free to just grab the whole lot in one go.

I've just confirmed that experimentally by bodging a reserved-memory
node into my Juno DT for the ARM HDLCD - another non-coherent device
which needs ~8MB contiguous buffers - and it works as expected.

Robin.

> 
> 
> Roy
> 

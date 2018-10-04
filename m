From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 4 Oct 2018 12:05:55 +0100
Subject: How is the Linux kernel API dma_alloc_coherent() typically
 implemented for the ARM Architecture?
In-Reply-To: <20181003180843.GY30658@n2100.armlinux.org.uk>
References: <BYAPR12MB2791F73EC1033F998FF533BAC8E90@BYAPR12MB2791.namprd12.prod.outlook.com>
 <866a698a-aa61-6c48-0258-f2dd97973e87@arm.com>
 <20181003180843.GY30658@n2100.armlinux.org.uk>
Message-ID: <41f7c1e1-066a-b984-53cd-17b5c25420d4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/10/18 19:08, Russell King - ARM Linux wrote:
> On Wed, Oct 03, 2018 at 06:44:56PM +0100, Robin Murphy wrote:
>> Hi Casey,
>>
>> On 03/10/18 17:55, Casey Leedom wrote:
>>>    I have a question about ARM CPU versus PCIe DMA I/O Coherence that I'm
>>> trying to understand. In general, I thought that ARM is I/O Incoherent and
>>> that setting up Device DMA READs from Coherent Memory and Device DMA WRITEs
>>> to Coherent Memory require that the Device Driver/OS coordinate to
>>> FLUSH/INVALIDATE Caches, etc.  In Linux this is all handled automatically
>>> via the dam_map*()/dma_unmap*() APIs.  But what does the Linux kernel API
>>> dma_alloc_coherent() do on an architecture like ARM?  Return an UNCACHED
>>> mapping? I've tried ferreting my way down through the layers and layers of
>>> abstraction and implementation differences for various ARM platforms but
>>> it's pretty opaque ...
>>
>> The really old stuff is a bit murky, but certainly from Armv7 onwards (i.e.
>> the kind of systems you'd be plugging a PCIe card into today), it's
>> relatively straightforward.
> 
> The old stuff is _not_ murky - it operates the same way as modern
> systems as far as Linux is concerned.

Apologies if that came across wrong - I mean it from my viewpoint in 
terms of the level of detail I wanted to go into (my point of reference 
is primarily VMSAv8, plus what it changed from VMSAv7). I can't say that 
an ARMv5 kernel is going to give a Normal-NC mapping since as I 
understand things it may be Strongly-Ordered instead depending on 
configuration. TBH I can't even fully remember off-hand what exactly the 
pre-TEX-remap attributes are and how they would map to AXI/ACE 
transactions, and it didn't seem worth spending half an hour looking it 
all up since the prospect of something like an ARM296 being the main 
application processor driving the kind of kit that Chelsio do seems 
rather unlikely.

>  That's one of the reasons
> for having the DMA API - to provide a consistent cross-platform
> cross-architecture way to deal with the DMA coherency issues.

Fully agreed that driver authors shouldn't care about this and can trust 
the kernel to provide the best thing it can, but Casey's initial 
question implied that a bit more architectural background might be 
useful (especially now given the response).

Robin.

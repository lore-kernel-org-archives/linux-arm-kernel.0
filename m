From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Wed, 09 Dec 2009 16:32:19 -0800
Subject: non barrier versions of dma_map functions
In-Reply-To: <20091207193548.GG26821@n2100.arm.linux.org.uk>
References: <7f6a66b765002fcc815937b5d8d085cf.squirrel@www.codeaurora.org>
	<20091207193548.GG26821@n2100.arm.linux.org.uk>
Message-ID: <4B204193.6050004@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Mon, Dec 07, 2009 at 11:37:21AM -0800, adharmap at codeaurora.org wrote:
>> We have a situation where we need to dma map multiple cached buffers for a
>> single dma transaction.
>>
>> The current DMA api suggests the use of dma_map_single for cache
>> consistency. On ARMv7 it performs the necessary cache-operations and calls
>> data sync barrier instruction (DSB). In our case we would be executing
>> multiple DSB instruction before starting the dma operation - we need
>> memory to be consistent only after we map the last buffer.
> 
> Is it a problem and do you have numbers to illustrate why it is a
> problem, or is this just theory?


Here are numbers from a test ran on ARMv7 based device
It kmallocs N buffers of size 'size', dirties their cache by writing
to them and calls dma_map_single that calls the arch specific clean
operations with and without dsb. In "without dsb" case a dsb is executed
after the last buffer is mapped. The time is in microseconds

size	N	map_single	map_single w/o dsb	delta
128	16	8		5			60%
512	16	9		6			50%
512	32	15		8			88%
512	48	20		11			82%
512	64	27		14			93%
64	4	4		3			33%
64	8	4		3			33%
64	16	7		4			75%
64	32	12		4			200%
64	48	17		6			183%
64	64	21		7			200%
1024	16	9		7			29%

These buffer sizes and N are very close to real world sizes the
framebuffer driver handles. Cases where N is large happen the most
often.

Clearly,we could benefit from the nobarrier versions of the cache
operations and we could use them in scatter gather mappings as well.

Abhijeet

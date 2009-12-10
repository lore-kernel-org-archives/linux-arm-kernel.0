From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Thu, 10 Dec 2009 10:16:49 -0800
Subject: non barrier versions of dma_map functions
In-Reply-To: <1260437955.22188.9.camel@pc1117.cambridge.arm.com>
References: <4B204193.6050004@codeaurora.org>
	<1260437955.22188.9.camel@pc1117.cambridge.arm.com>
Message-ID: <4B213B11.40308@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> On Thu, 2009-12-10 at 00:32 +0000, Abhijeet Dharmapurikar wrote:
>> Russell King - ARM Linux wrote:
>>> On Mon, Dec 07, 2009 at 11:37:21AM -0800, adharmap at codeaurora.org wrote:
>>>> We have a situation where we need to dma map multiple cached buffers for a
>>>> single dma transaction.
>>>>
>>>> The current DMA api suggests the use of dma_map_single for cache
>>>> consistency. On ARMv7 it performs the necessary cache-operations and calls
>>>> data sync barrier instruction (DSB). In our case we would be executing
>>>> multiple DSB instruction before starting the dma operation - we need
>>>> memory to be consistent only after we map the last buffer.
>>> Is it a problem and do you have numbers to illustrate why it is a
>>> problem, or is this just theory?
>>
>> Here are numbers from a test ran on ARMv7 based device
>> It kmallocs N buffers of size 'size', dirties their cache by writing
>> to them and calls dma_map_single that calls the arch specific clean
>> operations with and without dsb. In "without dsb" case a dsb is executed
>> after the last buffer is mapped. The time is in microseconds
> 
> Interesting results but I have some additional questions:
> 
> What is the direction given to dma_map_single()?
> 
DMA_TO_DEVICE
> If the direction is TO_DEVICE, has the buffer been dirtied before
> calling dma_map_single()? The DSB overhead could be smaller compared to
> the actual cache flushing.
Yes the buffers were dirtied before calling 
dma_map_single(...DMA_TO_DEVICE);
> 

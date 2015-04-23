From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Thu, 23 Apr 2015 13:52:34 +0200
Subject: dma_alloc_coherent versus streaming DMA, neither works satisfactory
Message-ID: <5538DD02.6050401@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?I'm writing a driver that transfers data on a Zynq-7000 between the ARM and PL 
part, using a buffering scheme similar to IIO. So it allocates buffers, which 
the user can memory-map and then send/receive using ioctl calls.
The trouble I have it that transitioning these buffers into user space is 
costing more CPU time than actually copying them.


The self-written DMA controller is in logic, can queue up several transfers 
and operates fine.

The trouble I have with the driver is that for the DMA transfers, I want to 
use a zero-copy style interface, because the data usually consists of video 
frames, and moving them around in memory is prohibitively expensive.

I based my implementation on what IIO (industrial IO) does, and implemented 
IOCTL calls to the driver to allocate, free, enqueue and dequeue blocks that 
are owned by the driver. Each block can be mmapped into user space.

Using dma_alloc_coherent to allocate the blocks, and then just using them 
without any extra measures works just fine. The system can transfer data at 
600MB/s to and from DDR into logic with very little CPU intervention. However, 
the memory returned by dma_mmap_coherent appears to be uncached, because 
accessing this area from userspace is horribly slow (e.g. reading 200MB 
byte-by-byte in a simple for loop takes 20 seconds, while this takes about a 
second in malloced memory)

After reading some documentation, I decided that I should use a streaming DMA 
interface because my driver knows exactly when logic or CPU "owns" the data 
blocks. So instead of the "coherent" functions, I just kmalloc these buffers 
and then use dma_map_single_* to initialize them. Before and after DMA 
transfers, I call the appropriate dma_sync_single_for_* method.

By mapping the kmalloced memory into user space, I once again have speedy 
access to this memory, and caching is enabled. Data transfers also work well 
and extensive testing shows that this works well. However, the in-kernel 
performance is now completely crippled. The system spends so much time in the 
dma_sync_single... calls, the the CPU now becomes a limiting factor. This 
limits the transfer speeds to about only 150MB/s. This method is only about 
20% more CPU intensive than just copying the data from the DMA buffer into a 
user buffer using a copy_to_user call!


Since my DMA controller is pretty smart, I also experimented with transfers 
directly from user memory. This boiled down to calling "get_user_pages" and 
then constructing a scatter-gather list using sg_init_table and then adding 
those user pages. Then call "dma_map_sg" to translate and coalesce the pages 
into DMA requests. Just this pagetable housekeeping took about the same amount 
of processing time as the copy_from_user call, which made me abandon that code 
before even getting to the point of actually transferring the data.

Based on that experience, I'd think the dma_sync calls do similar things 
(walking page tables and changing some attributes) and that is where they 
spend so much time.

I also tried cheating by not calling the dma_sync methods at all, but this 
(surprisingly) led to hangups in the driver. I would have only expected data 
corruption, not "hang". I'm still investigating that route. Specifying 
"dma-coherent" has the same effect as it basically "nulls" the sync methods.

Also tried to replace the "dma_mmap_coherent" call by a simple 
"remap_pfn_range" so as to prevent setting the cache attributes on that 
region, but that didn't have any effect at all, it appears that the 
non-cachable property was already applied in the dma_alloc_coherent method.


I added some timing code to the "sync" calls, this is what I get (numbers in 
microseconds) when using 1MB blocks of streaming DMA transfers:

dma_sync_single_for_device(TO_DEVICE): 3336
dma_sync_single_for_device(FROM_DEVICE): 1991
dma_sync_single_for_cpu(FROM_DEVICE): 2175
dma_sync_single_for_cpu(TO_DEVICE): 0
dma_sync_single_for_device(TO_DEVICE): 3152
dma_sync_single_for_device(FROM_DEVICE): 1990
dma_sync_single_for_cpu(FROM_DEVICE): 2193
dma_sync_single_for_cpu(TO_DEVICE): 0


As you can see, the system spends 2 or 3 ms on "housekeeping" for each 
transition, except the cpu(TO_DEVICE) one which appears to be free which is 
perfectly logical because returning the outgoing buffer to the CPU should not 
need any special cache handling. I would have expected the 
for_device(FROM_DEVICE) to be free as well, but surprisingly this one takes up 
2ms as well.

Adding the numbers, it takes over 7 ms overhead to transfer 1MB data, hence 
1MB/0.007s or about 150MB/s would be the maximum possible data transfer rate.


Can anyone here offer some advise on this?


Kind regards,

Mike Looijmans
System Expert

TOPIC Embedded Products
Eindhovenseweg 32-C, NL-5683 KH Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
Telefax: +31 (0) 499 33 69 70
E-mail: mike.looijmans at topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail

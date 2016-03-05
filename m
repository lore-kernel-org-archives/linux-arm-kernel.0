From: d.mueller@elsoft.ch (=?UTF-8?Q?David_M=c3=bcller_=28ELSOFT_AG=29?=)
Date: Sat, 5 Mar 2016 17:23:04 +0100
Subject: Slow access to data in mmaped memory areas
Message-ID: <56DB07E8.4040003@elsoft.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

I have a multi-core Cortex-A9 based system where an external busmaster 
capable device is transmitting data into the system memory. 
Unfortunately the device's DMA engine does not support "scatter-gather" 
mode.
The CPU job is to process the data received from the device.

I have written a driver which allocates serveral continuous memory block 
(each 2MiB in size) as buffers, and transfers the data from the external 
device to the buffers by DMA.

I have also written an application which accesses the data by "mmaping" 
the buffers into the application's address space.
All this works ok, but processing performance of the data by the CPU is 
pretty slow.

After looking at arch/arm/mm/mmu.c and arch/arm/mm/dma-mapping.c, it 
seems like caching is disabled for all mmaped memory areas.

Is this observation correct?
Is there a way to re-enable caching for mmaped memory areas after the 
DMA transfer is completed and to disable caching before the next DMA starts?

Dave

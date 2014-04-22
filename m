From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 22 Apr 2014 10:36:44 -0400
Subject: [PATCH] ARM: mm: dma: Update coherent streaming apis with missing
 memory barrier
In-Reply-To: <201404221608.36628.arnd@arndb.de>
References: <1398103390-31968-1-git-send-email-santosh.shilimkar@ti.com>
 <20140422102834.GE7484@arm.com> <53567352.1080306@ti.com>
 <201404221608.36628.arnd@arndb.de>
Message-ID: <53567E7C.7020409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 April 2014 10:08 AM, Arnd Bergmann wrote:
> On Tuesday 22 April 2014, Santosh Shilimkar wrote:
>> On Tuesday 22 April 2014 06:28 AM, Will Deacon wrote:
> 
>>> Don't you only need these barriers if you're passing ownership of a CPU
>>> buffer to a device? In that case, I would expect a subsequent writel to tell
>>> the device about the new buffer, which includes the required __iowmb().
>>> That's the reason for the relaxed accessors: to avoid this barrier when it's
>>> not needed. Perhaps you're using the relaxed accessors where you actually
>>> need the stronger ordering guarantees?
>>>
>> I kind of guessed some one will bring up above point. Infact this is how
>> mostly people have been living with the issue on coherent machines. On
>> Keystone too, we did explicit barriers in respective drivers.
> 
> You should not actually need explicit barriers in the drivers. As Will
> said, you already do a writel() operation, which is contains the
> implicit wmb.
> 
>> I have added these barriers only on CPU to device streaming APIs because on
>> other direction, the memory is already upto date from CPU's perspective.
>>
>> But if you look at the actual problem, its really responsibility of
>> DMA streaming APIs which we are trying to push on to drivers. A device
>> driver should be independent of whether it is running on a coherent or
>> a non-coherent CPU.
>>
>> Lets take a example....
>> MMC controller driver running on a non-coherent and coherent machine.
>> Driver has below code sequence which is generic.
>> 1. Prepare SG list
>> 2. Perform CMO using DMA streaming API
>> 3. Start DMA transfer...
>> 	
>> Step 3 expects that step 2 has done its job and buffer is
>> completely in the main memory. And thats what also happens
>> on non-coherent machines.
>>
>> Now, on coherent machines, as you mentioned, we are saying drivers
>> should add a barrier because Step2 is just NOP which is not correct.
>> The Step3 itself which is just suppose to start DMA doesn't need
>> any barrier as such. This is the whole rationale behind the patch.
> 
> That's not what the API is. The entire reason for having both writel()
> and writel_relaxed() is that drivers rely on writel() to do the barrier.
> Doing another barrier in the DMA operations would add unnecessary
> overhead for every single driver.
> 
> It's not the nicest API ever, but that's what it is and has been, mostly
> for compatibility with x86, where the 'mov' instruction performing the
> store to MMIO registers implies that all writes to DMA memory are
> visible to the device.
> 
This is not about writel() and  writel_relaxed(). The driver don't
need that barrier. For example if the actual start of the DMA
happens bit later, that doesn't matter for the driver.

DMA APIs already do barriers today for non-coherent case. We
are not talking anything new here. Sorry but I don't see the
connection here.

Regards,
Santosh

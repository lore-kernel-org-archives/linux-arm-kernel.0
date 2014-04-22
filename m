From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 22 Apr 2014 09:49:06 -0400
Subject: [PATCH] ARM: mm: dma: Update coherent streaming apis with missing
 memory barrier
In-Reply-To: <20140422102834.GE7484@arm.com>
References: <1398103390-31968-1-git-send-email-santosh.shilimkar@ti.com>
 <20140422102834.GE7484@arm.com>
Message-ID: <53567352.1080306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Tuesday 22 April 2014 06:28 AM, Will Deacon wrote:
> Hi Santosh,
> 
> On Mon, Apr 21, 2014 at 07:03:10PM +0100, Santosh Shilimkar wrote:
>> ARM coherent CPU dma map APIS are assumed to be nops on cache coherent
>> machines. While this is true, one still needs to ensure that no
>> outstanding writes are pending in CPU write buffers. To take care
>> of that, we at least need a memory barrier to commit those changes
>> to main memory.
>>
>> Patch is trying to fix those cases. Without such a patch, you will
>> end up patching device drivers to avoid the synchronisation issues.
> 
> Don't you only need these barriers if you're passing ownership of a CPU
> buffer to a device? In that case, I would expect a subsequent writel to tell
> the device about the new buffer, which includes the required __iowmb().
> That's the reason for the relaxed accessors: to avoid this barrier when it's
> not needed. Perhaps you're using the relaxed accessors where you actually
> need the stronger ordering guarantees?
> 
I kind of guessed some one will bring up above point. Infact this is how
mostly people have been living with the issue on coherent machines. On
Keystone too, we did explicit barriers in respective drivers.

I have added these barriers only on CPU to device streaming APIs because on
other direction, the memory is already upto date from CPU's perspective.

But if you look at the actual problem, its really responsibility of
DMA streaming APIs which we are trying to push on to drivers. A device
driver should be independent of whether it is running on a coherent or
a non-coherent CPU.

Lets take a example....
MMC controller driver running on a non-coherent and coherent machine.
Driver has below code sequence which is generic.
1. Prepare SG list
2. Perform CMO using DMA streaming API
3. Start DMA transfer...

Step 3 expects that step 2 has done its job and buffer is
completely in the main memory. And thats what also happens
on non-coherent machines.

Now, on coherent machines, as you mentioned, we are saying drivers
should add a barrier because Step2 is just NOP which is not correct.
The Step3 itself which is just suppose to start DMA doesn't need
any barrier as such. This is the whole rationale behind the patch.

Regards,
Santosh

 

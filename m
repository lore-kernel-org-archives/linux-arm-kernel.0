From: robherring2@gmail.com (Rob Herring)
Date: Fri, 15 Feb 2013 10:24:35 -0600
Subject: [PATCH 0/2] Device Tree support for CMA (Contiguous Memory
 Allocator)
In-Reply-To: <20130215083304.GK1906@pengutronix.de>
References: <1360845928-8107-1-git-send-email-m.szyprowski@samsung.com>
 <20130214213013.GG1906@pengutronix.de> <511D6076.9090503@gmail.com>
 <20130215083304.GK1906@pengutronix.de>
Message-ID: <511E6143.609@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/15/2013 02:33 AM, Sascha Hauer wrote:
> On Thu, Feb 14, 2013 at 11:08:54PM +0100, Sylwester Nawrocki wrote:
>> Hi,
>>
>> On 02/14/2013 10:30 PM, Sascha Hauer wrote:
>>> On Thu, Feb 14, 2013 at 01:45:26PM +0100, Marek Szyprowski wrote:
>> ...
>>>> Here is my initial proposal for device tree integration for Contiguous
>>>> Memory Allocator. The code is quite straightforward, however I expect
>>>> that the memory bindings require some discussion.
>>>>
>>>> The proposed bindings allows to define contiguous memory regions of
>>>> specified base address and size. Then, the defined regions can be
>>>> assigned to the given device(s) by adding a property with a phanle to
>>>> the defined contiguous memory region. From the device tree perspective
>>>> that's all. Once the bindings are added, all the memory allocations from
>>>> dma-mapping subsystem will be served from the defined contiguous memory
>>>> regions.
>>>>
>>>
>>> I think CMA regions should not be described in the devicetre at all. The
>>> devicetree is about hardware description and it should be OS agnostic,
>>> but CMA is only a Linux specific implementation detail. It's not even
>>> specific to a particular board, it's specific to a particular usecase of
>>> a board.
>>
>> I disagree. For example, in a multiprocessor system describing the memory
>> regions this way allows to assign memory to each subsystem, e.g. shared
>> memory, so that the memory region constraints are satisfied.
>>
>> CMA just happens to be an implementation of a method of assigning memory
>> to each device in Linux. The constraints on the memory are real hardware
>> constraints, resulting from a particular subsystem architecture.
> 
> If you are talking about DMA controllers which can only access a certain
> memory area, then yes, that's a hardware constraint, I'm not sure though
> if describing this as CMA in the devicetree is the way to go.
> 
> If you are talking about 'on this board I want to have 128MiB for this
> device because I'm doing 1080p while on another board 64MiB are enough
> because I'm doing 720p', then this is not a hardware constraint.
> 
> There may be valid scenarios for putting CMA into the devicetrees, but
> doing this also opens the door for abuse of this binding. I for once
> don't want to find areas being allocated for CMA in the devicetree for
> devices I don't care about. I know I can always exchange a devicetree,
> but I think the devicetree should be seen as firmware to a certain
> degree.

I agree this does not belong in DT. As a kernel developer, the DT comes
from firmware. Can the firmware author decide how much CMA memory is
needed? I don't think so.

I would suggest a kernel command line parameter instead if that does not
already exist.

Rob

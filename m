From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 25 Jun 2014 17:46:43 +0200
Subject: [PATCH v2 0/6] Enable L2 cache support on Exynos4210/4x12 SoCs
In-Reply-To: <20140625143728.GN3705@n2100.arm.linux.org.uk>
References: <1403703451-12233-1-git-send-email-t.figa@samsung.com>
 <20140625135039.GM3705@n2100.arm.linux.org.uk> <53AAD8FC.9040306@samsung.com>
 <20140625143728.GN3705@n2100.arm.linux.org.uk>
Message-ID: <53AAEEE3.1000004@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.06.2014 16:37, Russell King - ARM Linux wrote:
> On Wed, Jun 25, 2014 at 04:13:16PM +0200, Tomasz Figa wrote:
>> On 25.06.2014 15:50, Russell King - ARM Linux wrote:
>>> On Wed, Jun 25, 2014 at 03:37:25PM +0200, Tomasz Figa wrote:
>>>> This series intends to add support for L2 cache on Exynos4 SoCs on boards
>>>> running under secure firmware, which requires certain initialization steps
>>>> to be done with help of firmware, as selected registers are writable only
>>>> from secure mode.
>>>
>>> What I said in my message on June 12th applies to this series.  I'm
>>> not having the virtual address exposed via the write_sec call.
>>>
>>> Yes, you need to read other registers in order to use your secure
>>> firmware implementation.  Let's fix that by providing a better write_sec
>>> interface so you don't have to read back these registers, rather than
>>> working around this short-coming.
>>
>> Do you have anything in particular in mind? I would be glad to implement
>> it and send patches.
> 
> As I've already said, you are not the only ones who need fuller information
> to make your secure monitor calls.  So, what that implies is that rather
> than the interface being "please write register X with value V", and then
> having platforms work-around that by reading various registers, we need
> a more flexible interface which passes the desired state.
> 

So it's still not clear to me how this should be done correctly.

One thing that comes to my mind is precomputing register values to some
kind of structure, then calling some kind of magical platform-specific
.enable() or .configure() callback, which takes the structure and, in
one shot, configures the L2C according to firmware requirements. Then
the generic code would read back those values to verify the final
configuration (as it does right now) and rest of the operation would be
identical.

Is this something you would deem acceptable?

Best regards,
Tomasz

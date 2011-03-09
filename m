From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 9 Mar 2011 08:05:19 +0000
Subject: CONFIG_ARM_DMA_MEM_BUFFERABLE and readl/writel weirdness
In-Reply-To: <4D7708EC.9020806@codeaurora.org>
References: <4D6D9C03.2080906@codeaurora.org>
	<20110302083904.GA4493@n2100.arm.linux.org.uk>
	<4D6F481B.8000700@codeaurora.org>
	<20110303102411.GB13179@n2100.arm.linux.org.uk>
	<4D7708EC.9020806@codeaurora.org>
Message-ID: <20110309080519.GB605@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 08, 2011 at 08:58:20PM -0800, Saravana Kannan wrote:
> On 03/03/2011 02:24 AM, Russell King - ARM Linux wrote:
>> On Wed, Mar 02, 2011 at 11:49:47PM -0800, Saravana Kannan wrote:
>>>> I think you misunderstand what's going on.  IO accesses are always ordered
>>>> with respect to themselves.  The barriers are there to ensure ordering
>>>> between DMA coherent memory (normal non-cached memory) and IO accesses
>>>> (device).
>>>
>>> Unfortunately this is not correct. The ARM spec doesn't guarantee that
>>> all IO accesses should be ordered with respect to themselves. It only
>>> requires that the ordering should be guaranteed at least within a 1KB
>>> region.
>>>
>>> You can find this info in ARMv7 ARM spec[1] named
>>> "DDI0406B_arm_architecture_reference_manual_errata_markup_8_0.pdf", on
>>> page A3-45. There is a para that goes:
>>>
>>> "Accesses must arrive at any particular memory-mapped peripheral or
>>> block of memory in program order, that is, A1 must arrive before A2.
>>> There are no ordering restrictions about when accesses arrive at
>>> different peripherals or blocks of memory, provided that the accesses
>>> follow the general ordering rules given in this section."
>>
>> That is news to me.  My DDI0406B does not have this paragraph, so it's
>> something that ARM has sprung upon us without telling *anyone* about it.
>> It's not unreasonable or even unexpected.  That is exactly the same
>> condition which applies on buses like PCI due to write posting on bridges
>> downstream of the CPU, and issuing memory barriers will not help with
>> that.
>
> While the PCI stuff is true, as you say, it's not related to mb()s. The  
> mb()s matter to the point of getting the writes to the  intended  
> "devices addresses" in the program order. What happens after that is a  
> separate issue.
>
> So, going back to the discussion of mb()s and readl/writel (and  
> variations), I think we should no longer state the all IO accesses are  
> ordered wrt each other. Are we in agreement on this?

No, because you clearly haven't understood the point I made.

I still believe you are wrong on this point.

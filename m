From: t.fujak@samsung.com (Tomasz Fujak)
Date: Thu, 23 Dec 2010 16:35:30 +0100
Subject: [PATCHv8 00/12] Contiguous Memory Allocator
In-Reply-To: <20101223142053.GN3636@n2100.arm.linux.org.uk>
References: <cover.1292443200.git.m.nazarewicz@samsung.com>
	<AANLkTim8_=0+-zM5z4j0gBaw3PF3zgpXQNetEn-CfUGb@mail.gmail.com>
	<20101223100642.GD3636@n2100.arm.linux.org.uk>
	<87k4j0ehdl.fsf@erwin.mina86.com>
	<20101223135120.GL3636@n2100.arm.linux.org.uk>
	<4D1357D5.9000507@samsung.com>
	<20101223142053.GN3636@n2100.arm.linux.org.uk>
Message-ID: <4D136C42.6090601@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2010-12-23 15:20, Russell King - ARM Linux wrote:
> On Thu, Dec 23, 2010 at 03:08:21PM +0100, Tomasz Fujak wrote:
>> On 2010-12-23 14:51, Russell King - ARM Linux wrote:
>>> On Thu, Dec 23, 2010 at 02:41:26PM +0100, Michal Nazarewicz wrote:
>>>> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>>>>> Has anyone addressed my issue with it that this is wide-open for
>>>>> abuse by allocating large chunks of memory, and then remapping
>>>>> them in some way with different attributes, thereby violating the
>>>>> ARM architecture specification?
>>>>>
>>>>> In other words, do we _actually_ have a use for this which doesn't
>>>>> involve doing something like allocating 32MB of memory from it,
>>>>> remapping it so that it's DMA coherent, and then performing DMA
>>>>> on the resulting buffer?
>>>> Huge pages.
>>>>
>>>> Also, don't treat it as coherent memory and just flush/clear/invalidate
>>>> cache before and after each DMA transaction.  I never understood what's
>>>> wrong with that approach.
>>> If you've ever used an ARM system with a VIVT cache, you'll know what's
>>> wrong with this approach.
>>>
>>> ARM systems with VIVT caches have extremely poor task switching
>>> performance because they flush the entire data cache at every task switch
>>> - to the extent that it makes system performance drop dramatically when
>>> they become loaded.
>>>
>>> Doing that for every DMA operation will kill the advantage we've gained
>>> from having VIPT caches and ASIDs stone dead.
>> This statement effectively means: don't map dma-able memory to the CPU
>> unless it's uncached. Have I missed anything?
> I'll give you another solution to the problem - lobby ARM Ltd to have
> this restriction lifted from the architecture specification, which
> will probably result in the speculative prefetching also having to be
> removed.
>
Isn't disabling Speculative Accesses forwarding to the AXI bus the
solution to our woes?
At least on the A8, which happens to be paired with non-IOMMU capable
IPs on our SoCs.
On A9 the bit is gone (or has it moved?), but we have IOMMU here so the
CMA isn't needed.

http://infocenter.arm.com/
Cortex-A8 Technical Reference Manual    Revision: r3p2
3.2.26. c1, Auxiliary Control Register
CP15, c1, c0, bit 4: Enables speculative accesses on AXI

> That would be my preferred solution if I had the power to do so, but
> I have to live with what ARM Ltd (and their partners such as yourselves)
> decide should end up in the architecture specification.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-media" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

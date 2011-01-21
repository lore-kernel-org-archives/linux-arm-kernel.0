From: bdegraaf@codeaurora.org (Brent DeGraaf)
Date: Fri, 21 Jan 2011 08:13:59 -0800 (PST)
Subject: [PATCH] mmc: msm: fix dma usage not to use internal APIs
In-Reply-To: <1295536094.9236.11.camel@m0nster>
References: <1295391805-15251-1-git-send-email-dwalker@codeaurora.org>
	<1295522421.4366.34.camel@m0nster>
	<20110120130246.GA23941@n2100.arm.linux.org.uk>
	<20110120131239.GB23941@n2100.arm.linux.org.uk>
	<1295536094.9236.11.camel@m0nster>
Message-ID: <ff5d6c73aa50329b025bfe69297a92d9.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

This code was not added simply for the dsb inside the dma_map_sg call.

This dma mapping call was introduced to deal with speculative dfetches:
the scatter-gather area can be in normal memory, so we need to do a cache
invalidate (which is taken care of by the mapping function) before reading
data into the area using dma, or it's possible that a speculative dfetch
could pull old data from the cache during the transfer.  (Maybe I should
have beefed up the comment with more detail explaining  the role of the
whole mapping call instead of using just the word "also" to signify that
the non-cacheable box data was also put in-order from this command.)

BTW, I have just looked at the new kernel mapping routines and they still
do the proper thing for speculative cpus, but older cpus without
speculative data fetches will do an unnecessary pre-invalidate.

I'd like to talk about the additional barriers added to writel, however. 
Our approach for such writes is to only add a barrier when ordering was
important because barriering between each individual writel will interfere
with our cpu's write-gathering capabilities, slowing things up a bit. 
Perhaps something could be done that is mach-based for this macro.  Do you
have any suggestions?

Best regards,
Brent DeGraaf

On Thu, January 20, 2011 7:08 am, Daniel Walker wrote:
> On Thu, 2011-01-20 at 13:12 +0000, Russell King - ARM Linux wrote:
>> On Thu, Jan 20, 2011 at 01:02:46PM +0000, Russell King - ARM Linux
>> wrote:
>> > Strongly ordered requires no additional maintainence to ensure that
>> writes
>> > to it are immediately visible to hardware.  However, ARMv6 and later
>> > requires a data synchronization barrier to ensure that writes to
>> 'normal
>> > non-cachable' memory are visible before writes to 'device' memory
>> complete.
>> >
>> > >From what I can see, the driver does use writel() as does the DMA
>> driver
>> > in arch/arm/mach-msm/dma.c, so there should be no problem with ARMv6
>> CPUs.
>>
>> BTW, it looks like the work-around was added at the time when writel()
>> did
>> not have the necessary barriers:
>>
>> commit 56a8b5b8ae81bd766e527a0e5274a087c3c1109d
>> Author: San Mehat <san@google.com>
>> Date:   Sat Nov 21 12:29:46 2009 -0800
>>
>>     mmc: msm_sdcc: Reduce command timeouts and improve reliability.
>>
>> +       n = dma_map_sg(mmc_dev(host->mmc), host->dma.sg,
>> +                       host->dma.num_ents, host->dma.dir);
>> +/* dsb inside dma_map_sg will write nc out to mem as well */
>>     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>     so we are talking about ARMv6 or later as previous versions did not
>>     have dsb.
>
> The changes were created in early Nov. 2009 on a 2.6.29 kernel,
>
>> vs
>>
>> commit e936771a76a7b61ca55a5142a3de835c2e196871
>> Author: Catalin Marinas <catalin.marinas@arm.com>
>> Date:   Wed Jul 28 22:00:54 2010 +0100
>>
>>     ARM: 6271/1: Introduce *_relaxed() I/O accessors
>>
>> commit 79f64dbf68c8a9779a7e9a25e0a9f0217a25b57a
>> Author: Catalin Marinas <catalin.marinas@arm.com>
>> Date:   Wed Jul 28 22:01:55 2010 +0100
>
> well before these two commits.
>
>> So the necessary barriers were found to be necessary way after MSM
>> discovered the problem.  It _is_ related to the ARMv6 weakly ordered
>> memory model, and it _was_ a bug in the ARM IO accessor implementation.
>
> Ok, so unless Brent wants to step in an give more comments on this it
> sounds like the problem has been fix already ..
>
>> It would've been nice to have had the problem discussed at architecture
>> level so maybe the problem could've been found sooner and fixed earlier.
>
> Yes .. At least we're communicating now ..
>
> Daniel
>
>
> --
> Sent by an consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> Forum.
>
>
>


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

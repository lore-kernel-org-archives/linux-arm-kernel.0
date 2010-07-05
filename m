From: per.xx.fransson@stericsson.com (Per Fransson)
Date: Mon, 5 Jul 2010 16:05:56 +0200
Subject: [PATCH v2 0/8] Initial implementation of kdump for ARM
In-Reply-To: <20100705135552.GB19338@n2100.arm.linux.org.uk>
References: <20100611063605.GB11156@esdhcp04058.research.nokia.com>
	<4C2DE024.8060308@stericsson.com>
	<20100705082835.GA32178@gw.healthdatacare.com>
	<4C31AD62.6070805@stericsson.com>
	<20100705101852.GA19338@n2100.arm.linux.org.uk>
	<4C31B527.8060401@stericsson.com>
	<20100705135552.GB19338@n2100.arm.linux.org.uk>
Message-ID: <4C31E6C4.8030200@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2010 03:55 PM, Russell King - ARM Linux wrote:
> On Mon, Jul 05, 2010 at 12:34:15PM +0200, Per Fransson wrote:
>> On 07/05/2010 12:18 PM, Russell King - ARM Linux wrote:
>>> On Mon, Jul 05, 2010 at 12:01:06PM +0200, Per Fransson wrote:
>>>> In machine_kexec an identity mapping is set up for the user space part
>>>> of the virtual address space, through a call to setup_mm_for_reboot(). I
>>>> believe this mapping is only necessary because the MMU is kept on and if
>>>> the kexec is done to facilitate the collection of a dump it would be
>>>> nice if a large part of the page table for the crashing context has not
>>>> been corrupted. Don't you agree?
>>>
>>> No.  The identity mapping is there so that we can safely disable the MMU
>>> and jump to the intended address.
>>>
>>> There is an implementation defined delay between writing the control
>>> register and the point in the instruction stream that the effect of that
>>> write is seen.
>>>
>>
>> But the identity mapping is only set up for user space part.
>
> That's because we're normally calling back into the boot loader.
>

True

>> It needs to
>> be set up around the code which turns off the MMU for the case when
>> there is no delay at all.
>
> There is always a delay as the ARM architecture is pipelined.  By the
> time the instruction which writes to the control register has got to
> the writeback stage, the following instruction has long since been
> fetched from memory, and has probably been decoded and partially
> executed.
>

I'm sure you are right. Although I've actually come across kexec not 
working for this very reason, when running under Qemu. By that I'm not 
saying the kernel should necessarily provide work-arounds for emulator 
inaccuracies.

>> And it would still be nice to not corrupt the page table of the
>> crashing context.
>
> What you're then asking for is the crashing kernel to allocate 16K of
> memory to setup some page tables, and then context switch to that table
> so that the MMU can be turned off.
>
> That's never going to be anywhere near reliable.
>

Well, I had another suggestion in my last mail.

Regards,
Per

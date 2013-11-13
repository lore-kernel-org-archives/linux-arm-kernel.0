From: julien.grall@linaro.org (Julien Grall)
Date: Wed, 13 Nov 2013 12:57:21 +0000
Subject: [Xen-devel] Physical memory start contraints in the Linux kernel
 (Was: Re:	Xen osstest on Calxeda midway progress (Was: Re:
 [xen-unstable test] 21486: tolerable FAIL - PUSHED))
In-Reply-To: <1384270357.10204.52.camel@kazak.uk.xensource.com>
References: <osstest-21486-mainreport@xen.org>			<1384250005.1883.35.camel@kazak.uk.xensource.com>			<alpine.DEB.2.02.1311121212240.26077@kaball.uk.xensource.com>			<201311121437.55826.arnd@arndb.de>
 <52823C9E.2010007@linaro.org>		
 <20131112144128.GL16735@n2100.arm.linux.org.uk>		
 <52824090.8040203@linaro.org>	
 <1384268259.10204.29.camel@kazak.uk.xensource.com>	
 <52824817.7010404@linaro.org>
 <1384270357.10204.52.camel@kazak.uk.xensource.com>
Message-ID: <52837731.7020300@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/12/2013 03:32 PM, Ian Campbell wrote:
> On Tue, 2013-11-12 at 15:24 +0000, Julien Grall wrote:
>>
>> On 11/12/2013 02:57 PM, Ian Campbell wrote:
>>> On Tue, 2013-11-12 at 14:52 +0000, Julien Grall wrote:
>>>>
>>>> On 11/12/2013 02:41 PM, Russell King - ARM Linux wrote:
>>>>> On Tue, Nov 12, 2013 at 02:35:10PM +0000, Julien Grall wrote:
>>>>>> During some debugging on the Arndale and Midway, I found another
>>>>>> constraint with CONFIG_ARM_PATCH_PHYS_VIRT.
>>>>>> I have noticed that all the kernel physical addresses must be lower than
>>>>>> the corresponding virtual addresses. So the delta offset compute in
>>>>>> __fixup_pv_table (arch/arm/kernel/head.S) must always be negative.
>>>>>> If this assertion is not validated, when the kernel will browse the
>>>>>> memory bank (sanity_check_info in arch/arm/mm/mmu.c), __phys(...) will
>>>>>> compute a wrong address and will result to consider all memory bank as
>>>>>> highmem.
>>>>>>
>>>>>> After digging in the code, it seems it's due to some optimization during
>>>>>> opcode fixup in __fixup_a_pvtable. Is it a wanted constraint?
>>>>>
>>>>> Are you talking about the code in v3.12 or the code in -next ?
>>>>
>>>> I was talking about 3.12. I have just checked -next and my issue seems
>>>> to be fixed by the commit f52bb722547f43caeaecbcc62db9f3c3b80ead9b.
>>>> I should have checked earlier, thanks.
>>>
>>> Should we revert your Xen side fix^Wworkaround then:
>>
>> For now it's only in -next. I would wait until this commit is at least
>> in Linux master, otherwise we will likely break vanilla/distro kernel
>> for Xen 4.4.
>
> OK. Can you keep an eye on it and let me know if/when the time comes to
> revert?

No problem.

>
> Is the fix a candidate for stable? Seems like a bit of a big exciting
> fix for what was an quite recently an obscure corner case...

I think yes, as soon as Linux contains this fix we will be able to 
revert the commit in Xen.

-- 
Julien Grall

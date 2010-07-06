From: per.xx.fransson@stericsson.com (Per Fransson)
Date: Tue, 6 Jul 2010 10:30:53 +0200
Subject: [PATCH v2 0/8] Initial implementation of kdump for ARM
In-Reply-To: <20100705181421.GA27771@n2100.arm.linux.org.uk>
References: <20100611063605.GB11156@esdhcp04058.research.nokia.com>
	<4C2DE024.8060308@stericsson.com>
	<20100705082835.GA32178@gw.healthdatacare.com>
	<4C31AD62.6070805@stericsson.com>
	<20100705101852.GA19338@n2100.arm.linux.org.uk>
	<4C31B527.8060401@stericsson.com>
	<20100705135552.GB19338@n2100.arm.linux.org.uk>
	<4C31E6C4.8030200@stericsson.com>
	<20100705141926.GA23860@n2100.arm.linux.org.uk>
	<4C31FC27.4010102@stericsson.com>
	<20100705181421.GA27771@n2100.arm.linux.org.uk>
Message-ID: <4C32E9BD.4090001@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2010 08:14 PM, Russell King - ARM Linux wrote:
> On Mon, Jul 05, 2010 at 05:37:11PM +0200, Per Fransson wrote:
>> On 07/05/2010 04:19 PM, Russell King - ARM Linux wrote:
>>> On Mon, Jul 05, 2010 at 04:05:56PM +0200, Per Fransson wrote:
>>>> Well, I had another suggestion in my last mail.
>>>
>>> Which is going to need per-CPU type support in order to achieve.  Do
>>> we really want to implement relocate_new_kernel for each of the 24
>>> CPU types which we currently support?
>>>
>>
>> Perhaps not. Couldn't the variable delay be macrofied then, i.e. a
>> macro like
>>
>> MMU_DISABLED_DELAY_AND_EXEC(<asm instr>)
>>
>> which would do nothing for an appropriate amount of time and put the
>> instruction in the last MMU mapped slot?
>
> There is no "appropriate amount of time" - some CPUs depend on many
> effects that a "3 nops and you'll be fine" approach doesn't work.
>
> Also, what about kernels that support multiple different CPU types.
>

Ok, I see what you're both saying about there not always being an 
"appropriate amount of time". But surely there must be a minimum number 
of instructions after which we can be sure the MMU will be off? Can't we 
set up the identity mapping for only the entry containing 
relocate_new_kernel() and then add enough NOPs at the start of that 
routine to cover all implementations? That way only one entry in the L1 
table is over-written while keeping the MMU handling code in the 
different arch/arm/mm/proc-<cpu_or_arch>.S?

Also, couldn't the L1 page table entry in question be saved for 
posterity in a variable inside the kernel before the table is modified, 
together with another variable to hold information on the index in the 
table the entry came from.

Regards,
Per

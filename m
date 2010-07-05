From: per.xx.fransson@stericsson.com (Per Fransson)
Date: Mon, 5 Jul 2010 12:01:06 +0200
Subject: [PATCH v2 0/8] Initial implementation of kdump for ARM
In-Reply-To: <20100705082835.GA32178@gw.healthdatacare.com>
References: <20100611063605.GB11156@esdhcp04058.research.nokia.com>
	<4C2DE024.8060308@stericsson.com>
	<20100705082835.GA32178@gw.healthdatacare.com>
Message-ID: <4C31AD62.6070805@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 07/05/2010 10:28 AM, Mika Westerberg wrote:
>>
>> I have a question regarding these patches. It seems to me that the kexec
>> will be done with the MMU left on for the ARMv7 case. Looking at the
>> code in the cpu_arm926_reset() routine in arch/arm/mm/proc-arm926.S this
>> is not the case there. Instead, the MMU is turned off and the last
>> instruction that is fetched using the virtual address mapping is a jump
>> to a physical address.
>
> This seems to be the case for both ARMv6 and ARMv7. I don't know
> why the MMU is not switched off there. Anyway, I've been testing
> this on ARMv7 and at least for panic kernel it works even when MMU
> is left on (didn't check but maybe the decompressor disables that
> before jumping to the kernel).
>

In machine_kexec an identity mapping is set up for the user space part 
of the virtual address space, through a call to setup_mm_for_reboot(). I 
believe this mapping is only necessary because the MMU is kept on and if 
the kexec is done to facilitate the collection of a dump it would be 
nice if a large part of the page table for the crashing context has not 
been corrupted. Don't you agree?

>> Shouldn't this be handled as consistently as possible for the different
>> ARM sub-archs?
>
> Yes, I guess. I'm still wondering why this hasn't been fixed already?

Can't help you there, I'm afraid.

Regards,
Per

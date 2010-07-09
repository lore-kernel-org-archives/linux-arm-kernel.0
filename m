From: per.xx.fransson@stericsson.com (Per Fransson)
Date: Fri, 9 Jul 2010 10:19:08 +0200
Subject: [PATCH v2 0/8] Initial implementation of kdump for ARM
In-Reply-To: <20100709033802.GA2951@verge.net.au>
References: <20100611063605.GB11156@esdhcp04058.research.nokia.com>
	<4C2DE024.8060308@stericsson.com>
	<20100705082835.GA32178@gw.healthdatacare.com>
	<4C31AD62.6070805@stericsson.com>
	<20100705101852.GA19338@n2100.arm.linux.org.uk>
	<4C31B527.8060401@stericsson.com>
	<20100705135552.GB19338@n2100.arm.linux.org.uk>
	<20100709033802.GA2951@verge.net.au>
Message-ID: <4C36DB7C.6030908@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/09/2010 05:38 AM, Simon Horman wrote:
>>> And it would still be nice to not corrupt the page table of the
>>> crashing context.
>>
>> What you're then asking for is the crashing kernel to allocate 16K of
>> memory to setup some page tables, and then context switch to that table
>> so that the MMU can be turned off.
>>
>> That's never going to be anywhere near reliable.
>
> Can this be addresses by allocating the memory at the time that kdump
> is loaded rather than when it is executed (because of a crash)?
>
> IIRC, x86 uses a double page table approach and it is done reliably.
>
>

We could do that.

Admittedly, this is getting very "hacky", but if we want to set up a new 
L1 page table in which we really only need one entry (for the code 
running until we're sure the MMU is off), we could set up this one entry 
all by itself placed at just the right offset within a page and then set 
the PGD to point at the start of that page (since we're talking about 
mappings for 0x00000000-0x40000000). The rest of the page could still be 
used for other stuff - and even if this turns out to be more trouble 
than it's worth, the other 12KB do not need to be allocated.

However, I still think we could work within the old L1 table and:

1) only modify one entry

2) save that entry before overwriting it

Regards,
Per

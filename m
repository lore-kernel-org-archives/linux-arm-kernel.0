From: per.xx.fransson@stericsson.com (Per Fransson)
Date: Mon, 5 Jul 2010 14:04:17 +0200
Subject: [PATCH v2 0/8] Initial implementation of kdump for ARM
In-Reply-To: <20100705113136.GB32178@gw.healthdatacare.com>
References: <20100611063605.GB11156@esdhcp04058.research.nokia.com>
	<4C2DE024.8060308@stericsson.com>
	<20100705082835.GA32178@gw.healthdatacare.com>
	<4C31AD62.6070805@stericsson.com>
	<20100705101852.GA19338@n2100.arm.linux.org.uk>
	<4C31B527.8060401@stericsson.com>
	<20100705113136.GB32178@gw.healthdatacare.com>
Message-ID: <4C31CA41.6050700@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2010 01:31 PM, Mika Westerberg wrote:
> On Mon, Jul 05, 2010 at 12:34:15PM +0200, Per Fransson wrote:
>> But the identity mapping is only set up for user space part. It needs to
>> be set up around the code which turns off the MMU for the case when
>> there is no delay at all. And it would still be nice to not corrupt the
>> page table of the crashing context.
>
> Yeah, with the current version, user-space mappings of the crashing
> process are gone.
>
> If they are really needed, then maybe we could do similar than x86
> and set up temporary page tables and do the identity mapping there?
> This way the crashing process' page tables would remain untouched.
>

We could move the MMU disabling to the relocate_new_kernel() routine. 
Before jumping there the two (if we are unlucky) page table entries (for 
1 MB sections) that this routine occupies could be put into registers 
and an identity mapping be set up for just those entries. Once we reach 
relocate_new_kernel():

1) the MMU is turned off

2) relocate_new_kernel does it's stuff (not much if a crashkernel area 
is used)

3) the entries are restored, once we are sure the disabling has taken effect

Regards,
Per

From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Fri, 3 Jun 2011 13:20:36 +0100 (BST)
Subject: using identity_mapping_add & switching MMU state - how ?
In-Reply-To: <1307038027.28002.12.camel@e102568-lin.cambridge.arm.com>
References: <alpine.DEB.2.00.1106021621400.2311@localhost6.localdomain6>
	<1307038027.28002.12.camel@e102568-lin.cambridge.arm.com>
Message-ID: <alpine.DEB.2.00.1106031159160.2311@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2 Jun 2011, Lorenzo Pieralisi wrote:

[ ... ]
>>  	mrc	p15, 0, r1, c1, c0, 0
>>  	bic	r1, #CR_M
>>  	mcr	p15, 0, r1, c1, c0, 0	@ MMU OFF
>
> I know it is a silly question, but are you sure your pc is pointing
> to a 1:1 physical address here ? This might explain also why if you call
> cpu_do_resume straight off you have to skip the mmu resume code since it
> creates a temporary mapping based on the current program counter. if it
> is a virtual address it goes pop, methinks.

You could be right there - that might actually _be_ the silly thing. After 
all, I'm coming from virtual ...


As said, I can't do the following:

 	mrc	p15, 0, r1, c1, c0, 0
 	bic	r1, #CR_M
 	mcr	p15, 0, r1, c1, c0, 0	@ MMU OFF
 	mrc	p15, 0, r1, c1, c0, 0
 	orr	r1, #CR_M
 	mcr	p15, 0, r1, c1, c0, 0	@ MMU ON

That ends in a hang; but yes the pc when exexuting this is still 
_virtual_.


[ ... ]
> See comment above, cpu_resume_mmu creates a 1:1 mapping based on the
> current PC (it uses adr), it should do no harm unless PC is running
> virtual.


Now just for the fun of it, I've attempted to do (note: on v6 - cpu_reset 
is only a `mov pc, r0` there, no MMU off):

 	identity_mapping_add(pgd_that_is_in_use, __pa(_stext), __pa(_etext));
 	... flush things ...
 	cpu_proc_fin();
 	cpu_reset(__pa(__builtin_return_address(0)));	/* return physical */

just to test whether a transfer to a physical / 1:1 mapped addr works, 
i.e. if the 1:1 mapping is ok. At return, then:

 	ldr	r4, =.Lvirt_label	@ pc-relative load
 	mov	pc, r4			@ back to virtual
.ltorg
.align 5
.Lvirt_label:
 	/* continue as if normal */

to go back to virtual. But that also hangs.


FrankH.

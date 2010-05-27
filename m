From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 27 May 2010 14:00:34 +0200
Subject: Initrd and 2.6.33 curious behaviour
In-Reply-To: <87hblz2alm.fsf@free.fr> (Robert Jarzmik's message of "Sun\,
	23 May 2010 12\:09\:25 +0200")
References: <874oi157c6.fsf@free.fr>
	<20100521204343.GA18032@n2100.arm.linux.org.uk>
	<87fx1k46qg.fsf@free.fr> <20100522094637.GA954@n2100.arm.linux.org.uk>
	<87pr0n31q2.fsf@free.fr> <20100523090139.GA950@n2100.arm.linux.org.uk>
	<87hblz2alm.fsf@free.fr>
Message-ID: <87pr0hy2ot.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


I have made some progress.

I have traced that :
 - after the bootloader has disabled the MMU, disabled the caches, quiesced
 the DMAs and masked the interrupts, and just before the final jump to the
 kernel first instruction :
   => the first u32 at physical address 0xa0508000 is 1f:8b:08:08
   => this is the correct begining of my initrd.gz

In function setup_arch(), just after paging_init(mdesc), I read the value again
with a "rjk = *((unsigned int *)(phys_to_virt(0xa0508000)));", and it has
changed to 10:00:00:a0.

Now, I would need some help to trace this memory location before
paging_init(). My current understanding is that before paging_init(), the MMU is
set by __create_page_tables(). The mapping doesn't cover the initrd area.
If I was to be able to watch this area, I would need to :
 - amend __create_page_tables(), and add a mapping for the 0xa0508000 area (1MB
 is enough)
 - read the value of the u32 at physical address 0xa0508000 from this mapping
 - printk the stored value at the end of setup_arch()

The questions I have are :
 - is this the right approach ?
 - which virtual address space can I use for my mapping

--
Robert

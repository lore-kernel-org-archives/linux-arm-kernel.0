From: rene.wolf@mbda-systems.de (Wolf, Rene, HRO-GP)
Date: Wed, 7 Oct 2009 09:57:22 +0200
Subject: i.MX31 kernel panic and irq
In-Reply-To: <4ACB659E.3000206@billgatliff.com>
References: <87077C4F48609F4392621D9F99DDE20901202E0E@tesla.star.galaxy.io>
	<4ACB659E.3000206@billgatliff.com>
Message-ID: <87077C4F48609F4392621D9F99DDE20901202E10@tesla.star.galaxy.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bill.

Thanks for your fast reply!

> low-level throttling of incoming interrupts 

Hmm, I did test it with the option 'IRQF_DISABLED'. That should disable
IRQs while in the ISR, so all IRQs during the ISR should be ignored.
If they are ignored this should not lead to stack overflows, right?
Or is the stack jumble happening during the time the kernel needs to
disable the IRQs?

I did test the setup with 10kHz and it went haywire, too:
1st test: crash after  700k irqs
2nd test: crash after 4200k irqs
3rd test: crash after  200k irqs

So it seams quite random to me. Also tried with no irq events: system
was running for 20 min. without crash.

About the application: the IRQs will come with a freq. of around 200kHz.
in bursts of several dozens. So I'm not quite sure if that is going
to work, will have to try :-)

Thanks again!

Cheers
Rene


Rene Wolf
LFK-Lenkflugk?rpersysteme GmbH
Human Resources Operations & Policy, HRO
Landshuter Stra?e 26, 85716 Unterschlei?heim, GERMANY
Phone: +49 89 3179 8337
Fax: +49 8252 99 8964
E-Mail: rene.wolf at mbda-systems.de

http://www.mbda.net

Chairman of the Supervisory Board: Antoine Bouvier
Managing Director: Werner Kaltenegger
Registered Office: Schrobenhausen
Commercial Register: Amtsgericht Ingolstadt, HRB 4365

-----Urspr?ngliche Nachricht-----
Von: Bill Gatliff [mailto:bgat at billgatliff.com] 
Gesendet: Dienstag, 6. Oktober 2009 17:43
An: Wolf, Rene, HRO-GP
Cc: linux-arm-kernel at lists.infradead.org
Betreff: Re: i.MX31 kernel panic and irq

Wolf, Rene, HRO-GP wrote:
> Hi @ all :-)
>
> This is about a kernel panic I'm experiencing / causing.
> Setup: The system is a DENX QONG EVB-Light. I consists of an i.MX31
> (ARM11) + some flash and an FPGA doing eth. I use a rootfs over NFS
> and the kernel is loaded from tftp. Version 2.6.31 (pulled from
> DENX, which should be equal to the one from kernel.org)
> So inside my kernel module I do that:
>   

The OOPS messages suggest that the machine has run off into stuff that 
isn't code, which would be consistent with the stack pointer getting 
blown out of the stack memory.

I don't know if the i.mx31 kernel does any low-level throttling of 
incoming interrupts, but if it doesn't then a reason why your hand 
gripping the wire might trigger the OOPS is because you are holding the 
pin at an invalid signal level, thereby causing a burst of interrupt 
events that blow up the stack.  I would ignore the results of this test 
case.

I would expect bursts of 100kHz interrupts to be manageable, but not 
sustainable.  So the failure there might be for the same reasons as 
above.  Do you see problems with 10kHz inputs?

This is all speculation, of course...


b.g.

-- 
Bill Gatliff
bgat at billgatliff.com

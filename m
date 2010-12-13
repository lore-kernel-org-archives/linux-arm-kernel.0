From: tim.sander@hbm.com (Tim Sander)
Date: Mon, 13 Dec 2010 12:20:48 +0100
Subject: Interrupt latencies on i.mx was Re: generic irq handler and stack?
In-Reply-To: <20101208101923.GA8221@n2100.arm.linux.org.uk>
References: <201012071129.26211.tim.sander@hbm.com>
	<201012080954.13998.tim.sander@hbm.com>
	<20101208101923.GA8221@n2100.arm.linux.org.uk>
Message-ID: <201012131220.48475.tim.sander@hbm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi
> > Ok. So e58aa3d2d0cc01ad8d6f7f640a0670433f794922 probably doesn't add any
> > additional delays in this case.
> I fail to see what has that commit ID got to do with whether we run IRQ
> handlers in IRQ mode or SVC mode.
My focus was on interrupt service latencies but i might still be confused 
about the interrupt system...

Nevertheless to answer my question and make people happy searching the 
archives: The answer to my question where to put specific interrupt controller 
code on the arm freescale mxc (i.mx) platform is the entry-macro.S to be  
found under arch/arm/plat-mxc/include/mach. So i also found out that the 
switch CONFIG_MXC_IRQ_PRIOR seems to handle the AVIC in the way it is 
described in the reference manual (At least if r4 is saved on stack after
"get_irqnr_preamble" and restored before "get_irqnr_and_base".). 

Nevertheless if i am enabling MXC_IRQ_PRIOR and set the priorities like this 
in platform init:
    imx_irq_set_priority(34,15); //SDMA Measval
    imx_irq_set_priority(29,14); //TIMER
    imx_irq_set_priority(57,13); //FEC
I get worse IRQ latency times (ca. 90?s vs. ca. 45?s) when MXC_IRQ_PRIOR is 
switched *on* and flood pinging the device. This result seems at least counter
intuitive to me. 

Besides, wouldn't it be usefull to allow priority setting even if       
MXC_IRQ_PRIOR is not set? As far as i understand the code with MXC_IRQ_PRIOR 
the IRQ's are not nested. This means if one interrupt finishes the next one is 
picked, so the priority set with imx_irq_set_priority would determine which 
interrupt is picked next when two interrupts are pending concurrently? 

Best regards
Tim

Hottinger Baldwin Messtechnik GmbH, Im Tiefen See 45, 64293 Darmstadt, Germany | www.hbm.com 

Registered as GmbH (German limited liability corporation) in the commercial register at the local court of Darmstadt, HRB 1147  
Company domiciled in Darmstadt | CEO: Andreas Huellhorst | Chairman of the board: James Charles Webster

Als Gesellschaft mit beschraenkter Haftung eingetragen im Handelsregister des Amtsgerichts Darmstadt unter HRB 1147 
Sitz der Gesellschaft: Darmstadt | Geschaeftsfuehrung: Andreas Huellhorst | Aufsichtsratsvorsitzender: James Charles Webster

The information in this email is confidential. It is intended solely for the addressee. If you are not the intended recipient, please let me know and delete this email.

Die in dieser E-Mail enthaltene Information ist vertraulich und lediglich f?r den Empfaenger bestimmt. Sollten Sie nicht der eigentliche Empfaenger sein, informieren Sie mich bitte kurz und loeschen diese E-Mail.

From: tim.sander@hbm.com (Tim Sander)
Date: Wed, 8 Dec 2010 09:54:13 +0100
Subject: generic irq handler and stack?
In-Reply-To: <20101207150203.GA23589@n2100.arm.linux.org.uk>
References: <201012071129.26211.tim.sander@hbm.com>
	<201012071356.16281.tim.sander@hbm.com>
	<20101207150203.GA23589@n2100.arm.linux.org.uk>
Message-ID: <201012080954.13998.tim.sander@hbm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell
> We don't run interrupts in IRQ mode.  The exception is entered in IRQ
> mode, but we then save what state is necessary and switch to SVC mode.
Ok. So e58aa3d2d0cc01ad8d6f7f640a0670433f794922 probably doesn't add any
additional delays in this case.

> We have supported nested interrupts since the 1.x kernel days - there's
> no code changes needed to support having one interrupt handler interrupt
> another handler - merely re-enabling interrupts in your own handlers
> will allow it to happen if your IRQ controller will also allow it.
Well the AVIC of the i.mx35x is not supporting multiple parallel handlers by 
default, but with some extra steps taken from the reference manual which i 
attached below this should be possible. Most of this stuff would go into the 
generic ack() and end() handlers but i don't know what to to with the NIMASK 
value, which should be pushed onto the stack (step 3 below). Beeing in a 
subroutine ( ack() )  it obviously doesn't make sense to push it on the stack 
there. So my question is: is there a nice way to implement the steps below 
within the generic interrupt handler infrastructure?

Thanks
Tim

PS: The steps:
1. Push the link register (LR_irq) on to the stack (SP_irq) i.MX35 (MCIMX35) 
2. Push the saved status register (SPSR_irq) on to the stack
3. Read the current value of NIMASK and push this value on to the stack
4. Read current priority level via NIVECSR
5. Interrupts of the equal or lesser priority than the current priority level 
should be masked via the NIMASK register by writing value from NIVECSR
6. Clear the I bit in the ARM1136JF-S core via a MSR / MRS command sequence 
(now a higher priority normal interrupt can preempt a lower priority one)
Also change the operating mode of the core to System Mode from IRQ mode
7. Push System Mode link register (LR) on to the stack (SP_user)
8. The traditional interrupt service routine is now included
9. Pop System Mode link register (LR) from the stack (SP_user)
10. Set I bit in the ARM1136JF-S core via a MSR / MRS command sequence (thus 
disabling all normal interrupts)
Also change the operating mode of the core to IRQ Mode from System mode
11. Pop the original value of normal interrupt mask and write to the NIMASK 
register
12. The saved status register should be popped from the stack (SP_irq)
13. The link register should be popped from the stack into the PC
14. Return from nIRQ

Hottinger Baldwin Messtechnik GmbH, Im Tiefen See 45, 64293 Darmstadt, Germany | www.hbm.com 

Registered as GmbH (German limited liability corporation) in the commercial register at the local court of Darmstadt, HRB 1147  
Company domiciled in Darmstadt | CEO: Andreas Huellhorst | Chairman of the board: James Charles Webster

Als Gesellschaft mit beschraenkter Haftung eingetragen im Handelsregister des Amtsgerichts Darmstadt unter HRB 1147 
Sitz der Gesellschaft: Darmstadt | Geschaeftsfuehrung: Andreas Huellhorst | Aufsichtsratsvorsitzender: James Charles Webster

The information in this email is confidential. It is intended solely for the addressee. If you are not the intended recipient, please let me know and delete this email.

Die in dieser E-Mail enthaltene Information ist vertraulich und lediglich f?r den Empfaenger bestimmt. Sollten Sie nicht der eigentliche Empfaenger sein, informieren Sie mich bitte kurz und loeschen diese E-Mail.

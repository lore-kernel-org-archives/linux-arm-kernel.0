From: andy@warmcat.com (Andy Green)
Date: Mon, 30 Aug 2010 16:05:00 +0100
Subject: iMX31 power management
In-Reply-To: <201008301641.41957.thomas.nemeth@betatech.fr>
References: <201008301444.21510.thomas.nemeth@betatech.fr>
	<4C7BB88C.1010202@warmcat.com>
	<201008301641.41957.thomas.nemeth@betatech.fr>
Message-ID: <4C7BC89C.8000506@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/30/10 15:41, Somebody in the thread at some point said:

Hi -

>> I ported this similar stuff from the Freescale tree to 2.6.32 last
>> December, it sleeps and wakes fine (using stop clock) on that txtr
>> board since then.
>
>      I did this piece of code because it wasn't in 2.6.34 mainline :)
>      Should we make something to have it marged ?

Yeah if it works for more than just my board ^^

>> http://git.warmcat.com/cgi-bin/cgit/txtr-kernel/commit/?h=txtr-tracki
>> ng&id=34685e9c378c865885ad6a8f2fc06fc36ad48482
>>
>> There was no enable_irq_wake(); platform support at that time so I
>
>      I wasn't aware of that function. It indeed may be of a great help.
>      I've seen that a lot of drivers use directly set_irq_wake(). Is
>      there a "prefered" way of using this facility ?

No idea, when I looked up that patch I saw I had gone and commented out 
that call at the time too, and remembered getting some unclear OOPS or 
warning telling me that the stuff wasn't implemented.  On the txtr 
device, it wakes fine from PMIC interrupt including RTC and its touchpad 
interrupt without having to meddle anything.

>      I think the set_wake() field in the irq_chip structure from
>      arch/arm/plat-mxc/irq.c should be created, didn't it ?

It may well be by now, that tree is still on 2.6.32.

>> guess maybe there is now and you need to make sure your wake
>> interrupts are marked as wake sources?
>
>      In a more recent version of my pm.c source file, I have :
>         __raw_writel(0, MXC_CCM_WIMR);
>      in mx31_pm_prepare(), in order to enable all interrupts to wake the
>      processor up. But to no use :(
>
>      Thanks a lot.

I recall having to fix something in the Freescale code, it might be 
worth checking through the patch I pointed to because I don't think it's 
just the freescale code any more.  I had a quick look and see if I did 
anything in the mach-*.c file but I didn't see anything relevant.

How're you provoking the suspend?  What worked for me was echo mem > 
/sys/power/state.

BTW we go 30mA from battery with clock stop suspend on iMX31 and 
everything else left up, so that's not so wonderful.  However the resume 
was well under 500ms, so the waking touchpad gesture can be seen and 
processed by the resumed driver in an unbroken fashion.

-Andy

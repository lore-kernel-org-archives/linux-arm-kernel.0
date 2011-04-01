From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 1 Apr 2011 23:00:36 +0200
Subject: [GIT PULL] omap changes for v2.6.39 merge window
In-Reply-To: <alpine.LFD.2.00.1104011441150.28032@xanadu.home>
References: <alpine.LFD.2.00.1103310145390.28032@xanadu.home>
	<201104011659.40443.arnd@arndb.de> <4D95EF8E.9080902@vollmann.ch>
	<201104011750.17344.arnd@arndb.de>
	<alpine.LFD.2.00.1104011441150.28032@xanadu.home>
Message-ID: <20110401210036.GB30938@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Apr 01, 2011 at 03:54:47PM -0400, Nicolas Pitre wrote:
> It would be more useful and scalable to simply sit down, look at the 
> current mess, and identify common patterns that can be easily factored 
> out into some shared library code, and all that would be left in the 
> board or SOC specific files eventually is the data to register with that 
> library code.  Nothing so complicated as grand plans or planification 
> that makes it look like a mountain.
> 
> Two patterns were identified so far, and they are:
> 
> 1) GPIO drivers
> 
>    As Linus observed, in the majority of the cases GPIOs are accessed 
>    through simple memory-mapped registers.  Some have absolute state 
>    registers, the others have separate clear/set registers.  Suffice to 
>    create two generic GPIO drivers each covering those two common cases, 
>    and those generic drivers would simply register with the higher level 
>    gpiolib code, and all the board code would have to do is to provide 
>    the data for those GPIOs (register offsets, number of GPIOs, etc.).  
>    Whether this data eventually comes from DT is an orthogonal issue.
> 
> 2) IRQ chip drivers
> 
>    Again, as Thomas observed, the same issue exists with the majority of 
>    the IRQ chip drivers.  Most of them follow a common simple pattern 
>    that can be abstracted in some generic library code due to their very 
>    similar mode of operation.  Writing a common driver would leave the 
>    board specific code with only a data table describing hardware 
>    registers.
> 
> A good example of such rationalization that already happened is the 
> leds-gpio driver (./drivers/leds/leds-gpio.c), or similarly the 
> gpio-keys driver (drivers/input/keyboard/gpio_keys.c).  I remember when 
> those board files were implementing their own simple drivers hooking 
> directly to the input API or the LED API.
> 
> After that let's take another identified common pattern and factorize it 
> out from board code.  That might be timers (see RMK's recent 
> sched_clock() rationalization).  That might be clocks (patches from 
> Jeremy Kerr exist and need merged). Etc.
Another one is pwm (git ls-files arch/arm | grep pwm). A general
pwm framework was already discussed on lkml and linux-embedded
(http://thread.gmane.org/gmane.linux.ports.mips.general/29037/focus=44475);
I don't know the details though.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

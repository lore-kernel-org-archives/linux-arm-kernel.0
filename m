From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 26 Oct 2015 09:05:37 +0100
Subject: v7-M: Fixing XIP when the kernel is in ROM
In-Reply-To: <20151026012710.GA17365@laptop>
References: <20151026012710.GA17365@laptop>
Message-ID: <20151026080537.GW4931@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sun, Oct 25, 2015 at 10:27:10PM -0300, Ezequiel Garcia wrote:
> I've been trying to make my ARM v7-M LPC43xx board
> boot a XIP kernel from flash. Currently, this seems

I admit I didn't update my efm32 machine for quite some time, but this
can only boot with XIP.

> to be broken in mainline due to this:
> 
> arch/arm/mm/proc-v7m.S
> [..]
>         @ SVC to run the kernel in this mode
>         badr    r1, 1f
>         ldr     r5, [r12, #11 * 4]      @ read the SVC vector entry
>         str     r1, [r12, #11 * 4]      @ write the temporary SVC vector entry
>         mov     r6, lr                  @ save LR
>         mov     r7, sp                  @ save SP
> 	ldr     sp, =__v7m_setup_stack_top @ <<< Breaks XIP!
If you make the tab above 8 spaces the line will align in the git
commit, too.
Hmm, this line is there from the beginning (i.e. 55bdd6941165 ("ARM: Add
base support for ARMv7-M")).

>         cpsie   i
>         svc     #0
> 1:      cpsid   i
>         str     r5, [r12, #11 * 4]      @ restore the original SVC vector entry
>         mov     lr, r6                  @ restore LR
>         mov     sp, r7                  @ restore SP
> 
> Here, a temporary stack is prepared before making a
> supervisor call (SVC) to switch to handler mode.
> 
> The temporary stack is allocated in the .text.init section
> and so this doesn't work when the kernel is executing from ROM.

If sp isn't used, how does it break you setup? Did you try to put a
watchpoint to the location in question?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

From: rene.wolf@mbda-systems.de (Wolf, Rene, HRO-GP)
Date: Tue, 22 Sep 2009 11:00:52 +0200
Subject: SPI, DMA and an i.MX31
In-Reply-To: <4AB839FF.4000803@windriver.com>
References: <87077C4F48609F4392621D9F99DDE20901202DFF@tesla.star.galaxy.io>	<BLU105-W229F8F8F533B107510C600BAE10@phx.gbl>	<87077C4F48609F4392621D9F99DDE20901202E00@tesla.star.galaxy.io>
	<4AB7C020.2070205@gmail.com> <4AB839FF.4000803@windriver.com>
Message-ID: <87077C4F48609F4392621D9F99DDE20901202E02@tesla.star.galaxy.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi @ all!

Wow, there seams to be some interest in this :-)

> My guess is that it's probably best to use the DMA scripts that Freescale
> released in their LTIB/BSP.

So far I did search the LTIB src for reference on sdma. Then I copied
those files to 2.6.31. For files which existed in 2.6.31, I tried to
add the stuff referencing / using the sdma. Mostly that worked smoothly.
But there was heavy reorganization on the sources from LTIB to 2.6.31:
one example would be, in LTIB <asm/arch/hardware.h> =>
<mach/hardware.h>. That was an easy one, changing the #include fixed
the majority of those problems. But there is at least one which just
doesn't match any more: <asm/arch/dma.h>. There is an <asm/dma.h> in
2.6.31 but that is just the definition of the global interface. The
one from LTIB has an i.MX specific interface + some enums. I just did a
work around by adding the following to <asm/dma.h>:
#ifdef  CONFIG_ARCH_MX31
#include <mach/sdma_mx31.h>
#endif/*CONFIG_ARCH_MX31*/
As you prob. guessed the <mach/sdma_mx31.h> is the 'dma.h' from LTIB.

Another thing was the UART 1-5. The sdma was referenced in some INIT
routines. I sort of had the feeling that those would collide with the
interrupt driven UART my bsp uses at the moment, so I just commented
out 'uart+sdam' stuff (just in one src file, as far as I remember).

At the moment I'm just trying to get it to compile. If that works I
should somehow verify that the api is 'still' working (there are)
drivers that could be compiled to thest it, right :?)

> Freescale has released a BSP for i.MX31 based on kernel 2.6.26. Don't
> know how much it differs in the DMA areas but it might be good to
> check it out and use that as well as a base for your work on i.MX31-DMA
> in 2.6.31. (freescale.com/imx31 => Software & Tools => i.MX31PDK =>
> Downloads)

Jep. As far as I can remember I did check it and that was a binary only
release or I just overlooked the interesting stuff... I will have a
second look at it.

> It would be very nice to have i.MX31 DMA support in mainline, that would
> perhaps also make it possible to have ALSA sound support for i.MX31.

Hmm, would that be ok by the GPL and stuff. Coz the actual 'firmware'
is binary only, though it is packed as a 'short' array inside
'sdma_script_code.h' & 'sdma_script_code_pass2.h'?

> Looking forward to testing this!

Me too :-) and I hope that I'm getting there, coz I only got limited
time for that after which I must resort to interrupts...


Thanks for the nice discussion!

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

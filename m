From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 26 Oct 2012 12:24:50 +0200
Subject: [PATCH 3/9] ARM: Kirkwood: Convert dnskw to pinctrl
In-Reply-To: <alpine.DEB.2.00.1210261016190.10589@marmot.wormnet.eu>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
 <1351090434-30499-4-git-send-email-andrew@lunn.ch>
 <alpine.DEB.2.02.1210252352360.22302@gonzo>
 <20121026060151.GE21046@lunn.ch>
 <alpine.DEB.2.00.1210261016190.10589@marmot.wormnet.eu>
Message-ID: <20121026102450.GG21046@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I did look at using the gpio-regulator stuff a while back, and
> decided it wasn't quite the right shape. Although I can't remember
> why, and it might have changed since.

O.K. I will look at it this weekend.
 
> The power-off GPIO registration could happen in dnskw_power_off
> instead, or the attempt at a gpio-poweroff driver could be
> resurrected (I'd forgotten about it until now).

I dusted the code off last weekend, but ran out of time.  I wanted to
make it also support the pxa use-case.

> I could accept dnskw:power:recover is a weirdo configuration option
> that should be set in the bootloader / userland rather than the
> kernel supporting it. Although it would be nice if the kernel
> registered it's purpose. Maybe GPIO pins could be exported by adding
> sub-nodes to the GPIO chip, if that's not too hackish?

We need some sort of solution. It is quite common to use GPIO this
way, to enable power, etc. So either we need some form of gpio
regulator, or the ability to set gpio defaults as you said in the gpio
DT node, or fix the ordering so the init function can set them up.
 
> >First thing that comes to mind, is it registering them for the correct
> >GPIO controller. I think with the new setup, pinctrl and gpio are
> >closely linked, so maybe, its modifying pins on the wrong controller.
> >Bit of a long shot....
> >
> 
> I did wonder that, but then why would turning the LEDs on work fine?
> I wonder if both pins are being toggled or something. I'll
> investigate further and report back. The two that cause the NAS to
> lock up are the only ones on &gpio1 though.

What would they map to on gpio0? NAND? 

> The sata0 and sata1 activity leds are definitely MPP20 and
> MPP21---I've set them up as GPIO leds before successfully.

O.K.

> >[   16.187814] initial MPP regs: 01112222 43303311 55550000 00000000 00000000 00000000 00000000
> >[   16.187833]   final MPP regs: 01552222 03303311 55550000 00000000 00000000 00000000 00000000
> >
> >The first line is how uboot setup the MPP pins. The second is after
> >the init function was called.
> 
> initial MPP regs: 01111111 03303311 00551100 00000000 00000000 00000000 00000000
>   final MPP regs: 01111111 03303311 00551100 00000000 00000000 00000000 00000000
> 
> Although the initial MPP regs is also set by a recompiled u-boot
> with ~identical MPP setup code.

It might be useful to generate the same sort of dumps with the new
driver, even if its code just hacked in for testing.

	Andrew

From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Oct 2012 22:00:21 +0200
Subject: [PATCH 1/9] ARM: Kirkwood: Convert TS219 to pinctrl.
In-Reply-To: <50884659.1020208@gmail.com>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
 <1351090434-30499-2-git-send-email-andrew@lunn.ch>
 <20121024213128.2d4c07dc@skate> <50884659.1020208@gmail.com>
Message-ID: <20121024220021.148a88ff@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian,

On Wed, 24 Oct 2012 21:49:45 +0200, Sebastian Hesselbarth wrote:

> Agree, but for now a global pinhog on pinctrl node itself is the correct
> way to go here. As soon as there is pinctrl support in the specific
> device drivers we can move pinmux phandle there.

I agree.

> Here I disagree. Even quite simple interfaces like uart can have dozens
> of possible mpp configurations, e.g. rx/tx on up to three different pins
> each plus rts/cts on various pins plus all possible combinations.
> 
> Now consider some more complex interface with more than one mpp pin per
> interface pin. Do you really want to predefine all possible combinations
> even if it is more likely that in fact only one is used on all boards
> because they are all based on the same reference design?

Where did I say that you should define *all* possible configurations?

I said: "The SoC .dtsi file should define all the pinmux groups that are
described in the datasheet and are used by boards". Read again the "and
are used by boards".

So I'm clearly not advocating adding *all* possible configurations,
because there would be gazillions of them. But I'm in favor of moving
the *used* configurations to the .dtsi files.

> >   * The board .dts file should define the pinmux groups that are really
> >     board-specific (buttons, LEDs, etc.), and then for each device,
> >     point to the correct pinmux group (either defined in the .dtsi file
> >     or in the board file).
> 
> With respect to mpp the actual configuration _is_ board specific. There
> are maybe only some pins that are always used if a specific interface is
> used, e.g. nand pins on dove can only be switched with gpio.

I am not sure to follow you here. There is clearly some MPP pins whose
muxing groups can be defined in the SoC level file, and some other MPP
pins whose muxing should entirely be done at the board level file.

For a UART, the .dtsi file can define a pinmux configuration for
RX/TX/RTS/CTS, and the .dts file only needs to reference this
configuration.

For LEDs, buttons and similar things, the pinmux configuration should
be defined in the .dts file, and of course the .dts file will reference
this configuration.

I think what Shawn Guo did with i.MX 28 is really neat. In the current
patches posted by Andrew, for example, the following piece:

+			pmx_uart1: pmx-uart1 {
+				marvell,pins = "mpp13", "mpp14";
+				marvell,function = "uart1";
+			};

is needlessly repeated in kirkwood-ts219-6281.dts,
kirkwood-ts219-6282.dts and kirkwood-dnskw.dtsi. This is clearly a
pinmux configuration that sets up TXD/RXD of UART1, and it should be in
kirkwood.dtsi.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

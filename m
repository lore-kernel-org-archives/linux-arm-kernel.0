From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Mar 2010 13:15:40 +0000
Subject: QUERY: How to handle SOC Configuration (Peripheral
	Multiplexing) in linux
In-Reply-To: <4B9DD46E.7060704@st.com>
References: <4B9DB823.1040809@st.com>
	<1b68c6791003142147y200fff12vc805fbd07f1c0ef4@mail.gmail.com>
	<4B9DC239.90407@st.com>
	<1b68c6791003142241q274b573dl3e60bf25be462e68@mail.gmail.com>
	<4B9DD46E.7060704@st.com>
Message-ID: <20100315131540.GD700@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 15, 2010 at 12:02:14PM +0530, Viresh KUMAR wrote:
> Actually, different peripherals share IO Pads (PL_GPIOs) and GPIO lines.
> Sending patch for drivers to support this doesn't look a great idea to me.
> Further this may cause problems to users, for example: User have entered
> a inserted a module and by mistake or lack of knowledge, he disables
> already working IP.

That's a _very_ bad idea - for the reasons Bill and you have pointed out.
Moreover, what's the situation if a needed driver is left out?

If the pins are left floating, then your current consumption increases -
the standard CMOS input configuration is two MOS transistors, and with
their 'gate' (input) floating at half supply, both are partially turned
on, and power flows from positive, through both transistors to ground.

Floating inputs are very bad news for power consumption - you really want
to avoid them at all cost.

That means if you leave the configuration of pins to modular drivers,
pins are left unconfigured, and you could have some of them floating
increasing your power consumption.

Most normal boards dedicate the function of pins at board design time;
they generally don't change at run time.  For the majority of cases, it
makes sense to configure all MUX pins at kernel boot time in the board
support code, which ensures that everything is correctly set for the
entire board in one central, easy to verify place.

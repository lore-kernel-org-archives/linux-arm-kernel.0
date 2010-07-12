From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Jul 2010 09:34:05 +0100
Subject: [PATCH v4] GPIO PL061: Adding Clk framework support
In-Reply-To: <4C3ACFD7.2060709@st.com>
References: <1277183247-4557-1-git-send-email-viresh.kumar@st.com>
	<20100709124050.GF22845@n2100.arm.linux.org.uk>
	<4C3A950F.5040900@st.com>
	<20100712080740.GB22138@n2100.arm.linux.org.uk>
	<4C3ACFD7.2060709@st.com>
Message-ID: <20100712083405.GD22138@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 12, 2010 at 01:48:31PM +0530, Viresh KUMAR wrote:
> On 7/12/2010 1:37 PM, Russell King - ARM Linux wrote:
> > PL061 does not have any other clock signal other than PCLK, the APB (AMBA
> > peripheral bus) clock.  This clock needs to be running to access any
> > register in an APB peripheral.  The primecell drivers and AMBA support
> > is currently implemented with the assumtion that this clock is
> > permanently running.
> > 
> > If you need to enable a clock before using any GPIO pin, and it's not the
> > APB clock, then that's a platform extension that is outside of the PL061
> > domain, and probably also affects alternate functions of the GPIO pins as
> > well.  That means the PL061 code shouldn't manage that clock signal as it
> > won't know what's going on with the alternate functions.
> > 
> 
> Russell,
> 
> I agree that this clock is outside of GPIO's domain, but this is how it
> is done for all other amba and non amba devices too, like pl011, pl022,
> etc. There also we are handling platform specific clocks in drivers only.

No.

1. All primecells take a clock called PCLK, which is the bus clock which
   times accesses to the registers from the CPU.

2. PL011 takes a clock, called UARTCLK.  PL022 takes a clock, called SSPCLK.
   PL061 does not take such a clock.

If you look that up in the ARM documentation (DDI0183, DDI0194 and DDI0190
respectively), you'll find these signal listed in the relevant appendix -
A.1 for the bus signals and A.2 for the internal on-chip peripheral signals.

The existing clk API usage in primecell drivers covers (2).  It does not
cover (1).  As such, and as PL011 and PL022 do have non-APB clock signals,
they have clk API support.  As PL061 doesn't have non-APB clock signals,
it doesn't have clk API support and shouldn't need it.

If your device is setup such that there is a 'GPIO clock' control, it is
either relating to a control for the APB bus clock, or it is something on
the pad side of the PL061 block, or is just a dummy control bit to keep
programmers happy which does nothing.

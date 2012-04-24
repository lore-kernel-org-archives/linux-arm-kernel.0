From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Apr 2012 09:26:52 +0100
Subject: [PATCH V2 4/9] ata/sata_mv: Remove conditional compilation of
 clk code
In-Reply-To: <4F965D1C.2010203@st.com>
References: <20120424070426.GA24089@lunn.ch> <4F9650B3.9030406@st.com>
 <20120424072653.GB24089@lunn.ch>
 <20120424074202.GO24211@n2100.arm.linux.org.uk> <4F965D1C.2010203@st.com>
Message-ID: <20120424082652.GQ24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2012 at 01:28:20PM +0530, Viresh Kumar wrote:
> On 4/24/2012 1:12 PM, Russell King - ARM Linux wrote:
> > If you don't have the clk API configured, you have no clocks to control.
> > So, why not make clk_get() return NULL, and make the rest of the API
> > calls do nothing?  That's what you'll end up codifying in the drivers
> > anyway.
> 
> Ok. We can return NULL from calls that return clk *. What about other
> routines that return integers. Like, clk_enable().
> 
> Is returning 0 correct? Which would mean we were able to enable clk, but
> actually we haven't.

Think about this case: if you don't have the means to control the clock
inputs to a device (for example, you don't support the clk API on your
CPU arch) then for the device to be functional, it must be supplied with
all its necessary clocks.  Therefore, the clock is already enabled.  It
makes sense for the clk API to stub-out to be completely transparent and
non-error inducing to the driver.

The problem comes with clk_get_rate().  I'd suggest merely returning zero
for that in this case.  If the clock rate is really required by a driver,
then the clk API would need to be enabled.

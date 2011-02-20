From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 20 Feb 2011 13:07:37 +0000
Subject: [RFC,PATCH 1/3] Add a common struct clk
In-Reply-To: <201102151733.30332.jeremy.kerr@canonical.com>
References: <1297233693.242364.862698430999.1.gpush@pororo>
	<201102151526.54280.jeremy.kerr@canonical.com>
	<20110215083759.GA4152@n2100.arm.linux.org.uk>
	<201102151733.30332.jeremy.kerr@canonical.com>
Message-ID: <20110220130737.GE14495@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 15, 2011 at 05:33:29PM +0800, Jeremy Kerr wrote:
> Hi Russell,
> 
> > > Why is that? Consider two devices using one clock; one does some
> > > initialisation based on the return value of clk_get_rate(), the other
> > > calls clk_set_rate() some time later. Now the first device is
> > > incorrectly initialised.
> > 
> > What about a clock sourced from a PLL which provides the dotclock for a
> > framebuffer device?  On every mode set, should the clk have to be disabled,
> > unprepared, rate set, re-prepared and re-enabled?
> 
> Sounds heavy-handed, but I honestly have no idea if that's reasonable or not.
> 
> Other options are:
> 
>  * Require that the driver has called clk_prepare, and that prepare_count
>    is 1 during the set_rate call (indicating that this is the only user); or
> 
>  * Leave the set_rate and set_parent semantics as-is and assume that anything
>    calling either knows what it's doing (and that it won't affect other
>    devices)
> 
> Are you OK if we address this separately to the API unification though?

Absolutely.  I think there's enough issues already without adding new
changes on top.  The unification step should do just that - unify.  It
should not introduce new restrictions that are not absolutely necessary
for the unification step.

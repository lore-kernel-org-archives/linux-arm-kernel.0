From: linuxzsc@gmail.com (Richard Zhao)
Date: Tue, 15 Feb 2011 22:13:04 +0800
Subject: [RFC,PATCH 1/3] Add a common struct clk
In-Reply-To: <201102151733.30332.jeremy.kerr@canonical.com>
References: <1297233693.242364.862698430999.1.gpush@pororo>
	<201102151526.54280.jeremy.kerr@canonical.com>
	<20110215083759.GA4152@n2100.arm.linux.org.uk>
	<201102151733.30332.jeremy.kerr@canonical.com>
Message-ID: <20110215141304.GA1968@richard-laptop>
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
I vote the second option. Two reasons:
1. Has any mach specific clock restricted clk_set_rate use? I don't hear any.
2. In my opinion, clk_set_rate is not called very often by drivers, especially
for the clock which has child clocks. Leaf clock are seldom shared. Even if it's
shared, we can let drivers handle it case by case .

Thanks
Richard
> 
> Are you OK if we address this separately to the API unification though?
> 
> Cheers,
> 
> 
> Jeremy
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

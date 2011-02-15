From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Feb 2011 08:37:59 +0000
Subject: [RFC,PATCH 1/3] Add a common struct clk
In-Reply-To: <201102151526.54280.jeremy.kerr@canonical.com>
References: <1297233693.242364.862698430999.1.gpush@pororo>
	<201102151041.40655.jeremy.kerr@canonical.com>
	<4D5A100F.9000809@codeaurora.org>
	<201102151526.54280.jeremy.kerr@canonical.com>
Message-ID: <20110215083759.GA4152@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 15, 2011 at 03:26:53PM +0800, Jeremy Kerr wrote:
> Hi Saravana,
> 
> > Sure, one could argue that in some archs for a certain set of clocks the
> > slow stuff in prepare/unprepare won't need to be done during set rate --
> > say, a simple clock that always runs off the same PLL but just has a
> > integer divider to change the rate.
> > 
> > In those cases, not grabbing the prepare_lock would make the code less
> > "locky".
> > 
> > > We
> > > may even want to disallow set_rate (and set_parent) when prepare_count is
> > > non- zero.
> > 
> > This is definitely not right.
> 
> Why is that? Consider two devices using one clock; one does some 
> initialisation based on the return value of clk_get_rate(), the other calls 
> clk_set_rate() some time later. Now the first device is incorrectly 
> initialised.

What about a clock sourced from a PLL which provides the dotclock for a
framebuffer device?  On every mode set, should the clk have to be disabled,
unprepared, rate set, re-prepared and re-enabled?

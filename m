From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Mar 2013 23:07:05 +0000
Subject: [PATCH 1/2] ARM: kirkwood: fix a not initialized variable in
 the sound subsystem
In-Reply-To: <20130327083157.794cfa05@armhf>
References: <20130326190513.1671a3be@armhf> <5151F9F4.2040005@gmail.com>
 <20130326210512.6c9c8990@armhf> <5152078C.5080401@gmail.com>
 <20130327083157.794cfa05@armhf>
Message-ID: <20130327230705.GS4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 08:31:57AM +0100, Jean-Francois Moine wrote:
> On Tue, 26 Mar 2013 21:39:40 +0100
> Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:
> > I suggest (again) to remove clks_ctrl and move the writel inside
> > if and else-if branch to cure the compiler warning.
> > 
> > Sebastian
> 
> That's what there was in the original patch from Rabeeh, but maybe it
> is the opportunity to use WARN_ON. Russell?

Sebastian is correct in that such a path should _never_ be reached
because ALSA will reject anything but 44.1, 48 or 96kHz rates if we
don't have an extclk.

However, I disagree with Sebastian's solution - doing that is likely to
generate more code because gcc tends not to optimise:

	if (foo) {
		writel(some_value, register);
	} else {
		writel(some_other_value, register);
	}

very well.  It will generate two separate writel()s when in fact, it
could just do:

	if (foo) {
		val = some_value;
	} else {
		val = some_other_value;
	}
	writel(val, register);

One solution to this would be to just get rid of "if (!IS_ERR(priv->extclk))"
entirely, so that the "else" clause always assumes that if we hit that,
there will be an external clock.  If it does, the clk API gets to deal
with being passed an error pointer for a clock, and we switch to extclk
mode.  Either that'll cause a nice backtrace from the kernel (which is
good in this case) or audio will just not work.

Remember, though - if there isn't an extclk set, then we should never
get there in the first place.  If it makes people feel happier, also put
a WARN_ON(IS_ERR(priv->extclk)) there to guarantee a backtrace if it
happens.

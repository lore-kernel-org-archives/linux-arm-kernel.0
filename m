From: broonie@kernel.org (Mark Brown)
Date: Wed, 8 Apr 2015 13:35:06 +0100
Subject: [PATCH] sunxi: a10-lime: add regulator nodes
In-Reply-To: <20150407101757.GC15823@lukather>
References: <551537ED.7060402@gmail.com> <551538AB.50207@redhat.com>
 <55169622.5070007@gmail.com> <20150330222311.GY23664@lukather>
 <CABxcv=nCROiQ2COrTmnwvhtSJzh83BWKaxgn0EkFuwW8HqSiQw@mail.gmail.com>
 <20150404123302.GY6023@sirena.org.uk>
 <20150404125645.GK14618@lukather>
 <20150404184716.GZ6023@sirena.org.uk>
 <20150407101757.GC15823@lukather>
Message-ID: <20150408123506.GY6023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 07, 2015 at 12:17:57PM +0200, Maxime Ripard wrote:
> On Sat, Apr 04, 2015 at 07:47:16PM +0100, Mark Brown wrote:

> > Or the regulator is used by some passive component on the board that
> > doesn't appear in DT (or some driver that doesn't yet have DT support
> > doesn't claim the regulator) and it gets switched off.  Or we power it
> > off and then later discover that we've been placing physical stress on
> > the system.

> Isn't that what the regulator-always-on property is here for?

Only if it's actually added by someone after having looked at the
system...

> > Providing .dtsis for reference designs can make sense, if there's a
> > widely cloned board with lots of common design elements then reusing
> > that .dtsi is fine but clearly that .dtsi isn't going to enable the full
> > flexibility of the regulators since there will be constraints from that
> > reference design.

> That PMIC is used with various SoCs, so that's not really an
> option. And especially when it comes to regulators, I don't think
> there's really a pattern that emerged yet...

I'm not sure you saw the "reference design" part of the above?

> > Nothing else is safe.  Remember, if we get this wrong we risk system
> > instability and at worst physical damage to the system either in rare
> > cases immediately due to getting something badly wrong or more likely
> > from long term electrical stresses.  If what you were proposing were
> > safe then we should still not be enumerating everything in device trees,
> > we should just be enabling all operations for every regulator in the
> > system by default.  The fact that you have to override this should be a
> > warning sign that you shouldn't be doing it.

> Well, we're doing low level stuff and (from experience) things like a
> poor muxing option can cause physical damage too, and we don't have
> any kind of protection or policy against that.

Does the pinmux code actively go in and do things without being
explicitly configured?

> So, what do you suggest for the kernel to have a behaviour independant
> of what the bootloader state was, without adding a lot of churn in
> each and every DTS?

Well, I'm fairly happy with the current state.  I think having some sort
of board level property saying that undescribed regulators can be
enabled and disabled (which I think is all that this is really doing)
might be a viable solution?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150408/37e07606/attachment.sig>

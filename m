From: broonie@kernel.org (Mark Brown)
Date: Sat, 4 Apr 2015 19:47:16 +0100
Subject: [PATCH] sunxi: a10-lime: add regulator nodes
In-Reply-To: <20150404125645.GK14618@lukather>
References: <551537ED.7060402@gmail.com> <551538AB.50207@redhat.com>
 <55169622.5070007@gmail.com> <20150330222311.GY23664@lukather>
 <CABxcv=nCROiQ2COrTmnwvhtSJzh83BWKaxgn0EkFuwW8HqSiQw@mail.gmail.com>
 <20150404123302.GY6023@sirena.org.uk>
 <20150404125645.GK14618@lukather>
Message-ID: <20150404184716.GZ6023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 04, 2015 at 02:56:45PM +0200, Maxime Ripard wrote:
> On Sat, Apr 04, 2015 at 01:33:02PM +0100, Mark Brown wrote:

> > This is broken - think about what this means.  If you are defining a
> > voltage (or any other constraint) you're saying that it's safe to use on
> > a given board. If you provide a voltage constraint saying that the
> > maximum allowable range for a voltage regulator is safe.  That's
> > unlikely to be true on any given board, usually only a limited set of
> > regulators can vary voltages at runtime safely at all and then rarely
> > over their full supported range.  Similarly for other constraints, for
> > example allowing a regulator to be disabled when there are driverless
> > things (or drivers without regulator support or mappings for that board)
> > relying on it is going to break.

> If this model is broken, then I don't see how the full regulator
> support is not broken.

> Our PMIC DTSI sets up the regulators with the ranges supported by the
> PMIC. We have two cases then:
>   - Either the regulator is not used on the board, and it will be
>     disabled by the framework.

Or the regulator is used by some passive component on the board that
doesn't appear in DT (or some driver that doesn't yet have DT support
doesn't claim the regulator) and it gets switched off.  Or we power it
off and then later discover that we've been placing physical stress on
the system.

>   - Or the regulator is actually used on the board, it will be defined
>     in the DTS, possibly with additional constraints.

Especially for voltage range constraints you're assuming that every
system integrator will get everything right from their initial attempt
to power up Linux onwards and will anticipate future enhancements to the
drivers which try to vary voltages.  For any given design you can pretty
much guarantee that the electrical engineers would not approve of
software making use of the maximum allowable voltage variation but that
is what you're proposing to enable.  That is clearly not a sensible or
reasonable default, the best we can do is just not vary the voltage and
let the system integrator say if it's safe to do so.

Just listing the regulators is less likely to be an issue, it's more
just not particularly useful than anything else, though it can
potentially cause long term stresses too.

Providing .dtsis for reference designs can make sense, if there's a
widely cloned board with lots of common design elements then reusing
that .dtsi is fine but clearly that .dtsi isn't going to enable the full
flexibility of the regulators since there will be constraints from that
reference design.

> I really don't see how your above comments apply to that
> situation. What I do see though, is that if we drop the DTSI, all our
> boards will have to define all the PMIC regulators, even if they're
> not used at all on the board, just to have the right behaviour. And
> that's clearly a no-go for me.

Nothing else is safe.  Remember, if we get this wrong we risk system
instability and at worst physical damage to the system either in rare
cases immediately due to getting something badly wrong or more likely
from long term electrical stresses.  If what you were proposing were
safe then we should still not be enumerating everything in device trees,
we should just be enabling all operations for every regulator in the
system by default.  The fact that you have to override this should be a
warning sign that you shouldn't be doing it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150404/a5fdb964/attachment.sig>

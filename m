From: marvin24@gmx.de (Marc Dietrich)
Date: Sun, 24 Jun 2012 15:27:42 +0200
Subject: [PATCH 3/3] ARM: dt: tegra: paz00: add regulators
In-Reply-To: <20120624123151.GZ4037@opensource.wolfsonmicro.com>
References: <1340406842-27135-1-git-send-email-swarren@wwwdotorg.org>
 <4127323.noaajNecru@ax5200p>
 <20120624123151.GZ4037@opensource.wolfsonmicro.com>
Message-ID: <27366523.LjLfRK1TqH@ax5200p>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 24 June 2012 13:31:51 Mark Brown wrote:
> On Sun, Jun 24, 2012 at 02:01:58PM +0200, Marc Dietrich wrote:
> > On Sunday 24 June 2012 12:03:06 Mark Brown wrote:
> > > > > +                                 	regulator-name = "+3.3vs_ldo0";
> > > > > +					regulator-max-microvolt = <3300000>;
> > > 
> > > This is one example, it looks like the rail needs to be fixed to 3.3V.
> > 
> > I think nowhere in the code a regulator (beside sm*) is programmed to some
> > different value that the maximum given here (this is not the maximum the
> > regulator can provide). I never understood why the kernel code always sets
> > the regulator to the maximum value if no other value was specified. IMHO,
> > there should be some initial value, e.g. regulator-default-microvolt, as
> > the original driver (from 2.6.32 ages) did. This way the maximum value
> > can be set
> That's *never* been in mainline, and nobody even bothered trying to
> submit it.

which was the best thing to do ;-)

> > to the hw limits, but maybe this is a bit dangerous.
> 
> One of two things should be happening.  Either a single voltage is
> specified (in which case that voltage will be configured in the

I'm not an expert on this, but it seems to me that only sm0 and sm1 should be 
changeable (and some rail called vdd_aon, which seems to be ldo2 in case of 
paz00 connected to the rtc). So, all others can be constant voltage. Maybe 
Stephen can comment on the actual requirements (also for the other boards 
which may have similar layout).

Marc

> hardware and consumer drivers can't change anything) or a voltage range
> is specified (in which case the consumers are expected to manage the
> voltage and the most the API should do is bring the voltage within the
> limits given, though I don't think that's actually implemented yet).
> Specifying an initial value within the range should at best be redundant
> as the drivers that are actively managing their voltages will be
> overriding it anyway.
> 
> We certainly shouldn't be specifying the limits of the regulator itself
> as normally the board design will be much more constrained than the
> regulator itself and like I said it's stupid to have to cut'n'paste the
> numbers out of the driver into the machine constraints.  We should
> instead be specifying the constraints the system is designed to operate
> in.  Chances are that if nothing is able to actively manage the voltage
> it's not in fact safe to change the voltage at all and therefore the
> constraints should specify only one voltage.
> 
> In the above case the fact that the supply is named "+3.3vs_ldo0" seems
> like a fairly clear sign that the board has been designed for this to
> operate at 3.3V which makes the fact that the constraints go down to
> 1.25V seem at best odd.

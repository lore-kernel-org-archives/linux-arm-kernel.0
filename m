From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 24 Jun 2012 13:31:51 +0100
Subject: [PATCH 3/3] ARM: dt: tegra: paz00: add regulators
In-Reply-To: <4127323.noaajNecru@ax5200p>
References: <1340406842-27135-1-git-send-email-swarren@wwwdotorg.org>
 <1963397.cqAXgGafFs@ax5200p> <20120624110306.GA16455@sirena.org.uk>
 <4127323.noaajNecru@ax5200p>
Message-ID: <20120624123151.GZ4037@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 24, 2012 at 02:01:58PM +0200, Marc Dietrich wrote:
> On Sunday 24 June 2012 12:03:06 Mark Brown wrote:

> > > > +                                 	regulator-name = "+3.3vs_ldo0";
> > > > +					regulator-max-microvolt = <3300000>;

> > This is one example, it looks like the rail needs to be fixed to 3.3V.

> I think nowhere in the code a regulator (beside sm*) is programmed to some 
> different value that the maximum given here (this is not the maximum the 
> regulator can provide). I never understood why the kernel code always sets the 
> regulator to the maximum value if no other value was specified. IMHO, there 
> should be some initial value, e.g. regulator-default-microvolt, as the 
> original driver (from 2.6.32 ages) did. This way the maximum value can be set 

That's *never* been in mainline, and nobody even bothered trying to
submit it.

> to the hw limits, but maybe this is a bit dangerous.

One of two things should be happening.  Either a single voltage is
specified (in which case that voltage will be configured in the
hardware and consumer drivers can't change anything) or a voltage range
is specified (in which case the consumers are expected to manage the
voltage and the most the API should do is bring the voltage within the
limits given, though I don't think that's actually implemented yet).
Specifying an initial value within the range should at best be redundant
as the drivers that are actively managing their voltages will be
overriding it anyway.

We certainly shouldn't be specifying the limits of the regulator itself
as normally the board design will be much more constrained than the
regulator itself and like I said it's stupid to have to cut'n'paste the
numbers out of the driver into the machine constraints.  We should
instead be specifying the constraints the system is designed to operate
in.  Chances are that if nothing is able to actively manage the voltage
it's not in fact safe to change the voltage at all and therefore the
constraints should specify only one voltage.

In the above case the fact that the supply is named "+3.3vs_ldo0" seems
like a fairly clear sign that the board has been designed for this to
operate at 3.3V which makes the fact that the constraints go down to
1.25V seem at best odd.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120624/c1d854e4/attachment.sig>

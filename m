From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 30 Jul 2012 19:53:45 +0100
Subject: [PATCH 3/3] cpufreq: Add a generic cpufreq-cpu0 driver
In-Reply-To: <20120730065218.GB31509@S2101-09.ap.freescale.net>
References: <1342713281-31114-1-git-send-email-shawn.guo@linaro.org>
 <1342713281-31114-4-git-send-email-shawn.guo@linaro.org>
 <20120726131121.GB7306@sirena.org.uk>
 <20120730065218.GB31509@S2101-09.ap.freescale.net>
Message-ID: <20120730185344.GT4468@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 02:52:20PM +0800, Shawn Guo wrote:
> On Thu, Jul 26, 2012 at 02:11:21PM +0100, Mark Brown wrote:

> > This should make it clear that the transition latency being documented
> > here is just that for the core clock change itself, there may be other
> > sources of latency like the regulator ramp time or reprogramming PLLs.

> I intended to make it be the total latency from whatever sources that
> should be counted on particular system.  Rather than adding complexity
> for the driver to figure out these latencies from every single source,
> I would expect that people know the possible maximum latency in total
> for their systems and specify it in device tree.

Quite honestly this seems totally unrealistic for the majority of users,
especially given the very poor documentation for this stuff which SoC
vendors typically provide.  It's a reasonable amount of work to go back
and figure this stuff out (especially given that it should be varying
depending on the transition in question), and it's going to give us a
bunch of magic numbers in people's bindings.

> > > +	if (cpu_reg && freqs.new > freqs.old) {
> > > +		if (regulator_set_voltage(cpu_reg, volt - tol, volt + tol)) {

> > This is a totally sane and sensible use case for specifying a voltage
> > range, we should move it into the regulator core for other users so you
> > can just specify the voltage and the tolerance directly.

> Are you asking for a change on regulator_set_voltage API?  While I agree
> with your comment, it's not a thing we need to necessarily do in this
> series.  The change on the API requires a touch on all the existing
> users.  I do not think it's nice to carry such a patch in this series.

No, add a new API.

> > It is a little sad here as it means that we loose the ability to do
> > frequency only scaling if there's no regulator which is nice.

> I do not understand it.  The regulator is optional for the driver, and
> we can still scale frequency even if there is no regulator.

As soon as a regulator is available your code will insist that we're
able to set the voltage specified to set the frequency, and since it's
using tolerances not ranges to whatever the chip maximum is that'll mean
it'll stop doing frequency scaling at all.

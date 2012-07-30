From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 30 Jul 2012 14:52:20 +0800
Subject: [PATCH 3/3] cpufreq: Add a generic cpufreq-cpu0 driver
In-Reply-To: <20120726131121.GB7306@sirena.org.uk>
References: <1342713281-31114-1-git-send-email-shawn.guo@linaro.org>
 <1342713281-31114-4-git-send-email-shawn.guo@linaro.org>
 <20120726131121.GB7306@sirena.org.uk>
Message-ID: <20120730065218.GB31509@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 02:11:21PM +0100, Mark Brown wrote:
> On Thu, Jul 19, 2012 at 11:54:41PM +0800, Shawn Guo wrote:
> 
> > +Optional properties:
> > +- transition-latency: Specify the possible maximum transition latency,
> > +  in unit of nanoseconds.
> 
> This should make it clear that the transition latency being documented
> here is just that for the core clock change itself, there may be other
> sources of latency like the regulator ramp time or reprogramming PLLs.
> 
I intended to make it be the total latency from whatever sources that
should be counted on particular system.  Rather than adding complexity
for the driver to figure out these latencies from every single source,
I would expect that people know the possible maximum latency in total
for their systems and specify it in device tree.

> > +	if (cpu_reg) {
> > +		opp = opp_find_freq_ceil(cpu_dev, &freq_Hz);
> > +		if (IS_ERR(opp)) {
> > +			pr_err("failed to find OPP for %ld\n", freq_Hz);
> > +			return PTR_ERR(opp);
> > +		}
> > +		volt = opp_get_voltage(opp);
> > +		tol = volt * voltage_tolerance / 100;
> > +		volt_old = regulator_get_voltage(cpu_reg);
> 
> regulator_get_voltage() might be a bit expensive, many regulators will
> query the hardware every time.  Since it's just for diagnostic purposes
> it'd be better to not bother and let people read the historical
> information from the logs.
> 
Ok, makes sense to me.

> > +	/* scaling up?  scale voltage before frequency */
> > +	if (cpu_reg && freqs.new > freqs.old) {
> > +		if (regulator_set_voltage(cpu_reg, volt - tol, volt + tol)) {
> 
> This is a totally sane and sensible use case for specifying a voltage
> range, we should move it into the regulator core for other users so you
> can just specify the voltage and the tolerance directly.
> 
Are you asking for a change on regulator_set_voltage API?  While I agree
with your comment, it's not a thing we need to necessarily do in this
series.  The change on the API requires a touch on all the existing
users.  I do not think it's nice to carry such a patch in this series.

> It is a little sad here as it means that we loose the ability to do
> frequency only scaling if there's no regulator which is nice.

I do not understand it.  The regulator is optional for the driver, and
we can still scale frequency even if there is no regulator.

-- 
Regards,
Shawn

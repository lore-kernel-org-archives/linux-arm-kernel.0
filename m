From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 21 Dec 2011 10:51:23 +0800
Subject: [PATCH V3 4/7] cpufreq: add generic cpufreq driver
In-Reply-To: <20111221023336.GE13529@sirena.org.uk>
References: <1324264903-15395-1-git-send-email-richard.zhao@linaro.org>
 <1324264903-15395-5-git-send-email-richard.zhao@linaro.org>
 <20111220145904.GD29727@sirena.org.uk>
 <20111220232701.GA1698@richard-laptop>
 <20111220234844.GC6551@opensource.wolfsonmicro.com>
 <20111221012046.GE15863@b20223-02.ap.freescale.net>
 <20111221013220.GA15398@opensource.wolfsonmicro.com>
 <20111221022452.GF15863@b20223-02.ap.freescale.net>
 <20111221023336.GE13529@sirena.org.uk>
Message-ID: <20111221025123.GG15863@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 21, 2011 at 02:33:36AM +0000, Mark Brown wrote:
> On Wed, Dec 21, 2011 at 10:24:53AM +0800, Richard Zhao wrote:
> > On Wed, Dec 21, 2011 at 01:32:21AM +0000, Mark Brown wrote:
> 
> > > That's not the point - the point is that you may do something like
> > > specify a defined set of frequencies and just drop the minimum supported
> > > voltage without altering the maximum supported voltage as the frequency
> > > gets lower.
> 
> > What do you mean by "drop"?
> 
> Drop is a synonym for lower in this context.
> 
> > cpu-volts = <
> > 	/* min  max */
> > 	1100000 1200000 /* 1G HZ */
> > 	1000000 1200000 /* 800M HZ */
> > 	900000  1200000 /* 600M HZ */
> > 	>;
> > The above sample dts could meet your point?
> 
> Yes.
> 
> > > While this is important the driver should also be enumerating the
> > > supported voltages at probe time and eliminating unsupportable settings
> > > so that governors aren't constantly trying to set things that can never
> > > be supported.  The s3c64xx cpufreq driver provides an implementation of
> > > this.
> 
> > I'll use regulator_is_supported_voltage pre-check the cpu-volts.
> > For clock, conditions ((clk_round_rate(cpu-freq)/1000) * 1000 == cpu-freq)
> > seems too strict. Because cpu clock is SoC dependent, I'll not add the check.
> 
> The issue that was there for is that there are multiple runtime
> detectable variant clocking configurations which couldn't be switched
> between so the driver needs to select only the rates that can be reached
> from the current configuration.  I'd imagine that might be an issue
> elsewhere.
one case is that, cpu freq is 800M, clock may only reach 799M. I'd rather let
clock code to decide how to handle 800M request. That's why I said
the condition check is too strict.

Thanks
Richard
> 

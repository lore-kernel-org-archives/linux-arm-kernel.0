From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 31 Jul 2012 14:40:26 +0100
Subject: [PATCH 3/3] cpufreq: Add a generic cpufreq-cpu0 driver
In-Reply-To: <20120731042050.GF762@S2101-09.ap.freescale.net>
References: <1342713281-31114-1-git-send-email-shawn.guo@linaro.org>
 <1342713281-31114-4-git-send-email-shawn.guo@linaro.org>
 <20120726131121.GB7306@sirena.org.uk>
 <20120730065218.GB31509@S2101-09.ap.freescale.net>
 <20120730185344.GT4468@opensource.wolfsonmicro.com>
 <20120731042050.GF762@S2101-09.ap.freescale.net>
Message-ID: <20120731134026.GI4468@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2012 at 12:20:52PM +0800, Shawn Guo wrote:
> On Mon, Jul 30, 2012 at 07:53:45PM +0100, Mark Brown wrote:

> > Quite honestly this seems totally unrealistic for the majority of users,

> I doubt that.  Searching drivers/cpufreq folder, I can see there are
> several cpufreq drivers scaling voltage with regulator API, but none
> of them is calling regulator_set_voltage_time to find voltage latency.
> That said, all these users are specify transition latency on their own.

This is more a sign of poor quality of implementation than anything
else, and obviously the fact that DT is supposed to be an ABI makes it
much more important to get things right.

There's also a bunch of problems in ondemand, it really doesn't cope
terribly well if you actually tell it what the latencies are for most
systems as it becomes absurdly conservative about not ramping.

> > especially given the very poor documentation for this stuff which SoC
> > vendors typically provide.  It's a reasonable amount of work to go back
> > and figure this stuff out (especially given that it should be varying
> > depending on the transition in question), and it's going to give us a
> > bunch of magic numbers in people's bindings.

> There will be only one magic number, and it can easily become "magic"
> with some comments put there.

This doesn't sound like a recipie for success..

> > No, add a new API.

> Is the following patch what you are ordering here?

Yes.  I'd go with _tol rather than _tolerance probably but something
like that, yes.

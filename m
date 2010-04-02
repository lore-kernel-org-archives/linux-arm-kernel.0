From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 2 Apr 2010 10:43:22 +0100
Subject: [PATCH 4/4] ASoC: enable wm8753 in aspenite
In-Reply-To: <l2u771cded01004012140pa41dac0egc067ce7a1cbeed0@mail.gmail.com>
References: <s2g771cded01003310548udc9ff8b8u35736bd95038f92c@mail.gmail.com>
	<20100401182124.GB26650@opensource.wolfsonmicro.com>
	<l2u771cded01004012140pa41dac0egc067ce7a1cbeed0@mail.gmail.com>
Message-ID: <20100402094322.GB11134@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 02, 2010 at 12:40:30PM +0800, Haojian Zhuang wrote:
> On Fri, Apr 2, 2010 at 2:21 AM, Mark Brown

> >> +/* Get the MCLK frequency */
> >> +static int pxa168_get_mclk(int i)

> > This stuff probably shouldn't be in the machine driver since pretty much
> > all machine drivers are going to want exactly the same code - it should
> > be in the library code. ?Probably best to have them take hw_params
> > rather than require the machine driver to decode the format, rate and
> > channel since that'll save a bit of per driver boiler plate if they
> > don't otherwise need that information.

> > As I said last time ideally machine drivers shouldn't have to see this
> > at all, of course.

> This functions is used to get the sysclk. It's the parameter that is
> used in hw_params() of machine driver since we need set codec and cpu
> sysclock. But hw_params() of machine driver is invoked before
> hw_params() of cpu_dai.

> That's the main reason. If hw_params() of cpu_dai is invoked before
> machine driver. This issue won't exist.

That's not the main point here - the code itself shouldn't be in the
machine driver since pretty much all machine drivers need exactly the
same code.  If they need to do this they should be calling functions
provided by the CPU driver rather than cut'n'pasting the code.

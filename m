From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 9 May 2012 14:13:35 +0300
Subject: moving Tegra30 to the common clock framework
In-Reply-To: <20120507000329.GB14559@gmail.com>
References: <20120503161311.GG20304@tbergstrom-lnx.Nvidia.com>
 <20120507000329.GB14559@gmail.com>
Message-ID: <20120509111335.GC20304@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 07, 2012 at 02:03:29AM +0200, Mike Turquette wrote:
> On 20120503-19:13, Peter De Schrijver wrote:
> > Hi,
> > 
> > I started looking into what would be needed to move our tegra30 clock code
> > to the common clock framework. The tegra30 clocktree is rather flat. Basically
> > there are a bunch of sources (13 PLLs, external audio clocks, osc and 32Khz)
> > and peripheral clocks which have a mux (with 4 or more inputs), a divider and
> > a gate. So almost every peripheral clock can have multiple parents.
> > 
> > Some questions:
> > 
> > 1) should these peripheral clocks be modelled as 3 different clocks
> >    (mux -> divider -> gate) or would it be better to make a new clock type for
> >    this?
> > 
> 
> That is really for you to decide.  If the semantics of the existing mux,
> divider and gate in drivers/clk/clk-*.c work well for you then I think
> the answer is "yes".  There is infrastructure for register-access
> locking in those common types which might help your complex clocks.
> 
> Thanks to the parent rate propagation stuff in clk_set_rate it should be
> possible for your drivers to only be aware of the gate and call
> clk_set_rate on only that clock, which propagates up to the divider and,
> if necessary, again propagates up to the mux.
> 
> I encourage you to try that first.  But if you find the semantics of
> those basic clock types aren't cutting it for you then you must create a
> type which is platform-specific.
> 
> > 2) how to define the default parent? in many cases the hw reset value isn't
> >    a very sensible choice, so the kernel probably needs to set a parent of
> >    many of them if we don't want to rely on bootloader configuration.
> 
> The only related thing handled at the framework level is _discovery_ of
> the parent during clock registration/initialization.  If you don't trust
> the bootloader and want to set things up as soon as possible (a wise
> move) then I suggest you do so from your platform clock code at the same
> time that you register your clocks with the framework.  Something like:
> 
> 	struct clk *c;
> 	c = clk_register(...);
> 	if (IS_ERR(c))
> 		omg_fail();
> 	clk_set_parent(c, b);
> 
> Where 'b' is a parent of 'c'.  Register your clock tree top-down and you
> can re-parent as you go.

Ok. Thanks. One more question. We have some clocks with special features
such as request lines for clock outputs, delays for clocks recovered from
an external source or several divisors which are used based on the state
of the module which is served by the clock (eg. an idle divisor and an active
divisor). How should these be modelled?

Thanks,

Peter.

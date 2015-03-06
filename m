From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 06 Mar 2015 11:55:26 -0800
Subject: [PATCH v5 1/6] clk: add of_clk_get_parent_rate function
In-Reply-To: <20150226084319.GZ12209@pengutronix.de>
References: <rjui@broadcom.com>
 <1423097705-22939-1-git-send-email-rjui@broadcom.com>
 <1423097705-22939-2-git-send-email-rjui@broadcom.com>
 <20150226055406.GB28214@pengutronix.de> <54EEB97B.6080006@broadcom.com>
 <20150226065155.GY12209@pengutronix.de> <54EECE74.8050108@broadcom.com>
 <20150226084319.GZ12209@pengutronix.de>
Message-ID: <20150306195526.11109.54039@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sascha Hauer (2015-02-26 00:43:19)
> On Wed, Feb 25, 2015 at 11:42:44PM -0800, Ray Jui wrote:
> > On 2/25/2015 10:51 PM, Sascha Hauer wrote:
> > > On Wed, Feb 25, 2015 at 10:13:15PM -0800, Ray Jui wrote:
> > >> Hi Sascha,
> > >>
> > >> On 2/25/2015 9:54 PM, Sascha Hauer wrote:
> > >>> Hi Ray,
> > >>>
> > >>> On Wed, Feb 04, 2015 at 04:55:00PM -0800, Ray Jui wrote:
> > >>>> Sometimes a clock needs to know the rate of its parent before itself is
> > >>>> registered to the framework. An example is that a PLL may need to
> > >>>> initialize itself to a specific VCO frequency, before registering to the
> > >>>> framework. The parent rate needs to be known, for PLL multipliers and
> > >>>> divisors to be configured properly.
> > >>>>
> > >>>> Introduce helper function of_clk_get_parent_rate, which can be used to
> > >>>> obtain the parent rate of a clock, given a device node and index.
> > >>>
> > >>> I can't see how this patch helps you. First it's not guaranteed that
> > >>> the parent is already registered, what do you do in this case?
> > >>
> > >> In the case when clock parent is not found, as you can see from the
> > >> code, it simply returns zero, just like other clk get rate APIs.
> > > 
> > > Yes, but what do you do with the 0 result then in your PLL initialization?
> > > 
> > 
> > As of the current code, it fails the PLL frequency initialization and
> > bails out. Thinking about it more, it actually makes more sense to just
> > warn and still go ahead to register the clock, in which case it will use
> > whatever default frequency after chip power on reset or a frequency
> > configured in the bootloader.
> > 
> > >>
> > >> I thought the order of clock registration is based on order of the clock
> > >> nodes in device tree. It makes sense to me to declare the parent clock
> > >> before a child clock, so it's guaranteed that the parent is registered
> > >> before the child.
> > > 
> > > No, you can't rely on that. The order of the device nodes may happen to
> > > define the order of clock initialization now, but that may change.
> > > device nodes are usually ordered by bus addresses, not by intended
> > > initialization order. Even if you reorder them everything must still
> > > work.
> > > 
> > 
> > Okay I get your point that the order of device nodes may not be relied
> > on for device initialization order. But then another mechanism should be
> > deployed to give developers the option to decide on the clock
> > initialization sequence. It can be optional but it should be there.
> > 
> > >>
> > >>> Then the clock framework doesn't require that you initialize the PLL
> > >>> before registering. That can be done in the clk ops later.
> > >>
> > >> Sure it's not mandatory. But what's wrong with me choosing to initialize
> > >> the PLL clock to a known frequency before registering it to the framework?
> > > 
> > > Appearantly you don't know the (input) frequency of the PLL when
> > > registering it to the framework, so the question must be: What's wrong
> > > with keeping it uninitialized?
> > > 
> > > If the PLL is unused then you don't care about it's initialization
> > > status. If it happens to be enabled by a bootloader and still unused
> > > at late_initcall time the clock framework will disable it so you
> > > have a known state then. If a consumer for the PLL appears it's its
> > > job to initialize it through the clk api.
> > > 
> > > Sascha
> > > 
> > 
> > Okay, what we need here is to initialize the PLL to a desired frequency,
> > based on device tree settings (since it will be configured differently,
> > among different boards). This is a PLL that 1) has limited options of
> > frequencies which it can be configured to, and 2) has multiple child
> > clocks, where is a more suitable place to initialize it to the desired
> > frequency than right before registering it to the framework? I know a
> > lot of people do it in the bootloader, but I thought we should be given
> > the flexibility of configuring it in the kernel.
> > 
> > When you say "consumers", do you mean 1) the device driver that uses the
> > PLL; or 2) the device driver that use the child clock of the PLL? If
> > it's case 1), then we don't really have a device driver that directly
> > uses the PLL, and I thought that's quite normal, as most PLLs don't
> > directly feed into any peripherals.
> 
> I meant 1) and 2). Before a consumer comes along the state of the PLL
> doesn't matter. When a consumer shows up it has to call
> clk_prepare_enable which (directly or indirectly) will enable your PLL.
> Then it's still time to apply the default settings you found out during
> probe of the PLL.

My review comments are really for iproc_pll_setup() in patch #3, but the
discussion is here so I'll respond to this thread.

I think the root of this problem is that your pll clk_ops does not
support .set_rate. That is why your clock driver hacks in a call to
pll_set_rate in iproc_pll_setup.

Due to the above shortcoming you also do not use the assigned-clock-rate
infrastructure to set your pll rate at registration-time. There is no
reason for your driver to re-invent this logic. iproc_pll_setup is
fetching the clock-frequency property from DT and then trying to set
that rate. Instead please use the generic code.

The right way to handle this is to support a .set_rate callback (looks
like you're 90% of the way there with pll_set_rate) and then use the
assigned-clock-rates property to specify this from DT.

Regards,
Mike

> 
> Sascha
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

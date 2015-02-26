From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 26 Feb 2015 07:51:55 +0100
Subject: [PATCH v5 1/6] clk: add of_clk_get_parent_rate function
In-Reply-To: <54EEB97B.6080006@broadcom.com>
References: <rjui@broadcom.com>
 <1423097705-22939-1-git-send-email-rjui@broadcom.com>
 <1423097705-22939-2-git-send-email-rjui@broadcom.com>
 <20150226055406.GB28214@pengutronix.de>
 <54EEB97B.6080006@broadcom.com>
Message-ID: <20150226065155.GY12209@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 10:13:15PM -0800, Ray Jui wrote:
> Hi Sascha,
> 
> On 2/25/2015 9:54 PM, Sascha Hauer wrote:
> > Hi Ray,
> > 
> > On Wed, Feb 04, 2015 at 04:55:00PM -0800, Ray Jui wrote:
> >> Sometimes a clock needs to know the rate of its parent before itself is
> >> registered to the framework. An example is that a PLL may need to
> >> initialize itself to a specific VCO frequency, before registering to the
> >> framework. The parent rate needs to be known, for PLL multipliers and
> >> divisors to be configured properly.
> >>
> >> Introduce helper function of_clk_get_parent_rate, which can be used to
> >> obtain the parent rate of a clock, given a device node and index.
> > 
> > I can't see how this patch helps you. First it's not guaranteed that
> > the parent is already registered, what do you do in this case?
> 
> In the case when clock parent is not found, as you can see from the
> code, it simply returns zero, just like other clk get rate APIs.

Yes, but what do you do with the 0 result then in your PLL initialization?

> 
> I thought the order of clock registration is based on order of the clock
> nodes in device tree. It makes sense to me to declare the parent clock
> before a child clock, so it's guaranteed that the parent is registered
> before the child.

No, you can't rely on that. The order of the device nodes may happen to
define the order of clock initialization now, but that may change.
device nodes are usually ordered by bus addresses, not by intended
initialization order. Even if you reorder them everything must still
work.

> 
> > Then the clock framework doesn't require that you initialize the PLL
> > before registering. That can be done in the clk ops later.
> 
> Sure it's not mandatory. But what's wrong with me choosing to initialize
> the PLL clock to a known frequency before registering it to the framework?

Appearantly you don't know the (input) frequency of the PLL when
registering it to the framework, so the question must be: What's wrong
with keeping it uninitialized?

If the PLL is unused then you don't care about it's initialization
status. If it happens to be enabled by a bootloader and still unused
at late_initcall time the clock framework will disable it so you
have a known state then. If a consumer for the PLL appears it's its
job to initialize it through the clk api.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

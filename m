From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 18 Apr 2012 14:28:32 +0200
Subject: [PATCH 1/1] pinctrl: handle dummy state in core
In-Reply-To: <CACRpkdYH06_kGbSdozKPWZcOG0FvoOyHvjHwhz-xUL1pfSX9DQ@mail.gmail.com>
References: <1334586289-13078-1-git-send-email-b29396@freescale.com>
 <4F8C42D6.2000607@wwwdotorg.org>
 <20120417034210.GD17173@shlinux2.ap.freescale.net>
 <CACRpkdYH06_kGbSdozKPWZcOG0FvoOyHvjHwhz-xUL1pfSX9DQ@mail.gmail.com>
Message-ID: <20120418122832.GP20478@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 01:31:17PM +0200, Linus Walleij wrote:
> On Tue, Apr 17, 2012 at 5:42 AM, Dong Aisheng
> <aisheng.dong@freescale.com> wrote:
> 
> > I think the main issue is for one platform neither supports dt nor using pinctrl
> > subsystem, do you think it still makes too much sense to force that platform
> > to define a _PINCTRL_ dummy state in their machine code?
> >
> > But the driver is commonly shared between these different platforms(using pinctrl
> > or not).
> 
> So this is for the situation where some machines have pinctrl and some haven't.
> 
> And I think that's how some archs have used the regulator dummies earlier,
> so I clearly see the point. So if converting a subset of machines in an
> architecture you will need this for a transitional period.
> 
> Is this helpful to get i.MX support in place?
> 
> On one hand I'd say we merge it for that reason alone, instead of requiring
> all i.MX machines to be converted at once.
> 
> On the other hand, I fear that this will be used to avoid *ever* migrating
> the old machines to pinctrl. And it's a generic disease that people working
> in the arch/arm/* tree want to ditch old hardware without actually deleting
> the code.

'existing' doesn't necessarily mean 'old'

> 
> I'd like Sascha's view on this to make a good decision.

Currently Dong Aisheng is working on i.MX6, we have i.MX31, i.MX35,
i.MX51 and i.MX53 enabled in the same defconfig. Waiting for all
machines turn over at once to pinctrl is illusionary. We have to make
drivers work with and without pinctrl. We have a bunch of bad choices:

- create a dummy pinctrl for all boards which do not have real pinmux
  support
- ignore pinctrl_request errors in drivers.
- generate and return a dummy pinctrl in the core if no real pinctrl is
  found.

(replace pinctrl with regulators or clocks, it's the same situation, and
it's not only i.MX specific)

I don't have a good solution for this, only the idea that it should be
possible to attach these kinds of resources to a device and then a
driver would only call a make_me_work(dev).

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

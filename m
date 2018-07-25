From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 25 Jul 2018 15:37:02 -0700
Subject: [PATCH] clk: Add functions to get optional clocks
In-Reply-To: <OSBPR01MB1766E6AFE37986B2E2B5E35DF5530@OSBPR01MB1766.jpnprd01.prod.outlook.com>
References: <1531918658-32278-1-git-send-email-phil.edworthy@renesas.com>
 <20180718130228.GG17271@n2100.armlinux.org.uk>
 <CAMuHMdUjzVBXn-goAwbTBULfo=HrJEY6eBae4w7Z6qA-gScUUw@mail.gmail.com>
 <OSBPR01MB1766E6AFE37986B2E2B5E35DF5530@OSBPR01MB1766.jpnprd01.prod.outlook.com>
Message-ID: <153255822286.48062.3193076486782567960@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Phil Edworthy (2018-07-18 06:56:26)
> Hi Russell,
> 
> On 18 July 2018 14:19, Geert Uytterhoeven wrote:
> > On Wed, Jul 18, 2018 at 3:02 PM Russell King - ARM Linux  wrote:
> > > On Wed, Jul 18, 2018 at 01:57:38PM +0100, Phil Edworthy wrote:
> > > > Behaves the same as (devm_)clk_get except where there is no clock
> > > > producer. In this case, instead of returning -ENOENT, the function
> > > > returns NULL. This makes error checking simpler and allows
> > > > clk_prepare_enable, etc to be called on the returned reference
> > > > without additional checks.
> > >
> > > How does this work with non-DT systems, where looking a clock up which
> > > isn't yet registered with clkdev returns -ENOENT ?
> > >
> > > (clkdev doesn't know when all clocks are registered with it.)
> > 
> > Good question.
> > 
> > I guess all drivers trying to handle optional clocks this way are already broken
> > on non-DT systems where clocks may be registered late...
> 
> So how do non-DT systems that look a clock up which isn't yet
> registered with clkdev, determine that an optional clock is there
> or not?
> 

Short answer is they don't. I'd still prefer we have this API though.

Can you rework this patch to be a little more invasive into the
clk_get() path, perhaps by reworking __of_clk_get_by_name() a little to
take an 'optional' argument, so that it only returns NULL when the clk
is looked up from DT? The fallback path in clkdev where we have a DT
based system looking up a clk through clkdev lookups doesn't seem to be
a real scenario that we should worry about here. I think sometimes
people use clkdev lookups when they're migrating to DT systems and
things aren't wired up properly in DT, but that isn't the norm.

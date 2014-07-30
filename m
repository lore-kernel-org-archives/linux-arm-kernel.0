From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 29 Jul 2014 23:06:19 -0700
Subject: use IORESOURCE_REG resource type for non-translatable addresses
 in DT
In-Reply-To: <CAL_JsqJjH0OH+X=fzwqAPeWarjoLev7v6Nv_QhAa+nZyztMnFA@mail.gmail.com>
References: <53D788A7.4020303@mm-sol.com> <3794875.CZFbAag5Sv@wuerfel>
 <53D7AA72.6010309@mm-sol.com>
 <20140729234522.E9FF1C40738@trevor.secretlab.ca>
 <53D84558.7060406@codeaurora.org>
 <CAL_JsqJjH0OH+X=fzwqAPeWarjoLev7v6Nv_QhAa+nZyztMnFA@mail.gmail.com>
Message-ID: <20140730060619.GC19933@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29, Rob Herring wrote:
> On Tue, Jul 29, 2014 at 8:07 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > On 07/29/14 16:45, Grant Likely wrote:
> >> On Tue, 29 Jul 2014 17:06:42 +0300, Stanimir Varbanov <svarbanov@mm-sol.com> wrote:
> >>>
> >>> This was just an example. Of course it has many issues and probaly it is
> >>> wrong:) The main goal was to understand does IORESOURCE_REG resource
> >>> type and parsing the *reg* properties for non-translatable addresses are
> >>> feasible. And also does it acceptable by community and OF platform
> >>> maintainers.
> >> The use case is actually very different from of_address_to_resource or
> >> of_get_address() because those APIs explicitly return physical memory
> >> addresses from the CPU perspective. It makes more sense to create a new
> >> API that doesn't attempt to translate the reg address. Alternately, a
> >> new API that only translates upto a given parent node.
> >
> > The most important thing is that platform_get_resource{_by_name}(&pdev,
> > IORESOURCE_REG, n) returns the reg property and optional size encoded
> > into a struct resource. I think Rob is suggesting we circumvent the
> > entire of_address_to_resource() path and do some if
> > (IS_ENABLED(CONFIG_OF) && type == IORESOURCE_REG) check in
> > platform_get_resource() to package up the reg property into a struct
> > resource. That should work.
> 
> No, I'm saying why are you using platform_get_resource at all and
> adding a new resource type? I don't see any advantage.

First off, the resource type is not new. IORESOURCE_REG has
existed for two years (see commit 72dcb1197228 "resources: Add
register address resource type, 2012-08-07").

The main advantage is allowing things like
platform_get_resource_by_name() and platform_get_resource() to
work seamlessly with devicetree. If we don't have this, drivers
are going to open code their reg property parsing and possibly
reg-names parsing. There are a handful of drivers that would be
doing this duplicate work.

Sure, we could consolidate them into an OF helper function, but
then these are the only platform drivers that are getting their
reg properties via a special non-translatable address function.
The drivers don't care that they're using non-translateable
addresses as long as they can pass the address returned from
platform_get_resource() to their regmap and do I/O. The drivers
are written under the assumption that they're a sub-device of
some parent device (in this case a PMIC) and so they assume that
the regmap has already been setup for them.

> 
> You might as well do of_property_read_u32 in the below example.
> 

Fair enough. The example is probably too simple. Things are
sometimes slightly more complicated and a simple
of_property_read_u32() isn't going to work in the case of
multiple reg values or when reg-names is in play.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 5 Sep 2018 11:05:34 +0200
Subject: [PATCH 3/4] bus: Add DT bindings for 96Boards low speed connector
In-Reply-To: <CAL_JsqK2tdGHkeJ0OceLbBiki7VUqKrstDSiB7KRpZ-FExHtQw@mail.gmail.com>
References: <20180823103332.32047-1-linus.walleij@linaro.org>
 <20180823103332.32047-4-linus.walleij@linaro.org>
 <CAL_JsqK2tdGHkeJ0OceLbBiki7VUqKrstDSiB7KRpZ-FExHtQw@mail.gmail.com>
Message-ID: <CACRpkdZ5jYTvNeHNDf3oJaGxgP8kie-uQu1=8FYyEDLeMquEnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2018 at 3:46 PM Rob Herring <robh+dt@kernel.org> wrote:
> On Thu, Aug 23, 2018 at 5:33 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > We need to be able to grab resources on a 96Boards low
> > speed connector to populate and use a daughterboard, so
> > define some very rudimentary properties simply passing
> > phandles for the resources used on the low speed
> > connector.
>
> This only works for describing what's on the connector, but does
> nothing for describing downstream devices on the connector. We already
> have a way to do the former with label properties at least for uart,
> i2c and spi. And gpio has it's own method of labeling lines.

This is on purpose as the downstream daughterboards are
described by C code rather than DT. The idea is to use the same
for ACPI rather than DSDT.

> > +lscon: connector {
> > +       compatible = "96boards,low-speed-connector";
> > +       i2c0 = <&i2csw_0>;
> > +       i2c1 = <&i2csw_1>;
> > +       spi = <&spi0>;
>
> David G has suggested using aliases (in this node, not top-level) for
> this purpose of mapping things like spi and i2c, and I think that's a
> good use of aliases (versus spi and i2c aliases at the top level which
> I don't). The hard part is still how to structure the child devices.

Sorry, I am just too ignorant about the semantic difference between
a phandle and an alias. As long as I can follow it to get a handle on
the device node I'm happy, aliases are fine I guess.

The specification says:

"The phandle property specifies a numerical identifier for a node that
is unique within the devicetree. The phandle property value is used by
other nodes that need to refer to the node associated with the
property."

Numerical? Hm.

The aliases are very vague and seem to not be really specified.
Not in the DT spec at least. And that is not in line with how the
Linux kernel DTs uses aliases anyway, it seems.

Syntactically they look like so:

aliases {
        serial0 = &uart1;
};

phandles {
        serial0 = <&uart1>;
};

Not a big difference.

In your opinion, what constitues the semantic meaning of an alias
vs a phandle?

> > +       gpios = <&gpio 36 0>, /* GPIO-A */
>
> We defined 'gpio-map' specifically for handling GPIOs thru connectors.
> It's in the DT spec (though not a released version yet). Use it here.

We have code for it (by Stephen Boyd) which works and I tested
it even, it works fine!

But it is not intended for what I do here. It shares the ambition to
define all devices in the daughterboard using DT, so there must
be a consuming node, on the daughterboard, using
my-gpios = <&connector 0>; and we are back
at overlays. There is no way for a connector driver to
grab a GPIO from the GPIO map, the map is just a
cross-reference, not resource provider.

Maybe I could let the connector say that it's using
GPIOs from itself? I can take a stab at that. It will look weird
but it's allright I guess.

> Sorry, but the only halfway solution
> I'm going to accept is one which
> can evolve into a full solution. Define the basic structure and add
> each interface one by one.
>
> Maybe that starts with just:
>
> lscon: connector {
>        compatible = "96boards,low-speed-connector";
> };

I suspect "full solution" in the above paragraph means full
DT overlays, and ACPI systems are none of your concern
in this context?

A halfway solution is what I am trying to do, because the
walking all the way down the road means we run into the
imperialistic ambitions of both DT and ACPI DSDT to describe
the whole system using just DT or just ACPI DSDT.

As mentioned, we have today the developer box that is
using ACPI, and the other 96Boards using mostly DT.

Which currently means similar support code twice
for these (simple) mezzanines, then author and support
overlays in both HW description languages.

Like with the fwnode rework that is going on in parallel, in
my view it is really necessary for both DT and ACPI to take
a step back and stop being so imperialistic. It seems they
are both living under the assumption that they do not really
need to care about the other HW description language, and
it is stifling development. Maybe this view is too harsh, I am
sometimes also just thinking inside my little box :(

My current plan is to develop the code in the patch set using
fwnode where possible so that I have a proof of concept of
the same mezzanine population code being used for DT and
ACPI alike. It works for GPIOs, but phandles or aliases are
going to be a challenge.

Yours,
Linus Walleij

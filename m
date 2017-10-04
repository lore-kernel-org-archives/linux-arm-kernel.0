From: andrew@aj.id.au (Andrew Jeffery)
Date: Wed, 04 Oct 2017 15:06:33 +1030
Subject: [PATCH 3/8] ARM: dts: aspeed: Add I2C buses
In-Reply-To: <CAFd5g46LrdCkPq-dZyrA3Nnw28=r-sCsPvp5bWngYUF=3RmDYA@mail.gmail.com>
References: <20170928075149.8154-1-joel@jms.id.au>
 <20170928075149.8154-4-joel@jms.id.au>
 <CAFd5g46LrdCkPq-dZyrA3Nnw28=r-sCsPvp5bWngYUF=3RmDYA@mail.gmail.com>
Message-ID: <1507091793.5452.10.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-09-28 at 11:35 -0700, Brendan Higgins wrote:
> > On Thu, Sep 28, 2017 at 12:51 AM, Joel Stanley <joel@jms.id.au> wrote:
> > Now with an upstream i2c bus driver, we can add??the 14 i2c buses that
> > exist in ASPEED G4 and G5 generation SoCs.
> >?
> > It also adds aliases for the 14 built-in I2C busses to ensure userspace
> > sees the numbering staring from zero and counting up.
> >?
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
>?
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>?
> nit: can we make the i2c labels and the pinctrl labels match?
>?
> For example:
>?
> > +
> > +???????i2c13: i2c-bus at 480 {
> > +???????????????#address-cells = <1>;
> > +???????????????#size-cells = <0>;
> > +???????????????#interrupt-cells = <1>;
> > +
> > +???????????????reg = <0x480 0x40>;
> > +???????????????compatible = "aspeed,ast2500-i2c-bus";
> > +???????????????clocks = <&clk_apb>;
> > +???????????????bus-frequency = <100000>;
> > +???????????????interrupts = <13>;
> > +???????????????interrupt-parent = <&i2c_ic>;
> > +???????????????pinctrl-names = "default";
> > +???????????????pinctrl-0 = <&pinctrl_i2c14_default>;
> > +???????????????status = "disabled";
> > +???????};
>?
> "i2c13" has a pinctrl-0 of "pinctrl_i2c14_default"
>?
> I know that pinctrl_i2c14_default is consistent with the function and
> groups it uses, but I would like to see them all be consistent at some
> point in the future.

I doubt we'll be making them consistent: How the i2c devices are aliased by
Linux are independent of how they're labelled in hardware or the datasheet.

For sanity's sake pinmux's functions and groups follow the datasheet (though if
you want to maintain the Aspeed pinctrl drivers, be my guest :D)

We could rename the pinmux nodes to offset them from the function and group,
but it feels less self-contained if the nodes are named at the whim of the
device requesting the function if there's no further configuration on top of
the function and group*. It also makes it harder to auto-explode the function
name into the node definitions as we'd then need some further mangling to make
things line up.

* The pinctrl devicetree bindings allow for definition of nested nodes to
specify collections and combinations of pin function and group, and pin
configuration such as drive-strength. Thus the nodes can be a lot more complex
than what we've defined up until now, but what we've got enables a lot of
pretty straight-forward uses-cases.

We could alias the i2c devices in line with the hardware, but that breaks the
convention of starting device numbering at 0.

Ultimately Joel and I chose to make the break at the point where the i2c device
requests the mux function. It's up to the device to know what hardware mux
configuration it needs and that's what this approach documents. The
inconsistency is irritating but I don't feel like it's the end of the world,
and I think the alternatives are (slightly) worse.

Cheers,

Andrew
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171004/38f5d196/attachment.sig>

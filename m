From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 06 Dec 2016 14:40:24 +0100
Subject: [resend v2: PATCH 1/2] dt-bindings: Document the hi3660 reset
 bindings
In-Reply-To: <3449091.bg2i6Oq5SM@wuerfel>
References: <1480553321-17400-1-git-send-email-zhangfei.gao@linaro.org>
 <5982682.vMJxVociDa@wuerfel> <1480687813.2460.19.camel@pengutronix.de>
 <3449091.bg2i6Oq5SM@wuerfel>
Message-ID: <1481031624.3202.54.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 02.12.2016, 23:11 +0100 schrieb Arnd Bergmann:
> On Friday, December 2, 2016 3:10:13 PM CET Philipp Zabel wrote:
> > Am Freitag, den 02.12.2016, 13:32 +0100 schrieb Arnd Bergmann:
> > > On Friday, December 2, 2016 8:21:33 AM CET zhangfei wrote:
> > > > On 2016?12?01? 20:05, Arnd Bergmann wrote:
> > > > > On Thursday, December 1, 2016 8:48:40 AM CET Zhangfei Gao wrote:
> > > > >> +               hisi,reset-bits = <0x20 0x8             /* 0: i2c0 */
> > > > >> +                                  0x20 0x10            /* 1: i2c1 */
> > > > >> +                                  0x20 0x20            /* 2: i2c2 */
> > > > >> +                                  0x20 0x8000000>;     /* 3: i2c6 */
> > > > >> +       };
> > > > >> +
> > > > >> +Specifying reset lines connected to IP modules
> > > > >> +==============================================
> > > > >> +example:
> > > > >> +
> > > > >> +        i2c0: i2c at ..... {
> > > > >> +                ...
> > > > >> +               resets = <&iomcu_rst 0>;
> > > > >> +                ...
> > > > >> +        };
> > > > > I don't really like this approach, since now the information is
> > > > > in two places. Why not put the data into the reset specifier
> > > > > directly when it is used?
> > 
> > From my point of view, with the binding above, all reset controller
> > register/bit layout information is in a single place and can be easily
> > compared to a list in the reference manual, whereas with your suggestion
> > the description of the reset controller register layout is spread
> > throughout one or even several dtsi files.
> > Also, since no two reset controllers are exactly the same, we get a
> > proliferation of different slightly phandle argument meanings.
> 
> There is no reason for this to be any different from other subsystems
> that all do it the same way: interrupts, gpios, dma, clk, ... all
> define #foo-cells to be used for addressing uniform things,
> and the data is only in the reference, so that the node that
> describes the controller needs no knowledge of what it's being
> used for.

For most of those bindings the knowledge about which register and bit
position(s) correspond to the handles resides in the driver.

> One exception is the case (often on clk bindings) where the register
> layout is anything but uniform 

The register layout is very non-uniform for many reset controllers. Some
share the same register space with some of those clock controllers.

> and every input line has a completely different behavior.

I can't argue that the behavior is non-uniform for the sane reset
controllers though, most of them have just a single bit, for most
of them all reset lines behave the same.

>  For that case, we define our own numbering
> system in the driver and hardcode those tables there.
>
> This reset driver does not seem to belong into that category though.

Yes. From what has been shown so far, it seems that in this case, while
the resets are distributed sparsely, the relative layout (set/clear
registers right next to each other) is uniform.

> Even if it did, we putting information about the controller into
> its own node is redundant as the driver already identifies the
> register layout by the compatible string.

Indeed I would prefer the driver to carry the register layout tables
instead of putting this information into the device tree at all.

> > > > Any example, still not understand.
> > > > They are consumer and provider.
> > > 
> > > I mean in the i2c node, have
> > > 
> > > 	i2c0: i2c at ..... {
> > > 		...
> > > 		resets = <&iomcu_rst 0x20 0x8>;
> > > 		...
> > > 	}
> > 
> > There already are a few drivers that use this, and I fear people having
> > to change their bindings because new flags are needed that have not been
> > previously thought of.
> 
> It rarely happens on other subsystems, and the binding can
> always specify different behavior depending on #reset-cells.

I recognize I am biased here. So feel free to ignore this point.

What I'd like to make sure is that we have thought about and are happy
to spread (partial) information about the reset controller register
layout throughout the device tree like this.

regards
Philipp

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 5 Sep 2016 22:21:43 +0200
Subject: [PATCH 5/7] ARM: sun8i: a33: Add display pipeline
In-Reply-To: <CAGb2v66F+i=8SxrCN2+HNrjo5d=zXpCmbe9R=BT2sBxDXXXquw@mail.gmail.com>
References: <20160901153204.11217-1-maxime.ripard@free-electrons.com>
 <20160901153204.11217-6-maxime.ripard@free-electrons.com>
 <CAGb2v66F+i=8SxrCN2+HNrjo5d=zXpCmbe9R=BT2sBxDXXXquw@mail.gmail.com>
Message-ID: <20160905202143.GC8596@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 02, 2016 at 02:28:54PM +0800, Chen-Yu Tsai wrote:
> > +               be0: display-backend at 01e60000 {
> > +                       compatible = "allwinner,sun8i-a33-display-backend";
> > +                       reg = <0x01e60000 0x10000>;
> 
> Please also list the interrupt, even though we don't use it yet.
> The manual says it's 127 - 32 = 95.

Yep, you're right.

> > +               sat0: sat at 01e80000 {
> > +                       compatible = "allwinner,sun8i-a33-sat";
> > +                       reg = <0x01e80000 0x1000>;
> > +                       clocks = <&ccu CLK_BUS_SAT>;
> > +                       resets = <&ccu RST_BUS_SAT>;
> > +
> > +                       ports {
> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +
> > +                               sat0_in: port at 0 {
> > +                                       #address-cells = <1>;
> > +                                       #size-cells = <0>;
> > +                                       reg = <0>;
> > +
> > +                                       sat0_in_fe0: endpoint at 0 {
> > +                                               reg = <0>;
> > +                                               remote-endpoint = <&fe0_out_sat0>;
> > +                                       };
> > +                               };
> > +
> > +                               sat0_out: port at 1 {
> > +                                       #address-cells = <1>;
> > +                                       #size-cells = <0>;
> > +                                       reg = <1>;
> > +
> > +                                       sat0_out_be0: endpoint at 0 {
> > +                                               reg = <0>;
> > +                                               remote-endpoint = <&be0_in_sat0>;
> > +                                       };
> > +                               };
> 
> I'm worried about the representation here.
> 
> In the user manuals, the SAT is shown as part of the BE.  Look at it
> this way: if it did come before the BE and is independent, we
> shouldn't have to bring the SAT out of reset for simplefb to work.

Indeed.

> For comparison, a similar function unit called "CMU" found on the
> other post-sun6i SoCs has the same function description as SAT on
> the A33. It uses the reserved registers at the beginning of the BE
> address space.

Hmm, ok, so you would essentially, merge the backend and sat nodes?

That wouldn't be very hard to do, i'll do it.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160905/edb8a22f/attachment.sig>

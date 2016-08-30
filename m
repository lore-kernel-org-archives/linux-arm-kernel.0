From: robh@kernel.org (Rob Herring)
Date: Tue, 30 Aug 2016 12:06:36 -0500
Subject: [PATCH v2 3/6] dt/bindings: Add bindings for Tegra GMI controller
In-Reply-To: <CALw8SCVcPymDZ8NyUbeanRF0TCT1TZzL6iRDticYA42FWrEWqw@mail.gmail.com>
References: <1472045838-22628-1-git-send-email-mirza.krak@gmail.com>
 <1472045838-22628-4-git-send-email-mirza.krak@gmail.com>
 <de2fb909-829e-6c04-4f6a-442cbb9171c9@nvidia.com>
 <CALw8SCVcPymDZ8NyUbeanRF0TCT1TZzL6iRDticYA42FWrEWqw@mail.gmail.com>
Message-ID: <20160830170636.GA8741@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2016 at 09:54:47PM +0200, Mirza Krak wrote:
> 2016-08-24 17:56 GMT+02:00 Jon Hunter <jonathanh@nvidia.com>:
> +
> >> +Example with two SJA1000 CAN controllers connected to the GMI bus. We wrap the
> >> +controllers with a simple-bus node since they are all connected to the same
> >> +chip-select (CS4), in this example external address decoding is provided:
> >> +
> >> +gmi at 70090000 {
> >> +     compatible = "nvidia,tegra20-gmi";
> >> +     reg = <0x70009000 0x1000>;
> >> +     #address-cells = <1>;
> >> +     #size-cells = <1>;
> >> +     clocks = <&tegra_car TEGRA20_CLK_NOR>;
> >> +     clock-names = "gmi";
> >> +     resets = <&tegra_car 42>;
> >> +     reset-names = "gmi";
> >> +     ranges = <4 0x48000000 0x7ffffff>;
> >> +
> >> +     status = "disabled";
> >> +
> >> +     bus at 4 {
> >> +             compatible = "simple-bus";
> >> +             reg = <4>;
> >> +             #address-cells = <1>;
> >> +             #size-cells = <1>;
> >> +             ranges = <0 4 0x40100>;
> >
> > Does this work? I tried to add an example like this and I got ...
> >
> > Warning (reg_format): "reg" property in /gmi at 70009000/bus at 4 has invalid
> > length (4 bytes) (#address-cells == 1, #size-cells == 1)
> 
> Shoot, to get rid of the warning it should be
> 
> reg = <4 0 >;
> 
> But it works either way.

The CS node should have #address-cells=2 with the first being CS# and 
the second being the offset (often 0).

> 
> >
> > I am wondering if we should just following the arm,pl172 example and
> > have ...
> >
> >         cs4 {
> >                 compatible = "simple-bus";
> >                 #address-cells = <1>;
> >                 #size-cells = <1>;
> >                 ranges;

Empty ranges is typically wrong and due to laziness...

This should have the CS# in it.

> >
> >                 nvidia,snor-cs = <4>;
> >                 nvidia,snor-mux-mode;
> >                 nvidia,snor-adv-inv;
> >
> >                 can at 0 {
> >                         reg = <0 0x100>;

This can be 1 cell with just the offset.

> >                         ...
> >                 };
> >
> >                 ...
> >         };
> >
> 
> That means to go back to V1 really (almost :)). Which I do not mind.
> Will give it a test run.
> 
> But I am a little hesitant if will be any better/cleaner. In your example above:
> 
> can at 0 {
>          reg = <0 0x100>;
>          ...
> };
> 
> Would this really translate correctly? In the pl172 example they have
> multiple ranges and address with "flash at 0,0" which a range defined in
> parent node. "can at 0" does not have valid match in parent node in our
> example. So I probably need add some more logic for it to properly
> translate.

pl172 has several things I don't like, so don't follow it. Mainly those 
are custom CS property and 3 levels of nodes. I'm fine with 3 levels if 
there is more than one device, but otherwise 2 levels with timing 
properties in the child device node.


> 
> I have an idea which is following:
> 
> gmi at 70090000 {
>          status = "okay";
>          #address-cells = <2>;
>          #size-cells = <1>;
>          ranges = <4 0 0x48000000 0x00040000>;
> 
>          cs4 {

cs at 4,0

>                  compatible = "simple-bus";
>                  #address-cells = <2>;

1 cell here.

>                  #size-cells = <1>;
>                  ranges;

Fill this in to drop the 2nd cell on child addresses and just have the 
offset.

> 
>                  nvidia,snor-cs = <4>;

NAK, no custom CS properties.

>                  nvidia,snor-mux-mode;
>                  nvidia,snor-adv-inv;
> 
>                  can at 0 {
>                          compatible = "nxp,sja1000";
>                          reg = <4 0 0x100>;
>                          ...
>                  };
> 
> 
>                  can at 40000 {
>                          compatible = "nxp,sja1000";
>                          reg = <4 0x40000 0x100>;
>                          ...
>                  };
>          };
> };
> 
> Do not know if above will work at all (not able to test at current
> location), anyway I will play around with it some more and get back to
> you.
> 
> Best Regards
> Mirza

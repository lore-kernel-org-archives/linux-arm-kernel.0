From: dongas86@gmail.com (Dong Aisheng)
Date: Mon, 13 Feb 2012 23:54:40 -0800
Subject: [PATCH 2/2] pinctrl: Add simple pinmux driver using device tree
 data
In-Reply-To: <20120213191113.GF1426@atomide.com>
References: <20120203205049.4089.74610.stgit@kaulin.local>
 <20120203205508.4089.35304.stgit@kaulin.local>
 <20120204175903.GF1426@atomide.com>
 <CAA+hA=Tux3P0RyaB=vG7UeycTt8z4nX9dBicpjB7tQ+xzwoSDQ@mail.gmail.com>
 <20120210200503.GX1426@atomide.com>
 <CAA+hA=Qa_3vXvgNMRuDjw93Wb3fGNOM1EqmvYVQO5CN9w2FA3A@mail.gmail.com>
 <20120213191113.GF1426@atomide.com>
Message-ID: <20120214075440.GA3058@b29396-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2012 at 11:11:13AM -0800, Tony Lindgren wrote:
...
> > Put it in pinctrl device node?
> > Then how do we name each pin?
> > And for IMX, currently we name all pins in driver.
> > I still can not find a good reason that i should name all pins in dt file.
> 
> But do you actually need the pin names in kernel? :)
> 
Yes, i meant name pins in driver.

> > Yes, we indeed have such a case.
> > For IMX, some special pins mux still need a setting called 'select input' which
> > is controlled in other registers.
> > But a rough idea in my mind that may choose different way to fix this issue.
> > It's a little like:
> > pinctrl_usdhc4: pinconfig-usdhc4 {
> >        mux =
> >                <MX6Q_SD4_CMD  0 SELECT_INPUT>
> >                <MX6Q_SD4_CLK  0 0>
> >                <MX6Q_SD4_DAT0 1 0>
> >                <MX6Q_SD4_DAT1 1 0>
> >                <MX6Q_SD4_DAT2 1 SELECT_INPUT>
> >                <MX6Q_SD4_DAT3 1 0>
> >                <MX6Q_SD4_DAT4 1 0>
> >                <MX6Q_SD4_DAT5 1 0>
> >                <MX6Q_SD4_DAT6 1 0>
> >                <MX6Q_SD4_DAT7 1 0>;
> > }
> > This format would not make the dts writer to take too much care of
> > register address
> > and value. For this case, the #pinmux-cells would be <3>;
> > It is a little different from OMAP.
> 
> If you don't want to keep the extra register entry around, then you
> could have a custom .data entry in the pinctrl driver that contains
> the mapping of these special registers.
> 
Yes, that's what i think.
But we still need pass the value for thoes sepcial registers from dt.

> > For your proposal, I'm afraid it is a little too much depend on the SoC register
> > layout. We need to find a flexible enough way to cover all possible
> > register layout
> > difference for all SoCs.
> > (Considering one register controls multi muxs?)
> 
> Most likely those special cases are best handled in hardware specific
> drivers.
>  
Yes, common driver needs provide a way to cover that.

> > Did i misunderstand?
> > I still can not understand why need this.
> > The pinctrl properly in device node can support multi pinmuxs .
> > serial at 48020000 {
> >       pinctrl = <&pmx_uart3_x &pmx_uart3_y>;
> > It's good to me that the consensus we reached at Linaro Connect is much like
> > my proposal in above URL. :)
> 
> I meant like what you have in the second option here, the count is
> used to parse each entry.
You're right, i misunderstood before.
Sorry for the noise.

Regards
Dong Aisheng

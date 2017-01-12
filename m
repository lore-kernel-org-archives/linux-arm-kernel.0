From: ping.bai@nxp.com (Jacky Bai)
Date: Thu, 12 Jan 2017 02:57:20 +0000
Subject: [PATCH v2 05/12] Document: dt: binding: imx: update pinctrl doc
 for imx6sll
In-Reply-To: <CACRpkdYTpEHyzBY-mA4YUsj=xt46Pibka3-4VHwUXosfgbgp1Q@mail.gmail.com>
References: <1482832070-22668-1-git-send-email-ping.bai@nxp.com>
 <1482832070-22668-6-git-send-email-ping.bai@nxp.com>
 <CACRpkdYUME8K+JusA0ORRKqxyBuhDdyei8eg7UZbHidKw9=bQw@mail.gmail.com>
 <AM3PR04MB5304992095753B761E66A9A87640@AM3PR04MB530.eurprd04.prod.outlook.com>
 <CACRpkdYTpEHyzBY-mA4YUsj=xt46Pibka3-4VHwUXosfgbgp1Q@mail.gmail.com>
Message-ID: <AM3PR04MB530A88C5C0E7C6AD2C59B9E87790@AM3PR04MB530.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [PATCH v2 05/12] Document: dt: binding: imx: update pinctrl doc
> for imx6sll
> 
> On Mon, Jan 9, 2017 at 3:32 AM, Jacky Bai <ping.bai@nxp.com> wrote:
> 
> > I have look into the above commit on using generic binding. But I
> > think the generic pinconf is not very easy to add in imx pinctrl Driver. imx
> pinctrl use a different way to parse the pin configure.
> 
> OK atleast I need an indication from one of the i.MX maintainers how they
> want to proceed.
> 
> > Each fsl,pin entry  looks like <PIN_FUNC_ID  CONFIG> in dts, the
> > CONFIG is the pad setting value like pull-up, open-drain, drive strength etc.
> The above config bit definition is specific to each SOC in the PAD CTL register.
> >
> > If we want set the pin config to enable hysteresis, 47KOhm Pull Up,
> > 50Mhz speed, 80Ohm driver strength and Fast Slew Rate, then the CONFIG
> value should be 0x17059( ORs corresponding bit definition).
> 
> Hysteresis is an input property and does not make sense on something that
> need drive strength and slew rate configuration which are output properties.
> (I guess you mean 80mA drive strength.)
> 

For some bi-direction pins, like SD DATA pin, we may need to enable the hysteresis configuration.

> Actually such oxymoronic settings is a good reason to migrate to generic
> bindings because when you describe stuff with generic strings you see better
> what is going on, and we can add sanity checks to cases like this in the generic
> code where it would indeed be valid to ask why this combination of settings is
> being made.
> 

Another thing is that we can use a pins-tool program developed by NXP to generate the pinctrl configuration code that can
be used directly in dts. This tiny program can avoid pin function conflict. As on i.MX, there are so may pins, each pin can be used
for up 8  function. Configuring the pins is a time-consuming work.  This tools is very useful for customer to generate the dts code.  

Using generic pinconf is another option, but it may need more time to add it and more work to do.  For now, I think we can still keep the legacy method?
 
> > This value will be set in
> > PAD CTL register to config the corresponding pin.
> 
> Yes? That is common. It looks like that in DT:
> 
> {
>    input-schmitt-enable;
>    bias-pull-up = <47000>;
>    slew-rate = <50000000>;
>    drive-strength = <80000>;
> };
> 
> Yours,
> Linus Walleij

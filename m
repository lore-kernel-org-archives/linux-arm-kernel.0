From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Thu, 09 Mar 2017 08:36:24 +0800
Subject: [PATCH 2/3] thermal: add support for the thermal sensor on
 Allwinner new SoCs
In-Reply-To: <20170302141105.5fr3ru72rtdyv4pd@lukather>
References: <20170301190220.2EgSha6N@smtp3o.mail.yandex.net>
 <20170302141105.5fr3ru72rtdyv4pd@lukather>
Message-ID: <8250311489019784@web18g.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



02.03.2017, 22:11, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> On Thu, Mar 02, 2017 at 12:02:13AM +0800, Icenowy Zheng wrote:
>> ?2017?3?1? 23:56? Maxime Ripard <maxime.ripard@free-electrons.com>???
>> ?>
>> ?> On Wed, Mar 01, 2017 at 06:20:51PM +0800, Icenowy Zheng wrote:
>> ?> >
>> ?> > 2017?3?1? 18:14? Maxime Ripard <maxime.ripard@free-electrons.com>???
>> ?> > >
>> ?> > > On Tue, Feb 28, 2017 at 03:18:13PM +0800, Icenowy Zheng wrote:
>> ?> > > >
>> ?> > > > 2017?2?28? 14:44? Maxime Ripard <maxime.ripard@free-electrons.com>???
>> ?> > > > >
>> ?> > > > > On Tue, Feb 28, 2017 at 03:40:53AM +0800, Icenowy Zheng wrote:
>> ?> > > > > > From: Ondrej Jirman <megous@megous.com>
>> ?> > > > > >
>> ?> > > > > > Allwinner SoCs from H3 (including H5, A64, etc) have a new version of
>> ?> > > > > > thermal sensor, and needs a new driver for it.
>> ?> > > > > >
>> ?> > > > > > Add such a driver.
>> ?> > > > > >
>> ?> > > > > > Currently only H3 is supported, but other SoCs are easily to be
>> ?> > > > > > supported by adding new formula and set the sensor number.
>> ?> > > > > >
>> ?> > > > > > Signed-off-by: Ond?ej Jirman <megous@megous.com>
>> ?> > > > > > [Icenowy: extend to support further multiple-sensor SoCs, change commit
>> ?> > > > > >? message]
>> ?> > > > > > Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>> ?> > > > >
>> ?> > > > > There's no need to create a new driver for that. This can be handled
>> ?> > > > > by the GPADC driver we already have.
>> ?> > > >
>> ?> > > > sun8i-ths is not GPADC at all.
>> ?> > > >
>> ?> > > > The latest SoC I know that use GPADC as thermal sensor is A33.
>> ?> > >
>> ?> > > It's not called the same way, but it definitely is an evolution of the
>> ?> > > same controller. There's no need for a new driver, only reworking what
>> ?> > > is already there.
>> ?> >
>> ?> > I don't think so -- here's some evidence:
>>
>> ?But the H3 THS have many new IRQs, functions, different sampling
>> ?rate set method and a quite different register layout.
>>
>> ?Doing this in GPADC driver is possible but meaningless.
>>
>> ?> >
>> ?> > 1. The old GPADC do not have module clock.
>> ?>
>> ?> The A33 could use a PLL.
>>
>> ?But it's a dedicated mod clk on new generation THS.
>
> And all of this really are evolutions. The block is still driven in
> the exact same way. And this is where there is value in having the
> same driver: you share the logic, which is mostly common, instead of
> duplicating it.

After some thinking, I can accept a common driver for A23/A33 thermal
sensor and H3/A64/H5 ones, but I cannot accept use iio-sun4i-gpadc
driver for it, as now H3/A64/H5 thermal sensors are not just an ADC --
they features hardware alarm levels, and in some SoC it become a
multiple channel thermal sensor.

I will insist on doing a dedicated driver for it, or if you like, I can add
A23/A33 support to this driver. (Considering no one have already posted
any patches for A23/A33 thermal sensor, except my old ones, so my
work at least won't conflict with anything merged)

>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

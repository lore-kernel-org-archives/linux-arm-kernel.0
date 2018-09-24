From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 24 Sep 2018 14:19:20 +0200
Subject: [PATCH 02/10] phy: Add configuration interface
In-Reply-To: <b5ebd9a5-f43b-728b-1d7f-0f7b08021f39@ti.com>
References: <a739a2d623c3e60373a73e1ec206c2aa35c4a742.1536138624.git-series.maxime.ripard@bootlin.com>
 <1ed01c1f-76d5-fa96-572b-9bfd269ad11b@ti.com>
 <20180906145622.kwxvkcuerbeqsj6b@flea>
 <1a169fad-72b7-fac0-1254-cac5d8304740@ti.com>
 <20180912084242.skxbwbgluakakyg6@flea>
 <e0d7db11-7ec1-cb98-4e62-12d78d1ba65b@ti.com>
 <20180919121436.ztjnxofe66quddeq@flea>
 <93088385-126b-6bfb-70e4-16f7b949d299@ti.com>
 <20180924095435.77hh7lrpq7wkss2o@flea>
 <b5ebd9a5-f43b-728b-1d7f-0f7b08021f39@ti.com>
Message-ID: <20180924121920.kv4e4qkorvexmyj7@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

(stripping the mail a bit)

On Mon, Sep 24, 2018 at 05:25:26PM +0530, Kishon Vijay Abraham I wrote:
> >>>>> This integration will prevent us to use some clock rates on the first
> >>>>> SoC, while the second one would be totally fine with it.
> >>>>
> >>>> If there's a clock that is fed to the PHY from the consumer, then the consumer
> >>>> driver should model a clock provider and the PHY can get a reference to it
> >>>> using clk_get(). Rockchip and Arasan eMMC PHYs has already used something like
> >>>> that.
> >>>
> >>> That would be doable, but no current driver has had this in their
> >>> binding. So that would prevent any further rework, and make that whole
> >>> series moot. And while I could live without the Allwinner part, the
> >>> Cadence one is really needed.
> >>
> >> We could add a binding and modify the driver to to register a clock provider.
> >> That could be included in this series itself.
> > 
> > That wouldn't work for device whose bindings need to remain backward
> > compatible. And the Allwinner part at least is in that case.
> 
> Er..
> 
> > I think we should aim at making it a norm for newer bindings, but we
> > still have to support the old ones that cannot be changed.
> 
> There are drivers which support both the old and new bindings. Allwinner could
> be in that category.

Yes, definitely. However, in order to support the old binding, we'd
still need to have a way to give the clock rates to the phy when we
don't have that clock provider. So I don't really see how we could
remove those fields, even if we start introducing new bindings.

> >>> So the timings expressed in the structure are the set of all the ones
> >>> currently used in the tree by DSI and CSI drivers. I would consider
> >>> that a good proof that it would be useful.
> >>
> >> The problem I see here is each platform (PHY) will have it's own set of
> >> parameters and we have to keep adding members to phy_configure_opts which is
> >> not scalable. We should try to find a correlation between generic PHY modes and
> >> these parameters (at-least for a subset).
> > 
> > I definitely understand you skepticism towards someone coming in and
> > dropping such a big list of obscure parameters :)
> 
> That's part of my concern. The other concern is consumer driver having to know
> so much internal details of the PHY. None of the other consumers (PCIe, USB,
> etc) had to know so much internals of the PHY.

I guess that's true to some extent, but it also feels a bit like a
self-realizing prophecy. The phy framework also didn't provide any way
to change the phy configuration based on some runtime values up until
now, and we have a good example with the MIPI-DSI and MIPI-CSI drivers
that given the constructs used in these drivers, if the phy framework
had allowed it, they would have used it.

Also, speaking of USB, we've had some configuration that was done in
some private functions exported by the phy drivers themselves. So
there is a use case for such an interface even for other, less
configurable, phy types.

I even planned for that, since the phy_validate and phy_configure
functions are passed an union, in order to make it extensible to other
phy types easily.

I guess that both the fact that the configuration is simpler for the
phy types supported so far, and that the phy and its consumer are very
integrated, didn't make it necessary to have such an interface so
far. But with MIPI-DPHY, we have both a quite extensive configuration
to make, and the phys and their consumers seem to be a bit more
loosely integrated. HDMI phys seem to be in pretty much the same case
too.

> > However, those values are actually the whole list of parameters
> > defined by the MIPI-DPHY standard, so I really don't expect drivers to
> > need more than that. As you can see, most drivers allow less
> > parameters to be configured, but all of them are defined within those
> > parameters. So I'm not sure we need to worry about an ever-expanding
> > list of parameters: we have a limited set of parameters defined, and
> > from an authoritative source, so we can also push back if someone
> > wants to add a parameter that is implementation specific.
> 
> Your commit log mentioned there are a few parameters in addition to what is
> specified in the MIPI D-PHY spec :-/
> 
> "The parameters added here are the one defined in the MIPI D-PHY spec, plus
> some parameters that were used by a number of PHY drivers currently found
> in the linux kernel."

I should have phrased that better then, sorry. The only additions that
were made were the lanes number (that we agreed to remove), the high
speed and low power clock rates, and the video timings.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180924/0fabdf38/attachment.sig>

From: sboyd@kernel.org (Stephen Boyd)
Date: Thu, 26 Jul 2018 00:35:14 -0700
Subject: [resend PATCH v4 4/5] drm/mediatek: Add support for mmsys through
 a pdev
In-Reply-To: <1531908387.8953.147.camel@mtkswgap22>
References: <20180717220328.792-1-matthias.bgg@kernel.org>
 <20180717220328.792-5-matthias.bgg@kernel.org>
 <1531882655.8953.83.camel@mtkswgap22> <51066716.k5MkZnrqCl@avalon>
 <1531908387.8953.147.camel@mtkswgap22>
Message-ID: <153259051470.48062.4735087631606629738@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sean Wang (2018-07-18 03:06:27)
> On Wed, 2018-07-18 at 11:05 +0300, Laurent Pinchart wrote:
> > Hi Sean,
> > 
> > On Wednesday, 18 July 2018 05:57:35 EEST Sean Wang wrote:
> > > On Wed, 2018-07-18 at 00:03 +0200, matthias.bgg at kernel.org wrote:
> > > > From: Matthias Brugger <mbrugger@suse.com>
> > > > 
> > > > The MMSYS subsystem includes clocks and drm components.
> > > > This patch adds an initailization path through a platform device
> > > > for the clock part, so that both drivers get probed from the same
> > > > device tree compatible.
> > > 
> > > Sorry for that I should have a response earlier for the series.
> > > 
> > > Some points I felt they're not exactly right and should be fixed up
> > > before we're moving on
> > > 
> > > Currently, drm driver have a wrong reference to the dt-binding,
> > > "mediatek,mt2701-mmsys" or "mediatek,mt8173-mmsys", they should be all
> > > for the subsystem exporting clock and reset line such common resource to
> > > its sub-devices. Every subsystem has a similar shape. I hope mmsys
> > > shouldn't be an exception.
> > > 
> > > DRM device needs to have its own dt-binding show how connections between
> > > DRM components being made and its node should be put under mmsys node.
> > > 
> > > In this way, it becomes easy to see how the topology of the subsystem is
> > > and grows, like a tree "device tree", instead of hiding the details in
> > > the implementation.
> > > 
> > > The similar example we already did for audsys on mt2701 and mt7623 as
> > > below
> > > 
> > >     audsys: clock-controller at 11220000 {
> > >             
> > compatible = "mediatek,mt7623-audsys",
> > >             
> >            "mediatek,mt2701-audsys",
> > >             
> >            "syscon";
> > >             
> >       ...
> > > 
> > >             
> > afe: audio-controller {
> > >             
> >       compatible = "mediatek,mt7623-audio",
> > >             
> >               
> >      "mediatek,mt2701-audio";
> > > 
> > >             
> >       ...
> > >             
> > };
> > >     };
> > 
> > This looks very strange to me. I'm not familiar with the hardware 
> > architecture, but a clock controller that includes an audio controller seems 
> > like a very weird design. It's usually the other way around, you have an audio
> 
> yes, naming audsys as clock controller is really not good. it should be
> worth a better naming.
> 
> mtk subsystem AFAIK works as a container, at least provides clocks,
> reset, syscon access, these common resource to these devices running on
> the subsystem. It also has a power gate independent from other
> subsystem, that can be controlled when these devices all powered down
> or once up.
> 
> And it should be better that we don't assume what exact devices are
> running on since it is possible that there're different devices running
> on the same subsystem per SoC. mtk has many subsystem working in this
> way. mmsys is just a case. we can see in [1]
> 
> 
> [1]
> https://elixir.bootlin.com/linux/v4.18-rc5/source/Documentation/devicetree/bindings/arm/mediatek
>  

Sean, is this an ack for this patch series? I think the consensus is to
not modify DT to add a subnode for the "clk" part of the hardware, but
instead either register the clks from the device driver that has the clk
hardware inside of it, or do what this patch series does and register a
device in software from the "parent" device driver so that logically clk
things are contained in drivers/clk/

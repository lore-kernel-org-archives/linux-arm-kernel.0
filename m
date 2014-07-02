From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Jul 2014 14:48:17 +0200
Subject: [Patch v7 3/3] usb: dwc3: qcom: Add device tree binding
In-Reply-To: <1404290605.3622.6.camel@iivanov-dev>
References: <1404144233-17222-1-git-send-email-agross@codeaurora.org>
 <CAL_JsqLjjDV50x5LCDeySvV0u4U1om-3KDkFHMd5WouC=eV8kw@mail.gmail.com>
 <1404290605.3622.6.camel@iivanov-dev>
Message-ID: <4545008.qD8N1qWmNz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 July 2014 11:43:25 Ivan T. Ivanov wrote:
> > > <snip>
> > >
> > >> > +
> > >> > +                       ranges;
> > >> > +
> > >> > +                       status = "disabled";
> > >> > +
> > >> > +                       dwc3 at 11000000 {
> > >> > +                               compatible = "snps,dwc3";
> > >>
> > >> This sub-node is just wrong. Why can't you have a single node with '
> > >> "qcom,dwc3", "snps,dwc3" ' for the compatible property? All you are
> > >> adding here is clocks. Does the Synopsys block have no clocks?
> > >>
> > >> I guess this is copied from other broken dwc3 bindings... That doesn't
> > >> mean you have to copy it.
> > >
> > > The dwc3 core does not deal with clocks.  That is why everyone has a wrapper.
> > > That, in addition to pm, has to be handled from the wrapper.  That's my take
> > > anyway.  I am sure Felipe can speak more to this.
> > 
> > That is a Linux driver issue which is irrelevant to the binding.
> 
> DWC3 IP core from Synopsys is the same across SoC's (OMAP, Exynos..),
> vendors are adding glue IP to provide necessary clocks and voltages. 
> I think that the DT bindings properly reflect this fact.

Not really. The proper way to do this is to have a single node that
lists multiple compatible strings from the most specific (per SoC variant)
to most generic (the underlying IP core) and have all properties in it.

We have seen many cases before where it later turned out that whatever
feature people thought was SoC specific actually was common to all
of them and that we later want to change the code to handle it in a
common way, and to reflect it in the common binding. The clocks that
Rob mentioned are one example of that.

If you have a binding that separates one IP block into two device nodes,
you cannot later adapt the common driver to be more generic and handle
all sorts of SoCs. See the usb-ehci.txt for an example: it started out
really simple but the generic driver has been extended multiple times
to the point where it handles a lot of SoCs by default.

	Arnd

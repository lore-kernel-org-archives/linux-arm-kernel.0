From: balbi@ti.com (Felipe Balbi)
Date: Wed, 2 Jul 2014 10:54:02 -0500
Subject: [Patch v7 3/3] usb: dwc3: qcom: Add device tree binding
In-Reply-To: <4545008.qD8N1qWmNz@wuerfel>
References: <1404144233-17222-1-git-send-email-agross@codeaurora.org>
 <CAL_JsqLjjDV50x5LCDeySvV0u4U1om-3KDkFHMd5WouC=eV8kw@mail.gmail.com>
 <1404290605.3622.6.camel@iivanov-dev> <4545008.qD8N1qWmNz@wuerfel>
Message-ID: <20140702155402.GE5541@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 02, 2014 at 02:48:17PM +0200, Arnd Bergmann wrote:
> On Wednesday 02 July 2014 11:43:25 Ivan T. Ivanov wrote:
> > > > <snip>
> > > >
> > > >> > +
> > > >> > +                       ranges;
> > > >> > +
> > > >> > +                       status = "disabled";
> > > >> > +
> > > >> > +                       dwc3 at 11000000 {
> > > >> > +                               compatible = "snps,dwc3";
> > > >>
> > > >> This sub-node is just wrong. Why can't you have a single node with '
> > > >> "qcom,dwc3", "snps,dwc3" ' for the compatible property? All you are
> > > >> adding here is clocks. Does the Synopsys block have no clocks?
> > > >>
> > > >> I guess this is copied from other broken dwc3 bindings... That doesn't
> > > >> mean you have to copy it.
> > > >
> > > > The dwc3 core does not deal with clocks.  That is why everyone has a wrapper.

everyone has a wrapper for several others reasons. PM from the point of
view of the Synopsys IP is *completely* different from PM from the point
of view the $current_soc. The wrapper helps abstract that. Currently,
there's little PM implemented in the driver, but when we get to
implementing the nice features Synopsys has given us (hibernation, for
instance) it will start to be aparent why the driver was split like
that.

> > > > That, in addition to pm, has to be handled from the wrapper.  That's my take
> > > > anyway.  I am sure Felipe can speak more to this.
> > > 
> > > That is a Linux driver issue which is irrelevant to the binding.
> > 
> > DWC3 IP core from Synopsys is the same across SoC's (OMAP, Exynos..),
> > vendors are adding glue IP to provide necessary clocks and voltages. 
> > I think that the DT bindings properly reflect this fact.
> 
> Not really. The proper way to do this is to have a single node that
> lists multiple compatible strings from the most specific (per SoC variant)
> to most generic (the underlying IP core) and have all properties in it.
> 
> We have seen many cases before where it later turned out that whatever
> feature people thought was SoC specific actually was common to all
> of them and that we later want to change the code to handle it in a
> common way, and to reflect it in the common binding. The clocks that
> Rob mentioned are one example of that.
> 
> If you have a binding that separates one IP block into two device nodes,
> you cannot later adapt the common driver to be more generic and handle
> all sorts of SoCs. See the usb-ehci.txt for an example: it started out
> really simple but the generic driver has been extended multiple times
> to the point where it handles a lot of SoCs by default.

The fact is that you _DO_ have *TWO* IP blocks. The synopsys DWC3 is one
IP and the wrapper is another IP which adapts the synopsys IP to the
SoC's integration context.

>From the SoC point of view, the device only needs one (or maybe two)
clocks, an IRQ line, etc... The wrapper then, sometimes, enables that
particular memory region, enables IRQs and generates several other
clocks which are needed for proper operation of the IP.

Having this sort of "bridge" or "glue" driver also helps *HUGELY* in
different PM methodologies different SoCs use. I certainly don't want
any clock API calls in my dwc3 driver when I'm running on top of a PCI
bus on an intel platform. Likewise, I don't want any pci_enable_device()
calls in my dwc3 driver when I'm running on OMAP/Exynos/Qcom/etc.

Now, you guys just decided to give crap to the authors for no aparent
reason. If you really want to describe the HW then every single clock
node and every single voltage rail would have to be described but that
would just create a whole bunch of fixed clocks and fixed regulators
which have no way of being controlled whatsoever and just waste memory
due to several other instances of such drivers being needed.

It's pointless to continue discussing if we should have one clock node
or two clock nodes. If the wrapper doesn't need an interface clock, it
just doesn't need an interface clock and it's not up to us to start
*GUESSING* that it maybe has both clock inputs tied to the same clock
node if that's not what's written in the documentation. Sure, Qcom folks
could ask their HW designers, but what would that give us in practice ?
Nothing, not a single damn benefit.

So can we just move on from this pointless discussion now ?

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140702/dca79cbd/attachment.sig>

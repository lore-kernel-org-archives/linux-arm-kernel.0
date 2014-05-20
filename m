From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 20 May 2014 23:10:47 +0200
Subject: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
In-Reply-To: <20140520054852.GA12384@atomide.com>
References: <20140515182133.GC23659@atomide.com> <5375A8A8.7080306@ti.com>
 <20140516160717.GD22031@atomide.com>
 <20140516174158.GA11733@earth.universe>
 <20140516180154.GG22031@atomide.com> <5379CD24.6040508@ti.com>
 <20140519160447.GB4849@atomide.com> <537A55EB.1080507@ti.com>
 <20140520051203.GB28812@earth.universe>
 <20140520054852.GA12384@atomide.com>
Message-ID: <20140520211046.GA3476@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 10:48:52PM -0700, Tony Lindgren wrote:
> * Sebastian Reichel <sre@kernel.org> [140519 22:13]:
> > On Mon, May 19, 2014 at 10:05:15PM +0300, Tomi Valkeinen wrote:
> > > On 19/05/14 19:04, Tony Lindgren wrote:
> > > 
> > > > In many cases however we do have multiple compatible strings that
> > > > describe how the device is wired. See drivers/tty/serial/of_serial.c
> > > > for example. It has "ns16550" but then it also has additional
> > > > "nvidia,tegra20-uart", "nxp,lpc3220-uart" and "ibm,qpace-nwp-serial".
> > > 
> > > All those sound like SoC components. In that case it sounds fine to have
> > > the device compatible contain the SoC name. We're talking here about
> > > external, detachable devices.
> 
> Yes I agree it's also hackish. But playing with the compatible flags
> avoids adding other custom workarounds.
> 
> > > >>> Not use what you're after with the SPI example though, but sounds
> > > >>> like that's something different.
> > > >>
> > > >> I think Sebastien's example is just like the issue here.
> > > > 
> > > > Hmm is there some existing example in the kernel like that?
> > > 
> > > No, Sebastien's example was just a hypothetical case. Here, using your
> > > way of having SoC specific data in the .dts, we would have
> > > "sharp,ls037v7dw01-omap-dss", and in Sebastien's example with a touch
> > > sensor we'd have, say, "synaptics,xyz123-omap-spi".
> > 
> > Yes, that's what I wanted to say :)
> 
> Hmm I think we need to add few things to the hypothetical SPI case
> to get it even close to the panel example. Like assume that no SPI bus
> exists, [...]

The important thing is not, that there is an SPI bus (hardware), but
that there is a common SPI client framework (software). That's one
of the problem's I see with the modified compatible value.

Basically I see the following problem with the appended -omapdss in
the compatible string:

 * You can read the -omapdss as "to be used with omapdss driver". In
   this case the compatible string is just needed for driver loading,
   which is frowned upon DT binding maintainers AFAIK.
 * Alternatively one can read it as "connected to omapdss". In this
   case we add unneeded redundancy to the DT. This does not belong
   into a compatible string, since its encoded in the DT hierarchy.

And btw. Tomi's rewrite hack basically works exactly like this, just
without adding the redundancy explicitly into the DT. Instead of
prefixing the comaptible string he could also add a -omapdss sufix.
That's basically a proof, that the suffix adds useless redudancy.

> [...] and that potentially multiple different Synaptics drivers are
> trying to share the same compatible flag for a non-existing generic
> binding.

If there was no common SPI client framework you would need two
different SPI client drivers for two different SPI host controllers.

Obviously its a bad idea to have no SPI framework, but that's not
important for the example (except that there should obviously be a
common panel framework) :)

> I think then it's getting close to the panel example :)

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140520/e2215fab/attachment.sig>

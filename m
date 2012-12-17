From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 17 Dec 2012 20:41:47 +0100
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <20121217182911.GA10448@obsidianresearch.com>
References: <50C9056D.2050309@wwwdotorg.org>
 <20121213070332.GA9946@avionic-0098.adnet.avionic-design.de>
 <20121213080415.GA21178@obsidianresearch.com>
 <20121213082323.GA13620@avionic-0098.adnet.avionic-design.de>
 <50CA1A8D.9070504@wwwdotorg.org>
 <20121213204229.GC18597@avionic-0098.adnet.avionic-design.de>
 <20121214151045.GA22304@avionic-0098.adnet.avionic-design.de>
 <20121214172729.GA7671@obsidianresearch.com>
 <20121216123340.GB31780@avionic-0098.adnet.avionic-design.de>
 <20121217182911.GA10448@obsidianresearch.com>
Message-ID: <20121217194147.GA2767@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 17, 2012 at 11:29:11AM -0700, Jason Gunthorpe wrote:
> 
> > > Ie route access for 00:1N.0 to the configuration space on bridge port N
> > 
> > Is there any particular reason why you choose 0x10 as the base slot
> > for bridge ports? With the latest DT support patches, mapping this
> > should be even simpler as we associate a port index with each port
> > and the port array is gone.
> 
> No specific reason, it similar to what intel did and clearly shows the
> port number in a octet of the device id. It just can't be 0.

So I tried and implemented something along the lines of what you
suggested, and guess what? It does work indeed. For some reason even the
"imprecise external abort" goes away. Basically what I did is fake the
configuration space accesses to 0000:0.0 so that they return semi-valid
data. Nothing special yet, just basically returning vendor and product
ID, header type, class and other static data.

Initially the implementation was read-only and that still caused the
external abort, but adding nop'ed write functions apparently solved
that.

What I'll do next is add some caching of written values, so that reading
them back actually yields something correct. After that I'll post what I
have so that others can look at it or even reuse it.

The problem of matching DT nodes to the root ports still isn't solved,
but I'll take another look at that tomorrow.

> > > Then you are a bit closer. You should see both root port bridges
> > > appear in your lspci.. IIRC the host bridge device is not essential to
> > > discovery working on Linux.
> > 
> > The second port will probably still not appear, at least not in the
> > latest patches for DT support since it won't be registered unless
> > enabled. Even if enabled it will not be registered unless a link is
> > available, which it isn't in any of the setups that I currently have.
> > I'll need to check with our hardware engineers whether we can hook
> > something up to the second port.
> 
> You can probably bodge around and just register it anyhow, the
> internal bridge will still show up in linux, even though there is no
> device behind it.
> 
> I'm not sure if PCI-E ports should be ignored if the link is down. The
> kernel has the ability to re-scan them at runtime, and if the
> controller has a link up interrupt then it can happen automatically.
> 
> I sent through a patch for kirkwood that did this, we hot plug the
> PCIe device because userspace intializes it.

I don't think the root ports on Tegra support this. Or at least there's
no code to support it yet. I'll see if I can at least modify the code to
still show the root port on the bus if it is enabled but the link is not
available. The DT binding allows each port to be enabled so that if a
board configuration doesn't provide a physical connection the software
doesn't have to bother initializing it.
available.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121217/207850de/attachment-0001.sig>

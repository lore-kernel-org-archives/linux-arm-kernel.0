From: jacopo@jmondi.org (jacopo mondi)
Date: Tue, 5 Jun 2018 10:12:22 +0200
Subject: [PATCH v3 8/8] ARM: dts: rcar-gen2: Remove unused VIN properties
In-Reply-To: <20180605074938.mljwmgpjlplvkp2v@verge.net.au>
References: <1527606359-19261-1-git-send-email-jacopo+renesas@jmondi.org>
 <1527606359-19261-9-git-send-email-jacopo+renesas@jmondi.org>
 <20180604122325.GH19674@bigcity.dyn.berto.se>
 <20180605074938.mljwmgpjlplvkp2v@verge.net.au>
Message-ID: <20180605081222.GL10472@w540>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Tue, Jun 05, 2018 at 09:49:38AM +0200, Simon Horman wrote:
> On Mon, Jun 04, 2018 at 02:23:25PM +0200, Niklas S?derlund wrote:
> > Hi Jacopo,
> >
> > Thanks for your work.
> >
> > On 2018-05-29 17:05:59 +0200, Jacopo Mondi wrote:
> > > The 'bus-width' and 'pclk-sample' properties are not parsed by the VIN
> > > driver and only confuse users. Remove them in all Gen2 SoC that use
> > > them.
> > >
> > > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> >
> > The more I think about this the more I lean towards that this patch
> > should be dropped. The properties accurately describes the hardware and
> > I think there is value in that. That the driver currently don't parse or
> > make use of them don't in my view reduce there value. Maybe you should
> > break out this patch to a separate series?
>
> I also think there is value in describing the hardware not the state of the
> driver at this time.  Is there any missmatch between these properties and
> the bindings?

Niklas and I discussed a bit offline on this yesterday. My main
concern, and sorry for being pedant on this, is that changing those
properties value does not change the interface behaviour, and this
could cause troubles when integrating image sensor not known to be
working on the VIN interface.

This said, the documentation of those (and all other) properties is in the
generic "video-interfaces.txt" file and it is my understanding, but I think
Laurent and Rob agree on this as well from their replies to my previous series,
that each driver should list which properties it actually supports, as
some aspects are very implementation specific, like default values and
what happens if the property is not specified [1]. Nonetheless, all
properties describing hardware features and documented in the generic
file should be accepted in DTS, as those aims to be OS-independent and
even independent from the single driver implementation.

A possible middle-ground would be documenting in the VIN device tree
bindings description properties whose values actually affect the VIN
interface configuration and state in bindings that all generic properties
described in 'video-interfaces.txt' are valid ones but if not
explicitly listed there their value won't affect the interface
configuration. Niklas suggested this, and I quite like the fact it
makes clear that, say, changing the 'pclk-sample' property won't
change how the VIN interface would sample data but at the same time
allows for extensive description of the hardware.

Would something like this work in your opinion?

As a consequence, this patch should be dropped as Niklas and you
suggested.

Thanks
   j

[1] Ie. An interface that supports BT.656 encoding will use it if
'hsync-active' and 'vsync-active' are not specified. One that does not
support embedded synchronization would instead use defaults for those
two properties. This is specific to the single interface (or even the
single driver implementation actually) and should be listed in the single
driver's bindings description imo.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180605/5a7706b3/attachment.sig>

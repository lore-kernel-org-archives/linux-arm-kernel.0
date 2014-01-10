From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 10 Jan 2014 16:11:50 -0500
Subject: [PATCH v5 2/4] ARM: mvebu: Add quirk for i2c for the
 OpenBlocks AX3-4 board
In-Reply-To: <52D05365.3050309@free-electrons.com>
References: <1389193589-18485-1-git-send-email-gregory.clement@free-electrons.com>
 <1389193589-18485-3-git-send-email-gregory.clement@free-electrons.com>
 <20140110182240.GK19878@titan.lakedaemon.net>
 <20140110190521.GI18269@obsidianresearch.com>
 <20140110194550.GT19878@titan.lakedaemon.net>
 <52D05365.3050309@free-electrons.com>
Message-ID: <20140110211150.GW19878@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 10, 2014 at 09:09:09PM +0100, Gregory CLEMENT wrote:
> Hi Jason,
> 
> On 10/01/2014 20:45, Jason Cooper wrote:
> > On Fri, Jan 10, 2014 at 12:05:21PM -0700, Jason Gunthorpe wrote:
> >> On Fri, Jan 10, 2014 at 01:22:40PM -0500, Jason Cooper wrote:
> >>
> >>> Do we create new compatible strings to indicate errata, or to indicate
> >>> 'from this version forward there are new features'?  The former would
> >>> indicate as Gregory has written '...-a0-i2c', the latter would warrant
> >>> '...-b0-i2c' and disabling offloading if we don't see '...-b0-i2c'.
> > 
> > s/-b0-i2c'./-b0-i2c' or newer./
> > 
> >> IMHO the compatible string should represent a specific HW/SW ABI. So
> >> you need a unique compatible string for every variation of that ABI.
> > 
> > My concern is that we tend to do things like "marvell,orion-sata" for
> > the first version of the IP block we can work with.  orion5x, kirkwood,
> > dove, and armada 370/xp all use that compatible string to refer to that
> > IP block.
> > 
> > Given that we look at it as 'and newer', '...-a0-i2c' would mean no
> > offloading until we introduce '-b0-i2c'.  Or am I mis-understanding what
> > you're saying?
> > 
> >> We already have a compatible string defined for the ABI that B0
> >> presents.
> > 
> > So 'mv78230-i2c' is newer than 'mv78230-a0-i2c', or are you referring to
> > something else?
> 
> I think you put too much attention in the name.

Sure, I might be bikeshedding, but...

> There are just name referring a specific hardware. I don't think
> there is a consideration of order. For instance this driver also
> work with allwinner,sun4i-i2c, here we can clearly see that this
> compatible don't describe a newer or an older version of the device
> it just describe an "other" version.

No one has said "EPAPR requires compatible string heirarchies to be
handled as such."  Or, "EPAPR doesn't specify, so we choose to treat
them in such-and-such manner."

The point I'm trying to highlight in this case is that we aren't clear
on how we code compatible strings.  Yes, we use the most specific
compatible in the list, which is typically the first one.  What we
haven't cleared up is how to handle a newer IP with an older compatible
string.

eg: we boot an -a0 SoC, the dtb has the i2c node with most specific
compatible string 'mv78230-a0-i2c'.  Obviously, we disable offload.
What do we do with an older DTB which only has 'mv78230-i2c'? [see 1]

now we're running on a -b0 SoC.  We boot with a DTB that has a node
'mv78230-i2c'.  Is this an old DTB?  Or is this a new DTB written with
the understanding that -a0-i2c is an exception?  You see?  We aren't
being definitive.  The kernel really doesn't know for certain whether it
should enable offloading in this case or not.

[1] Yes, for Armada i2c, we can retrieve the CPU revision to wade out of
this grey area.  I'm just looking for clarification regarding the
general DT handling of this scenario.

I'm reluctant to push this series until I have an answer because the
answer will change the meaning of 'mv78230-i2c'.  Which *is* relevant to
this series.

Personally, I feel that since 'mv78230-i2c' has been used to refer to A0
revision of the IP, we should treat any nodes using it (as it's most
specific string) as having broken offloading.  Which implies that
-b0-i2c should be used to indicate IPs with working offloading.

I swear, I'm starting to feel like Russell...  Maybe I'm just grumpy
after crawling out from under my email backlog...

> About this whole series how do you plan to handle it?
> It was acked by Wolfram and even by Arnd.
> 
> This series is for fixing a bug so it should be part of the stable
> kernels including the 3.13. However we are so close to the release
> of the 3.13, that it seems to be too late.

Yes, it's a fix, and it'll get in.  It might be too late for v3.13, but
it'll get in to v3.13.1 (and the other appropriate stable kernels).  I
don't like to rush fixes just because of a pending merge window.

thx,

Jason.

> At least I hope it can be pushed to the arm-soc-next and be part of the
> 3.14-rc1. What do you think about it?
> 
> 
> Thanks,
> 
> Gregory
> 
> 
> > 
> > thx,
> > 
> > Jason.
> > 
> 
> 
> -- 
> Gregory Clement, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com

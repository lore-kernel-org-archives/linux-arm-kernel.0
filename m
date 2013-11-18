From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 18 Nov 2013 17:18:14 +0100
Subject: ARM topic: Is DT on ARM the solution, or is there something
 better?
In-Reply-To: <20131118161151.GG16735@n2100.arm.linux.org.uk>
References: <20131020231134.GR25034@n2100.arm.linux.org.uk>
 <20131021083242.GB30088@pengutronix.de>
 <20131021084854.GV25034@n2100.arm.linux.org.uk>
 <20131021092730.GF30088@pengutronix.de>
 <CAF6AEGtt_2sStiZCNBp9btxevWghSwLZZBdN6ir8eUpX1FXrCQ@mail.gmail.com>
 <20131024072811.GS30088@pengutronix.de>
 <CAF6AEGuEho9Ms7ifTE-EmBoQ-=_AXgvGcJxi5qEC0vsZ+H9C+A@mail.gmail.com>
 <20131118124518.GA16735@n2100.arm.linux.org.uk>
 <20131118153750.GM26046@ulmo.nvidia.com>
 <20131118161151.GG16735@n2100.arm.linux.org.uk>
Message-ID: <20131118161812.GP26046@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 18, 2013 at 04:11:51PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 18, 2013 at 04:37:51PM +0100, Thierry Reding wrote:
> > Very nice. This is in fact very similar to a skeleton I started to
> > implement locally. The names vary to some degree, but the general
> > approach is the same.
> > 
> > This also happens to be very similar to what Tegra DRM does, just as a
> > set of helpers rather than a bus type. I like it a lot.
> > 
> > In particular this gives every driver a good amount of flexibility to
> > implement the matching in a way that's appropriate. On hardware where
> > the relationships are hierarchical, a driver can use that to its
> > advantage. Whenever that's not possible it can be done using phandles
> > or any other meta data that fits the particular use-case.
> 
> Indeed - I set out to solve the following problems:
> 
> - How do we deal with a componentised device such that we can find all
>   of its component devices, and know when we have them all?
> - How can we probe the master device when we know we have all the
>   components?
> - How do we tear down the master device when one of the components is
>   removed?
> 
> I intentionally didn't want the code to answer the question about how
> we specify how the components are organised - that's a subject best
> left to the subsystem and/or device, since it's something which will
> most likely vary.
> 
> > Do you have a branch somewhere that I could use to test this with?
> 
> Not yet - and there probably won't be, because the code itself is not
> large - it's currently less than 500 lines.
> 
> The code has evolved over time - with imx-drm as a guinea pig.
> 
> The code which I have so far committed (and some people are using in
> patch form on the carrier-1 boards) is an earlier version, which just
> caters for proper init ordering and making it possible to unbind the
> "master" device.  It gets that init ordering by using deferred probing
> if there's no connectors, or the CRTCs which the connectors refer to
> are missing - it needs no changes to the DT representation.
> 
> Since then, I've augmented it as I described and that's currently just
> as an additional patch on top which adds the master device idea - which
> does need those additional changes.
> 
> Logically, it can't stay as two separate patches, because it won't be
> possible to "migrate" to it in stages.  So I'm fully intending to
> squash that all down to one patch which adds the core code (probably
> ultimately into drivers/base).
> 
> IOW, watch this space this week. :)

Will do! Thanks for doing this.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131118/7643954e/attachment-0001.sig>

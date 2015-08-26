From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 26 Aug 2015 13:51:50 +0200
Subject: [PATCH 1/7] drm/vc4: Add devicetree bindings for VC4.
In-Reply-To: <55CEC25E.7070303@wwwdotorg.org>
References: <1439427380-2436-1-git-send-email-eric@anholt.net>
 <1439427380-2436-2-git-send-email-eric@anholt.net>
 <55CEC25E.7070303@wwwdotorg.org>
Message-ID: <20150826115148.GB320@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 10:38:54PM -0600, Stephen Warren wrote:
> On 08/12/2015 06:56 PM, Eric Anholt wrote:
> > Signed-off-by: Eric Anholt <eric@anholt.net>
> 
> This one definitely needs a patch description, since someone might not
> know what a VC4 is, and "git log" won't show the text from the binding
> doc itself. I'd suggest adding the initial paragraph of the binding doc
> as the patch description, or more.
> 
> > diff --git a/Documentation/devicetree/bindings/gpu/brcm,bcm-vc4.txt b/Documentation/devicetree/bindings/gpu/brcm,bcm-vc4.txt
> 
> > +Required properties for VC4:
> > +- compatible:	Should be "brcm,vc4"
> > +- crtcs:	List of references to pixelvalve scanout engines
> 
> s/references to/phandles of/ would be more typical DT language.
> 
> > +- hvss:		List of references to HVS video scalers
> > +- encoders:	List of references to output encoders (HDMI, SDTV)
> 
> Would it make sense to make all those nodes child node of the vc4
> object. That way, there's no need to have these lists of objects; they
> can be automatically built up as the DT is enumerated. I know that e.g.
> the NVIDIA Tegra host1x binding works this way, and I think it may have
> been inspired by other similar cases.

Actually the host1x binding was the first of its kind. Unfortunately for
the purposes of this discussion (but fortunately otherwise) Tegra is the
odd-ball it seems. host1x is indeed a physical parent of all the devices
pertaining to the DRM driver, so the DT description is accurate from a
hardware point of view while at the same time giving us a top-level
device that we can bind against.

Now for most other cases it seems like the central piece that they are
missing is this top-level device, hence why the "virtual DRM subsystem
device" is instantiated. I tried to argue in the past that it wasn't a
proper description and proposed alternatives, but I was always pretty
much the only one with this viewpoint, so my comments ended up being
ignored.

Technically there is nothing that would prevent other drivers from doing
without the lists of phandles. On Tegra, again this might be special for
this particular hardware, we've never had a need to describe these kinds
of relationships. Each display controller can essentially drive each of
the outputs, which we deal with elegantly by setting the .possible_crtcs
mask of the encoders.

Also, to pull together all devices that are needed to make up the DRM
device, we use a list of compatible strings in the driver to find these
devices. Then as each of them registers with the host1x bus we wait for
the subdevice list to become empty and ->probe() the component host1x
device.

Note that while this predates component/master, this is all very similar
in principle (Russell and I did have some discussions about this back at
the time, but I'm not sure how much, if anything, he took as inspiration
from the host1x infrastructure). After component/master was merged I did
try to convert Tegra DRM to use it. Things looked pretty good, but ended
up not working because each componentized device must have a unique
master device. This poses a problem because on Tegra we needed the top-
level (i.e. master) device to be shared among multiple drivers.

I posted patches at some point to try and fix remedy the situation but
wasn't able to elicit any reactions, and since I had something that was
working did not pursue this any further.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150826/6ac61672/attachment.sig>

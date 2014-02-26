From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 26 Feb 2014 16:35:39 +0200
Subject: [PATCH 2/2] ARM: dts: duovero-parlor: Add HDMI output
In-Reply-To: <20140226132856.GB27282@n2100.arm.linux.org.uk>
References: <1393261669-32039-1-git-send-email-florian.vaussard@epfl.ch>
 <20140225123921.GY27282@n2100.arm.linux.org.uk>
 <20140225134139.GA23898@earth.universe> <2364124.7r818M0xAj@avalon>
 <20140225205634.GZ27282@n2100.arm.linux.org.uk> <530DCC8A.6060708@ti.com>
 <20140226120359.GA27282@n2100.arm.linux.org.uk> <530DE192.9030506@ti.com>
 <20140226132856.GB27282@n2100.arm.linux.org.uk>
Message-ID: <530DFBBB.9020309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/02/14 15:28, Russell King - ARM Linux wrote:
> On Wed, Feb 26, 2014 at 02:44:02PM +0200, Tomi Valkeinen wrote:
>>> Also - DRM is not going to ever support hotplugging components - this
>>> was discussed at kernel summit last year and David Airlie was quite
>>
>> Ok. Very odd stance. Maybe there's a reason for it that I just don't see.
> 
> DRM is like ALSA - it's a card level subsystem.  All components have
> to be present before the card level is brought up for the subsystem to
> function correctly.

Well, yes, at the moment. I don't know what his message was, but if it
was "DRM won't get hotplug, even if someone would do it properly", that
sounds just silly.

>> But if I'm not mistaken, it suffers from the problems above, when there
>> are multiple independent pipelines (simultaneous or non-simultaneous)
>> handled by the same IPs.
> 
> It may "suffer from the problems above" that you've raised, but that's
> by explicit design of it - because that's what subsystems like DRM and
> ALSA require, and this is _precisely_ the problem it's solving.
> 
> It's solving the "subsystem requires a stable view of hardware components,
> but we have multiple devices and drivers which need probing" problem.

And that's good. What I'd like to avoid is developers using the
component helpers, and designing the DT just for that use case,
preventing the use of a possible future framework.

The example in your component helper commit:

        imx-drm {
                compatible = "fsl,drm";
                crtcs = <&ipu1>;
                connectors = <&hdmi>;
        };

How would that be extended if one imx board has an external HDMI
encoder? Or maybe the board has an external HDMI encoder, and also a
separate level-shifter/ESD chip like some OMAP boards have. Or maybe a
board has two displays connected to one imx LCD output, and a GPIO is
used to switch between the used display.

Rephrasing: How would those DT bindings be extended to allow arbitrarily
long or complex display pipelines?

The proposed OMAP DSS and CDF DT bindings try to allow all the above cases.

So in my opinion, using component helpers is good, but it'd be important
to make sure the DT bindings for all platforms are future proof, and
also compatible so that we can share encoder/panel drivers.

>> And, while I may be mistaken, it sounds that the component helpers leave
>> mostly everything up to the display drivers. Everyone devising their own
>> way to describe the hardware in DT, and the connections between the
>> components. Of course, the core component system shouldn't define
>> anything DT related, as it doesn't. But that part is still needed, which
>> is where CDF comes in.
> 
> Sigh.  It's very easy for people to get the wrong end of the stick.
> 
> What the component helpers do is provide a _subsystem_ _independent_
> method of collecting a set of devices together and binding them to the
> drivers at an appropriate time, in a way that is _completely_ independent
> of whether you're using platform data, DT, ACPI, or whatever other
> hardware description language comes along.

Yep, that's what I meant with "Of course, the core component system
shouldn't define anything DT related, as it doesn't.". Maybe that's not
even English, so my bad =).

> It's up to the users of this to define how components are grouped
> together, whether that be at the subsystem level or at the driver
> level - whatever is appropriate.
> 
> If a subsystem (eg, a display subsystem) wants to define "this is how
> you define in DT the bindings between all components" and provide its
> own hook for the "add_components" callback which does this, then it's
> at liberty to do that.
> 
> If we can come up with a generic way to describe how all the components
> in a display subsystem should be connected together, then great - but
> that needs to happen very quickly.  Philipp Zabel is working on replacing
> the imx-drm binding method right now for 3.15, and is probably completely
> unaware of anything that's been talked about here.  I need to sort out

Yes, I just pinged him a few hours ago about this. I've been ill for a
few weeks, so I'm catching up on emails, but I want to sync with him
asap to see if the OMAP DSS side and his imx series have things in common.

> Armada DRM at some point to use the component stuff, which includes
> sorting out TDA998x for DT - which again needs to be done in such a way
> that it follows a common theme.

BeagleBoneBlack has TDA998x, so I'm also very interested in that.

>> So with hotplug, a new fbdev or a combination of drm crtcs, encoders,
>> etc, could appear even after the initial probe of the display controller.
> 
> This is the exact situation that David is opposed to.  DRM, like ALSA,
> whats to have a stable view of hardware - once the drm_device has been
> created and probed, no further changes to it are allowed.
> 
> Certainly no changes to the CRTCs will _ever_ be permitted, because it
> completely destroys the user API for referecing which encoders can be
> associated with which CRTCs - not only at the kernel level, but also the
> Xorg and Xrandr level too.  That's done via a bitmask of allowable CRTCs,
> where bit 0 refers to the first CRTC, bit 1 to the second and so on.
> That's propagated all the way through to userspace, right through the Xorg
> interfaces to applications.
> 
> Connectors and encoders are fixed at the moment after initial probe time
> in DRM due to the way the fbdev emulation layer works.  There's also issues
> there concerning bitmasks for which connectors can be cloned onto other
> connectors which follows the same pattern as above - and again, that
> propagates all the way through userspace.
> 
> So, if this is going to get fixed, there has to be a desire to break
> userspace quite badly, and there is no such desire to do that.
> 
> For instance, let's say that Xorg is up and running, and you have the
> gnome applet for configuring your display open, and you have two CRTCs.
> Then the first CRTC is removed from the system, resulting in CRTC 1
> becoming CRTC 0 in the kernel.  What happens...
> 
> Think the same thing through for a system with three connectors, A, B, C
> numbered 0, 1, and 2 respectively.  A and be cloned onto B.  Now connector
> A is removed, meaning B and C appear to become numbers 0 and 1 in the
> kernel...

I specifically said "hot-unplug not needed". Fbs, crtcs, etc. could only
appear, never to be removed individually. I don't see much benefit in
supporting hot-unplug, but I see much benefit with hot-plug. And I'm
sure there could be problems with only hot-plug, but I'd bet they are
much simpler if we never remove the components individually.

Usually, all the hot-plugging would happen before the rootfs is mounted.
However, it'd still be possible to load a display driver as a module
later, as long as any user (say, X) would be loaded after that.

Do you see that model as overly problematic, possibly breaking the
userspace API?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140226/f06a18a2/attachment-0001.sig>

From: treding@nvidia.com (Thierry Reding)
Date: Tue, 25 Aug 2015 12:40:01 +0200
Subject: [PATCH v3 06/14] Documentation: drm/bridge: add document for
 analogix_dp
In-Reply-To: <20150825092939.GM7557@n2100.arm.linux.org.uk>
References: <1439995728-18046-1-git-send-email-ykk@rock-chips.com>
 <1439995834-18363-1-git-send-email-ykk@rock-chips.com>
 <CAL_JsqLz+8RtBucctUj4euXZ3Ac0DvB52N9ONpAerh5T9BiTJg@mail.gmail.com>
 <20150824125758.GA7557@n2100.arm.linux.org.uk>
 <CAL_JsqKZYMMzV9Sc2r3K_rnM0FNuyb1TyJEhjGq1Hf7dTiWFKQ@mail.gmail.com>
 <20150825091246.GA14034@ulmo.nvidia.com>
 <20150825092939.GM7557@n2100.arm.linux.org.uk>
Message-ID: <20150825104000.GE14034@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 25, 2015 at 10:29:39AM +0100, Russell King - ARM Linux wrote:
> On Tue, Aug 25, 2015 at 11:12:48AM +0200, Thierry Reding wrote:
> > On Mon, Aug 24, 2015 at 09:48:27AM -0500, Rob Herring wrote:
> > > It goes beyond bindings IMO. The use of the component framework or not
> > > has been at the whim of driver writers as well. It is either used or
> > > private APIs are created. I'm using components and my need for it
> > > boils down to passing the struct drm_device pointer to the encoder.
> > > Other components like panels and bridges have different ways to attach
> > > to the DRM driver.
> > 
> > I certainly support unification, but it needs to be reasonable. There
> > are cases where a different structure for the binding work better than
> > another and I think this always needs to be evaluated on a case by case
> > basis.
> 
> It can't be a case-by-case basis.
> 
> The TDA998x encoder/connector is going to be component only.  This is
> a generic chip, which can be attached to the output of any parallel
> RGB+sync+clock bus.  In other words, it could appear anywhere.
> 
> Are you really saying that we need to support multiple schemes of
> attaching the driver to DRM?  That's totally insane IMHO.

No, what I'm saying is that we should have a single scheme, but one
that doesn't put any restrictions on what kind of DT binding you use or
how your driver is architected.

> The problem with the drm_encoder_slave stuff is that you can't sanely
> attach of-nodes to the drm-created i2c device.  Yes, you can parse
> them from the DT file as a sub-node of the upper device, but that
> then goes against the principle of the I2C bindings, which is to
> list the I2C devices as a child below the I2C adapter node.  If you
> try and put the DT node there, then the OF code will create the I2C
> device for you, and the drm_encoder_slave stuff won't have the
> control it needs to communicate through the wrapped i2c_driver
> stuff.
> 
> So, tda998x is going component-only, as that's the _only_ sane solution
> for it.

Has anyone ever considered turning it into a DRM bridge driver? I had
always envisioned component/master to be primarily useful to glue
together various SoC components to form one componentized device. Now
if tda998x is an I2C slave it is external to the SoC (auxiliary), so
in my opinion much better off as a bridge driver.

Bridge drivers don't come with any of the disadvantages that the
drm_encoder_slave stuff has. They are regular drivers that are probed
via their parent busses (I2C, platform, SPI, ...) and hook into DRM via
an abstract interface. The DT aspect is taken care of automatically
because they get instantiated by their parent bus like any other device.

> Now, what happens when some other DRM driver wants to use the tda998x
> driver, and its bindings are not compatible with the component helpers?
> They're pretty much stuck up the creek without a paddle.

I'm sure that will be very helpful response for whoever's going to end
up having to deal with that situation.

> Case by case doesn't work unless you're talking about truely isolated
> hardware where no one shares anything.

There are two different things here. The inter-driver interface, which,
in my opinion, it makes a lot of sense to standardize. Like I mentioned
above I think it unwise to make this interface depend upon a framework
or the firmware description such as DT in order to avoid unnecessary
restrictions. The second, orthogonal, issue, is the DT bindings. Those
I think should absolutely be designed case by case and select whatever
most accurately describes the hardware.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150825/de0cd192/attachment.sig>

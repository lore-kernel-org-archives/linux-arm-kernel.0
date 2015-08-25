From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 Aug 2015 10:29:39 +0100
Subject: [PATCH v3 06/14] Documentation: drm/bridge: add document for
 analogix_dp
In-Reply-To: <20150825091246.GA14034@ulmo.nvidia.com>
References: <1439995728-18046-1-git-send-email-ykk@rock-chips.com>
 <1439995834-18363-1-git-send-email-ykk@rock-chips.com>
 <CAL_JsqLz+8RtBucctUj4euXZ3Ac0DvB52N9ONpAerh5T9BiTJg@mail.gmail.com>
 <20150824125758.GA7557@n2100.arm.linux.org.uk>
 <CAL_JsqKZYMMzV9Sc2r3K_rnM0FNuyb1TyJEhjGq1Hf7dTiWFKQ@mail.gmail.com>
 <20150825091246.GA14034@ulmo.nvidia.com>
Message-ID: <20150825092939.GM7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 25, 2015 at 11:12:48AM +0200, Thierry Reding wrote:
> On Mon, Aug 24, 2015 at 09:48:27AM -0500, Rob Herring wrote:
> > It goes beyond bindings IMO. The use of the component framework or not
> > has been at the whim of driver writers as well. It is either used or
> > private APIs are created. I'm using components and my need for it
> > boils down to passing the struct drm_device pointer to the encoder.
> > Other components like panels and bridges have different ways to attach
> > to the DRM driver.
> 
> I certainly support unification, but it needs to be reasonable. There
> are cases where a different structure for the binding work better than
> another and I think this always needs to be evaluated on a case by case
> basis.

It can't be a case-by-case basis.

The TDA998x encoder/connector is going to be component only.  This is
a generic chip, which can be attached to the output of any parallel
RGB+sync+clock bus.  In other words, it could appear anywhere.

Are you really saying that we need to support multiple schemes of
attaching the driver to DRM?  That's totally insane IMHO.

The problem with the drm_encoder_slave stuff is that you can't sanely
attach of-nodes to the drm-created i2c device.  Yes, you can parse
them from the DT file as a sub-node of the upper device, but that
then goes against the principle of the I2C bindings, which is to
list the I2C devices as a child below the I2C adapter node.  If you
try and put the DT node there, then the OF code will create the I2C
device for you, and the drm_encoder_slave stuff won't have the
control it needs to communicate through the wrapped i2c_driver
stuff.

So, tda998x is going component-only, as that's the _only_ sane solution
for it.

Now, what happens when some other DRM driver wants to use the tda998x
driver, and its bindings are not compatible with the component helpers?
They're pretty much stuck up the creek without a paddle.

Case by case doesn't work unless you're talking about truely isolated
hardware where no one shares anything.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

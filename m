From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 04 Mar 2014 14:47:12 +0100
Subject: [RFC PATCH v4 3/8] staging: imx-drm: Document updated imx-drm
 device tree bindings
In-Reply-To: <53103C72.5030509@ti.com>
References: <1393338203-25051-1-git-send-email-p.zabel@pengutronix.de>
 <1393338203-25051-4-git-send-email-p.zabel@pengutronix.de>
 <530F1C4C.2010504@ti.com>
 <1393506385.4507.49.camel@paszta.hi.pengutronix.de>
 <20140227130020.GJ21483@n2100.arm.linux.org.uk> <530F43B9.800@ti.com>
 <1393520088.4507.92.camel@paszta.hi.pengutronix.de>
 <53103C72.5030509@ti.com>
Message-ID: <1393940832.3917.84.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomi,

Am Freitag, den 28.02.2014, 09:36 +0200 schrieb Tomi Valkeinen:
> On 27/02/14 18:54, Philipp Zabel wrote:
> 
> >> - One IPU enabled, one disabled: nothing special here, just set the
> >> other IPU to status="disabled" in the DT data. The driver for the
> >> enabled IPU would register the required DRM entities.
> > 
> > that should work. Let the enabled IPU create the imx-drm platform device
> > on probe, parse the device tree and ignore everything only hanging off
> > of the disabled IPU.
> 
> I think you misunderstood me a bit.
> 
> What I meant is that there's no need for imx-drm device at all, neither
> in the DT data or in the kernel side.

agreed about the DT node. But the drm_device must be associated with a
struct device. There is no reason to have the device representing the
whole display subsystem hang off of one IPU over the other, and I'd
rather not special case the IPU code with master/slave cases.

> There'd just be the DT nodes for the IPUs, which would cause the IPU
> platform devices to be created, and a driver for the IPU. So just like
> for any other normal platform device.

Except that one IPU has to create the drm_device and the other needs to
be drm_device-less.

> In the simplest cases, where only one IPU is enabled, or the IPUs want
> to be considered as totally independent, there'd be nothing special. The
> IPU driver would just register the drm entities.

[...]
> Here the slave IPU doesn't need to scan the graph at all. It just needs
> to make itself available somehow to the master. Maybe just by exported
> functions, or registering itself somewhere.
>
> Only the master IPU will scan the graph, and as all the entities are
> connected to the same graph, including the slave IPU, the master can
> find all the relevant nodes.

Somehow it needs to know whether it should create the component master
and drm_device, or just register as a slave component. I'd strongly
prefer to have a look at the graph over giving explicit "master;" or
"slave;" properties to the IPU device nodes for this single
Linux-specific reason.

[...]
> And I don't even know if the master-slave method I described is valid,
> although I don't see why it would not work. The master
> "display-subsystem" DT node does make sense to me in cases like this,
> where the IPUs need to be driven as a single unit.

which is a sensible default for i.MX6.

> > Did anybody propose such a generic term? How about:
> > 
> > -imx-drm {
> > -	compatible = "fsl,imx-drm";
> > -	ports = <&ipu1_di0>, <&ipu1_di1>;
> > -};
> > +display-subsystem {
> > +	compatible = "fsl,imx-display-subsystem";
> > +	ports = <&ipu1_di0>, <&ipu1_di1>;
> > +};
> 
> That sounds fine to me.
> 
> I wonder how it works if, say, there are 4 IPUs, and you want to run
> them in two pairs. In that case you need two of those display-subsystem
> nodes. But I guess it's just a matter of assigning a number for them
> with 'regs' property, and making sure the driver has nothing that
> prevents multiple instances of it.

Exactly. I'm not even sure it is necessary to assign a number.

[...]
> >> If that's not possible, then the drivers in question could have an
> >> option to enable or disable themselves, passed via the kernel command
> >> line, so that the user can select which subsystem to use.
> > 
> > That is the exact same problem as having multiple drivers that can bind
> > to the same device.
> 
> Hmm, sorry? Weren't we just discussing about that problem =). Or maybe I
> missed the original point from Russell, as the problem about DRM and
> fbdev conflicting sounded a bit unrelated.

I guess I missed it, though. Rereading the context, I am just
(re)stating that this is a problem beyond DRM and fbdev. Compiling a
kernel with two drivers binding to the same device, you effectively say
"whichever binds first, I don't care". To change this, we'd need
something similar to module blacklists for non-modular builds. I'd
rather strive to remove the need for duplicate drivers in the kernel.

regards
Philipp

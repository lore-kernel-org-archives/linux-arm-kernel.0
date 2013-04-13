From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Sat, 13 Apr 2013 23:45:39 +0200
Subject: Latest randconfig build errors
In-Reply-To: <CAF6AEGv=3453KKS9-8YAgHrxMMbNvLMvt0pz-=qdG+zcd-Trrw@mail.gmail.com>
References: <20130304095136.GI17833@n2100.arm.linux.org.uk>
 <20130304184649.GO11806@atomide.com>
 <CAF6AEGv=3453KKS9-8YAgHrxMMbNvLMvt0pz-=qdG+zcd-Trrw@mail.gmail.com>
Message-ID: <20130413214539.GA32613@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 13, 2013 at 08:54:22AM -0400, Rob Clark wrote:
> On Mon, Mar 4, 2013 at 1:46 PM, Tony Lindgren <tony@atomide.com> wrote:
> >
> >> drivers/gpu/drm/tilcdc/tilcdc_slave.o:(.data+0x54): multiple definition of `__mod_of_device_table'
> >> drivers/gpu/drm/tilcdc/tilcdc_tfp410.o:(.data+0x54): first defined here
> >> drivers/gpu/drm/tilcdc/tilcdc_panel.o:(.data+0x54): multiple definition of `__mod_of_device_table'
> >> drivers/gpu/drm/tilcdc/tilcdc_tfp410.o:(.data+0x54): first defined here
> >> drivers/gpu/drm/tilcdc/tilcdc_drv.o:(.data+0x184): multiple definition of `__mod_of_device_table'
> >> drivers/gpu/drm/tilcdc/tilcdc_tfp410.o:(.data+0x54): first defined here
> >
> > Rob, I assume you'll do a patch for this one?
> 
> 
> oh, I apologize for the late reply, I didn't see this email...
> 
> There is a patch that we can merge to make tilcdc bool instead of
> tristate[1], which I suppose is ok for a temporary fix.  Although I'm
> all-ears if someone has a better idea about how to fix this.  The
> problem is that we have multiple sub-devices for different possible
> panel drivers, so that depending on DT tables, the correct ones get
> loaded for the hw.  But they are all built into a single module.
> Splitting them into multiple modules will be problematic, as panel
> drivers which are present really need to get probed before the
> toplevel drm device..

You could look at the Tegra driver. I had to solve a similar problem
there. What I did is basically parse the DT in the host1x driver and add
all device nodes which are required by DRM to a list. Later when the
individual devices are probed they are removed from that list, so that
when the list becomes empty we are sure that all required devices are
there and only then call the drm_platform_init() function.

This fits very well with how Tegra hardware is designed because host1x
is the parent for all DRM subdevices (DC, RGB/LVDS, HDMI, ...). So it is
probed before any of its children and it can easily parse the DT upfront
and initialize the list of required devices.

> I suppose in theory it is possible to make drm
> cope better with dynamically loaded outputs, but I'm not sure that
> there is any way to do this without breaking userspace which expects
> that all of the connectors/encoders are present once the drm device is
> loaded.

I had been thinking about this on and off for a while, but I haven't
come up with anything concrete. Ideally we could just have some kind of
event that userspace would listen for, so that new outputs can be
dynamically added and userspace informed about them. Last time I checked
most of the helpers assumed that the complete output configuration is
known when the DRM device is registered, so some major rework will be
required to efficiently make use of such dynamicity.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130413/e0117fe8/attachment.sig>

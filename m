From: tony@atomide.com (Tony Lindgren)
Date: Sun, 1 Oct 2017 14:03:45 -0700
Subject: [PATCH 1/7] dt-bindings: bus: Minimal TI sysc interconnect
 target module binding
In-Reply-To: <20171001204834.kqc6fgfo7dx6m7rn@earth>
References: <20170929223411.9691-1-tony@atomide.com>
 <20170929223411.9691-2-tony@atomide.com>
 <20171001131151.loanjnvarkihbhik@earth>
 <20171001171406.GL4394@atomide.com>
 <20171001204834.kqc6fgfo7dx6m7rn@earth>
Message-ID: <20171001210345.GM4394@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sebastian Reichel <sre@kernel.org> [171001 13:49]:
> Hi,
> 
> On Sun, Oct 01, 2017 at 10:14:07AM -0700, Tony Lindgren wrote:
> > * Sebastian Reichel <sre@ring0.de> [171001 06:12]:
> > > On Fri, Sep 29, 2017 at 03:34:05PM -0700, Tony Lindgren wrote:
> > > > Note that additional properties for sysc capabilities will be added
> > > > later on. For now, we can already use this binding for interconnect
> > > > target modules that do not have any child device drivers available.
> > > > This allows us to idle the unused interconnect target modules during
> > > > init without the need for legacy hwmod platform data for doing it.
> > > 
> > > DT backwards compatibility is about booting an old DT file with a
> > > newer kernel. Since old DT file does not contain a "ti,sysc-omap*"
> > > node you don't need to add "ti,hwmod = *" support to it. Instead a
> > > DT file, that uses ti,hwmod in the device node and does not have a
> > > "ti,sysc-omap*" at all should still work.
> > 
> > Not sure if I parse that right, but I'm assuming you suggest leaving
> > out ti,hwmod to start with. Well I considered that, but it causes
> > the "waiting for a magical flip issue". So initially we need to use
> > both ti,sysc and ti,hwmod until ti,sysc alone has the equal
> > functionality. That's because then we can do the following steps:
> > 
> > 1. We want to add compatible = ti,sysc so we can define the
> >    nodes and get the parent-children hierarhcy right. We can
> >    already use the parent-child features even with ti,hwmods
> >    before we have complete dts based data. We are currently
> >    missing that capability without doing device specific parent
> >    drivers like we do with drivers/usb/musb/musb_am335x.c. Note
> >    that in this step we are moving the ti,hwmod to the parent
> >    node
> > 
> > 2. When ti,sysc can configure things based on dts data alone the
> >    same way as the legacy platform data, we can just drop the
> >    ti,hwmod property. We also want to be able to test one driver
> >    at a time between ti,sysc + ti,hwmod vs ti,sysc only
> > 
> > 3. Once ti,hwmod properties have been removed from the mainline
> >    kernel, we can add a warning about ti,hwmod properties being
> >    deprecated
> > 
> > 4. Then later on, we can also drop the hwmod platform data and
> >    continue produce warnings if ti,hwmod is seen
> 
> Ok, I misunderstood the reason for keeping/adding "ti,hwmod".
> I thought it was only about keeping backwards compatibility, but
> it's still required since hwmod is only partially converted to DT
> by this patchset.

OK

> That basically means, that this patchset breaks DT ABI *now*, since
> old DT has no ti,sysc node?

Nope, things still keep working as they are with and without
ti,sysc :)

Regards,

Tony

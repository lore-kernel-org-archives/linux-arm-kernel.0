From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 10 Sep 2009 15:05:51 +0200 (CEST)
Subject: What's inside the pxa tree for this merge window
In-Reply-To: <20090910124401.GW9410@buzzloop.caiaq.de>
References: <f17812d70909100446h17a1903fy74941945dbfc6943@mail.gmail.com>
	<20090910115439.GU9410@buzzloop.caiaq.de>
	<f17812d70909100523l5936e11bpd41354aed622d480@mail.gmail.com>
	<20090910123218.GV9410@buzzloop.caiaq.de>
	<f17812d70909100535r36b62ad5r2c32e2dcecba0c93@mail.gmail.com>
	<20090910124401.GW9410@buzzloop.caiaq.de>
Message-ID: <Pine.LNX.4.64.0909101459370.4458@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Sep 2009, Daniel Mack wrote:

> On Thu, Sep 10, 2009 at 08:35:51PM +0800, Eric Miao wrote:
> > On Thu, Sep 10, 2009 at 8:32 PM, Daniel Mack <daniel@caiaq.de> wrote:
> > > Hmm, I'd say you don't want fb.fix.accel set unless the driver is
> > > enabled, right?
> > >
> > 
> > I'm not sure if it can be set anyway without the driver being
> > built.
> 
> DirectFB userspace applications take that value to decide whether to
> enable the acceleration driver or go for software fallbacks. If that
> field is set, the kernel is expected to come along with the driver
> interface.
> 
> Hence, it should really only be set if the driver is enabled, otherwise
> the userspace logic breaks.
> 
> > I mean - I don't want Kconfig option to cross modules.
> 
> I agree, and it would be even better to only set that field in case the
> driver has actually been probed (and not just enabled in the kernel
> config). But I see no clean way to do that - the gcu driver has no
> access to the framebuffer driver and its data structs either.

Yeah, that doesn't look pretty. Maybe add a field to struct 
pxafb_mach_info? You can put its assignment in respective platform data 
instances under an #ifdef - that's more acceptable, IMHO. Of course, it is 
still worse than beeing able to switch this at run-time. But you could 
trick by setting that field at run-time if acceleration is available, 
provided you have that info before pxafb initialises. Also consider, there 
might be more PXA SoCs in the future using pxafb and providing hardware 
acceleration.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

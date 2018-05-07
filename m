From: daniel@ffwll.ch (Daniel Vetter)
Date: Mon, 7 May 2018 15:53:41 +0200
Subject: [PATCH v2 26/26] drm/bridge: establish a link between the bridge
 supplier and consumer
In-Reply-To: <4cdcd215-8caf-e045-a478-f438f128c9f2@samsung.com>
References: <20180504135212.26977-1-peda@axentia.se>
 <CGME20180504135358epcas3p2bd9c2f5c9a8295152f2c96fdbb2ea8b1@epcas3p2.samsung.com>
 <20180504135212.26977-27-peda@axentia.se>
 <4cdcd215-8caf-e045-a478-f438f128c9f2@samsung.com>
Message-ID: <20180507135341.GI12521@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 07, 2018 at 02:59:45PM +0200, Andrzej Hajda wrote:
> On 04.05.2018 15:52, Peter Rosin wrote:
> > If the bridge supplier is unbound, this will bring the bridge consumer
> > down along with the bridge. Thus, there will no longer linger any
> > dangling pointers from the bridge consumer (the drm_device) to some
> > non-existent bridge supplier.
> 
> I understand rationales behind this patch, but it is another step into
> making drm_dev one big driver with subcomponents, where drm will work
> only if every subcomponent is working/loaded. Do we need to go this way?
> In case of many platforms such approach results in display turned on
> very late on boot for example due to late initialization of some
> regulator exposed by some i2c device, which is used by hdmi bridge. And
> this hdmi bridge is just to provide alternative(rarely used) display
> path, the main display path would work anyway.
> 
> So the main question to drm maintainers is about evolution of bridges,
> if drm_bridges should become mandatory components of drm device or they
> could be added/removed dynamically?

This is already the case. You currently cannot hotplug a drm_bridge,
everything must be present. I don't think it makes sense to change that
until we have physically hotpluggable drm_bridges in real hardware. I
definitely don't want to refcount stuff to work around driver load
bonghits on DT platforms, because refcounting is way too hard to get right
:-)

Afaik there's out-of-tree patches to solve 99% of the driver load fun on
DT platforms, but because it's not a 100% solution it's blocked since
forever.
-Daniel

> 
> Regards
> Andrzej
> 
> 
> >
> > Signed-off-by: Peter Rosin <peda@axentia.se>
> > ---
> >  drivers/gpu/drm/drm_bridge.c | 18 ++++++++++++++++++
> >  include/drm/drm_bridge.h     |  2 ++
> >  2 files changed, 20 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> > index 78d186b6831b..0259f0a3ff27 100644
> > --- a/drivers/gpu/drm/drm_bridge.c
> > +++ b/drivers/gpu/drm/drm_bridge.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/mutex.h>
> >  
> >  #include <drm/drm_bridge.h>
> > +#include <drm/drm_device.h>
> >  #include <drm/drm_encoder.h>
> >  
> >  #include "drm_crtc_internal.h"
> > @@ -127,12 +128,25 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
> >  	if (bridge->dev)
> >  		return -EBUSY;
> >  
> > +	if (encoder->dev->dev != bridge->odev) {
> > +		bridge->link = device_link_add(encoder->dev->dev,
> > +					       bridge->odev, 0);
> > +		if (!bridge->link) {
> > +			dev_err(bridge->odev, "failed to link bridge to %s\n",
> > +				dev_name(encoder->dev->dev));
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> >  	bridge->dev = encoder->dev;
> >  	bridge->encoder = encoder;
> >  
> >  	if (bridge->funcs->attach) {
> >  		ret = bridge->funcs->attach(bridge);
> >  		if (ret < 0) {
> > +			if (bridge->link)
> > +				device_link_del(bridge->link);
> > +			bridge->link = NULL;
> >  			bridge->dev = NULL;
> >  			bridge->encoder = NULL;
> >  			return ret;
> > @@ -159,6 +173,10 @@ void drm_bridge_detach(struct drm_bridge *bridge)
> >  	if (bridge->funcs->detach)
> >  		bridge->funcs->detach(bridge);
> >  
> > +	if (bridge->link)
> > +		device_link_del(bridge->link);
> > +	bridge->link = NULL;
> > +
> >  	bridge->dev = NULL;
> >  }
> >  
> > diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> > index b656e505d11e..804189c63a4c 100644
> > --- a/include/drm/drm_bridge.h
> > +++ b/include/drm/drm_bridge.h
> > @@ -261,6 +261,7 @@ struct drm_bridge_timings {
> >   * @list: to keep track of all added bridges
> >   * @timings: the timing specification for the bridge, if any (may
> >   * be NULL)
> > + * @link: drm consumer <-> bridge supplier
> >   * @funcs: control functions
> >   * @driver_private: pointer to the bridge driver's internal context
> >   */
> > @@ -271,6 +272,7 @@ struct drm_bridge {
> >  	struct drm_bridge *next;
> >  	struct list_head list;
> >  	const struct drm_bridge_timings *timings;
> > +	struct device_link *link;
> >  
> >  	const struct drm_bridge_funcs *funcs;
> >  	void *driver_private;
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

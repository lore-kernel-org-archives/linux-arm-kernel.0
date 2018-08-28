From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Aug 2018 19:14:31 +0100
Subject: [PATCH v4 7/8] drm/i2c: tda998x: register as a drm bridge
In-Reply-To: <d7810203-77da-deae-8edd-c93c36096917@axentia.se>
References: <20180424080833.GJ16141@n2100.armlinux.org.uk>
 <8448e90a-4562-b564-c160-1b5c67e0f92f@axentia.se>
 <0cbee3bd-8987-5f2f-519d-f8d1b426f2a3@ti.com>
 <20180424170625.GL16141@n2100.armlinux.org.uk>
 <b7a7ffb6-b282-cbc5-435e-9ca1cd405e33@ti.com>
 <20180424232523.GN16141@n2100.armlinux.org.uk>
 <7e8cdcf6-c816-1e01-24f1-a526fb0a591f@ti.com>
 <20180706100346.GV17271@n2100.armlinux.org.uk>
 <20180706124305.GX17271@n2100.armlinux.org.uk>
 <d7810203-77da-deae-8edd-c93c36096917@axentia.se>
Message-ID: <20180828181430.GI30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 07:49:28PM +0200, Peter Rosin wrote:
> On 2018-07-06 14:43, Russell King - ARM Linux wrote:
> > On Fri, Jul 06, 2018 at 11:03:46AM +0100, Russell King - ARM Linux wrote:
> >> On Wed, Apr 25, 2018 at 11:01:15PM +0300, Jyri Sarha wrote:
> >>> Oh yes. But in this case the substandard solution is already there and
> >>> it is already widely used, despite it being severely broken. I am merely
> >>> trying to fix the existing substandard solution.
> >>>
> >>> I admit that a full integration with component helpers would probably be
> >>> more elegant solution to the problem, but the amount of work is just too
> >>> much. The change would impact the way all the master drm drivers pull
> >>> them selves together. The drivers that already use the component helpers
> >>> for some internal stuff will add their own challenge. Separate component
> >>> matching implementations are needed for device-tree and ACPI (are ther
> >>> more flavors?) etc. I just do not see this happening any time soon (am
> >>> happy to be wrong about this).
> >>
> >> The issue is actually worse than that:
> >>
> >> - drivers that are already componentised can't use bridges
> >> - drivers that use bridges can't use componentised stuff
> >>
> >> because bridges don't register themselves with the component helper,
> >> and the helpers in drm_of.c assume that all graph nodes will be
> >> components.
> >>
> >> The whole thing about whether stuff is componentised or bridge based
> >> is really getting out of hand, and the push is towards bridge based
> >> stuff even though that is technically inferior when it comes to being
> >> able to develop and test (which involves being able to remove and
> >> re-insert modules.)
> >>
> >> Consequently more and more code is being written for bridges, and
> >> the component helper ignored, and the problems with bridges are
> >> being ignored.  This is not healthy.
> >>
> >> The problem is only going to get worse.  Someone needs to bite the
> >> bullet and fix bridges before the problem gets any more out of hand.
> > 
> > This patch (which is actually two patches locally) allows the component
> > helper to know what's going on inside the bridge code wrt bridge
> > availability, and takes the appropriate action at the correct time.
> > No need for device links or similar, or incompatibilities between
> > bridges and components.  The only requirement is that bridges set the
> > "device" member of struct drm_bridge to opt-in to this.
> > 
> > Tested with Armada converted to support bridges, TDA998x as a
> > componentised bridge, and dumb-vga-dac as a non-componentised bridge:
> > 
> > root at cubox:~# less /sys/kernel/debug/device_component/display-subsystem
> > master name                                            status
> > -------------------------------------------------------------
> > display-subsystem                                       bound
> > 
> > device name                                            status
> > -------------------------------------------------------------
> > port                                               registered
> > port                                               registered
> > hdmi-encoder                                       registered
> > vga-bridge                                         registered
> > root at cubox:~# dmesg |grep bound
> > [    1.921798] armada-drm display-subsystem: bound f1820000.lcd-controller (ops
> > armada_lcd_ops)
> > [    1.931014] armada-drm display-subsystem: bound f1810000.lcd-controller (ops
> > armada_lcd_ops)
> > [    2.069231] armada-drm display-subsystem: bound 1-0070 (ops tda998x_ops)
> > [    2.076059] armada-drm display-subsystem: bound vga-bridge (ops dummy_ops)
> > 
> > Without this, the same DT fails because "vga-bridge" is never added
> > to the component helpers.
> 
> What did you need to do to convert Armada to support bridges? How much
> work is it to convert drivers that support bridges so that they
> support components? Maybe that's not needed? What happens with tda998x?
> I mean, it already calls component_add, and with this there's an
> indirect call in drm_bridge_add which it also calls. I guess I'm asking
> if a component may call component_add several times without things
> sliding sideways?

The difference with tda998x is that with the code below (as it stood
in an earlier revision of the bridge code, when we had a separate
bridge->of_node member), bridge->device is not set for the tda998x,
which avoids the duplicated component_add() - which would be illegal
(and cause problems.)

However, I also hacked tda998x to make tda998x_bind() a no-op - without
such a hack, the DRM driver needs to know whether the bridge is tda998x
or not, so it knows whether it needs to create the encoder.

I don't think there's any simple, non-hacky solution to this problem.

> 
> > 
> > diff --git a/drivers/base/component.c b/drivers/base/component.c
> > index 8946dfee4768..b14b3a3655ea 100644
> > --- a/drivers/base/component.c
> > +++ b/drivers/base/component.c
> > @@ -602,4 +602,32 @@ void component_del(struct device *dev, const struct component_ops *ops)
> >  }
> >  EXPORT_SYMBOL_GPL(component_del);
> >  
> > +static int component_dummy_bind(struct device *comp, struct device *master,
> > +				void *master_data)
> > +{
> > +	return 0;
> > +}
> > +
> > +static void component_dummy_unbind(struct device *comp, struct device *master,
> > +				   void *master_data)
> > +{
> > +}
> > +
> > +static const struct component_ops dummy_ops = {
> > +	.bind = component_dummy_bind,
> > +	.unbind = component_dummy_unbind,
> > +};
> > +
> > +int component_mark_available(struct device *dev)
> > +{
> > +	return component_add(dev, &dummy_ops);
> > +}
> > +EXPORT_SYMBOL_GPL(component_mark_available);
> > +
> > +void component_mark_unavailable(struct device *dev)
> > +{
> > +	component_del(dev, &dummy_ops);
> > +}
> > +EXPORT_SYMBOL_GPL(component_mark_unavailable);
> > +
> 
> Is this really needed in component.c? I'd say that these dummy
> bridge_component_bind/unbind can be added directly in drm_bridge.c
> and that the new call to component_mark_available in drm_bridge
> could simply be component_add(bridge->device, &bridge_component_ops)
> (etc)

What if other subsystems want this functionality?  IMHO, it belongs
in the component layer, not in other subsystems where it could end
up being duplicated.

> >  MODULE_LICENSE("GPL v2");
> > diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> > index 1638bfe9627c..ce3ccd327916 100644
> > --- a/drivers/gpu/drm/drm_bridge.c
> > +++ b/drivers/gpu/drm/drm_bridge.c
> > @@ -21,6 +21,7 @@
> >   * DEALINGS IN THE SOFTWARE.
> >   */
> >  
> > +#include <linux/component.h>
> >  #include <linux/err.h>
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> > @@ -73,6 +74,9 @@ void drm_bridge_add(struct drm_bridge *bridge)
> >  	mutex_lock(&bridge_lock);
> >  	list_add_tail(&bridge->list, &bridge_list);
> >  	mutex_unlock(&bridge_lock);
> > +
> > +	if (bridge->device)
> > +		WARN_ON(component_mark_available(bridge->device));
> >  }
> >  EXPORT_SYMBOL(drm_bridge_add);
> >  
> > @@ -83,6 +87,9 @@ EXPORT_SYMBOL(drm_bridge_add);
> >   */
> >  void drm_bridge_remove(struct drm_bridge *bridge)
> >  {
> > +	if (bridge->device)
> > +		component_mark_unavailable(bridge->device);
> > +
> >  	mutex_lock(&bridge_lock);
> >  	list_del_init(&bridge->list);
> >  	mutex_unlock(&bridge_lock);
> > diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> > index 3270fec46979..e863da14d4d9 100644
> > --- a/include/drm/drm_bridge.h
> > +++ b/include/drm/drm_bridge.h
> > @@ -268,6 +268,7 @@ struct drm_bridge {
> >  	struct drm_device *dev;
> >  	struct drm_encoder *encoder;
> >  	struct drm_bridge *next;
> > +	struct device *device;
> 
> In patch [1] i add struct device *odev (for owner device) and the series
> then proceeds to convert all bridges to add a link to its owner device
> and to then remove the (below) of_node member.
> 
> [1] https://lkml.org/lkml/2018/5/16/382
> 
> Would it be bad if all bridges opted in to this? In other words, could
> my "odev" and your "device" be shared?

No (see my explanation above about duplicate registrations not being
permitted.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up

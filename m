From: daniel@ffwll.ch (Daniel Vetter)
Date: Wed, 16 May 2018 11:31:10 +0200
Subject: [PATCH v2 26/26] drm/bridge: establish a link between the bridge
 supplier and consumer
In-Reply-To: <f8215ba1-4cdb-69b9-39ff-68feca3ec502@axentia.se>
References: <20180504135212.26977-1-peda@axentia.se>
 <CGME20180504135432epcas3p368bb7541ca52bc8bc301dec794851214@epcas3p3.samsung.com>
 <20180504135212.26977-27-peda@axentia.se>
 <a723ad4a-8caa-4ff5-d39d-52db98a56d7b@samsung.com>
 <c25f81e0-5b7b-c605-5b58-0ecc88830124@axentia.se>
 <20180514162828.GE28661@phenom.ffwll.local>
 <73fa1ca3-28e4-96c5-1fc6-23e9c0cebb49@axentia.se>
 <CAKMK7uECSUo5k6uG3-y+yKQTGxB3FfGcwzMT+ZP5uux2SbpfUg@mail.gmail.com>
 <f8215ba1-4cdb-69b9-39ff-68feca3ec502@axentia.se>
Message-ID: <20180516093110.GC3438@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2018 at 01:09:59PM +0200, Peter Rosin wrote:
> On 2018-05-15 12:22, Daniel Vetter wrote:
> > On Mon, May 14, 2018 at 10:40 PM, Peter Rosin <peda@axentia.se> wrote:
> >> On 2018-05-14 18:28, Daniel Vetter wrote:
> >>> On Fri, May 11, 2018 at 09:37:47AM +0200, Peter Rosin wrote:
> >>>> On 2018-05-10 10:10, Andrzej Hajda wrote:
> >>>>> On 04.05.2018 15:52, Peter Rosin wrote:
> >>>>>> If the bridge supplier is unbound, this will bring the bridge consumer
> >>>>>> down along with the bridge. Thus, there will no longer linger any
> >>>>>> dangling pointers from the bridge consumer (the drm_device) to some
> >>>>>> non-existent bridge supplier.
> >>>>>>
> >>>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
> >>>>>> ---
> >>>>>>  drivers/gpu/drm/drm_bridge.c | 18 ++++++++++++++++++
> >>>>>>  include/drm/drm_bridge.h     |  2 ++
> >>>>>>  2 files changed, 20 insertions(+)
> >>>>>>
> >>>>>> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> >>>>>> index 78d186b6831b..0259f0a3ff27 100644
> >>>>>> --- a/drivers/gpu/drm/drm_bridge.c
> >>>>>> +++ b/drivers/gpu/drm/drm_bridge.c
> >>>>>> @@ -26,6 +26,7 @@
> >>>>>>  #include <linux/mutex.h>
> >>>>>>
> >>>>>>  #include <drm/drm_bridge.h>
> >>>>>> +#include <drm/drm_device.h>
> >>>>>>  #include <drm/drm_encoder.h>
> >>>>>>
> >>>>>>  #include "drm_crtc_internal.h"
> >>>>>> @@ -127,12 +128,25 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
> >>>>>>    if (bridge->dev)
> >>>>>>            return -EBUSY;
> >>>>>>
> >>>>>> +  if (encoder->dev->dev != bridge->odev) {
> >>>>>
> >>>>> I wonder why device_link_add does not handle this case (self dependency)
> >>>>> silently as noop, as it seems to be a correct behavior.
> >>>>
> >>>> It's kind-of a silly corner-case though, so perfectly understandable
> >>>> that it isn't handled.
> >>>>
> >>>>>> +          bridge->link = device_link_add(encoder->dev->dev,
> >>>>>> +                                         bridge->odev, 0);
> >>>>>> +          if (!bridge->link) {
> >>>>>> +                  dev_err(bridge->odev, "failed to link bridge to %s\n",
> >>>>>> +                          dev_name(encoder->dev->dev));
> >>>>>> +                  return -EINVAL;
> >>>>>> +          }
> >>>>>> +  }
> >>>>>> +
> >>>>>>    bridge->dev = encoder->dev;
> >>>>>>    bridge->encoder = encoder;
> >>>>>>
> >>>>>>    if (bridge->funcs->attach) {
> >>>>>>            ret = bridge->funcs->attach(bridge);
> >>>>>>            if (ret < 0) {
> >>>>>> +                  if (bridge->link)
> >>>>>> +                          device_link_del(bridge->link);
> >>>>>> +                  bridge->link = NULL;
> >>>>>>                    bridge->dev = NULL;
> >>>>>>                    bridge->encoder = NULL;
> >>>>>>                    return ret;
> >>>>>> @@ -159,6 +173,10 @@ void drm_bridge_detach(struct drm_bridge *bridge)
> >>>>>>    if (bridge->funcs->detach)
> >>>>>>            bridge->funcs->detach(bridge);
> >>>>>>
> >>>>>> +  if (bridge->link)
> >>>>>> +          device_link_del(bridge->link);
> >>>>>> +  bridge->link = NULL;
> >>>>>> +
> >>>>>>    bridge->dev = NULL;
> >>>>>>  }
> >>>>>>
> >>>>>> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> >>>>>> index b656e505d11e..804189c63a4c 100644
> >>>>>> --- a/include/drm/drm_bridge.h
> >>>>>> +++ b/include/drm/drm_bridge.h
> >>>>>> @@ -261,6 +261,7 @@ struct drm_bridge_timings {
> >>>>>>   * @list: to keep track of all added bridges
> >>>>>>   * @timings: the timing specification for the bridge, if any (may
> >>>>>>   * be NULL)
> >>>>>> + * @link: drm consumer <-> bridge supplier
> >>>>>
> >>>>> Nitpick: "<->" suggests symmetry, maybe "device link from drm consumer
> >>>>> to the bridge" would be better.
> >>>>
> >>>> I meant "<->" to indicate that the link is bidirectional, not that the
> >>>> relationship is in any way symmetric. I wasn't aware of any implication
> >>>> of a symmetric relationship when using "<->", do you have a reference?
> >>>> But I guess the different arrow notations in math are somewhat overloaded
> >>>> and that someone at some point must have used "<->" to indicate a
> >>>> symmetric relationship...
> >>>
> >>> Yeah I agree with Andrzej here, for me <-> implies a symmetric
> >>> relationship. Spelling it out like Andrzej suggested sounds like the
> >>> better idea.
> >>> -Daniel
> >>
> >> Ok, I guess that means I have to do a v3 after all. Or can this
> >> trivial documentation update be done by the committer? I hate to
> >> spam everyone with another volley...
> >>
> >> Or perhaps I should squash patches 2-23 that are all rather similar
> >> and mechanic? I separated them to allow for easier review from
> >> individual driver maintainers, but that didn't seem to happen
> >> anyway...
> > 
> > Do another volley of the full set, or in-reply-to to just replace the
> > patch that needs to be respun (but some people don't like that).
> > 
> > When resending just make sure you're picking up all the acks/r-bs you
> > have already.
> 
> Right, I always try to do that. One Ack that I did not include in v2
> was the one you had on v1 24/24 (i.e. this patch). The reason I did
> not add your Ack for v2 even on the patch where it obviously applied
> was that I didn't know if you'd barf on the odev name.
> 
> But it was (and still is) a bit unclear if that was on Ack on the
> last patch only, or if it was for the whole series? I think it might
> have been for the whole series, but I'm not sure and I hate to be a
> presumptuous idiot...

Ack on the overall concept, and I'm ok with odev too. But definitely get
acks from relevant people (bridge/driver maintainers). In terms of
patches, I'd say patch 1 + 24-26 have my

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

-Daniel

> 
> Cheers,
> Peter
> 
> > -Daniel
> >> Cheers,
> >> Peter
> >>
> >>>
> >>>>
> >>>>> Anyway:
> >>>>> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> >>>>
> >>>> Thanks!
> >>>>
> >>>> Cheers,
> >>>> Peter
> >>>>
> >>>>>  --
> >>>>> Regards
> >>>>> Andrzej
> >>>>>
> >>>>>>   * @funcs: control functions
> >>>>>>   * @driver_private: pointer to the bridge driver's internal context
> >>>>>>   */
> >>>>>> @@ -271,6 +272,7 @@ struct drm_bridge {
> >>>>>>    struct drm_bridge *next;
> >>>>>>    struct list_head list;
> >>>>>>    const struct drm_bridge_timings *timings;
> >>>>>> +  struct device_link *link;
> >>>>>>
> >>>>>>    const struct drm_bridge_funcs *funcs;
> >>>>>>    void *driver_private;
> >>>>>
> >>>>>
> >>>>
> >>>
> >>
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel at lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > 
> > 
> > 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

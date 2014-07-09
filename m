From: robdclark@gmail.com (Rob Clark)
Date: Wed, 9 Jul 2014 07:53:47 -0400
Subject: [RESEND PATCH v3 05/11] drm: add Atmel HLCDC Display Controller
 support
In-Reply-To: <20140709101817.3ad39b2b@bbrezillon>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <1404751384-5077-6-git-send-email-boris.brezillon@free-electrons.com>
 <CAF6AEGtttUFquRQrhFKtEKq+frAAmzp4AVtF5gixVkMmJNC68g@mail.gmail.com>
 <20140709101817.3ad39b2b@bbrezillon>
Message-ID: <CAF6AEGtmm+SaeUDD5=+WM4W_oRAXX4G5_OooQKgcOeT1uo0GwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 9, 2014 at 4:18 AM, Boris BREZILLON
<boris.brezillon@free-electrons.com> wrote:
> On Mon, 7 Jul 2014 23:45:54 -0400
> Rob Clark <robdclark@gmail.com> wrote:
>
>> On Mon, Jul 7, 2014 at 12:42 PM, Boris BREZILLON
>> <boris.brezillon@free-electrons.com> wrote:
>> > The Atmel HLCDC (HLCD Controller) IP available on some Atmel SoCs (i.e.
>> > at91sam9n12, at91sam9x5 family or sama5d3 family) provides a display
>> > controller device.
>> >
>> > This display controller supports at least one primary plane and might
>> > provide several overlays and an hardware cursor depending on the IP
>> > version.
>> >
>> > At the moment, this driver only implements an RGB connector to interface
>> > with LCD panels, but support for other kind of external devices (like DRM
>> > bridges) might be added later.
>> >
>> > Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
>> > ---
>> >  drivers/gpu/drm/Kconfig                         |   2 +
>> >  drivers/gpu/drm/Makefile                        |   1 +
>> >  drivers/gpu/drm/atmel-hlcdc/Kconfig             |  11 +
>> >  drivers/gpu/drm/atmel-hlcdc/Makefile            |   7 +
>> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c  | 469 +++++++++++++++
>> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c    | 474 +++++++++++++++
>> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h    | 210 +++++++
>> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.c | 706 +++++++++++++++++++++++
>> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.h | 422 ++++++++++++++
>> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_panel.c | 351 ++++++++++++
>> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 729 ++++++++++++++++++++++++
>> >  11 files changed, 3382 insertions(+)
>> >  create mode 100644 drivers/gpu/drm/atmel-hlcdc/Kconfig
>> >  create mode 100644 drivers/gpu/drm/atmel-hlcdc/Makefile
>> >  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
>> >  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
>> >  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
>> >  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.c
>> >  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.h
>> >  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_panel.c
>> >  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
>> >
>> > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
>> > index d1cc2f6..df6f0c1 100644
>> > --- a/drivers/gpu/drm/Kconfig
>> > +++ b/drivers/gpu/drm/Kconfig
>> > @@ -182,6 +182,8 @@ source "drivers/gpu/drm/cirrus/Kconfig"
>> >
>
> [...]
>
>> > +/**
>> > + * Atmel HLCDC Layer GEM flip garbage collector structure
>> > + *
>> > + * This structure is used to schedule GEM object release when we are in
>> > + * interrupt context (within atmel_hlcdc_layer_irq function).
>> > + *
>> > + *@list: GEM flip objects to release
>> > + *@list_lock: lock to access the GEM flip list
>> > + *@work: work queue scheduled when there are GEM flip to collect
>> > + *@finished: action to execute the GEM flip and all attached objects have been
>> > + *          released
>> > + *@finished_data: data passed to the finished callback
>> > + *@finished_lock: lock to access finished related fields
>> > + */
>> > +struct atmel_hlcdc_layer_gem_flip_gc {
>> > +       struct list_head list;
>> > +       spinlock_t list_lock;
>> > +       struct work_struct work;
>> > +};
>>
>>
>> Please have a look at drm_flip_work.. I think that should simplify
>> post-flip cleanup for you..
>>
>
> Now I remember why I didn't make use of drm_flip_work helpers:
>
> I have to specify a fifo size when initializing the
> drm_flip_work structure (drm_flip_work_init) and I don't know exactly
> what I should choose here.
>
> You might have noticed that I'm queuing the unref work to be done within
> the irq handler (which means I'm in irq context), and, AFAIU,
> drm_flip_work_queue will execute the function if the FIFO is full
> (AFAIK calling drm_framebuffer_unreference in irq context is not safe).

yeah, the place where it is used so far, it has been ok just to size
the FIFO a couple times bigger than it should ever need to be..

Possibly dynamically growing the FIFO would make it a bit more robust.
I was trying to avoid a list so we didn't have restrictions about what
can be queued up (and didn't have issues queuing something up multiple
times)

> This leaves the following solutions if I ever want to use drm_flip_work:
>  - use a threaded irq. Meaning the next frame (or the pending plane
>    update) might take a bit longer to be displayed.
>  - increase the fifo size, so that it's never entirely filled (relying
>    on the assumption that the flip work queue will be executed at least
>    as much as the plane update requests)
>  - rely on the assumption that work_queue will be executed at least
>    once per fb flip. This is true for the primary plane because we're
>    using page_flip and only one page_flip can take place at a given
>    time, but AFAIK this is not true for plane updates.

At least some of the hw can only do plane updates once per frame
anyway.  I do kinda wish the plane API was better defined in terms of
what happens if you try multiple updates in a frame.  In practice, the
only place I can think of where this is an issue is when using a plane
to implement a hw cursor (because you have userspace that likes to
enable/disable cursor at a high rate sometimes, like spinning
busy-cursor).

> My approach is to use a simple list instead of a kfifo to queue fb
> flip unref work, this way I don't have to bother about whether the fifo
> is full or not.

true, but what happens when you need to queue up the same gem obj or
same fb multiple times?

> ITOH, this means I might keep fb references longer than I would when
> using drm_flip_work, and potentially get out of resources if plane
> updates occurs more often than my unref work queue is called.
>
> Please, let me know what's the preferred solution here.

I suppose making flip-work clever enough to grow it's FIFO on demand
would be a nice enhancement that the other users of flip-work would
benefit from.  It would be nice if we could use a list and not have to
worry about size, but it would be common for userspace to flip between
2 or 3 buffers on a plane, so as soon as you have to start worrying
about FIFO size, you also have to worry about having same buffer
queued up for multiple unref's.

BR,
-R

> Best Regards,
>
> Boris
>
> --
> Boris Brezillon, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

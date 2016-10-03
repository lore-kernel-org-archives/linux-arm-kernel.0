From: daniel.vetter@ffwll.ch (Daniel Vetter)
Date: Mon, 3 Oct 2016 15:49:09 +0200
Subject: [PATCH v2 2/2] drm: zte: add initial vou drm driver
In-Reply-To: <CACvgo53A7BpVWHgkFrZsjWnw_uW6xDmKRsrxF=46HOEWQ43BxA@mail.gmail.com>
References: <1474727185-24180-1-git-send-email-shawn.guo@linaro.org>
 <1474727185-24180-3-git-send-email-shawn.guo@linaro.org>
 <CACvgo51feNJYrHaKT+M06Z7kOUqzYo1Uv_TAHdLhNXPtRUwsvw@mail.gmail.com>
 <20161001002228.GA2989@x250>
 <CACvgo53A7BpVWHgkFrZsjWnw_uW6xDmKRsrxF=46HOEWQ43BxA@mail.gmail.com>
Message-ID: <CAKMK7uFWcL8909UKMFbm5BrcjS5V2-ExtH5a8HR_cuNxyC+TQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 3, 2016 at 12:36 PM, Emil Velikov <emil.l.velikov@gmail.com> wrote:
>>> > +static int zx_gl_get_fmt(uint32_t format)
>>> > +{
>>> > +       switch (format) {
>>> > +       case DRM_FORMAT_ARGB8888:
>>> > +       case DRM_FORMAT_XRGB8888:
>>> > +               return GL_FMT_ARGB8888;
>>> > +       case DRM_FORMAT_RGB888:
>>> > +               return GL_FMT_RGB888;
>>> > +       case DRM_FORMAT_RGB565:
>>> > +               return GL_FMT_RGB565;
>>> > +       case DRM_FORMAT_ARGB1555:
>>> > +               return GL_FMT_ARGB1555;
>>> > +       case DRM_FORMAT_ARGB4444:
>>> > +               return GL_FMT_ARGB4444;
>>> > +       default:
>>> > +               WARN_ONCE(1, "invalid pixel format %d\n", format);
>>> > +               return -EINVAL;
>>> Afaics the only user of this is atomic_update() and that function
>>> cannot fail. You might want to move this to the _check() function.
>>> Same logic goes for the rest of the driver, in case I've missed any.
>>
>> The function does the conversion from DRM format values to the ones that
>> hardware accepts.  And I need to set up hardware register with the
>> converted value.
>>
>> I suppose that the error case in 'default' should never be hit, since
>> all valid format have been reported to DRM core by gl_formats?  In that
>> case, I can simply drop the WARN and return a sane default format
>> instead?
>>
> I'd just do the error checking in check() function and keep the
> mapping in update(). As devs add new formats to DRM core it's not
> possible for them to test every driver so getting a failure early is
> better (imho) than getting subtle visual and/or other issues. Either
> way it's up-to you really.

I think a WARN_ON here is perfectly fine. Like Shawn said, any invalid
formats should already be filtered out by the drm core (by checking
against the list of valid formats for this plane), so no need to move
this to ->check(). In i915.ko we have a MISSING_CASE macro to catch
these cases when someone adds a new format, but forgets to update all
the switch statements.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch

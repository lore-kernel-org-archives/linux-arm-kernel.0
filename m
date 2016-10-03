From: emil.l.velikov@gmail.com (Emil Velikov)
Date: Mon, 3 Oct 2016 11:36:01 +0100
Subject: [PATCH v2 2/2] drm: zte: add initial vou drm driver
In-Reply-To: <20161001002228.GA2989@x250>
References: <1474727185-24180-1-git-send-email-shawn.guo@linaro.org>
 <1474727185-24180-3-git-send-email-shawn.guo@linaro.org>
 <CACvgo51feNJYrHaKT+M06Z7kOUqzYo1Uv_TAHdLhNXPtRUwsvw@mail.gmail.com>
 <20161001002228.GA2989@x250>
Message-ID: <CACvgo53A7BpVWHgkFrZsjWnw_uW6xDmKRsrxF=46HOEWQ43BxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 October 2016 at 01:22, Shawn Guo <shawnguo@kernel.org> wrote:
> Hi Emil,
>
> On Fri, Sep 30, 2016 at 01:34:14PM +0100, Emil Velikov wrote:
>> Hi Shawn,
>>
>> A couple of fly-by suggestions, which I hope you'll find useful :-)
>
> Thanks for the suggestions.
>
>> On 24 September 2016 at 15:26, Shawn Guo <shawn.guo@linaro.org> wrote:
>>
>> > +
>>  > +       val = ((vm.hsync_len - 1) << SYNC_WIDE_SHIFT) & SYNC_WIDE_MASK;
>> To save some writing/minimise the chances to typos getting, in you can
>> have single/collection to static inline functions similar to msm [1].
>> On a similar note inline wrappers zte_read/write/mask (around
>> writel/readl) will provide quite useful for debugging/tracing :-)
>>
>> [1] drivers/gpu/drm/msm/adreno/a4xx.xml.h
>
> I would not add a header file with hundreds or thousands of defines
> while only tens of them are actually used.  For debugging, I prefer
> to print particular registers than every single read/write, which
> might not be easy to check what I want to check.
>
I've never implied adding hundreds/etc defines, but a few
macros/inlines which get you from

  val = ((vm.hsync_len - 1) << SYNC_WIDE_SHIFT) & SYNC_WIDE_MASK;
  ....
  val = readl(vou->vouctl + VOU_CLK_EN);
  val |= inf->clocks_en_bits;
  writel(val, vou->vouctl + VOU_CLK_EN);

to

  val = SYNC_WIDE(vm.hsync_len - 1);
  ...
  zte_vouctl_mask(vou, VOU_CLK_EN, mask, value); // or any permutation
of upper/lower case, argument order, use/discard the VOU_ register
prefix, etc.


The latter tends to be easier to read and less error prone. Either
way, it was just a suggestion.


>> > +static int zx_gl_get_fmt(uint32_t format)
>> > +{
>> > +       switch (format) {
>> > +       case DRM_FORMAT_ARGB8888:
>> > +       case DRM_FORMAT_XRGB8888:
>> > +               return GL_FMT_ARGB8888;
>> > +       case DRM_FORMAT_RGB888:
>> > +               return GL_FMT_RGB888;
>> > +       case DRM_FORMAT_RGB565:
>> > +               return GL_FMT_RGB565;
>> > +       case DRM_FORMAT_ARGB1555:
>> > +               return GL_FMT_ARGB1555;
>> > +       case DRM_FORMAT_ARGB4444:
>> > +               return GL_FMT_ARGB4444;
>> > +       default:
>> > +               WARN_ONCE(1, "invalid pixel format %d\n", format);
>> > +               return -EINVAL;
>> Afaics the only user of this is atomic_update() and that function
>> cannot fail. You might want to move this to the _check() function.
>> Same logic goes for the rest of the driver, in case I've missed any.
>
> The function does the conversion from DRM format values to the ones that
> hardware accepts.  And I need to set up hardware register with the
> converted value.
>
> I suppose that the error case in 'default' should never be hit, since
> all valid format have been reported to DRM core by gl_formats?  In that
> case, I can simply drop the WARN and return a sane default format
> instead?
>
I'd just do the error checking in check() function and keep the
mapping in update(). As devs add new formats to DRM core it's not
possible for them to test every driver so getting a failure early is
better (imho) than getting subtle visual and/or other issues. Either
way it's up-to you really.

Regards,
Emil

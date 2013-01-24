From: robdclark@gmail.com (Rob Clark)
Date: Thu, 24 Jan 2013 08:10:01 -0600
Subject: [PATCH 2/4] drm/i2c: nxp-tda998x (v2)
In-Reply-To: <20130124115720.GV31870@phenom.ffwll.local>
References: <1358894185-21617-1-git-send-email-robdclark@gmail.com>
 <1358894185-21617-3-git-send-email-robdclark@gmail.com>
 <20130124115720.GV31870@phenom.ffwll.local>
Message-ID: <CAF6AEGsvvk-x_OhWJSQc_RON2BUSeAuBwav8vriX2Cv=pNaH7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 24, 2013 at 5:57 AM, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Tue, Jan 22, 2013 at 04:36:23PM -0600, Rob Clark wrote:
>> Driver for the NXP TDA998X i2c hdmi encoder slave.
>>
>> v1: original
>> v2: fix npix/nline programming
>>
>> Signed-off-by: Rob Clark <robdclark@gmail.com>
>
> Just one bikeshed, otherwise
>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> [cut]
>
>> +static void
>> +reg_set(struct drm_encoder *encoder, uint16_t reg, uint8_t val)
>> +{
>> +     reg_write(encoder, reg, reg_read(encoder, reg) | val);
>> +}
>> +
>> +static void
>> +reg_clear(struct drm_encoder *encoder, uint16_t reg, uint8_t val)
>> +{
>> +     reg_write(encoder, reg, reg_read(encoder, reg) & ~val);
>> +}
>
> What about drivers/base/regmap? I haven't looked to closely yet and never
> used it in code, but there's a presentation [1] and it sounds like it
> provides some nice (and more important standardized) helper stuff for
> debug, tracing, ...
>
> Since encoder slave drivers tend to be utterly boring register bashing and
> we expect tons of time, I think high levels of standardization would be
> really useful. Care to look into this a bit?

I did look at regmap.. what convinced me against using it was that if
you don't use cached mode, it ends up writing the page selector
register for every read/write.  And I don't have enough actual
documentation about this nxp part to know the reset values of all the
registers in order to use caching.

BR,
-R

> Cheers, Daniel
>
> 1: http://free-electrons.com/blog/fosdem2012-videos/
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch

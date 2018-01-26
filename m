From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 26 Jan 2018 15:26:10 +0100
Subject: [PATCH] drm/pl111: Use max memory bandwidth for resolution
In-Reply-To: <CACRpkdZ6p+ooAeRAk3BnGryiU07_i4RCb9Vq-k5wpHQLWRY=cg@mail.gmail.com>
References: <20180123132220.29886-1-linus.walleij@linaro.org>
 <87inbqppm4.fsf@anholt.net>
 <CACRpkdZ6p+ooAeRAk3BnGryiU07_i4RCb9Vq-k5wpHQLWRY=cg@mail.gmail.com>
Message-ID: <CACRpkdZeH8BR3Hs8Pa5=mELn4Swo7whxPAj1vpfvo7yQ2zrscQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 26, 2018 at 2:27 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Jan 25, 2018 at 4:46 AM, Eric Anholt <eric@anholt.net> wrote:
>
>>> +     pl111_choose_max_resolution(dev, priv->memory_bw,
>>> +                                 &mode_config->max_width,
>>> +                                 &mode_config->max_height, &bpp);
>>> +     dev_info(dev->dev, "cap resolution at %u x %u, %u BPP\n",
>>> +              mode_config->max_width, mode_config->max_height, bpp);
>>
>> I think this is the wrong place in the pipeline to be doing this, but I
>> don't have a complete solution so I'm not necessarily saying no.
>
> So currently the driver does this:
>
> mode_config->max_width = 1024;
> mode_config->max_height = 768;
>
> And that is because it cannot really handle anything. I guess ideally
> the DRM driver should set these to -1 or something so that any widths
> and heights negotiated will work.
>
>>  Things I think we should do for bandwidth limits:
>>
>> A new pl111_mode_valid() rejects modes with width*height*2 > bandwidth
>> (if we can't scan it out with our smallest format, don't advertise it).
>>
>> pl111_display_check() rejects modes with width*height*bpp > bandwidth
>> (if we can't scan out this particular configuration, let them know we
>> can't set the mode).
>>
>> Ideally given those two things, fbdev and X11 would notice that the
>> preferred mode fails at 24bpp and fall back to 16bpp.  I don't think
>> either of those does so today, though.
>>
>> Interested in tackling any of these?
>
> I tried the pl111_display_check() version. It just made the driver
> fail to initialize anything, at least when using the dumb VGA
> bridge.

I guess this is because it gets called from
drm_simple_display_pipe_funcs
at which point the driver framework has already decided to go with
this format. And that is backed by crtc.

We would need to extend this with a new function such as
.crtc_valid() that can check both mode (for resolution)
and format (for BPP).

But then I start to wonde how "simple" drm_simple_display_pipe
is becoming :/

I can't figure out if the crtc is even the right place to address this...

> There are .mode_valid() callbacks on the bridges we use
> (panel and dumb VGA) but neither uses it at the moment, hm.
> I could just assign my own .mode_valid() callback to the bridge,
> but it seems a bit fragile. But it's worth a hack, I'll try it.

It turns out that this passes only an struct drm_display_mode
which does not concern itself with display engine details
like BPP.

So the bridges just put limitations on modes, not on BPP,
which makes a lot of sense, it corresponds to what the
hardware does.

It's evident when I think about it...

The check needs to be done in the
drm_simple_display_pipe_funcs  or setting that up as
per above. I just don't really see exactly where?

Yours,
Linus Walleij

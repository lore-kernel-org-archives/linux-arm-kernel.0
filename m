From: eric@anholt.net (Eric Anholt)
Date: Mon, 29 Jan 2018 16:00:40 -0800
Subject: [PATCH] drm/pl111: Use max memory bandwidth for resolution
In-Reply-To: <CACRpkdZ6p+ooAeRAk3BnGryiU07_i4RCb9Vq-k5wpHQLWRY=cg@mail.gmail.com>
References: <20180123132220.29886-1-linus.walleij@linaro.org>
 <87inbqppm4.fsf@anholt.net>
 <CACRpkdZ6p+ooAeRAk3BnGryiU07_i4RCb9Vq-k5wpHQLWRY=cg@mail.gmail.com>
Message-ID: <87tvv4w6zb.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

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

The PPL field only gets you up to 1024 width.  Looks like LPP lets you
get up to 1024 height, though, even if the top level of the PL111 docs
say 1024x768 is the max.

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
>
> There are .mode_valid() callbacks on the bridges we use
> (panel and dumb VGA) but neither uses it at the moment, hm.
> I could just assign my own .mode_valid() callback to the bridge,
> but it seems a bit fragile. But it's worth a hack, I'll try it.
>
> I sent a sent of lesser controversial patches in the meantime,
> and rebased this on top of those so we can deal with the
> memory BW issue separately.

The memory-bandwidth field is in the pl111 binding, so I do think we
should handle it there.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180129/c5e8b0cf/attachment.sig>

From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 11 Dec 2012 13:49:05 -0700
Subject: [PATCH 2/2] pinctrl: skip deferral of hogs
In-Reply-To: <1355232965-16596-1-git-send-email-linus.walleij@stericsson.com>
References: <1355232965-16596-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <50C79C41.8070305@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/2012 06:36 AM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> Up until now, as hogs were always taken at the end of the
> pin control device registration, it didn't cause any problem.
> But when starting to hog pins from the device core it will
> cause deferral of the pin controller device itself since the
> default pin fetch is done *before* the device probes, so
> let's fix this annoyance (which is also aesthetically ugly).

I guess this is OK, although I can't quite get over the feeling of it
being a bit of a hack.

The issue is IIUC that the driver core is going to call pinctrl_get()
for any device before it's probed, and if it succeeds it will select the
default state, but this patch deliberately fails the pinctrl_get() for a
pin controller, and hence relies on pinctrl_register() making a second
attempt at pinctrl_get(), and also activating the default state there.
That's a bit of duplication and rather asymmetric.

That all said, I don't really see what we can do better, so I won't object!

Oh, one comment on the patch. It returns -ENODEV as soon as any hog is
seen. Just in case someone does something wierd, shouldn't it accumulate
the "worst-case" return value and not return early? Consider a pin
controller whose mapping table entries contain both hogs, /and/ entries
that use a different pin controller. That's a little contrived, but
trivial to actually do. As such, I think we want something more like:

ret = 0
for every mapping table entry:
    if can't find pinctrl device:
        if map entry is a hog:
            # Requiring defer is a worst case, so defer the return!
            ret = -ENODEV
        else:
            # This is worst-case, so can return now
            return -EPROBE_DEFER
if ret:
    cleanup
return ret

That way, if a mapping table entry requiring defer comes after a hog,
we'll still return the correct value.

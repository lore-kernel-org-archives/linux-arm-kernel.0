From: stigge@antcom.de (Roland Stigge)
Date: Mon, 18 Jun 2012 17:08:17 +0200
Subject: [PATCH] gpio: of_get_named_gpio_flags() return -EPROBE_DEFER
 if GPIO not yet available
In-Reply-To: <4FDF403E.9090302@wwwdotorg.org>
References: <1339927893-8842-1-git-send-email-stigge@antcom.de>
 <4FDE8D27.6030508@wwwdotorg.org> <4FDEF293.9080305@antcom.de>
 <4FDF403E.9090302@wwwdotorg.org>
Message-ID: <4FDF4461.60707@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2012 04:50 PM, Stephen Warren wrote:
>> Can you please tell in which way the patch breaks those drivers?
>> However, I can see that those drivers solved the same problem in a
>> different way (deferring of_get_named_gpio(), via the sound init()). So
>> they could be adjusted to take advantage of new -EPROBE_DEFER.
> 
> The drivers I mentioned test the return code of of_get_named_gpio() to
> see if it's -ENODEV, which means that DT property for that GPIO exists
> but the driver for it isn't available yet, so the property can't be
> parsed. In this case, the sound drivers defer their own probe. If
> of_get_named_gpio() is modified to return -EPROBE_DEFER directly, then
> it won't be returning -ENODEV, and hence the sound drivers' check for
> -ENODEV won't fire, and hence the sound drivers will just continue their
> probe assuming that the particular GPIOs are not present on the board
> (since they are all optional, so anything other than an explicit
> deferral error from of_get_named_gpio() is not treated as an error).
> This will break sound on those platforms.

Thanks for the hint! I previously also suspected sth. like this but
didn't find it in v3.5-rc3. In broonie's sound.git for-next, I now
finally found it.

Should be easy to fix (replacing the if (... == -ENODEV) to -EPROBE_DEFER.

Will you provide patches as signalled, of should I? Which branch would
be the correct one to build on top?

Thanks in advance,

Roland

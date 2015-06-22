From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 22 Jun 2015 12:06:04 +0200
Subject: [PATCH v5 4/6] drm: bridge/dw_hdmi-i2s-audio: add audio driver
In-Reply-To: <1434731295-11060-1-git-send-email-ykk@rock-chips.com>
References: <1434730417-10629-1-git-send-email-ykk@rock-chips.com>
 <1434731295-11060-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1434967564.31094.20.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Something I didn't notice in v4, sorry.

On Sat, 2015-06-20 at 00:28 +0800, Yakir Yang wrote:
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/dw_hdmi-i2s-audio.c

> +#define DRIVER_NAME "dw-hdmi-i2s-audio"

> +MODULE_ALIAS(PLATFORM_MODULE_PREFIX DRIVER_NAME);

0) Side note: this is the first time that PLATFORM_MODULE_PREFIX is used
inside MODULE_ALIAS(). But none of the 1000+ other "platform:" aliases
do that. And neither does 5/6 of this series! That suggests, I think,
that this shouldn't be done.

You could consider adding something like
    #define MODULE_ALIAS_PLATFORM(NAME) MODULE_ALIAS(PLATFORM_MODULE_PREFIX NAME)

But then, I think, all the current 1000+ platform: aliases should be
converted to that macro. Would that be worth it?

1) Now on to my remark: this alias seems to be only useful if there also
is a struct platform_device with a "dw-hdmi-i2s-audio" name. Because
that platform_device would, badly summarized, fire of a
"MODALIAS=platform:dw-hdmi-i2s-audio" uevent when created. Which, in its
turn, would trigger userspace to load this module, correct?

But I think there's no platform_device with a "dw-hdmi-i2s-audio" name.
So I wonder whether this MODULE_ALIAS() is actually needed. What breaks
if you leave it out?

(Likewise for 5/6, but there the platform_device should have a
"rockchip-hdmi-audio" name.)

Thanks,


Paul Bolle

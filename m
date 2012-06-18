From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sun, 17 Jun 2012 20:06:31 -0600
Subject: [PATCH] gpio: of_get_named_gpio_flags() return -EPROBE_DEFER
 if GPIO not yet available
In-Reply-To: <1339927893-8842-1-git-send-email-stigge@antcom.de>
References: <1339927893-8842-1-git-send-email-stigge@antcom.de>
Message-ID: <4FDE8D27.6030508@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/17/2012 04:11 AM, Roland Stigge wrote:
> of_get_named_gpio_flags() and of_get_named_gpio() return -EPROBE_DEFER if the
> respective GPIO is not (yet) available. This is useful if driver's probe()
> functions try to get a GPIO whose controller isn't probed yet. Thus, the driver
> can be probed again later on.
> 
> The function still returns -EINVAL on other errors (parse error or node doesn't
> exist). This way, the case of an optional/intentionally missing GPIO is handled
> appropriately.

While I agree this is a correct change, it is going to break some
existing code - at least sound/soc/tegra/tegra_{wm8903.c,alc5632.c}. I'm
happy to send patches for those files though (is this going into 3.5 or
3.6?). However, have you audited all existing callers (including
indirect, e.g. through plain of_get_named_gpio()) for issues this will
cause?

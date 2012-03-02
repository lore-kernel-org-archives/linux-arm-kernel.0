From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 2 Mar 2012 09:22:14 -0800
Subject: [PATCH] pinctrl: resurrect verbose pinmux-pins
In-Reply-To: <1330705873-10798-1-git-send-email-linus.walleij@stericsson.com>
References: <1330705873-10798-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BE861978@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote at riday, March 02, 2012 9:31 AM:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This reintroduces the verbosity in the pinmux-pins file, now this
> file will list all pins, their names, owning device (and if it's
> a hog) and also in applicable cases the function and group making
> use of that pin right now.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

It'd be nice if we could defer this fix until after all the API rework,
because it'll cause all kinds of conflicts otherwise.

The type "struct pinmux_group" you added to struct pin_desc is removed by
patches in my series. If this patch goes in before my series, it'd be best
if it just stored the char* for the function instead of that type, so the
rework by my patche series will be smaller.

I don't think it make sense to store a "group" as owning a pin; each pin
should be part of one muxing group as defined by the hardware so there isn't
a concept of "which group acquired the pin", just "which function is
programmed on the pin". Even if multiple "virtual groups" contain a pin
(which I think would be a bad idea) then the important information from a
HW perspective is the function and not the arbitrary group name.

-- 
nvpublic

From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 20 Sep 2011 13:10:55 -0700
Subject: [PATCH 0/2] pin controller subsystem v7
In-Reply-To: <1316175182-10700-1-git-send-email-linus.walleij@stericsson.com>
References: <1316175182-10700-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04B73216C5@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote at Friday, September 16, 2011 6:13 AM:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This is the sixth iteration of the controller subsystem...

Overall, the changelog sounds like a great move in the right direction.
There's just one small thing I'd comment on here:

> ChangeLog v6->v7:
> 
> - Make it possible to have several map entries matching the
>   same device, pin controller and function, but using
>   a different group, and alter the semantics so that
>   pinmux_get() will pick all matching map entries, and
>   store the associated groups in a list. The list will
>   then be iterated over at pinmux_enable()/pinmux_disable()
>   and corresponding driver functions called for each
>   defined group. Notice that you're only allowed to map
>   multiple *groups* to the same
>   { device, pin controller, function } triplet, attempts
>   to map the same device to multiple pin controllers will
>   for example fail. This is hopefully the crucial feature
>   requested by Stephen Warren.

I've been viewing the map table as:

input: (device, device's function) 
output: list of (controller, controller's group, controller's function)

... hence I was surprised to see that you explicitly note that mapping a
single device to multiple controllers was disallowed.

That said, I suppose this restriction won't cause any issues for any
use-case I'm aware of; the only possibilities might be:

a) Multiple pinmux controllers within the SoC, but perhaps the driver
should just aggregate multiple HW modules into a single Linux device
anyway?

b) Where the pinmux map wants to affect the pinmux on both ends of some
bus, where the two ends are different chips each having obviously separate
pinmux controllers.

Then again, if this need ever does arise, we should be able to just relax
this restriction without causing any backwards-compatibility issues, so
I don't see a specific need to change this now; I just thought I'd mention
it so you're aware of what I'm thinking.

I'll go review the code now.

-- 
nvpublic

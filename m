From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 25 May 2016 19:42:59 -0700
Subject: [PATCH v2 1/4] reset: Add support for the Amlogic Meson SoC Reset
 Controller
In-Reply-To: <1464169758-26975-2-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Wed, 25 May 2016 11:49:15 +0200")
References: <1464169758-26975-1-git-send-email-narmstrong@baylibre.com>
 <1464169758-26975-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <m2iny1h74c.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> This patch adds the platform driver for the Amlogic Meson SoC Reset
> Controller.
>
> The Meson8b and GXBB SoCs are supported.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Maybe a question for Philipp, but when testog this version with the
stmmac ethernet driver on the Amlogic boards, I noticed that ->reset was
never getting called.

Turns out, the stmmac driver only uses reset_control_assert() and
reset_control_deassert(), both of which return -ENOTSUPP since this
driver doesn't provide ->assert or ->deassert, so the driver's ->reset()
never gets called.

I haven't looked into the reset framework in detail, but if there's only
a ->reset hook, I kind of expected that reset_control_deassert() would
use that instead of returning -ENOTSUPP.

If not, what's the proper way of handling hardware that only supports a
write-only reset pulse?  Should users of reset_control_* be adapted to
check if ->deassert returns -ENOTSUPP and call ->reset?

Kevin

From: olof@lixom.net (Olof Johansson)
Date: Tue, 6 Jan 2015 20:41:34 -0800
Subject: [PATCH 1/4] usb: phy: Fix deferred probing
In-Reply-To: <1420559110-8043-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1420559110-8043-1-git-send-email-maxime.ripard@free-electrons.com>
 <1420559110-8043-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAOesGMhWgUu8wDyZyL63gq5JEDu=ecv=r0y7Aa+6SMt24N-Z+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 6, 2015 at 7:45 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Commit 1290a958d48e ("usb: phy: propagate __of_usb_find_phy()'s error on
> failure") actually broke the deferred probing mechanism, since it now returns
> EPROBE_DEFER only when the try_module_get call fails, but not when the phy
> lookup does.
>
> All the other similar functions seem to return ENODEV when try_module_get
> fails, and the error code of either __usb_find_phy or __of_usb_find_phy
> otherwise.
>
> In order to have a consistent behaviour, and a meaningful EPROBE_DEFER, always
> return EPROBE_DEFER when __(of_)usb_find_phy fails to look up the requested
> phy, that will be propagated by the caller, and ENODEV if try_module_get fails.
>

Fixes:  1290a958d48e ("usb: phy: propagate __of_usb_find_phy()'s error
on failure")

> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

This also fixes USB on tegra/trimslice here.

Tested-by: Olof Johansson <olof@lixom.net>

Given that the regression went in during 3.19 merge window, this
should go in as a fix during -rc, please.


-Olof

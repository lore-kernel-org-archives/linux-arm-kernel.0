From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 29 Apr 2015 10:40:07 -0700
Subject: [PATCH 1/1] Revert "ARM: dts: add display power domain for
 exynos5250"
In-Reply-To: <1427107800-21668-1-git-send-email-javier.martinez@collabora.co.uk>
 (Javier Martinez Canillas's message of "Mon, 23 Mar 2015 11:49:59
 +0100")
References: <1427107800-21668-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <7hr3r2suiw.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier Martinez Canillas <javier.martinez@collabora.co.uk> writes:

> This reverts commit 2d2c9a8d0a4f90e298315d2f4a282d8bd5d45e5c
> ("ARM: dts: add display power domain for exynos5250").
>
> The mentioned commit added a domain definition for the DISP1
> power domain and references to it in the appropriate devices
> but this change breaks the display in at least the Exynos5250
> based Snow and Spring Chromebooks.
>
> On these machines, the boot-loader enables the DISP1 domain and
> before the mentioned commit, the kernel didn't know about it so
> the power domain remained always enabled.
>
> But after that commit when the exynos-dp probe is deferred,
> the DISP1 domain is powered off and on again but the exynos-dp
> driver fails to configure the video showing the following error:
>
> exynos-dp 145b0000.dp-controller: Timeout of video streamclk ok
> exynos-dp 145b0000.dp-controller: unable to config video
>
> The same issue happens when the display is turned off and on
> again using DPMS.
>
> So, it seems the DISP1 power domain definition is not complete
> since the display works with the initialization made by the boot
> loader but it does not work when the power domain is enabled by
> the kernel.
>
> Having the definition in the DTS makes the power domain to be
> powered on when needed and powered off when not needed which is
> better in terms of power consumption but for now is safer to just
> revert the commit to avoid adding a regression in some machines.
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Tested-by: Kevin Hilman <khilman@linaro.org>

FWIW, this patch fixes the boot panics when using MMC rootfs on
exynos5800-peach-pi with current linux-next that have been happening
for awhile.

For several months now, DRM/display related stuff is very routinely
breaking basic booting on exynos5, which gives the rather strong
impression that the DRM stuff is not tested well enough to be merged.

Kevin

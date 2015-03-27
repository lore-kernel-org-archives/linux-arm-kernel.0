From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 27 Mar 2015 15:29:08 +0100
Subject: [PATCH 1/1] Revert "ARM: dts: add display power domain for
 exynos5250"
In-Reply-To: <1427107800-21668-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1427107800-21668-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <CAJKOXPewO77pRwh151MFLX+W6WQYPZS759uqjvyZ_TkRf9vmdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-03-23 11:49 GMT+01:00 Javier Martinez Canillas
<javier.martinez@collabora.co.uk>:
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

I looked at the DP and FIMD drivers and with great help of Andrzej
Hajda found the issue: the FIMD driver does not enable DP clock
(DP_MIE_CLKCON register). The process looks like:
1. Bootloader sets the DP_MIE_CLKCON to proper value.
2. FIMD is probed, DP power domain is on.
3. FIMD is deffered, DP power domain is turned off.
4. The FIMD registers are reset so DP clock is turned off.
5. DP driver is probed, DP power domain is turned on but clock is not enabled.

I'll do some more testing and sent a patch for it till end of Monday
so I think we should not revert this commit.

Best regards,
Krzysztof

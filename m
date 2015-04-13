From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 13 Apr 2015 19:59:11 +0900
Subject: [PATCH 1/1] ARM: dts: Make DP a consumer of DISP1 power domain on
 Exynos5420
In-Reply-To: <1428870659-5525-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1428870659-5525-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <CAJKOXPdpxst6HocbMr53HoKQJu=09aCuy_sKVpUei240TbRVKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-04-13 5:30 GMT+09:00 Javier Martinez Canillas
<javier.martinez@collabora.co.uk>:
> Commit ea08de16eb1b ("ARM: dts: Add DISP1 power domain for exynos5420")
> added a device node for the Exynos5420 DISP1 power domain but dit not
> make the DP controller a consumer of that power domain.
>
> This causes an "Unhandled fault: imprecise external abort" error if the
> exynos-dp driver tries to access the DP controller registers and the PD
> was turned off. This lead to a kernel panic and a complete system hang.
>
> Make the DP controller device node a consumer of the DISP1 power domain
> to ensure that the PD is turned on when the exynos-dp driver is probed.
>
> Fixes: ea08de16eb1b ("ARM: dts: Add DISP1 power domain for exynos5420")
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>
> Hello,
>
> This latent bug was not exposed before since drivers for other devices
> marked as DISP1 power domain consumers were probed before exynos-dp so
> the PD was already on which made possible to access the DP registers.
>
> But "regulator: Defer lookup of supply to regulator_get" [0] that is in
> linux-next from a couple of days now, changed the order on which the
> drivers' probes succeed so the PD was disabled during exynos-dp probe.
>
> Exynos5420 machines with a display such as the Exynos5420 Peach Pit and
> Exynos5800 Peach Pi were failing to boot due this issue, i.e: [1].
>
> Olof,
>
> Could you please confirm $subject fixes the issue catched by your farm?
>
> Krzysztof,
>
> This patch conflicts with your Exynos5 phandle notation cleanup [2] but
> I preferred to send it on top of linux-next instead of making your series
> a dependency since it fixes a very important bug that had caused -next to
> be broken on these matchines for days now.

Sure, I don't mind. My patchset is just a cleanup so it can wait and
should not block important stuff.

Best regards,
Krzysztof

From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 03 Jul 2018 13:03:11 +0200
Subject: [PATCH 12/12] drm/rockchip: add support for CDNS MHDP IP
 controller.
In-Reply-To: <1530612152-27555-13-git-send-email-dkos@cadence.com>
References: <1530612152-27555-1-git-send-email-dkos@cadence.com>
 <1530612152-27555-13-git-send-email-dkos@cadence.com>
Message-ID: <2647490.Uuqs1CuF1U@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Damien,

it's very cool to see collaboration from vendors on this.


Am Dienstag, 3. Juli 2018, 12:02:23 CEST schrieb Damian Kos:
>

It would be really nice to explain a bit about the added controller support
in the commit message, so that people reviewing the patch can get a
feeling for it.

> Signed-off-by: Damian Kos <dkos@cadence.com>
> ---
>  drivers/gpu/drm/rockchip/cdn-dp-core.c |  953
> +++++++++++++++++++++++++++++++- drivers/gpu/drm/rockchip/cdn-dp-core.h |  
> 25 +
>  drivers/gpu/drm/rockchip/cdn-dp-reg.c  |    2 +-
>  drivers/gpu/drm/rockchip/cdn-dp-reg.h  |    4 +

>From the changes below, it looks that this seems to add support for a
bridge chip based on that IP block. So it seems like the bridge+glue driver
model would be a perfect fit for this, instead of stapling this onto the
Rockchip-specific driver.

So essentially, you could take the Rockchip cdn-dp driver, move the common
parts to drivers/gpu/drm/bridge and then create separate glue drivers for
both Rockchip and your external bridge IP block.

This would prevent code duplication and also allow your bridge driver to
be compiled without the Rockchip drm being present :-) .
And also pave the way for future socs using your DP ip block.


Nowadays we have quite a number of examples you could take as
inspiration for this:
- bridge/analogix/* (shared between Exynos and Rockchip right now)
- bridge/synopsys/dw-hdmi* (shared between a quite big number of users)
- bridge/synopsys/dw-mipi-dsi.c (shared between Rockchip [pending] and stm)


Thanks
Heiko

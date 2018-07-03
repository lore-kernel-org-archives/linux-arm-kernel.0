From: dkos@cadence.com (Damian Kos)
Date: Tue, 3 Jul 2018 14:06:56 +0000
Subject: [PATCH 12/12] drm/rockchip: add support for CDNS MHDP IP
 controller.
In-Reply-To: <2647490.Uuqs1CuF1U@diego>
References: <1530612152-27555-1-git-send-email-dkos@cadence.com>
 <1530612152-27555-13-git-send-email-dkos@cadence.com>
 <2647490.Uuqs1CuF1U@diego>
Message-ID: <CO2PR07MB25512372C4FEAF1990305433CD420@CO2PR07MB2551.namprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

Thank you for your feedback! Initially, MHDP driver was developed as a DRM bridge driver and was planned to be placed in drivers/gpu/drm/bridge/cadence/mhdp.c.  However, there was already a driver for Cadence's DP controller developed by RockChip, but that driver uses different DRM framework. Both controllers (including firmware) are quite different internally (MST/FEC/DSC support, link training done by driver, additional commands, etc.) but they have very similar register map, except for Framer/Streamer, so they appear similar.

We would be more than happy to provide fully separate driver (that was basically pasted in RockChip's driver) for DP DRM bridge. Some parts can definitely shared between these two drivers like code for mailbox and commands sent/received by it, audio init.

Moving cdn-dp-* to drivers/gpu/drm/bridge/ was also a plan, but it seems that cdn-dp-core.c use some stuff from drivers/gpu/drm/rockchip/*. cdn-dp-core driver in this case seems like a part of a bigger picture while the driver that we want to upstream is standalone.

We'll move/add everything that can be shared by both drivers to drivers/gpu/drm/ and add new DPI/DP bridge driver as you advised and provide a new patch.

PS. Should we post patches 01-08 done in DRM helper by Quentin as a separate patch, so that reviewers will not have to go through them every time when we send updated version?

Regards,
Damian

-----Original Message-----
From: Heiko St?bner <heiko@sntech.de> 
Sent: Tuesday, July 3, 2018 13:03
To: Damian Kos <dkos@cadence.com>
Cc: David Airlie <airlied@linux.ie>; Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Gustavo Padovan <gustavo@padovan.org>; Maarten Lankhorst <maarten.lankhorst@linux.intel.com>; Sean Paul <seanpaul@chromium.org>; Sandy Huang <hjc@rock-chips.com>; dri-devel at lists.freedesktop.org; devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-rockchip at lists.infradead.org; Lukasz Tyrala <ltyrala@cadence.com>; Przemyslaw Gaj <pgaj@cadence.com>; Scott Telford <stelford@cadence.com>
Subject: Re: [PATCH 12/12] drm/rockchip: add support for CDNS MHDP IP controller.

EXTERNAL MAIL


Hi Damien,

it's very cool to see collaboration from vendors on this.


Am Dienstag, 3. Juli 2018, 12:02:23 CEST schrieb Damian Kos:
>

It would be really nice to explain a bit about the added controller support in the commit message, so that people reviewing the patch can get a feeling for it.

> Signed-off-by: Damian Kos <dkos@cadence.com>
> ---
>  drivers/gpu/drm/rockchip/cdn-dp-core.c |  953
> +++++++++++++++++++++++++++++++- 
> +++++++++++++++++++++++++++++++drivers/gpu/drm/rockchip/cdn-dp-core.h 
> +++++++++++++++++++++++++++++++|
> 25 +
>  drivers/gpu/drm/rockchip/cdn-dp-reg.c  |    2 +-
>  drivers/gpu/drm/rockchip/cdn-dp-reg.h  |    4 +

>From the changes below, it looks that this seems to add support for a bridge chip based on that IP block. So it seems like the bridge+glue driver model would be a perfect fit for this, instead of stapling this onto the Rockchip-specific driver.

So essentially, you could take the Rockchip cdn-dp driver, move the common parts to drivers/gpu/drm/bridge and then create separate glue drivers for both Rockchip and your external bridge IP block.

This would prevent code duplication and also allow your bridge driver to be compiled without the Rockchip drm being present :-) .
And also pave the way for future socs using your DP ip block.


Nowadays we have quite a number of examples you could take as inspiration for this:
- bridge/analogix/* (shared between Exynos and Rockchip right now)
- bridge/synopsys/dw-hdmi* (shared between a quite big number of users)
- bridge/synopsys/dw-mipi-dsi.c (shared between Rockchip [pending] and stm)


Thanks
Heiko

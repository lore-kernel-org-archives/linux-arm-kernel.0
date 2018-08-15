From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 15 Aug 2018 12:18:08 +0200
Subject: [PATCH 3/4] phy: rockchip-inno-usb2: allow to force the B-Device
 Session Valid bit.
In-Reply-To: <20180815095934.11205-4-enric.balletbo@collabora.com>
References: <20180815095934.11205-1-enric.balletbo@collabora.com>
 <20180815095934.11205-4-enric.balletbo@collabora.com>
Message-ID: <2209969.yNeHebgXRl@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Enric,

Am Mittwoch, 15. August 2018, 11:59:33 CEST schrieb Enric Balletbo i Serra:
> The OTG disconnection event is generated after the presence/abscense of
> an ID connection, but some platforms doesn't have the ID pin connected, so
> the event is not generated. In such case, for detecting the disconnection
> event, we can get the cable state from an extcon driver. We need, though,
> to force to set the B-Device Session Valid bit on the PHY to have the
> device respond to setup address. Otherwise, the following error is
> shown:
> 
>     usb 2-2: Device not responding to setup address.
>     usb 2-2: device not accepting address 14, error -71
>     usb usb2-port2: unable to enumerate USB device
> 
> The patch allows to tell the PHY to force the B-Device Session Valid bit
> when the OTG role is device and clear that bit if the OTG role is host.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> @@ -1024,6 +1051,12 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
>  	INIT_DELAYED_WORK(&rport->chg_work, rockchip_chg_detect_work);
>  	INIT_DELAYED_WORK(&rport->otg_sm_work, rockchip_usb2phy_otg_sm_work);
>  
> +	rport->force_bvalid = false;
> +	if (of_device_is_compatible(rphy->dev->of_node,
> +				    "rockchip,rk3399-usb2phy"))
> +		rport->force_bvalid = of_property_read_bool(child_np,
> +						"rockchip,force-bvalid");

That feels a bit clumsy, especially as the rk3399 seems to have the id
connection in general ... maybe you could just make that conditional
on the presence of the extcon?

Or alternatively if needed put that in the soc-specific data struct we
have already instead open-coding soc compatible checks.

Heiko

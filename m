From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Thu, 1 Mar 2018 13:15:44 +0100
Subject: [PATCH 1/6] phy: rockchip-typec: fall back to working in
 host-mode if extcon is missing.
In-Reply-To: <5052573.JZoBBeufta@diego>
References: <20180301092420.1191-1-enric.balletbo@collabora.com>
 <20180301092420.1191-2-enric.balletbo@collabora.com>
 <5052573.JZoBBeufta@diego>
Message-ID: <38900733-42c3-4b53-74c9-30356f01d46d@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 01/03/18 10:45, Heiko St?bner wrote:
> Am Donnerstag, 1. M?rz 2018, 10:24:15 CET schrieb Enric Balletbo i Serra:
>> Right now the rockchip typec-phy does fail probing when no extcon is
>> detected. Some boards get the cable-state via the extcon interface and
>> have this supported, other boards seem to use the fusb302 chip or
>> another but the driver currently does not seem to utilize the extcon
>> interface to report the cable-state. That's required to detect
>> cable-state changes but a missing extcon shouldn't fail to probe,
>> instead, should just fall back to working in host-mode if it cannot get
>> the extcon.
> 
> And of course:
> Some boards use no controller at all and just connect the type-c to a
> standard USB-A port.
> 
>> Fixes: c301b327aea898af ("arm64: dts: rockchip: add usb3-phy otg-port
>> support for rk3399") Reported-by: Vicente Bergas <vicencb@gmail.com>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>>  drivers/phy/rockchip/phy-rockchip-typec.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c
>> b/drivers/phy/rockchip/phy-rockchip-typec.c index
>> 7492c8978217..3741afab5cd2 100644
>> --- a/drivers/phy/rockchip/phy-rockchip-typec.c
>> +++ b/drivers/phy/rockchip/phy-rockchip-typec.c
>> @@ -782,6 +782,9 @@ static int tcphy_get_mode(struct rockchip_typec_phy
>> *tcphy) u8 mode;
>>  	int ret;
>>
>> +	if (!edev)
>> +		return MODE_DFP_USB;
>> +
>>  	ufp = extcon_get_state(edev, EXTCON_USB);
>>  	dp = extcon_get_state(edev, EXTCON_DISP_DP);
>>
>> @@ -1115,9 +1118,9 @@ static int rockchip_typec_phy_probe(struct
>> platform_device *pdev)
>>
>>  	tcphy->extcon = extcon_get_edev_by_phandle(dev, 0);
>>  	if (IS_ERR(tcphy->extcon)) {
>> -		if (PTR_ERR(tcphy->extcon) != -EPROBE_DEFER)
>> -			dev_err(dev, "Invalid or missing extcon\n");
>> -		return PTR_ERR(tcphy->extcon);
>> +		if (PTR_ERR(tcphy->extcon) == -EPROBE_DEFER)
>> +			return PTR_ERR(tcphy->extcon);
>> +		tcphy->extcon = NULL;
> 
> Do we want to keep a bit of the error handling of extcon, a la
> 
> +		if (PTR_ERR(tcphy->extcon) == -ENODEV) {
> +			tcphy->extcon = NULL;
> +		} else {
> +			if (PTR_ERR(tcphy->extcon) != -EPROBE_DEFER)
> +				dev_err(dev, "Invalid or extcon\n");
> +			return PTR_ERR(tcphy->extcon);
> +		}
> 
> So only make it NULL, if extcon really reports ENODEV?
> 

Sounds good to me, I'll send a second version ASAP, so people can test it with
that change applied.

Thanks for the feedback.

Regards,
 Enric

> 
> Heiko
> 

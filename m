From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 15 Aug 2018 12:36:59 +0200
Subject: [PATCH 3/4] phy: rockchip-inno-usb2: allow to force the B-Device
 Session Valid bit.
In-Reply-To: <72ca2b54-785c-8fe3-b472-5b8837afe00a@collabora.com>
References: <20180815095934.11205-1-enric.balletbo@collabora.com>
 <2209969.yNeHebgXRl@phil>
 <72ca2b54-785c-8fe3-b472-5b8837afe00a@collabora.com>
Message-ID: <2399692.mpX5uTAn2d@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 15. August 2018, 12:34:42 CEST schrieb Enric Balletbo i Serra:
> Hi Heiko,
> 
> On 15/08/18 12:18, Heiko Stuebner wrote:
> > Hi Enric,
> > 
> > Am Mittwoch, 15. August 2018, 11:59:33 CEST schrieb Enric Balletbo i Serra:
> >> The OTG disconnection event is generated after the presence/abscense of
> >> an ID connection, but some platforms doesn't have the ID pin connected, so
> >> the event is not generated. In such case, for detecting the disconnection
> >> event, we can get the cable state from an extcon driver. We need, though,
> >> to force to set the B-Device Session Valid bit on the PHY to have the
> >> device respond to setup address. Otherwise, the following error is
> >> shown:
> >>
> >>     usb 2-2: Device not responding to setup address.
> >>     usb 2-2: device not accepting address 14, error -71
> >>     usb usb2-port2: unable to enumerate USB device
> >>
> >> The patch allows to tell the PHY to force the B-Device Session Valid bit
> >> when the OTG role is device and clear that bit if the OTG role is host.
> >>
> >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > 
> >> @@ -1024,6 +1051,12 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
> >>  	INIT_DELAYED_WORK(&rport->chg_work, rockchip_chg_detect_work);
> >>  	INIT_DELAYED_WORK(&rport->otg_sm_work, rockchip_usb2phy_otg_sm_work);
> >>  
> >> +	rport->force_bvalid = false;
> >> +	if (of_device_is_compatible(rphy->dev->of_node,
> >> +				    "rockchip,rk3399-usb2phy"))
> >> +		rport->force_bvalid = of_property_read_bool(child_np,
> >> +						"rockchip,force-bvalid");
> > 
> > That feels a bit clumsy, especially as the rk3399 seems to have the id
> 
> Agree, It is, let me explain :)
> 
> Ideally we shouldn't have this check, to get rid of this check I only need the
> offsets for bvalid_session register for all the compatibles and fill in phy
> configuration data (rk3228_phy_cfgs, &rk3328_phy_cfgs, rk3366_phy_cfgs,
> rv1108_phy_cfgs)
> 
> To be honest I didn't look if all the datasheets are public available, let me do
> some research. Or, if anyone has the datasheet and can tell where the
> bvalid_session bit is I can fill all the data.

Or just always check for the presence of the property and just make the
driver warn if that bvalid_session setting is not available for that soc yet.

>From the TRMs I have your rk3399 bvalid_session settings seems to live
in the depths of the undocumented inno-phy regs, so that will probably
be the same for other socs using that phy.


Heiko

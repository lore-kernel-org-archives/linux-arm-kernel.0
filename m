From: prakity@marvell.com (Philip Rakity)
Date: Mon, 18 Jun 2012 18:23:35 -0700
Subject: Where to power on the wifi device before loading the driver.
In-Reply-To: <6B4D417B830BC44B8026029FD256F7F1C6EE2DD61F@HKMAIL01.nvidia.com>
References: <6B4D417B830BC44B8026029FD256F7F1C377BFFE88@HKMAIL01.nvidia.com>
 <4FD90352.9090606@wwwdotorg.org>
 <20120614063120.GA20167@avionic-0098.mockup.avionic-design.de>
 <20120614121234.GC3913@opensource.wolfsonmicro.com>
 <4FDA092E.10301@wwwdotorg.org>
 <6B4D417B830BC44B8026029FD256F7F1C377BFFE8D@HKMAIL01.nvidia.com>
 <4FDB5976.20809@wwwdotorg.org>,
 <6B4D417B830BC44B8026029FD256F7F1C6EE2DD61F@HKMAIL01.nvidia.com>
Message-ID: <43E4817426ED174AA81263BCECB4351D138E8ACD6B@sc-vexch3.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Why can't you use the regulator notify to get called back on power or voltage change options to plumb in the manipulation of the gpio. I can imagine you might need to add a notify call in core.c if you need to assert the gpio before power is applied


________________________________________
From: linux-mmc-owner@vger.kernel.org [linux-mmc-owner at vger.kernel.org] On Behalf Of Wei Ni [wni at nvidia.com]
Sent: Sunday, June 17, 2012 11:20 PM
To: 'Stephen Warren'; Rakesh Kumar
Cc: Mark Brown; 'frankyl at broadcom.com'; Thierry Reding; Mursalin Akon; 'linux-mmc at vger.kernel.org'; devicetree-discuss at lists.ozlabs.org; 'linux-wireless at vger.kernel.org'; linux-tegra at vger.kernel.org; linux-arm-kernel at lists.infradead.org
Subject: RE: Where to power on the wifi device before loading the driver.

On Fri, Jun 15, 2012 at 23:49:10, Stephen Warren wrote:
>> I talked with Franky, this power sequence is generally for 4329, so
>> it mean this sequence can be put into the wifi driver.
>> We can use the virtual platform device both for OOB and non OOB.
>> I will send out patches later.
>
>Can you please expand on what a "virtual platform device" is; device tree typically represents real hardware rather than anything "virtual".

The "virtual platform device" is created before the real wifi device, so that it can pass the gpios to the driver, and power up the device before calling sdio_register_driver.
But as Franky said, this power sequence is only generally for 4329, not for the USB dongle chips. So it's not a good idea to add this "power up" in brcmfmac.

>
>Now if this means adding a child node under the SDIO controller to represent the attached device, and storing any settings required by that device in that child node, that's probably a reasonable basic approach.
>
>BTW, which GPIO is the power GPIO; is it WF_EN on the schematic? That seems reasonable to represent as a GPIO rather than a regulator since it connects directly into the WiFi device as a GPIO, and its use within the WiFi device can indeed be governed purely internally to the WiFi driver/HW. However, if this is some GPIO that controls the power to e.g.
>VBAT3V3_IN_WF, VDDIO_WF, or other power supply to the WiFi card, then it'd be better represented as a regulator, since the control point is outside the WiFi device.

I think Rakesh may can answer this.

Wei.
---
nvpublic


--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

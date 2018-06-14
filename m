From: eyalr@ti.com (Reizer, Eyal)
Date: Thu, 14 Jun 2018 06:40:05 +0000
Subject: [EXTERNAL] Re: [PATCH] arm64: dts: hikey: Define wl1835 power
 capabilities
In-Reply-To: <87tvq6a577.fsf@kamboji.qca.qualcomm.com>
References: <20180613151305.17240-1-ryan@edited.us>
 <CANcMJZASEDRxaXwdG96nNeEDPrDm_ap5MjhXonEcg=yHZ8F=qg@mail.gmail.com>
 <87tvq6a577.fsf@kamboji.qca.qualcomm.com>
Message-ID: <ae036763950c4c9e80ceccc8c61e78dd@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> These properties are required for compatibility with runtime PM.
> >> Without these properties, MMC host controller will not be aware
> >> of power capabilities. When the wlcore driver attempts to power
> >> on the device, it will erroneously fail with -EACCES.
> >>
> >> Signed-off-by: Ryan Grachek <ryan@edited.us>
> >
> > Fixes: 60f36637bbbd ("wlcore: sdio: allow pm to handle sdio power")
> > Tested-by: John Stultz <john.stultz@linaro.org>
> > Acked-by: John Stultz <john.stultz@linaro.org>
> >
> > Wei Xu: This fixes a functional regression with wifi on the HiKey
> > board that was introduced in 4.18-rc with commit 60f36637bbbd
> > ("wlcore: sdio: allow pm to handle sdio power").
> >
> > Could you please be sure to queue this for the 4.18-rc ?
> 
> Adding linux-wireless so that wireless folks are aware of this wlcore
> regression fix as well.
> 
Actually  "cap-power-off-card" is normally included with all .dts files supporting wilink 
So it should have been there from the start for this board as well. 
It probably worked without it due to the explicit call to mmc_power_restore_host()
that was there as an old workaround for trying to control the power explicitly from the
driver which was actually causing other failures on suspend/resume as the mmc layer 
already power the module on resume.
"keep-power-in-suspend" is needed in case of planning to use "WoWLAN":
Iw phy0 wowlan enable....

Best Regards,
Eyal

From: weijuny@qti.qualcomm.com (Yang, York)
Date: Mon, 14 Dec 2015 09:24:20 +0000
Subject: [PATCH 1/2] mmc: core: enable CMD19 tuning for DDR50 mode
In-Reply-To: <CAOQ7t2YOd9TtAHHUBhF4n_POQURhfaqC_9Tg-b8d1Bf2QCyoYA@mail.gmail.com>
References: <1439282492-6274-1-git-send-email-21cnbao@gmail.com>
 <CAPDyKFpXZD28NwNAhKQyxmWasVhk_7AeyOW6oXaBPHKuSTmGUA@mail.gmail.com>
 <CAGsJ_4wvvQdyjFi=JmWfASm-LbJMybrhC=Wxxn7jHZEP5dUfEw@mail.gmail.com>
 <CAPDyKFpEwWvu3tnbMT9ZvM0TUvEHp0Qa8PADohyJoTaNZ9HS9g@mail.gmail.com>
 <CAGsJ_4x5Nd3Cts1BHsUyB_mCejxbHPPjznUVWUcFoZhxKy+Tcg@mail.gmail.com>
 <CAPDyKFpWfY9G4WG_GfCutJ2NkRbcAYZToYJXp3RvX=_25sgnWA@mail.gmail.com>
 <CAGsJ_4zaWcmGsc82=LSohK0UHxJir2OJOBSgoU3sPRXYvLdOZQ@mail.gmail.com>
 <CAPDyKFrj7mfxYPotHfpYPVf8M=Mvjcz+HfuB871EZNv9FWpPqw@mail.gmail.com>
 <CAOQ7t2YuSDwtK0R3R4++3LUPyEqW+ENLju63QisX6tO=-cvt6w@mail.gmail.com>
 <edf24ca1a9614943b55b8d19745a3c45@aptaiexm02f.ap.qualcomm.com>
 <CAOQ7t2YOd9TtAHHUBhF4n_POQURhfaqC_9Tg-b8d1Bf2QCyoYA@mail.gmail.com>
Message-ID: <a2ffc219b04b483b87696ffc81a60787@aptaiexm02f.ap.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Carlo

	I don't think so. You may check the 9faac7b95, there are two changes in sd.c and sdhc.c.
	Surely the change in sdhc.c will not affect ASUS X205TA (bcm43341) since it is a SDIO device.
	Actually the calling sequence is this: mmc_sd_init_uhs_card() calls sdhci_execute_tuning(). In 9faac7b95, I enabled tuning for DDR50 in these two functions.
	If your function calling sequence is mmc_sdio_init_uhs_card()->sdhci_execute_tuning(), the tuning will not carried out, since you didn't enable tuning for DDR50 in mmc_sdio_init_uhs_card().
	Unless you call sdhci_execute_tuning directly, the tuning command may go through be sent out.

-----Original Message-----
From: carlo.caione@gmail.com [mailto:carlo.caione at gmail.com] On Behalf Of Carlo Caione
Sent: 2015?12?14? 17:14
To: Yang, York <weijuny@qti.qualcomm.com>
Cc: Carlo Caione <carlo@caione.org>; Ulf Hansson <ulf.hansson@linaro.org>; Barry Song <21cnbao@gmail.com>; linux-mmc <linux-mmc@vger.kernel.org>; DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>; linux-arm-kernel at lists.infradead.org; Song, Barry <baohuas@qti.qualcomm.com>
Subject: Re: [PATCH 1/2] mmc: core: enable CMD19 tuning for DDR50 mode

On Mon, Dec 14, 2015 at 9:46 AM, Yang, York <weijuny@qti.qualcomm.com> wrote:
> Hi, Carlo
>         In 9faac7b95, tuning for DDR50 is enabled in mmc_sd_init_uhs_card(), so only SD card is affected.
>         This is based on the SD spec version 3.01.
>         mmc_sdio_init_uhs_card() is untouched. I don't know who add the code into mmc_sdio_init_uhs_card() and you may have a check on your side.

Hi Yang,
sorry for not being clear. Modifying mmc_sdio_init_uhs_card() was only a test I did to check whether that could fix the issue, but it didn't.

Right now the situation is:
- In the latest master with commit 9faac7b95 WiFi is broken on the ASUS X205TA (bcm43341)
- Reverting 9faac7b95 makes it working fine again

My conclusion is that issuing the CMD19 is basically breaking WiFi on this platform.

--
Carlo Caione

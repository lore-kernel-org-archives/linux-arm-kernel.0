From: weijuny@qti.qualcomm.com (Yang, York)
Date: Mon, 14 Dec 2015 08:46:36 +0000
Subject: [PATCH 1/2] mmc: core: enable CMD19 tuning for DDR50 mode
In-Reply-To: <CAOQ7t2YuSDwtK0R3R4++3LUPyEqW+ENLju63QisX6tO=-cvt6w@mail.gmail.com>
References: <1439282492-6274-1-git-send-email-21cnbao@gmail.com>
 <CAPDyKFpXZD28NwNAhKQyxmWasVhk_7AeyOW6oXaBPHKuSTmGUA@mail.gmail.com>
 <CAGsJ_4wvvQdyjFi=JmWfASm-LbJMybrhC=Wxxn7jHZEP5dUfEw@mail.gmail.com>
 <CAPDyKFpEwWvu3tnbMT9ZvM0TUvEHp0Qa8PADohyJoTaNZ9HS9g@mail.gmail.com>
 <CAGsJ_4x5Nd3Cts1BHsUyB_mCejxbHPPjznUVWUcFoZhxKy+Tcg@mail.gmail.com>
 <CAPDyKFpWfY9G4WG_GfCutJ2NkRbcAYZToYJXp3RvX=_25sgnWA@mail.gmail.com>
 <CAGsJ_4zaWcmGsc82=LSohK0UHxJir2OJOBSgoU3sPRXYvLdOZQ@mail.gmail.com>
 <CAPDyKFrj7mfxYPotHfpYPVf8M=Mvjcz+HfuB871EZNv9FWpPqw@mail.gmail.com>
 <CAOQ7t2YuSDwtK0R3R4++3LUPyEqW+ENLju63QisX6tO=-cvt6w@mail.gmail.com>
Message-ID: <edf24ca1a9614943b55b8d19745a3c45@aptaiexm02f.ap.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Carlo
	In 9faac7b95, tuning for DDR50 is enabled in mmc_sd_init_uhs_card(), so only SD card is affected.
	This is based on the SD spec version 3.01.
	mmc_sdio_init_uhs_card() is untouched. I don't know who add the code into mmc_sdio_init_uhs_card() and you may have a check on your side.

-----Original Message-----
From: carlo.caione@gmail.com [mailto:carlo.caione at gmail.com] On Behalf Of Carlo Caione
Sent: 2015?12?13? 7:52
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Barry Song <21cnbao@gmail.com>; Yang, York <weijuny@qti.qualcomm.com>; linux-mmc <linux-mmc@vger.kernel.org>; DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>; linux-arm-kernel at lists.infradead.org; Song, Barry <baohuas@qti.qualcomm.com>
Subject: Re: [PATCH 1/2] mmc: core: enable CMD19 tuning for DDR50 mode

On Wed, Sep 23, 2015 at 9:25 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> [...]
>
>>>
>>> Also, I was giving this a second thought...
>>>
>>> What happens with the SD 3.0 card when it *doesn't* support CMD19.
>>> Will it still be functional afterwards or will it move from 
>>> "transfer state" to another not known state?
>>
>> uffe, i am not the expert of this issue but weijun is. weijun told 
>> that for the cards who don't support cmd19, it will take it as 
>> illegal command and not response it. and it also sets illegal command 
>> error in registers.
>> but the card status is still functional and doesn't cause unknown state.
>>
>> so maybe we can just ignore the err of tuning, and use the second 
>> patch with the refine you mentioned?
>
> Sure, let's do that. Please send a v2 of the patchset then.

Replying here since I'm not subscribed to linux-mmc.

Commit 9faac7b95 "mmc: sdhci: enable tuning for DDR50" actually breaks WiFi on SDIO at least for the ASUS X205TA.

I tried to ignore the error from the tuning also for the SDIO card patching mmc_sdio_init_uhs_card() in drivers/mmc/core/sdio.c but I end up with the error "Controller never released inhibit bit(s)". At least in my case CMD19 shouldn't be issued at all to have the SDIO card working.

Any suggestion how to approach this problem?

--
Carlo Caione


 To report this email as spam click https://www.mailcontrol.com/sr/t!EO05MqfQ7GX2PQPOmvUkWM85sEKD4+jZQCQMWcEF+Ktu75GnJjKIuILC13YpF6Ld90r0YXMUaNc!rJiVGaJg== .

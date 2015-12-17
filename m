From: carlo@caione.org (Carlo Caione)
Date: Thu, 17 Dec 2015 20:54:24 +0100
Subject: [PATCH 1/2] mmc: core: enable CMD19 tuning for DDR50 mode
In-Reply-To: <7a1072e99c8149a5b08d1bf260808ce7@aptaiexm02f.ap.qualcomm.com>
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
 <a2ffc219b04b483b87696ffc81a60787@aptaiexm02f.ap.qualcomm.com>
 <CAOQ7t2Z=4Mc9Ev9OBxXiLDtiXaTr5jQzc-gVwU_xJnHLrumd0g@mail.gmail.com>
 <7a1072e99c8149a5b08d1bf260808ce7@aptaiexm02f.ap.qualcomm.com>
Message-ID: <CAOQ7t2YB8VHw4+v=_5tMU5tAn4oE8KfCOPPAMbZx+2QyY7N5Zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On gio, dic 17, 2015 at 02:00:17 +0000, Yang, York wrote:
> Hi, Carlo

Hi Yang,

> I don't understand. We can see that 9faac7b95 is all about
> DDR50. It should not affect the behavior of SDR50.

What I'm saying is that this commit is negatively affecting some DDR50
SDIO card as in my case.

Ok, let's try to go through the code with and without 9faac7b95.

Without 9faac7b95:
- mmc_sdio_init_uhs_card() is called
- sw_caps.sd3_bus_mode is 0x14 (SD_MODE_UHS_SDR50 | SD_MODE_UHS_DDR50)
- card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR50 is verified and
mmc_execute_tuning() is called
- sdhci_execute_tuning() is called
- host->timing is MMC_TIMING_UHS_DDR50
- since there is no case for that we end up in 'default', goto
out_unlock and CMD19 is never issued

With 9faac7b95:
- mmc_sdio_init_uhs_card() is called
- sw_caps.sd3_bus_mode is 0x14 (SD_MODE_UHS_SDR50 | SD_MODE_UHS_DDR50)
- card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR50 is verified and
  mmc_execute_tuning() is called
- sdhci_execute_tuning() is called
- host->timing is MMC_TIMING_UHS_DDR50
- this time we have the the 'case MMC_TIMING_UHS_DDR50' and we break on that
- CMD19 is issued and the card stops working

> Since the commit is very simple, you may remove the change one by one
> by yourself. And see if any difference occurs.

As stated above the problem is in the new 'case MMC_TIMING_UHS_DDR50'
we have in sdhci_execute_tuning()

> Besides, please check
> if the card->sw_caps.sd3_bus_mode changes with or without DDR50 tuning
> enabled.

It doesn't.

-- 
Carlo Caione

From: adrian.hunter@intel.com (Adrian Hunter)
Date: Tue, 14 Jun 2016 13:05:20 +0300
Subject: [PATCH] ARM: tegra: beaver: allow SD card voltage to be changed
In-Reply-To: <575FBEE5.50905@nvidia.com>
References: <1456779678-20173-1-git-send-email-dev@lynxeye.de>
 <1463124331.2459.0.camel@lynxeye.de> <20160513172704.GA498@ulmo.ba.sec>
 <573DCDB3.80202@nvidia.com> <575E897A.5080508@nvidia.com>
 <575FA21E.80309@intel.com> <575FBEE5.50905@nvidia.com>
Message-ID: <575FD6E0.7070201@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/06/16 11:23, Jon Hunter wrote:
> 
> On 14/06/16 07:20, Adrian Hunter wrote:
>> On 13/06/16 13:22, Jon Hunter wrote:
>>> Adding Adrian and Ulf ...
>>>
>>> On 19/05/16 15:29, Jon Hunter wrote:
>>>>
>>>> On 13/05/16 18:27, Thierry Reding wrote:
>>>>> * PGP Signed by an unknown key
>>>>>
>>>>> On Fri, May 13, 2016 at 09:25:31AM +0200, Lucas Stach wrote:
>>>>>> Am Montag, den 29.02.2016, 22:01 +0100 schrieb Lucas Stach:
>>>>>>> This allows to switch the card signal voltage level to 1.8V,
>>>>>>> which is needed for any ultra high speed modes to work.
>>>>>>>
>>>>>>> Signed-off-by: Lucas Stach <dev@lynxeye.de>
>>>>>>> ---
>>>>>>> This needs the SDMMC memcomp pad calibration patches I just
>>>>>>> sent out to be applied, otherwise the card voltage change will
>>>>>>> fail with a message in the kernel log and a fall back to
>>>>>>> high speed operation.
>>>>>>
>>>>>> The patches this one depends on have been applied for some time now.
>>>>>> Please pick up this patch.
>>>>>
>>>>> My understanding is that UHS modes currently cause problems on Beaver.
>>>>> What I don't understand about that is how it will even try those modes
>>>>> if the voltage regulator can't be set to 1.8 V? Shouldn't that actively
>>>>> prevent those modes from even being attempted?
>>>>
>>>> Looking at the sdhci code, if the regulator is missing then we still
>>>> attempt to place the controller is 1.8V mode ...
>>>>
>>>>  static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>>>>                                               struct mmc_ios *ios)
>>>>  {
>>>>
>>>>  ...
>>>>
>>>>          case MMC_SIGNAL_VOLTAGE_180:
>>>>                  if (!IS_ERR(mmc->supply.vqmmc)) {
>>>>                          ret = regulator_set_voltage(mmc->supply.vqmmc,
>>>>                                          1700000, 1950000);
>>>>                          if (ret) {
>>>>                                  pr_warn("%s: Switching to 1.8V signalling voltage failed\n",
>>>>                                          mmc_hostname(mmc));
>>>>                                  return -EIO;
>>>>                          }
>>>>                  }
>>>>
>>>>                  /*
>>>>                   * Enable 1.8V Signal Enable in the Host Control2
>>>>                   * register
>>>>                   */
>>>>                  ctrl |= SDHCI_CTRL_VDD_180;
>>>>                  sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>>>>  
>>>>                  /* Some controller need to do more when switching */
>>>>                  if (host->ops->voltage_switch)
>>>>                          host->ops->voltage_switch(host);
>>>>  
>>>>                  /* 1.8V regulator output should be stable within 5 ms */
>>>>                  ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>>>                  if (ctrl & SDHCI_CTRL_VDD_180)
>>>>                          return 0;
>>>>  
>>>>                  pr_warn("%s: 1.8V regulator output did not became stable\n",
>>>>                          mmc_hostname(mmc));
>>>>  
>>>>                  return -EAGAIN;
>>>>
>>>> Ideally, the above *should* fail if the regulator is missing. However, what
>>>> I have found, is that in my case, even though the regulator is missing, the
>>>> above succeeds and the host thinks we are operating at 1.8V even though we
>>>> are still at 3.3V! It seems that this does not happen with all SD cards that
>>>> support UHS. 
>>>>
>>>> This patch resolves the problems I am seeing on beaver with SD card
>>>> initialisation failing. I am surprised this is not causing problems for
>>>> others?
>>>
>>> Adrian, Ulf, per the above, I have found that on a Tegra30 beaver board,
>>> if we enable UHS-I modes for Tegra30 but the device-tree for the board
>>> is missing the regulator to select 1.8V mode operation, then the above
>>> code sequence may still return success (ie. SDHCI_CTRL_VDD_180 bit is
>>> set in SDHCI_HOST_CONTROL2) even though we have not changed the voltage.
>>> This leads to other problems later on during SD initialisation.
>>>
>>> Would you expect that an SDHCI controller should fail to set the
>>> SDHCI_CTRL_VDD_180 bit in the SDHCI_HOST_CONTROL2 register if we did not
>>> change the voltage?
>>
>> What is meant to happen is that sdhci should wait 5ms and then check
>> SDHCI_CTRL_VDD_180 - which it used to do but then someone took the 5ms wait
>> away.
> 
> Do you plan to add the 5ms delay again?

I guess the assumption is the card will fail to switch voltage, so the check
is unnecessary.

> 
>> In any case, if you are using a regulator there is no knowing what sdhci is
>> meant to do.
> 
> Ok, seems fragile.

In what way.

> 
>>>
>>> We want to ensure that Tegra devices do not attempt to switch the UHS-I
>>> modes if the regulator is not present and it is not clear to me if there
>>> is a problem with the Tegra SDHCI controller or how this should be handled.
>>
>> If the driver doesn't support UHS-I modes then it must remove the cap flags.
> 
> So the controller itself supports UHS-I modes, but a given board may not
> have the regulator to support them. We need a way to determine if the
> board can support the UHS-I modes. Now we could check to see if the
> regulator is present in the Tegra SDHCI driver and if not remove the cap
> flags. However, I was not sure if this is applicable to other sdhci
> controllers and so there should be a generic solution for this?

There is SDHCI_QUIRK2_NO_1_8_V but it doesn't cover the eMMC 1.8V DDR52 case
at present.  Dong Aisheng wanted to plug that gap but I wanted to get rid of
SDHCI_QUIRK2_NO_1_8_V:

	http://marc.info/?l=linux-mmc&m=146132847206423&w=2

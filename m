From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 5 Jun 2017 17:15:43 +0200
Subject: [PATCH 8/8] arm64: dts: hikey: Fix WiFi support
In-Reply-To: <CALAqxLU2zz17sHMFKOe4p248Bu4fRiU_dKoBBPbY38gDrpb_mw@mail.gmail.com>
References: <1494260477-25163-1-git-send-email-ulf.hansson@linaro.org>
 <1494260477-25163-9-git-send-email-ulf.hansson@linaro.org>
 <CALAqxLX4HwbVm8G4Ch2uYKAy6C9vYAZEcRUdCLDePT55oGz6hw@mail.gmail.com>
 <d7988293-853f-fb3a-ae29-d1dff4e4d732@linaro.org>
 <CALAqxLU2zz17sHMFKOe4p248Bu4fRiU_dKoBBPbY38gDrpb_mw@mail.gmail.com>
Message-ID: <CAPDyKFrtE1nKrc1Zk_n=rZTrMVT=Vb=cpk-7AEFWZRmVhFi+4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 June 2017 at 22:57, John Stultz <john.stultz@linaro.org> wrote:
> On Wed, May 31, 2017 at 11:36 AM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> On 31/05/2017 20:14, John Stultz wrote:
>>> On Mon, May 8, 2017 at 9:21 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>> The description of the connection between the dwmmc (SDIO) controller and
>>>> the Wifi chip, which is attached to the SDIO bus is wrong. Currently the
>>>> SDIO card can't be detected and thus the Wifi doesn't work.
>>>>
>>>> Let's fix this by assigning the correct vmmc supply, which is the always on
>>>> regulator VDD_3V3 and remove the WLAN enable regulator altogether. Then to
>>>> properly deal with the power on/off sequence, add a mmc-pwrseq node to
>>>> describe the resources needed to detect the SDIO card.
>>>>
>>>> Except for the WLAN enable GPIO and its corresponding assert/de-assert
>>>> delays, the mmc-pwrseq node also contains a handle to a clock provided by
>>>> the hi655x pmic. This clock is also needed to be able to turn on the WiFi
>>>> chip.
>>>>
>>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>
>>>
>>> Ulf,
>>>   So oddly, this patch seems to have broken wifi on HiKey when it
>>> landed in 4.12-rc3. I checked my config and CONFIG_PWRSEQ_SIMPLE is
>>> enabled.
>>
>> Hi John,
>>
>> how is it possible the WiFi stops working with this series? This series
>> provides the missing bits to enable the WiFi with a vanilla kernel.
>>
>> May be the WiFi is reset with this kernel and when it starts again the
>> firmware fails to load because it is not up-to-date?
>>
>> Can you check in dmesg if there is a firmware error message?
>
> So, it seems to me to be connected to some of the tweaks to the mmc2 dts node.
>
> When it works I see:
>  dwmmc_k3 f723f000.dwmmc2: Using internal DMA controller.
>  dwmmc_k3 f723f000.dwmmc2: Version ID is 250a
>  dwmmc_k3 f723f000.dwmmc2: DW MMC controller at irq 43,32 bit host
> data width,128 deep fifo
>  mmc_host mmc2: card is non-removable.
>  mmc_host mmc2: Bus speed (slot 0) = 24800000Hz (slot req 400000Hz,
> actual 400000HZ div = 31)
>  dwmmc_k3 f723f000.dwmmc2: 1 slots initialized
>  dwmmc_k3 f723f000.dwmmc2: card claims to support voltages below defined range
>  mmc_host mmc2: Bus speed (slot 0) = 24800000Hz (slot req 25000000Hz,
> actual 24800000HZ div = 0)
>  mmc2: new SDIO card at address 0001
>  wl18xx_driver wl18xx.4.auto: Direct firmware load for
> ti-connectivity/wl18xx-conf.bin failed with error -2
>  wl18xx_driver wl18xx.4.auto: Falling back to user helper
>
> When it fails:
>  dwmmc_k3 f723f000.dwmmc2: fifo-depth property not found, using value
> of FIFOTH register as default
>  dwmmc_k3 f723f000.dwmmc2: IDMAC supports 32-bit address mode.
>  dwmmc_k3 f723f000.dwmmc2: Using internal DMA controller.
>  dwmmc_k3 f723f000.dwmmc2: Version ID is 250a
>  dwmmc_k3 f723f000.dwmmc2: DW MMC controller at irq 43,32 bit host
> data width,128 deep fifo
>
> is seen repeatedly.
>
>
> I'm using my branch here (using the hikey_defconfig included):
> https://git.linaro.org/people/john.stultz/android-dev.git dev/hikey-mainline-WIP

John, thanks for the report!

After a some investigation, I realized that the mmc pwrseq_simple
driver returns -EPROBE_DEFER as it's not able to get the "ext" clock.
Hence the SDIO card will not be detected.

To fix the problem, you need to enable CONFIG_COMMON_CLK_HI655X in the
kernel config. This is actually also the case when using the arm64
defconfig for a plain 4.12 rc3 and later. We should probably make this
driver enabled per default when building the arm64 defconfig.

Can you run a re-test at your side with the CONFIG_COMMON_CLK_HI655X
set? Just to make sure it works also with those boot binaries you are
using...

>
> With the last patch included or removed to generate the working and
> broken dmesgs respectively.
>
> thanks
> -john

Kind regards
Uffe

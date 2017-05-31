From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 31 May 2017 20:36:11 +0200
Subject: [PATCH 8/8] arm64: dts: hikey: Fix WiFi support
In-Reply-To: <CALAqxLX4HwbVm8G4Ch2uYKAy6C9vYAZEcRUdCLDePT55oGz6hw@mail.gmail.com>
References: <1494260477-25163-1-git-send-email-ulf.hansson@linaro.org>
 <1494260477-25163-9-git-send-email-ulf.hansson@linaro.org>
 <CALAqxLX4HwbVm8G4Ch2uYKAy6C9vYAZEcRUdCLDePT55oGz6hw@mail.gmail.com>
Message-ID: <d7988293-853f-fb3a-ae29-d1dff4e4d732@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/05/2017 20:14, John Stultz wrote:
> On Mon, May 8, 2017 at 9:21 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> The description of the connection between the dwmmc (SDIO) controller and
>> the Wifi chip, which is attached to the SDIO bus is wrong. Currently the
>> SDIO card can't be detected and thus the Wifi doesn't work.
>>
>> Let's fix this by assigning the correct vmmc supply, which is the always on
>> regulator VDD_3V3 and remove the WLAN enable regulator altogether. Then to
>> properly deal with the power on/off sequence, add a mmc-pwrseq node to
>> describe the resources needed to detect the SDIO card.
>>
>> Except for the WLAN enable GPIO and its corresponding assert/de-assert
>> delays, the mmc-pwrseq node also contains a handle to a clock provided by
>> the hi655x pmic. This clock is also needed to be able to turn on the WiFi
>> chip.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> 
> Ulf,
>   So oddly, this patch seems to have broken wifi on HiKey when it
> landed in 4.12-rc3. I checked my config and CONFIG_PWRSEQ_SIMPLE is
> enabled.

Hi John,

how is it possible the WiFi stops working with this series? This series
provides the missing bits to enable the WiFi with a vanilla kernel.

May be the WiFi is reset with this kernel and when it starts again the
firmware fails to load because it is not up-to-date?

Can you check in dmesg if there is a firmware error message?




> Reverting this patch seems to get things working again for me.
> 
> thanks
> -john
> 


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

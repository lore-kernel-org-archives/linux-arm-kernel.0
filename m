From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 09 Apr 2014 15:33:05 +0200
Subject: [PATCH V4 1/5] phy: Add new Exynos5 USB 3.0 PHY driver
In-Reply-To: <CAFp+6iEzaxCQNkGZWuBnAaAHk0uXrX4KhjVbaJfZFChB6uzk4A@mail.gmail.com>
References: <1396967803-28868-1-git-send-email-gautam.vivek@samsung.com>
 <1396967803-28868-2-git-send-email-gautam.vivek@samsung.com>
 <534529B2.2020107@samsung.com>
 <CAFp+6iEzaxCQNkGZWuBnAaAHk0uXrX4KhjVbaJfZFChB6uzk4A@mail.gmail.com>
Message-ID: <53454C11.7060607@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09.04.2014 13:49, Vivek Gautam wrote:
> Hi,
>
>
> On Wed, Apr 9, 2014 at 4:36 PM, Tomasz Figa <t.figa@samsung.com> wrote:
>> Hi Vivek,
>>
>> Please see my comments inline.
>>
>>
>> On 08.04.2014 16:36, Vivek Gautam wrote:
>>>
>>> Add a new driver for the USB 3.0 PHY on Exynos5 series of SoCs.
>>> The new driver uses the generic PHY framework and will interact
>>> with DWC3 controller present on Exynos5 series of SoCs.
>>> Thereby, removing old phy-samsung-usb3 driver and related code
>>> used untill now which was based on usb/phy framework.
>>>
>>> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
>>> ---
>>>    .../devicetree/bindings/phy/samsung-phy.txt        |   42 ++
>>>    drivers/phy/Kconfig                                |   11 +
>>>    drivers/phy/Makefile                               |    1 +
>>>    drivers/phy/phy-exynos5-usbdrd.c                   |  668
>>> ++++++++++++++++++++
>>>    4 files changed, 722 insertions(+)
>>>    create mode 100644 drivers/phy/phy-exynos5-usbdrd.c
>>
>>
>> [snip]
>>
>>
>>> +       Additional clock required for Exynos5420:
>>> +       - usb30_sclk_100m: Additional special clock used for PHY operation
>>> +                          depicted as 'sclk_usbphy30' in CMU of
>>> Exynos5420.
>>
>>
>> Are you sure this isn't simply a gate for the ref clock, as it can be found
>> on another SoC that is not upstream yet? I don't have documentation for
>> Exynos 5420 so I can't tell, but I'd like to ask you to recheck this.
>
>>From what i can see in the manual :
> sclk_usbphy30 is derived from OSCCLK.
> It is coming from a MUX (default input line to this is OSCCLK)  and
> then through a DIV
> there's this gate.
>
>        {OSCCLK  + other sources} --->[MUX] ---> [DIV] --> [GATE for
> sclk_usbphy30]
>
> the {rate of sclk_usbphy30} == OSCCLK
>
> However the 'ref' clock that we have been using is the actual oscillator clock.
> And on SoC Exynos5250, we don't have any such gate (sclk_usbphy30).
> So should this mean that ref clock and sclk_usbphy30 are still be controlled by
> two different gates ?
>

Is there maybe a diagram of PHY input clocks in the datasheet, like for 
USB 2.0 PHY in Exynos4210/4412/5250 datasheets in the chapter about 
USB2.0 Device? Something like:

                      ____________________________________
                     |                                    |
                     |                         ___________|
XusbXTI             |   Phy_fsel[2:0]        |  _______  |
    _______[X]_______|    |         __________|_|___|\__|_|
   |                 |   _v___     |  _____   ^ |   |/  | |
_____               |  |     |    | |     |  | |  ___  | |
  ___                |  |     |    | |     |  | | |   |_|_|
|___|               |  | X 0 |____|_| PLL |__|_|_|CLK|_|_|
_____               |  |     |      |     |    | |DIV|_|_|
   |_______[X]       |  |_____| 12   |_____|480 | |___| | |
                     |          MHz         MHz |Digital| |
XusbXTO             |   USB PHY                |_______| |
                     |____________________________________|


Best regards,
Tomasz
